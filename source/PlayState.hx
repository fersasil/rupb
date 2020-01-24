package;

import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import monster.OrcMasked;
import monster.Skeleton;
import helperClass.HUD;
import screen.DeadScreen;
import screen.NextLevel;
import monster.Monster;
import screen.BoardNext;
import player.*;
import object.*;

import helperClass.Message;
import helperClass.Entity;
import helperClass.Mail;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup;
import flixel.FlxCamera;
import flixel.system.FlxSound;

import helperClass.Store;

using helperClass.ogmo.FlxOgmoUtils;
using helperClass.ogmo.OgmoUtils;


class PlayState extends FlxState{
	var _player:Player;
	var _boardNext:BoardNext;

	var _map: OgmoPackage;
	var _fakeCollision:FlxTilemap;
	var _collision:FlxTilemap;
	var _background:FlxTilemap;
	var _backgroundColor:FlxTilemap;
	
	var _grpBox: FlxTypedGroup<Box>;
	var _grpCoin: FlxTypedGroup<Coin>;
	var _grpWater: FlxTypedGroup<Water>;
	var _grpRock: FlxTypedGroup<Rock>;
	var _grpMonster: FlxTypedGroup<Monster>;
	var _grpStair: FlxTypedGroup<Stair>;
	var _grpWeapon: FlxTypedGroup<Weapon>;


	var weapon: Sword;
	var _hud:HUD;
	var _money:Int;
	var _health:Int;
	var _nextLevel: NextLevel;
	var _deadScreen: DeadScreen;
	var mail: Mail;
	var _cam:FlxCamera;
	var timer = new FlxTimer();
	var store: Store;

	var _sndBackground: FlxSound;

	#if mobile
		public static inline var CAM_ZOOM = 7;
	#else
		public static inline var CAM_ZOOM = 7;
	#end

	public function new(store: Store) {
		this.store = store;
		super();
	}


	override public function create():Void { 
		// _health = 3;

		timer = new FlxTimer();

		_background = new FlxTilemap();
		_backgroundColor = new FlxTilemap();
		_collision = new FlxTilemap();
		_fakeCollision = new FlxTilemap();
		
		_backgroundColor.load_tilemap(_map, 'assets/images/tiles/', "color");
		_background.load_tilemap(_map, 'assets/images/tiles/', "background");
		_collision.load_tilemap(_map, 'assets/images/tiles/', "collision");
		_fakeCollision.load_tilemap(_map, 'assets/images/tiles/', "fake_collision");

		// 	Todo: só criar se houver esses membros
		// 	com uma verificação

		_grpBox = new FlxTypedGroup<Box>();
		_grpCoin = new FlxTypedGroup<Coin>();
		_grpWater = new FlxTypedGroup<Water>();
		_grpMonster = new FlxTypedGroup<Monster>();
		_grpRock = new FlxTypedGroup<Rock>();
		_grpStair = new FlxTypedGroup<Stair>();
		_grpWeapon = new FlxTypedGroup<Weapon>();

		mail = new Mail();
		_hud = new HUD(CAM_ZOOM, store);

		_deadScreen = new DeadScreen();
		
		_player = new Player(0, 0, mail, store);
		_player.setMail(mail);

		_boardNext = new BoardNext();
		_nextLevel = new NextLevel();
		
		
		_collision.setTileProperties(92, FlxObject.NONE); //Não colidir com escada
		_collision.setTileProperties(109, FlxObject.NONE); //Escada inicio
		_collision.setTileProperties(75, FlxObject.NONE); //Escada fim
		_collision.follow();

		//Colocar o jogador e as outras coisas no lugar certo do mapa
		_map.level.get_entity_layer('entities').load_entities(placeEntities);

		add(mail); //Se não adicionar o correio ele não atualiza e não funciona!!!!
		
		add(_backgroundColor);
		add(_background);
		add(_collision);
		add(_fakeCollision);
		
		add(_player);
		
		add(_grpBox);
		add(_grpCoin);
		add(_grpWater);
		add(_grpMonster);
		add(_grpRock);
		add(_grpWeapon);

		
		add(_deadScreen);
		add(_boardNext);
		add(_nextLevel);
		
		add(_hud);

		setCamera();
		setHudCamera();


		

		super.create();
	}

