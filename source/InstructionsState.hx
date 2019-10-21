package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;


class InstructionsState extends FlxState{
    var _instructions: FlxText;
    var _left: FlxText;
    var _right: FlxText;
    var _jump: FlxText;
    var _swordMoviment: FlxText;
    var _btn: FlxButton;

    override public function create():Void{
        _instructions = new FlxText(0, 0, "INSTRUCTIONS", 30);
        _jump = new FlxText(0, 0, "JUMP -> W OR ARROW UP", 15);
        _left = new FlxText(0, 0, "LEFT -> A OR ARROW LEFT", 15);
        _right = new  FlxText(0, 0, "RIGHT -> D OR ARROW RIGHT", 15);
        _swordMoviment = new FlxText(0, 0, "ATTACK -> P, SPACE  OR LEFT MOUSE CLICK", 15);
        _btn = new FlxButton(0, 0, "Go back", goBack);
        
        _instructions.x = FlxG.width/2 - _instructions.width/2;
        _instructions.y = FlxG.height / 6;

        _left.x = 50;
        _left.y = _instructions.y + _instructions.height + 10;

        _right.x = 50;
        _right.y = _left.y + _left.height + 10;

        _jump.x = 50;
        _jump.y = _right.y + _right.height + 10; 

        _swordMoviment.x = 50;
        _swordMoviment.y = _jump.y + _jump.height + 10;

        _btn.x = 10;
        _btn.y = _swordMoviment.y + _swordMoviment.height + 10;

        add(_instructions);
        add(_jump);
        add(_left);
        add(_right);
        add(_swordMoviment);
        add(_btn);
    }

    override public function update(elapsed:Float):Void{
		super.update(elapsed);

        if(FlxG.keys.justPressed.UP) goBack();
	}

    function goBack():Void{
        FlxG.switchState(new MenuState());
    }

}