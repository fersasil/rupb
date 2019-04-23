package;

import openfl.display.Sprite;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Box extends FlxSprite{
    public function new(X:Float = 0, Y:Float = 0){
        super(X, Y);
        makeGraphic(16, 16, FlxColor.RED);
        this.immovable = true;
    }
}