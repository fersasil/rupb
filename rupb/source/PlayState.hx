package;

import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup;
import flixel.FlxCamera;
import flixel.addons.display.FlxZoomCamera;

import flixel.addons.editors.ogmo.FlxOgmoLoader;

//PULO DIAGONAL MUITO RAPIDO, ARRUMAR
//ARRUMAR PULO NA BOX
//ARRUMAR espadada para baixo
//ARRUMAR fundo com bug

class PlayState extends FlxState{
	var _player:Player;
	var _boardNext:BoardNext;
	var _map:FlxOgmoLoader;
	var _walls:FlxTilemap;
	var _bk:FlxTilemap;
	var _bkColor:FlxTilemap;
	var _grpBox: FlxTypedGroup<Box>;
	var _grpCoin: FlxTypedGroup<Coin>;
	var _grpWater: FlxTypedGroup<Water>;
	var _grpRock: FlxTypedGroup<Rock>;
	var _grpMonster: FlxTypedGroup<Monster>;
	var _grpStair: FlxTypedGroup<Stair>;
	var sword: Sword;
	var _hud:HUD;
	var _money:Int = 0;
	var _health:Int = 3;
	var _nextLevel: NextLevel;
	var _deadScreen: DeadScreen;
	var _zoomCam:FlxZoomCamera;
	var flashAux: Bool = true;
	var _correio: Correio;

	override public function create():Void { 
		_grpBox = new FlxTypedGroup<Box>();
		_grpCoin = new FlxTypedGroup<Coin>();
		_grpWater = new FlxTypedGroup<Water>();
		_grpMonster = new FlxTypedGroup<Monster>();
		_grpRock = new FlxTypedGroup<Rock>();
		_grpStair = new FlxTypedGroup<Stair>();

		_correio = new Correio();
		_hud = new HUD();
		_deadScreen = new DeadScreen();
		_player = new Player(0, 0, this);
		_map = new FlxOgmoLoader(AssetPaths.room_002__oel);
		_boardNext = new BoardNext();
		_nextLevel = new NextLevel();
		sword = new Sword();
		
		//Carrega os layers do mapa
		_walls = _map.loadTilemap(AssetPaths.tiles__png, 16, 16, "walls");
		_bk = _map.loadTilemap(AssetPaths.tiles__png, 16, 16, "bk");
		_bkColor = _map.loadTilemap(AssetPaths.tiles__png, 16, 16, "color");
		
		_walls.follow();

		_walls.setTileProperties(92, FlxObject.NONE); //Não colidir com escada
		_walls.setTileProperties(109, FlxObject.NONE); //Escada inicio
		_walls.setTileProperties(75, FlxObject.NONE); //Escada fim

		//https://opengameart.org/content/a-platformer-in-the-forest

		//Colocar o jogador e as outras coisas no lugar certo do mapa
		_map.loadEntities(placeEntities, "entity");

		//var sprite = new FlxSprite(_player.x +, _player.y);
		//sprite.makeGraphic(16, 16, FlxColor.BLUE);
		add(_correio); //Se não adicionar o correio ele não atualiza e não funciona!!!!
		add(_bkColor);
		add(_bk);
		add(_walls);
		//add(_grpStair);
		add(_player);
		add(_hud);
		add(_grpBox);
		add(_grpCoin);
		add(sword);
		add(_grpWater);
		add(_grpMonster);
		add(_grpRock);
		add(_deadScreen);
		add(_boardNext);
		add(_nextLevel);

		//Cria uma camera para zoom
		var cam:FlxCamera = FlxG.camera;
		_zoomCam = new FlxZoomCamera(Std.int(cam.x), Std.int(cam.y), cam.width, cam.height, cam.zoom);
		_zoomCam.follow(_player, NO_DEAD_ZONE, 3);
 
		FlxG.cameras.reset(_zoomCam);

		FlxG.camera.setScrollBoundsRect(0, 0, _map.width, _map.height);

		FlxG.fullscreen = true;
		
		super.create();
	}


