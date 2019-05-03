package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite{
	public function new(): Void{
		super();
		//addChild(new FlxGame(400, 320, MenuState));
		addChild(new FlxGame(0, 0, MenuState));
	}
}
