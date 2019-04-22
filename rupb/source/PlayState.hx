package;

import flixel.FlxCamera;
import flixel.util.FlxColor;
import openfl.events.EventDispatcher;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.FlxG;

import flixel.addons.editors.ogmo.FlxOgmoLoader;


class PlayState extends FlxState{
	var _player:Player;
	var _map:FlxOgmoLoader;
	var _walls:FlxTilemap;
	var _bk:FlxTilemap;
	var _bkColor:FlxTilemap;

	override public function create():Void { 
		_map = new FlxOgmoLoader(AssetPaths.room_002__oel);
		//Carrega os layers do mapa
		_walls = _map.loadTilemap(AssetPaths.tiles__png, 16, 16, "walls");
		_bk = _map.loadTilemap(AssetPaths.tiles__png, 16, 16, "bk");
		_bkColor = _map.loadTilemap(AssetPaths.tiles__png, 16, 16, "color");
		
		_walls.follow();
		//_walls.setTileProperties(1, FlxObject.NONE); //Não colidir -> aqui é o chão
		//_walls.setTileProperties(2, FlxObject.ANY); //Colidir -> parede de todas as direções

		_walls.setTileProperties(92, FlxObject.NONE); //Não colidir com escada
		_walls.setTileProperties(109, FlxObject.NONE); //Escada inicio
		_walls.setTileProperties(75, FlxObject.NONE); //Escada fim
		_walls.setTileProperties(42, FlxObject.FLOOR);
		_walls.setTileProperties(45, FlxObject.FLOOR);
		_walls.setTileProperties(46, FlxObject.FLOOR);



		//https://opengameart.org/content/a-platformer-in-the-forest

		_player = new Player();
		//Colocar o jogador e as outras coisas no lugar certo do mapa
		_map.loadEntities(placeEntities, "entity");

		add(_bkColor);
		add(_bk);
		add(_walls);
		add(_player);

		// Create the FlxZoomCamera and pass in the default
		// camera's x/y/width/height/zoom values, then make
		// it follow the player
		// Set camera bounds so the camera doesn't show off-screen area
		// camera = new FlxCamera(0, 0, 230, 180);
		//camera.bgColor = FlxColor.TRANSPARENT;
		// camera.setScrollBoundsRect(0, 0, 1000, 700);
		// FlxG.cameras.reset(camera);
		// camera.style = PLATFORMER;
		//camera.setPosition(-_map.width/2, 0);
		// camera.target = _player;
		// camera.setBounds(200, 200);
		FlxG.camera.follow(_player);
		
		super.create();
	}

	function placeEntities(entityName:String, entityData:Xml):Void{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		
		if(entityName == "player"){
			_player.x = x;
			_player.y = y;
		}
	}

	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		FlxG.collide(_player, _walls); //Colisão
	}
}
