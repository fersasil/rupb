package;

import flixel.effects.FlxFlicker;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.input.touch.FlxTouch;
import flixel.math.FlxPoint;

class Player extends Entity {
	var start = false;
	var count = 0;
	var flikers:Bool = true;
	var climbing:Bool = false;
	var _sndDamage:FlxSound;
	var _sndJump:FlxSound;
	var jumping:Bool = false;
	var justStopedMoving: Bool = false;
	var anterior: Bool;
	var clickSign: Bool;

	var clickHandler: ClickHandler;

	var _screenFirstPress = true;
	var _screenPressedPosition:FlxPoint;
	var canAttack: Bool;

	var weapon:Sword;

	var _mail:Correio;

	public var timer:FlxTimer;

	public static inline var WALK_VELOCITY = 90;
	public static inline var JUMP_VELOCITY = 300;

	private static inline var JUST_RELEASED = 2;
	private static inline var HOLDING = 1;
	private static inline var NOT_HOLDING = 0;




	override public function new(?X:Float = 0, ?Y:Float = 0, mail:Correio):Void {
		super(X, Y);


		health = 3;
		movimentSide = true; // 0 esquerda 1 direta

		loadGraphic(AssetPaths.sheet_hero_idle28x30__png, true, 30, 30);

		// Faz com que não se precise de uma imagem diferente para a
		// esquerda e para a direita
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);

		animation.add("IDLE", [0, 1, 2, 3, 4, 5, 6], 8, true); // 9 ou 8
		animation.add("JUMP", [7, 8, 9, 10, 11], 6, false);
		animation.add("SLASH", [12, 13, 14, 15], 10, false);
		animation.add("WALK", [16, 17, 18], 13, false);
		animation.add("HURT", [19, 20, 21, 22, 23, 24], 10, false);
		animation.add("CLIMB", [22], 10, false);
		animation.add("DUCK", [24, 25, 26, 27, 28, 29], 10, false);

		_sndDamage = FlxG.sound.load(AssetPaths.damage__wav);
		_sndJump = FlxG.sound.load(AssetPaths.jump__wav);


		// IDLE 1-6
		// JUMP 7-11
		// Criar animações
		// animation.add("WALK", [1, 2, 3, 4], 10, false);

		/*animation.add("WALK", [1, 2, 3, 4], 10, false);
			animation.add("JUMP", [5, 6], 6, false);

			animation.add("SLASH", [12, 11, 12, 13], 10, false);
			animation.add("CLIMB", [19, 20, 21, 22], 6, true); */

		timer = new FlxTimer();

		_mail = mail;

		// FISICA DO PERSONAGEM
		drag.x = drag.y = 1600;
		acceleration.y = 1000; // Cria Gravidade
		this.maxVelocity.set(120, 200);

		// TEMPORARIO, REDIMENSIONA IMAGEM DO JOGADOR
		setGraphicSize(16, 20);
		setSize(16, 20);

		updateHitbox();

		clickHandler = new ClickHandler();


