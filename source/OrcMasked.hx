package;

import flixel.FlxObject;

class OrcMasked extends Monster{
    var bool = true;

    public function new(X:Float = 0, Y: Float = 0): Void{
        super(X, Y, 1);

        loadGraphic(AssetPaths.orcMasked_w13_h18__png, true, 13, 18);
        setFacingFlip(FlxObject.RIGHT, false, false);
        setFacingFlip(FlxObject.LEFT, true, false);
        
        health = 1;
        velocity.x = 30;
        acceleration.y = 700;
        animation.add("WALK", [0, 1, 3], 8, true);
        animation.play("WALK");
    }

    override public function update(elapsed:Float):Void {
        moviment();           
        super.update(elapsed);
    }
    
}