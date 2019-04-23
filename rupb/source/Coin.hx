package;

import flixel.FlxSprite;

class Coin extends FlxSprite{
    public function new(X: Float = 0, Y:Float = 0){
        super(X, Y);
        loadGraphic(AssetPaths.coin__png, false, 7, 9);
    }


}