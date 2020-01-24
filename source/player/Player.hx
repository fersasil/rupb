package player;

import helperClass.Store;
import flixel.input.touch.FlxTouch;
import helperClass.Entity;
import helperClass.ClickHandler;
import helperClass.Message;
import helperClass.Mail;
import flixel.effects.FlxFlicker;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.math.FlxPoint;

using flixel.util.FlxSpriteUtil;

class Player extends Entity {
	var start = false;
	var count = 0;
	var isFlikering:Bool = true;
	var climbing:Bool = false;
	var _sndDamage:FlxSound;
	var _sndJump:FlxSound;
	var jumping:Bool = false;
	var timeAfterAnimation:Float = 0;
	var notShaking:Bool = true;

	var clickHandler:ClickHandler;

	var weapon:Sword;

	var _mail:Mail;
	public var store:Store;

	public var timer:FlxTimer;

	public static inline var WALK_VELOCITY = 90;
	public static inline var JUMP_VELOCITY = 250;
	public static inline var ANIMATION_IDLE_TIME = .5;
	public static inline var CLIMB_SPEED = 60;

	override public function new(?X:Float = 0, ?Y:Float = 0, ?mail:Mail, store:Store):Void {
		super(X, Y);

		this.store = store;
		// store.player.getHealth = 3;
		movimentSide = true; // 0 esquerda 1 direta
		health = store.player.getHealth();

		// loadGraphic(AssetPaths.sheet_hero_idle28x30__png, true, 30, 30);
		loadGraphic(AssetPaths.sheet_hero_gray_28x30__png, true, 30, 30);

		// Faz com que não se precise de uma imagem diferente para a
		// esquerda e para a direita
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		animation.add("IDLE", [0, 1, 2, 3, 4, 5, 6], 8, true); // 9 ou 8
		animation.add("JUMP", [7, 8, 9, 10, 11], 12, false);
		animation.add("SLASH", [12, 13, 14, 15], 10, false);
		animation.add("WALK", [16, 17, 18], 13, false);
		animation.add("HURT", [19, 20, 21, 22, 23, 24], 10, false);
		animation.add("CLIMB", [22], 10, false);
		animation.add("DUCK", [24, 25, 26, 27, 28, 29], 10, false);

		_sndDamage = FlxG.sound.load(AssetPaths.damage__wav);
		_sndJump = FlxG.sound.load(AssetPaths.jump__wav);

		timer = new FlxTimer();

		_mail = mail;

		// FISICA DO PERSONAGEM
		drag.x = drag.y = 1600;
		acceleration.y = 1000; // Cria Gravidade
		this.maxVelocity.set(120, 200);

		scale.x = .5;
		scale.y = .6;

		updateHitbox();

		clickHandler = new ClickHandler();

		animation.play("IDLE");
	}

	override public function update(elapsed:Float):Void {
		#if (desktop || html5)
		movePlayer();
		verifyAttack();
		#elseif mobile
		mobile_movement();
		#end

		timeAfterLastAnimation(elapsed);

		super.update(elapsed);
	}

	override public function onMessage(m:Message):Void {
		if (m.op == Message.OP_HURT) {
			if (m.to.isFlickering())
				return;

			store.player.hurt(1);

			// animation.play("HURT");
			_sndDamage.play();
			m.to.flicker();

			if (health - 1 == 0) {
				FlxG.camera.flash();
				hurt(1);
				store.player.setHealth(Std.int(m.to.health));
				return;
			}

			FlxG.camera.shake(0.005, 0.01);

			timer.start(0.2, function(Timer:FlxTimer) {
				hurt(m.data);
			});
		} // Fim do dano
		else if (m.op == Message.OP_CLIMB) {
			velocity.y = -120;
			climbing = true;
		} else if (m.op == Message.OP_KILL) {
			FlxG.camera.flash();
			kill();
		} else if (m.op == Message.OP_HEAL) {}
	}

	/**
		SHARED FUNCTIONS
	**/
	function movePlayer(degree:Float = null):Void {
		#if mobile
		var angle = -degree;

		var _down:Bool = angle < -160 && degree > -30 ? true : false;
		var _up:Bool = angle > 20 && angle < 150 ? true : false;
		var _left:Bool = angle < 179 && angle > 90 ? true : false;
		var _right:Bool = angle < 90 && angle > -30 ? true : false;
		#else
		var _up:Bool = FlxG.keys.anyPressed([UP, W]) ? true : false;
		var _down:Bool = FlxG.keys.anyPressed([DOWN, S]) ? true : false;
		var _left:Bool = FlxG.keys.anyPressed([LEFT, A]) ? true : false;
		var _right:Bool = FlxG.keys.anyPressed([RIGHT, D]) ? true : false;
		#end

		// TODO add a falling animation to it and ajust it to only stop when it
		// touch the ground or something
		if (animation.name == "JUMP" && this.isTouching(FlxObject.DOWN)) {
			animation.reset();
		}

		FlxG.watch.add(animation, "name", "name animation");

		if (_up && this.isTouching(FlxObject.DOWN)) { // Só pula quando estiver encostando no chão
			velocity.y = -JUMP_VELOCITY - 30;
			facing = FlxObject.UP;
			animation.play("JUMP");
			_sndJump.play();
		}
		if (_down) {
			// O personagem devera abaixar?
			facing = FlxObject.DOWN;
		}
		if (_right) {
			velocity.x = WALK_VELOCITY;
			movimentSide = true;
			facing = FlxObject.RIGHT;

			if (animation.finished || animation.name == "IDLE")
				animation.play("WALK");
		}
		if (_left) {
			velocity.x = -WALK_VELOCITY;
			movimentSide = false;
			facing = FlxObject.LEFT;

			if (animation.finished || animation.name == "IDLE")
				animation.play("WALK");
		}
		if (!_up && !_down && !_left && !_right && animation.finished && timeAfterAnimation > ANIMATION_IDLE_TIME) {
			animation.play("IDLE");
		}

		if (climbing) {
			animation.play("CLIMB");
			climbing = false; // Isso evita que a animação de escalando continue mesmo depois que sair da escada
		}

		// animation.play("IDLE");
	}

