package;

import flixel.util.FlxColor;
import flixel.FlxSprite;

class Stair extends Entity{
    public function new(X: Float, Y: Float) {
        super(X + 7.8, Y);
        makeGraphic(1, 16, FlxColor.BLUE);
    }

    //Da entidade
        override public function onMessage(m: Message){
        //Write a message here!!!!!
    }
}