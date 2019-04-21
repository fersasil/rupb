package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.math.FlxVelocity;
import flixel.FlxObject;

class CreditState extends FlxState{
    var _programmer: FlxText;
    var _arte: FlxText;

	override public function create():Void{
        var PROGRAMADOR = "[PROGRAMADOR]:\nGUILHERME";
        var ARTE = "[ARTE]\nA platformer in the forest tileset\n by Buch\navailable at \nhttps://opengameart.org/users/buch";

        _programmer = new FlxText(0, 0, 0, PROGRAMADOR, 30);
        _arte = new FlxText(0, 0, 0, ARTE, 30);
        
		_programmer.moves = true;
        _programmer.screenCenter();
        //_programmer.angularVelocity = 5;
        _programmer.velocity.y = -20;

        _arte.moves = true;
        _arte.x = _programmer.x;
        _arte.y = _programmer.y + _arte.height;
        _arte.velocity.y = -20;


        add(_arte);
        add(_programmer);
        super.create();
	}
}
