package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup;
import flixel.FlxCamera;
import flixel.system.FlxSound;

import flixel.addons.editors.ogmo.FlxOgmoLoader;

//ARRUMAR PULO NA BOX ?
//ARRUMAR ZOOM
//ARRUMAR MOEDA

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
	var _money:Int;
	var _health:Int;
	var _nextLevel: NextLevel;
	var _deadScreen: DeadScreen;
	var flashAux: Bool;
	var _correio: Correio;
	var _cam:FlxCamera;

	//Gambiarra hud
	var _count = 0;
	var _scroll: Float;
	var _sndBackground: FlxSound;

	override public function create():Void { 
		_money = 0;
		_health = 3;
		flashAux = true;

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

		// FlxG.sound.playMusic("assets/music/flags.ogg", 0.1, true);

		if (FlxG.sound.music == null){
			_sndBackground = FlxG.sound.play(AssetPaths.flags__ogg, 0.1, true);
			_sndBackground.play();
        }
		
		//Carrega os layers do mapa
		_walls = _map.loadTilemap(AssetPaths.tiles__png, 16, 16, "walls");
		_bk = _map.loadTilemap(AssetPaths.tiles__png, 16, 16, "bk");
		_bkColor = _map.loadTilemap(AssetPaths.tiles__png, 16, 16, "color");
		
		_walls.follow();

		_walls.setTileProperties(92, FlxObject.NONE); //Não colidir com escada
		_walls.setTileProperties(109, FlxObject.NONE); //Escada inicio
		_walls.setTileProperties(75, FlxObject.NONE); //Escada fim


		//Colocar o jogador e as outras coisas no lugar certo do mapa
		_map.loadEntities(placeEntities, "entity");

		

	
		add(_correio); //Se não adicionar o correio ele não atualiza e não funciona!!!!
		add(_bkColor);
		add(_bk);
		add(_walls);
		//add(_grpStair);
		add(_player);
		add(_grpBox);
		add(_grpCoin);
		add(sword);
		add(_grpWater);
		add(_grpMonster);
		add(_grpRock);
		add(_deadScreen);
		add(_boardNext);
		add(_nextLevel);
		add(_hud);

		setCamera();

		
		super.create();
	}

	function setCamera(){
		_cam = new FlxCamera(-FlxG.width, -FlxG.height, FlxG.width, FlxG.height, 3);
		_cam.follow(_player, LOCKON);

		#if mobile
			_cam.zoom = 11; //9 is okay
		#end
 
		FlxG.cameras.reset(_cam);
		

		FlxG.camera.setScrollBoundsRect(0, 0, _map.width, _map.height);
		
		FlxG.fullscreen = true;

		#if (desktop || html5)
			FlxG.mouse.visible = false;
		#end
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

	public function allColisions():Void {
		FlxG.collide(_player, _walls); //Colisão
		FlxG.collide(_player, _grpBox);
		FlxG.collide(_grpBox, _walls);
		FlxG.collide(_player, _grpRock);
		FlxG.collide(_grpMonster, _walls);
		FlxG.collide(_grpMonster, _grpBox);
		FlxG.collide(_grpMonster, _grpRock);
		FlxG.collide(_grpMonster, _boardNext);
		FlxG.collide(sword, _grpMonster, playerAttackBox);

	}


	function allOverlaps():Void {
		FlxG.overlap(_player, _grpCoin, getCoin);
		FlxG.overlap(_player, _grpWater, waterLetter);
		FlxG.overlap(_player, _grpMonster, playerHurts);
		FlxG.overlap(_player, _boardNext, goNextLevel); 
		FlxG.overlap(_player, _grpStair, climbStair);
		
		//TODO reimplementação do android
		// if(FlxG.mouse.justPressed || FlxG.keys.anyJustPressed([P, SPACE])){ 
		// 	//Mouse pressionado, chamar a espada
		// 	var m = new Message(_player, sword, Message.OP_ATTACK);
		// 	_correio.send(m);
		// }

		//Verificar se há overlap entre a caixa e a espada
		if(!FlxG.overlap(sword, _grpBox, function (sword, box){
			var m = new Message(sword, box, Message.OP_KILL);
			m.data = _player.movimentSide ? 1 : 0;
			_correio.send(m);
		})){
			sword.kill();
		}
		//punch(); //ok -> talvez mudar p/ collision
	}

	

	override public function update(elapsed:Float):Void{
		super.update(elapsed);

		allColisions();		
		allOverlaps();


		if(!_player.alive){ //Colocar mensagem que você morreu, etc...
			// _hud.updateHUD(0, _money);
			_deadScreen.newDeath(_money);
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

	function climbStair(player: Entity, stair: Entity):Void {
		//Todo Reimplementar subir escadas
		#if (desktop|| html5)
		if(player.exists && player.alive && FlxG.keys.anyPressed([UP, W])){ //Colocar essa verificação na mensagem?
			var m = new Message(stair, player, Message.OP_CLIMB, -120);
			_correio.send(m);
		}
		#end

	}

	function goNextLevel(player: Entity, winSpot: Entity):Void {
		if(player.exists && player.alive){
			_sndBackground.stop();
			var m = new Message(player, winSpot, Message.OP_WINS, _money);
			_correio.send(m);
			_nextLevel.wins(_money);

			#if (desktop || html5)
				FlxG.mouse.visible = true;
			#end
		}
	}


	function playerHurts(player: Entity, monster: Entity): Void{
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
		if(enemy.alive && enemy.exists){
			var m = new Message(sword, enemy, Message.OP_HURT, 1);
			_correio.send(m);
		}
	}
}
