package;

import flixel.FlxSprite;

class Water extends FlxSprite {
    public function new(X: Float, Y: Float){
        super(X, Y);
        loadGraphic(AssetPaths.water__png, false, 16, 16);
    }
}