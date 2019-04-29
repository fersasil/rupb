package;

import flixel.FlxSprite;

class Water extends Entity{
    public function new(X: Float, Y: Float){
        super(X, Y);
        loadGraphic(AssetPaths.water__png, false, 16, 16);
    }

    //Da entidade
        override public function onMessage(m: Message){
        //Write a message here!!!!!
    }
}