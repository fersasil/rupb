package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class CreditState extends FlxState{
    var _programmer: FlxText;
    var _arte: FlxText;
    var _btn:FlxButton;

	override public function create():Void{
        var PROGRAMADOR = "[DEVELOPER]:\n\nFersasil";
        var ARTE_UM = "[ART]\n\nA platformer in the forest\nTileset by Buch available at:\nhttps://opengameart.org/users/buch\n";
        var ARTE_DOIS = "Dungeon Tileset II\nCharacters by Robert\navaliable at: \nhttps://0x72.itch.io/\n";
        var ARTE_TRES = "Micro Character Bases\nCharacters by Kacper Woźniak\n avaliable at:\nhttps://thkaspar.itch.io/\n";
        var ARTE_QUATRO = "Cute Knight\nCharacter by @goglilol (twitter)\navaliable at:\nhttps://goglilol.itch.io/cute-knight";
        
        _programmer = new FlxText(0, 0, 0, PROGRAMADOR, 25);
        _arte = new FlxText(0, 0, 0, ARTE_UM + ARTE_DOIS + ARTE_TRES + ARTE_QUATRO, 23);
        _btn = new FlxButton(0, 0, "Back", returnState);

        _btn.x = FlxG.width - _btn.width;
        _btn.y = FlxG.height - _btn.height;
        // _programmer.screenCenter();
        //_programmer.angularVelocity = 5;
        
        _programmer.x = FlxG.width/6;
        _programmer.y = FlxG.height/2;
        _programmer.velocity.y = -20;
		_programmer.moves = true;
        
        _arte.moves = true;
        _arte.x = _programmer.x;
        _arte.y = _programmer.y + _programmer.height + 10;
        _arte.velocity.y = -20;


        add(_arte);
        add(_programmer);
        add(_btn);
        super.create();
	}

    function returnState(): Void{
        FlxG.switchState(new MenuState());
    }
}