		// animation.play("IDLE");
	}

	override public function update(elapsed:Float):Void {
		#if (desktop || html5)
		keyboard_movement();
		
		function oi() {
			
			if(FlxG.mouse.justPressed){
				clickHandler.newClick();
			}
			
			if(clickHandler.click){
				mouse_touch_movement();
				attack_touch();
			}

			//ninguem usando o mutex
			if(!clickHandler.inUseMutex()) clickHandler.click = false;

			
		}

		
		
		oi();
		// if(FlxG.mouse.justPressed){
		// 		start = true;
		// 	// FlxG.log.add(FlxG.mouse.justReleased);
		// }
		// else if(count < 4 && start){
		// 	if(FlxG.mouse.justReleased)
		// 		FlxG.log.add("Lucky");

		// 	// FlxG.log.add("antes");
		// 	count++;
		// }
		// else {
		// 	count = 0;
		// 	start = false;
		// }
		
		#elseif mobile
		mobile_movement();
		#end

		super.update(elapsed);
	}

	/**
		Apenas um hurt faria com que o jogador morresse instaneamente
		O timer faz com que o jogador leve dano apenas após 0.3 segundos
		O hud é atualizado, porem. Caso a vida chegue a 0, o timer não é
		acionado.
	 */
	override public function onMessage(m:Message):Void {
		if (m.op == Message.OP_HURT) {
			if (flikers) {
				FlxFlicker.flicker(this);
				animation.play("HURT");
				_sndDamage.play();
				flikers = false;
			}

			if (health - 1 == 0) {
				FlxG.camera.flash();
				hurt(1);
			} else {
				// FlxG.camera.shake(1);
				timer.start(0.2, function(Timer:FlxTimer) {
					hurt(m.data);
					flikers = true;
				});
			}
		} else if (m.op == Message.OP_CLIMB) {
			velocity.y = -120;
			climbing = true;
		} else if (m.op == Message.OP_KILL) {
			FlxG.camera.flash();
			kill();
		} else if (m.op == Message.OP_HEAL) {}
	}

	#if (desktop || html5)
	function keyboard_movement():Void {
		// suporte a varias teclas
		var _cima:Bool = FlxG.keys.anyPressed([UP, W]) ? true : false;
		var _baixo:Bool = FlxG.keys.anyPressed([DOWN, S]) ? true : false;
		var _esquerda:Bool = FlxG.keys.anyPressed([LEFT, A]) ? true : false;
		var _direita:Bool = FlxG.keys.anyPressed([RIGHT, D]) ? true : false;

		// Anular movimentos contrarios
		if (_cima && _baixo)
			_cima = _baixo = false;
		if (_esquerda && _direita)
			_esquerda = _direita = false;

		// MOVIMENTO
		if (_cima && this.isTouching(FlxObject.DOWN)) { // Só pula quando estiver encostando no chão
			// if(_cima && velocity.y == 0){
			velocity.y = -JUMP_VELOCITY - 30;
			facing = FlxObject.UP;
			_sndJump.play();
		}
		if (_baixo) {
			// O personagem devera abaixar?
			facing = FlxObject.DOWN;
		}
		if (_direita) {
			velocity.x = WALK_VELOCITY;
			movimentSide = true;
			facing = FlxObject.RIGHT;
		}
		if (_esquerda) {
			velocity.x = -WALK_VELOCITY;
			movimentSide = false;
			facing = FlxObject.LEFT;
		}
		if (!_cima && !_baixo && !_esquerda && !_direita && !climbing) {
			animation.play("IDLE");
		}

		if (climbing) {
			animation.play("CLIMB");
			climbing = false; // Isso evita que a animação de escalando continue mesmo depois que sair da escada
		} else {
			// Só devera haver animação enquanto as teclas serem pressionadas
			if ((velocity.x != 0 || velocity.y != 0) && !isTouching(facing)) {
				switch (facing) {
					case FlxObject.LEFT, FlxObject.RIGHT:
						animation.play("WALK");
					case FlxObject.UP:
						animation.play("JUMP");
					case FlxObject.DOWN:
				}
			}
		}

		if (this.exists && this.alive && FlxG.keys.anyPressed([UP, W])) {
			var m = new Message(this, weapon, Message.OP_ATTACK);
			_mail.send(m);
		}
	}
	#end

	#if mobile
	function mobile_movement() {
		
		for (touch in FlxG.touches.list) {

			// if(touch.touchPointID > 0) break;
				
			if(touch.justPressed){
				clickHandler.newClick();
			}
			
			if(clickHandler.click){
				mouse_touch_movement(touch);
				attack_touch();
			}

			//ninguem usando o mutex
			if(!clickHandler.inUseMutex()) clickHandler.click = false;
		}
	}
	#end

	function mouse_touch_movement(touch:FlxTouch = null):Int {
		if(!clickHandler.getMutex(0)){
			// FlxG.log.add("Mouse Não conseguiu o mutex");
			
			return 0;
		}

		var justReleased:Bool;
		var pressed:Bool;
		var touchPosition:FlxPoint;
		var justPressed: Bool;

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

			if (_screenFirstPress) {
				_screenFirstPress = false;
				_screenPressedPosition = touchPosition;
			}

			function distanceBetweenTwoPoints(p1:FlxPoint, p2:FlxPoint):Float {
				var a = Math.pow(p1.x - p2.x, 2);
				var b = Math.pow(p1.y - p2.y, 2);
				var ab = a + b;

				var c = Math.sqrt(ab);

				return c;
			}

			var dbp = distanceBetweenTwoPoints(_screenPressedPosition, touchPosition);

			clickHandler.setUse(true);

			if (dbp < 10) {
				anterior = justStopedMoving;
				justStopedMoving = false;
				
				return HOLDING;
			}



			function getmovementAngle(touchPoint:FlxPoint):Float {
				var radians = Math.atan2(touchPoint.y - _screenPressedPosition.y, touchPoint.x - _screenPressedPosition.x);
				var degree = (180 * radians / Math.PI);
				return degree;
			}

			function movethis(degree:Float, speed:Float):Void {
				var angle = -degree;

				var _baixo:Bool = angle < -160 && degree > -30 ? true : false;
				var _cima:Bool = angle > 20 && angle < 150 ? true : false;

				var _esquerda:Bool = angle < 179 && angle > 90 ? true : false;
				var _direita:Bool = angle < 90 && angle > -30 ? true : false;

				if (_cima && this.isTouching(FlxObject.DOWN)) { // Só pula quando estiver encostando no chão
					velocity.y = -JUMP_VELOCITY - 30;
					facing = FlxObject.UP;
					_sndJump.play();
				}
				if (_baixo) {
					// O personagem devera abaixar?
					facing = FlxObject.DOWN;
				}
				if (_direita) {
					velocity.x = WALK_VELOCITY;
					movimentSide = true;
					facing = FlxObject.RIGHT;
					animation.play("WALK");
				}
				if (_esquerda) {
					velocity.x = -WALK_VELOCITY;
					movimentSide = false;
					facing = FlxObject.LEFT;
					animation.play("WALK");
				}
				if (!_cima && !_baixo && !_esquerda && !_direita && !climbing) {
					animation.play("IDLE");
				}

				if (climbing) {
					animation.play("CLIMB");
					climbing = false; // Isso evita que a animação de escalando continue mesmo depois que sair da escada
				}
			}

			var angle = getmovementAngle(touchPosition);

			// angle = getRealAngle(angle);
			movethis(angle, WALK_VELOCITY);

			anterior = justStopedMoving;
			justStopedMoving = false;

			return HOLDING;
		}

		
		if (justReleased) {
			_screenFirstPress = true;
			_screenPressedPosition = null;
			this.velocity.set(0, 0);
			
			// FlxG.log.add("P1");
			anterior = justStopedMoving;
			justStopedMoving = true;

			clickHandler.setUse(false);
			clickHandler.setJustReleased(true);
			clickHandler.freeMutex();

			return NOT_HOLDING;
		}

		// clickHandler.setNotUsing(false);

		anterior = justStopedMoving;
		return NOT_HOLDING;


		
	}

	function attack_touch(touch:FlxTouch = null) {
		if(!clickHandler.getMutex(1)) {
			return;
		}

		// FlxG.log.add("conseguiu o mutex");

		

		// var justReleased: Bool;
		// var justPressed: Bool;
		// var pressed: Bool;


		// #if mobile
		// 	justReleased = touch.justReleased;
		// 	justPressed = touch.justPressed;
		// 	pressed = touch.pressed;
		// #elseif (desktop || html5)
		// 	justReleased = FlxG.mouse.justReleased;
		// 	justPressed = FlxG.mouse.justPressed;
		// 	pressed = FlxG.mouse.pressed;
		// #end
		//TD
		

		if(clickHandler.count > 6) {
		// 	// FlxG.log.add("Estava em loop: " + clickHandler.count);
			clickHandler.cleanCount();
			clickHandler.freeMutex();
			clickHandler.click = false;

			return;
		}

		clickHandler.cleanCount();
		

		// if(clickHandler.justReleased) {
		// 	clickHandler.click = false;
		// 	clickHandler.justReleased = false;
		// 	clickHandler.freeMutex();
		// 	return;
		// }

		var m = new Message(this, weapon, Message.OP_ATTACK);
		_mail.send(m);

		clickHandler.click = false;
		clickHandler.freeMutex();
	}

	public function setWeapon(weapon:Sword) {
		this.weapon = weapon;
	}
}
