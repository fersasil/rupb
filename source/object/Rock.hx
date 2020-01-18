package object;

import helperClass.Entity;

class Rock extends Entity{
    public function new(X:Float = 0, Y:Float = 0): Void{
        super(X, Y);
        loadGraphic(AssetPaths.rock__png, false, 13, 9);
        immovable = true;
    }

}