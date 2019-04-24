package;

import flixel.util.FlxColor;
import flixel.FlxSprite;

class Water extends FlxSprite {
    public function new(X: Float, Y: Float){
        super(X, Y);
        loadGraphic(AssetPaths.water__png, false, 16, 16);
        //makeGraphic(16, 16, FlxColor.WHITE);
    }
}