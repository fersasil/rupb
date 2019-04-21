package;

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

	override public function create():Void{
		_map = new FlxOgmoLoader(AssetPaths.room_001__oel);
		//Carrega os layers do mapa
		_walls = _map.loadTilemap(AssetPaths.tiles__png, 16, 16, "walls");
		_bk = _map.loadTilemap(AssetPaths.tiles__png, 16, 16, "bk");
		_bkColor = _map.loadTilemap(AssetPaths.tiles__png, 16, 16, "color");
		
		_walls.follow();
		_walls.setTileProperties(1, FlxObject.NONE); //Não colidir -> aqui é o chão
		_walls.setTileProperties(2, FlxObject.ANY); //Colidir -> parede de todas as direções
		

		//https://opengameart.org/content/a-platformer-in-the-forest

		_player = new Player();
		//Colocar o jogador e as outras coisas no lugar certo do mapa
		_map.loadEntities(placeEntities, "entity");

		add(_bkColor);
		add(_bk);
		add(_walls);
		add(_player);
		
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
	}
}
