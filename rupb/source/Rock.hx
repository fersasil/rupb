package;

import flixel.FlxSprite;

class Rock extends FlxSprite{
    public function new(X:Float = 0, Y:Float = 0): Void{
        super(X, Y);
        loadGraphic(AssetPaths.rock__png, false, 13, 9);
        immovable = true;
    }

}