package;

import flixel.util.FlxColor;
import flixel.FlxSprite;

class Stair extends FlxSprite{
    public function new(X: Float, Y: Float) {
        super(X + 7.8, Y);
        makeGraphic(1, 16, FlxColor.BLUE);
    }
}