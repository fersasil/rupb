package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.ui.FlxButton;

class MenuState extends FlxState{
    var _mainText:FlxText;
    var _btnPlay: FlxButton;
    var _btnCredits: FlxButton;
	
    override public function create():Void{
        _mainText = new FlxText(0, 0, 0, "RUP", 50);
        _btnPlay = new FlxButton(0, 0, "Jogar!", goPlay);
        _btnCredits = new FlxButton(0, 0, "Créditos:", goCreditos);
        _mainText.x = FlxG.width/2 - _mainText.width/2;

        _mainText.y = FlxG.height/2 - _mainText.height/2;
        
        _btnPlay.x = FlxG.width/2 - _btnPlay.width/2;
        _btnPlay.y = _mainText.y + _mainText.height;

        _btnCredits.x = FlxG.width/2 - _btnCredits.width/2;
        _btnCredits.y = _btnPlay.y + _btnPlay.height;

        add(_btnCredits);
        add(_btnPlay);
        add(_mainText);
        
        super.create();

	}

    function goCreditos(): Void{
        FlxG.switchState(new CreditState());

    }

    function goPlay(): Void{
        FlxG.switchState(new PlayState());

    }

}