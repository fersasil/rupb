package;

import Type.ValueType;
import haxe.Log;
import flixel.math.FlxPoint;
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
	public var _walls:FlxTilemap;
	var _bk:FlxTilemap;
	var _bkColor:FlxTilemap;
	public var _escadas2: Array<FlxPoint>;

	public static inline var ESCADA = 20;

	override public function create():Void { 
		_player = new Player(0, 0, this);

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
		//_walls.setTileProperties(92, ESCADA);
		//_escadas = _walls.getTileCoords(92);
		//_escadas1 = _walls.getTileCoords(109);
		_escadas2 = _walls.getTileCoords(109, false);
		gambiArrumaY();




		//https://opengameart.org/content/a-platformer-in-the-forest

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
	
	//Mover essa função para a classe player o quanto antes
	function climbing(){
		var verificador = false;

        if(_player.x == _escadas2[0].x && _player.y - _escadas2[0].y >= 0) //Verifica se o jogador esta na mesma posição da primeira escada
			verificador = true;
		else if(_player.x == _escadas2[1].x && _player.y - _escadas2[1].y >= 0) //Verifica se o jogador esta na escada dois
			verificador = true;

		else if(_player.x == _escadas2[2].x && _player.y - _escadas2[2].y >= 0 && _player.y <= 224) //verifica se o jogador esta na escada 3 com a altura certa
			verificador = true;
		
		if(verificador){ //Se uma das teclas pressionadas o jogador sobe
			_player.acceleration.y = 0;
				var _cima = FlxG.keys.anyPressed([UP, W]);
        		var _baixo = FlxG.keys.anyPressed([DOWN, S]);
				var _mouse = FlxG.mouse.justPressed;

				var velocidade = 200;

				if(_cima)
					_player.velocity.y = - velocidade;
				else if(_baixo)
					_player.velocity.y = velocidade *2;
				else if(_mouse){
					_player.velocity.y = - velocidade;
				}
				
            }
		else{
			_player.acceleration.y = 1000;
		}    
    }

	function placeEntities(entityName:String, entityData:Xml):Void{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		
		if(entityName == "player"){
			_player.x = x;
			_player.y = y;
		}
	}

	//O y do personagem decresce no mapa, enquanto o y do mapa aumenta
	//A função a seguir arruma o y das escadas de acordo com o y desejado para a função
	//funcionar
	//Mover essa função para classe player
	function gambiArrumaY() {
		_escadas2[0].y = 337;
		_escadas2[1].y = 225;
		_escadas2[2].y = 113;
	}

	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		FlxG.collide(_player, _walls); //Colisão
		climbing();
		//FlxG.overlap(_player, _walls.getTileCoords(92)[0])
	}
}
