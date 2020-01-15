package object;

import helperClass.Message;
import helperClass.Entity;
import flixel.util.FlxColor;

class Stair extends Entity{
    public function new(X: Float, Y: Float): Void {
        super(X + 7.8, Y);
        makeGraphic(1, 16, FlxColor.BLUE);
    }

    //Da entidade
        override public function onMessage(m: Message): Void{
        //Write a message here!!!!!
    }
}