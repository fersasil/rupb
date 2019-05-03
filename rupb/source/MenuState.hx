package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.ui.FlxButton;

class MenuState extends FlxState{
    var _mainText:FlxText;
    var _btnPlay: FlxButton;
    var _btnCredits: FlxButton;
    var _btnInstructions: FlxButton;
	
    override public function create():Void{
        _mainText = new FlxText(0, 0, 0, "RUP", 50);
        _btnPlay = new FlxButton(0, 0, "Play", goPlay);
        _btnInstructions = new FlxButton(0, 0, "Instructions", goInstructions);
        _btnCredits = new FlxButton(0, 0, "Credits", goCreditos);
        _mainText.x = FlxG.width/2 - _mainText.width/2;

        _mainText.y = FlxG.height/2 - _mainText.height/2;
        
        _btnPlay.x = FlxG.width/2 - _btnPlay.width/2;
        _btnPlay.y = _mainText.y + _mainText.height;

        _btnInstructions.x = FlxG.width/2  - (_btnInstructions.width + _btnCredits.width)/2;
        _btnInstructions.y = _btnPlay.y + 5 + _btnPlay.height;

        _btnCredits.x = _btnInstructions.x + 5 + _btnInstructions.width;
        _btnCredits.y = _btnInstructions.y;

        add(_btnCredits);
        add(_btnPlay);
        add(_btnInstructions);
        add(_mainText);
        
        super.create();

	}

    function goCreditos(): Void{
        FlxG.switchState(new CreditState());
    }

    function goPlay(): Void{
        FlxG.switchState(new PlayState());
    }
    function goInstructions(): Void{
        FlxG.switchState(new InstructionsState());
    }

}