	//A espada possui um bug do lado direito, por algum motivo ela parece menor do que deve ser...
	//Resolver
	function punch():Void {
        if(FlxG.mouse.justPressed){
			var m = new Message(_player, sword, Message.OP_ATTACK);
			_correio.send(m);
			FlxG.overlap(sword, _grpBox, playerAttackBox);
			FlxG.overlap(sword, _grpMonster, playerAttackBox); 
			//Se matar, colocar um esqueleto morto no lugar?
        }
    }
	
	function placeEntities(entityName:String, entityData:Xml):Void{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		
		if(entityName == "player"){
			_player.x = x;
			_player.y = y;
		}
		else if(entityName == "coin"){
			var box = new Coin(x, y);
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
		else if(entityName == "stairs"){
			_grpStair.add(new Stair(x, y));
		}
	}

	public function allColisions() {
		FlxG.collide(_player, _walls); //Colisão
		FlxG.collide(_player, _grpBox);
		//FlxG.collide(_player, FlxObject.FLOOR);
		FlxG.collide(_grpBox, _walls);
		FlxG.collide(_player, _grpRock);
		FlxG.collide(_grpMonster, _walls);
		FlxG.collide(_grpMonster, _grpBox);
		FlxG.collide(_grpMonster, _grpRock);
		FlxG.collide(_grpMonster, _boardNext);

	}

	public function zoom() {
		if (FlxG.keys.justPressed.ONE) _zoomCam.targetZoom += -0.25; // zoom in
        if (FlxG.keys.justPressed.TWO) _zoomCam.targetZoom += 0.25; // zoom out
		if(FlxG.mouse.wheel != 0) _zoomCam.targetZoom += (FlxG.mouse.wheel/10);
	}

	public function allOverlaps() {
		FlxG.overlap(_player, _grpCoin, getCoin); // OK
		FlxG.overlap(_player, _grpWater, waterLetter); //Ok
		
		FlxG.overlap(_player, _grpMonster, playerHurts); // Ok
		
		FlxG.overlap(_player, _boardNext, goNextLevel); //OK
		
		FlxG.overlap(_player, _grpStair, climbStair); //ok

		punch(); //ok -> talvez mudar p/ collision
	}

	

	override public function update(elapsed:Float):Void{
		super.update(elapsed);

		zoom();
		allColisions();
		//climbing();
		
		allOverlaps();


		if(!_player.alive){ //Colocar mensagem que você morreu, etc...
			_hud.updateHUD(0, _money);
			_deadScreen.newDeath(_money);
		}
	}

	/* ------------------------------------------
		FUNÇÕES A SEREM COLOCADAS NO CORREIO
	----------------------------------------------
	*/

	public function climbStair(player: Entity, stair: Entity) {
		if(player.exists && player.alive && FlxG.keys.anyPressed([UP, W])){ //Colocar essa verificação na mensagem?
			var m = new Message(stair, player, Message.OP_CLIMB, -120);
			_correio.send(m);
		}

	}

	function  goNextLevel(player: Entity, winSpot: Entity) {
		if(player.exists && player.alive){
			var m = new Message(player, winSpot, Message.OP_WINS, _money);
			_correio.send(m);
			_nextLevel.wins(_money);
		}
	}


	function playerHurts(player: Entity, monster: Entity){
		if(player.alive && player.exists  && monster.alive && monster.exists){
			var m = new Message(monster, player, Message.OP_HURT, 1);
			_hud.updateHUD(Std.int(player.health - 1), _money);
			_correio.send(m);
		}
	}
	function waterLetter(player: Entity, water: Entity): Void {
		if(player.alive && player.exists  && water.alive && water.exists){
			var m = new Message(water, player, Message.OP_KILL);
			_correio.send(m);
		}
	}

	function getCoin(player: Entity, coin: Entity): Void {
		if(player.alive && player.exists && coin.alive && coin.exists){
			var m = new Message(player, coin, Message.OP_KILL);
			_correio.send(m);
			_hud.updateHUD(Std.int(_player.health), ++_money);
		}
	}

	function playerAttackBox(sword: Entity, enemy: Entity): Void{
		//var _mouse = FlxG.mouse.justPressed;
		if(sword.alive && sword.exists && enemy.alive && enemy.exists){
			var m = new Message(sword, enemy, Message.OP_HURT, 1);
			_correio.send(m);
		}
		sword.kill();
	}
}