	function setCamera(){
		_cam = new FlxCamera(-FlxG.width, -FlxG.height, FlxG.width, FlxG.height, 3);
		_cam.follow(_player, LOCKON);

		_cam.zoom = CAM_ZOOM;

		_cam.setScrollBoundsRect(0, 0, _map.level.width, _map.level.height, true);

		_cam.bgColor = FlxColor.TRANSPARENT;

		FlxG.cameras.reset(_cam);
	}

	function setHudCamera() {
		var _hudCamera = new FlxCamera(0, 0, FlxG.width,FlxG.height, 1);
		
		_hudCamera.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.add(_hudCamera);

		FlxCamera.defaultCameras = [_cam];
		
		_hud.forEach(function(el) {
			el.cameras = [_hudCamera];
		}); 
	}

	function placeEntities(entityData: EntityData):Void{
		var x:Int = entityData.x;
		var y:Int = entityData.y;
		
		var entityName = entityData.name;
		
		if(entityName == "player"){
			_player.x = x;
			_player.y = y;
		}
		else if(entityName == "coin"){
			var box = new Coin(x + Coin.WIDTH/2, y + Coin.HEIGHT/2);
			_grpCoin.add(box);
		}
		else if(entityName == "box"){
			_grpBox.add(new Box(x, y));
		}
		else if(entityName == "water"){
			_grpWater.add(new Water(x, y));
		}
		else if(entityName == "skeleton"){
			_grpMonster.add(new Skeleton(x + 2, y, FlxG.random.bool()));
		}
		else if(entityName == "rock"){
			_grpRock.add(new Rock(x, y + 7)); //Pedra se ajustar ao cenário
		}
		else if(entityName == "nextLevel"){
			_boardNext.x = x;
			_boardNext.y = y + 4;
		}
		else if(entityName == "orcMasked"){
			_grpMonster.add(new OrcMasked(x, y - 3));
		}
		else if(entityName == "stair"){
			_grpStair.add(new Stair(x, y));
		}
		else if(entityName == "sword"){
			_grpWeapon.add(new Sword(x + 5, y + 3));
		}
	}

	public function allColisions():Void {
		FlxG.collide(_player, _collision);
		FlxG.collide(_player, _grpBox);
		FlxG.collide(_collision, _grpBox);
		FlxG.collide(_player, _grpRock);
		FlxG.collide(_collision, _grpMonster);
		FlxG.collide(_grpMonster, _grpBox);
		FlxG.collide(_grpMonster, _grpRock);
		FlxG.collide(_grpMonster, _boardNext);
		
		if(store.player.getWeapon() != null)
		FlxG.collide(store.player.getWeapon(), _grpMonster);
		// }

	}


	function allOverlaps():Void {
		FlxG.overlap(_player, _grpCoin, getCoin);
		FlxG.overlap(_player, _grpWeapon, getWeapon);
		FlxG.overlap(_player, _grpWater, waterLetter);
		FlxG.overlap(_player, _grpMonster, playerHurts);
		FlxG.overlap(_player, _boardNext, goNextLevel); 
		FlxG.overlap(_player, _grpStair, climbStair);
		
		//Verificar se há overlap entre a caixa e a espada

		// trace()
		
		playerAttacks();

		// if(!FlxG.overlap(store.player.getWeapon(), _grpBox, attackBox)){
		// 	// if(store.player.getWeapon().alive)
		// 	// 	store.player.getWeapon().kill();
		// }
	}

	override public function update(elapsed:Float):Void{
		super.update(elapsed);

		allColisions();
		allOverlaps();
		
		//Todo mover para uma função
		verifyPlayerIsAlive();
	}

	function playerAttacks() {
		var weapon = store.player.getWeapon();

		if(weapon == null) return;

		
		FlxG.overlap(weapon, _grpBox, playerAttackBox);
		FlxG.overlap(weapon, _grpMonster, playerAttackBox);

		if(weapon.alive) weapon.kill();

	}

