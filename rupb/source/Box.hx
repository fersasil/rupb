package;

import flixel.FlxSprite;

class Box extends FlxSprite{
    public function new(X:Float = 0, Y:Float = 0){
        super(X + 2, Y + 2);
        loadGraphic(AssetPaths.box12x12__png, false, 12, 12);
        this.immovable = true;
    }
}