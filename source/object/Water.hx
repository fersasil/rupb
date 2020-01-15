package object;

import helperClass.Message;
import helperClass.Entity;

class Water extends Entity{
    public function new(X: Float, Y: Float): Void{
        super(X, Y);
        loadGraphic(AssetPaths.water__png, false, 16, 16);
    }

    //Da entidade
        override public function onMessage(m: Message): Void{
        //Write a message here!!!!!
    }
}