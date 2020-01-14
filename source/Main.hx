package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite{
	public function new(): Void{
		super();
		//P falso é para n pular splash screen
		addChild(new FlxGame(0, 0, PlayState, 1, 60, 60, false, true));
	}
}
