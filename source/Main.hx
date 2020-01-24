package;

import flixel.FlxGame;
import openfl.display.Sprite;
import levels.Level_1;

class Main extends Sprite{

	public function new(): Void{
		super();
		//P falso é para n pular splash screen

		addChild(new FlxGame(0, 0, MenuState, 1, 60, 60, true, true));
	}
}