	function verifyPlayerIsAlive(){
		if(!_player.alive){
			_hud.updateHUD();
			_deadScreen.newDeath(_money);
			
			if(_sndBackground != null)
				_sndBackground.stop();

			#if (desktop || html5)
				FlxG.mouse.visible = true;
			#end

		}
	}

	/* ------------------------------------------
		FUNÇÕES A SEREM COLOCADAS NO CORREIO
	----------------------------------------------
	*/

	function climbStair(player: Player, stair: Entity):Void {
		player.canClimb(stair);
	}


	function goNextLevel(player: Entity, winSpot: Entity):Void {
		if(player.exists && player.alive){
			if(_sndBackground != null)
				_sndBackground.stop();
			
			var m = new Message(player, winSpot, Message.OP_WINS, _money);
			mail.send(m);
			_nextLevel.wins(_money);

			#if (desktop || html5)
				FlxG.mouse.visible = true;
			#end
		}
	}

	//TODO: pass to player class;
	function playerHurts(player: Entity, monster: Entity): Void{
		if(player.alive && player.exists  && monster.alive && monster.exists){
			var m = new Message(monster, player, Message.OP_HURT, 1);
			_hud.updateHUD();
			mail.send(m);
		}
	}

	//TODO: Pass to player class;
	function waterLetter(player: Entity, water: Entity): Void {
		if(player.alive && player.exists  && water.alive && water.exists){
			var m = new Message(water, player, Message.OP_KILL);
			mail.send(m);
		}
	}

	//TODO: Pass to player class;
	function getCoin(player: Entity, coin: Entity): Void {
		if(player.alive && player.exists && coin.alive && coin.exists){
			var m = new Message(player, coin, Message.OP_KILL);
			mail.send(m);

			_hud.updateHUD(HUD.op_COINS);
		}
	}

	function getWeapon(player: Entity, weapon: Weapon): Void {
		if(player.alive && player.exists && weapon.alive && weapon.exists){
			
			var m: Message;

			if(store.player.getWeapon() != null && store.player.getWeapon() == weapon) {
				m = new Message(player, weapon, Message.OP_KILL);
				mail.send(m);
				return;
			}

			m = new Message(player, weapon, Message.OP_WEAPON_GET);

			store.player.setWeapon(weapon);
			
			mail.send(m);
			// _hud.updateHUD(Std.int(_player.health), ++_money);
		}
	}

	//Todo: Refatorar
	function playerAttackBox(weapon: Entity, enemy: Entity): Void{
		if(enemy.alive && enemy.exists){
			// trace("ataque");
			var m = new Message(weapon, enemy, Message.OP_HURT, 1);
			
			mail.send(m);
		}
	}

	// function attackBox (weapon: Weapon, box: Box){
	// 	var m = new Message(weapon, box, Message.OP_KILL);
	// 	m.data = _player.movimentSide ? 1 : 0;
	// 	mail.send(m);
	// }





	// SETTERS

	function setPalyer(_player:Player){
		this._player = _player;
	}
	
	function setMap(_map){
		return this._map = _map;
	};

	function getGroupBox(){
		return _grpBox;
	}

	function getGroupCoin(){
		return _grpCoin;
	}

	function getGroupWater(){
		return _grpWater;
	}

	function getGroupRock(){
		return _grpRock;
	}

	function getGroupMonster(){
		return _grpMonster;
	}

	function getGroupStair(){
		return _grpStair;
	}



	function getHud(){
		return _hud;
	}

	function getMoney(){
		return _money;
	}

	function getHealth(){
		return _money;
	}
	
	function setMoney(_money){
		return this._money = _money;
	}

	function setHealth(_health) {
		// return this._health = _health;
	}

	function setNextLevel(_nextLevel){
		return this._nextLevel = _nextLevel;
	}

	function getMail(){
		return mail;
	}
	function getCam(){
		return _cam;
	}
	function getTimer(){
		return timer;
	}

	function setSound(sound){
		this._sndBackground = sound;
		
		soundPlay();
	}

	function soundPlay(){
		_sndBackground.play();
	}

	function soundStop(){
		_sndBackground.stop();
	}

}
