package;

import openfl.display.Sprite;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Box extends FlxSprite{
    public function new(X:Float = 0, Y:Float = 0){
        super(X, Y);
        loadGraphic(AssetPaths.box__png, false, 7, 9);
        this.immovable = true;
    }
}