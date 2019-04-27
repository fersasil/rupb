package;

import flixel.FlxObject;

class Skeleton extends Monster{
    public function new(X:Float = 0, Y:Float = 0, D: Bool = true) {
        super(X, Y, 0);

        loadGraphic(AssetPaths.skull12x14__png , true, 12, 14);

        //Fazer com que só precise de um dos lados da animação
        setFacingFlip(FlxObject.RIGHT, false, false);
        setFacingFlip(FlxObject.LEFT, true, false);

        //Criar animações

        animation.add("WALK", [1, 2, 3], 7, false);

        //Direção em que os esqueletos andam ao nascer
        if(D) velocity.x = 20;
        else velocity.x = -20;
    }

    override public function update(elapsed:Float):Void {
        verifyColision();
        super.update(elapsed);
        
        if(velocity.x > 0){
            facing = FlxObject.RIGHT;
        }
        else{
            facing = FlxObject.LEFT;
        }

        animation.play("WALK");
    }
}