	public function canClimb(stair) {
		#if mobile
		mobileClimb(stair);
		#elseif (desktop || html5)
		if (this.exists && this.alive && FlxG.keys.anyPressed([UP, W])) { // Colocar essa verificação na mensagem?
			var m = new Message(stair, this, Message.OP_CLIMB, -120);
			_mail.send(m);
		}
		#end
	}

	function timeAfterLastAnimation(elapsed) {
		if (animation.finished)
			timeAfterAnimation += elapsed;
		else
			timeAfterAnimation = 0;
	} /*
		SETTERS
	 */

	public function setWeapon(weapon:Sword) {
		this.weapon = weapon;
	}

	public function destroyWeapon() {
		// FlxDestroyUtil.destroy(weapon);
		weapon = null;
	}

	public function hasWeapon() {
		return weapon == null ? false : true;
	}

	public function setMail(mail:Mail) {
		_mail = mail;
	}

	/*
		MOBILE FUNCTIONS
	 */
	#if mobile
	function mobile_movement() {
		for (touch in FlxG.touches.list) {
			if (touch.justPressed) {
				clickHandler.newClick();
			}

			if (clickHandler.click) {
				swipeAndMove(touch);

				if (weapon == null)
					return;
				attack_touch();
			}

			// ninguem usando o mutex
			if (!clickHandler.inUseMutex())
				clickHandler.click = false;
		}
	}

	function swipeAndMove(touch:FlxTouch = null):Void {
		if (!clickHandler.getMutex(0))
			return;

		var justReleased:Bool;
		var pressed:Bool;
		var touchPosition:FlxPoint;
		var justPressed:Bool;

		#if (desktop || html5)
		touchPosition = FlxG.mouse.getWorldPosition();
		justReleased = FlxG.mouse.justReleased;
		justPressed = FlxG.mouse.justPressed;
		pressed = FlxG.mouse.pressed;
		#elseif mobile
		touchPosition = touch.getWorldPosition();
		justReleased = touch.justReleased;
		justPressed = touch.justPressed;
		pressed = touch.pressed;
		#end

		if (pressed) {
			clickHandler.count++;

			if (clickHandler.getFirstPress())
				clickHandler.setFirstPressedPosition(touchPosition);

			var distanceSwiped = distanceBetweenTwoPoints(clickHandler.getFirstPressedPosition(), touchPosition);

			// TODO: holding mas não movendo
			if (distanceSwiped < 10)
				return;

			var angle = getmovementAngle(touchPosition, clickHandler.getFirstPressedPosition());

			movePlayer(angle);
		}

		if (justReleased) {
			clickHandler.resetFirstPresss();
			clickHandler.resetScreenPressedPosition();
			clickHandler.freeMutex();
		}
	}

	function attack_touch(touch:FlxTouch = null) {
		if (!clickHandler.getMutex(1))
			return;

		if (clickHandler.count > 6) {
			clickHandler.cleanCount();
			clickHandler.freeMutex();
			clickHandler.freeClick();

			return;
		}

		clickHandler.cleanCount();

		var m = new Message(this, weapon, Message.OP_ATTACK);
		_mail.send(m);

		clickHandler.freeClick();
		clickHandler.freeMutex();
	}

	/**
		MOBILE FUNCTIONS HELPERS
	**/
	function mobileClimb(stair) {
		var touch = FlxG.touches.getFirst();

		if (touch == null)
			return;

		var upTouch = touch.pressed;

		if (this.exists && this.alive && upTouch) {
			var m = new Message(stair, this, Message.OP_CLIMB, -CLIMB_SPEED);
			_mail.send(m);
		}
	}

	function getmovementAngle(touchPoint:FlxPoint, screenPressedPosition:FlxPoint):Float {
		var radians = Math.atan2(touchPoint.y - screenPressedPosition.y, touchPoint.x - screenPressedPosition.x);
		var degree = (180 * radians / Math.PI);
		return degree;
	}

	function distanceBetweenTwoPoints(p1:FlxPoint, p2:FlxPoint):Float {
		var a = Math.pow(p1.x - p2.x, 2);
		var b = Math.pow(p1.y - p2.y, 2);
		var ab = a + b;

		var c = Math.sqrt(ab);

		return c;
	}
	#end

	#if (desktop || html5)
	function verifyAttack() {
		if (weapon == null)
			return;

		if (FlxG.mouse.justPressed || FlxG.keys.anyJustPressed([P, SPACE])) {
			// Mouse pressionado, chamar a espada
			var m = new Message(this, weapon, Message.OP_ATTACK);
			_mail.send(m);
		}
	}
	#end
}
