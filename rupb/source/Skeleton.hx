package;

import flixel.FlxObject;
import flixel.FlxSprite;

class Skeleton extends FlxSprite{
    public var VELOCITY: Float = 15;


    public function new(X:Float = 0, Y:Float = 0, D: Bool = true) {
        super(X, Y);

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

    function verifyColision() {

        if(this.isTouching(FlxObject.RIGHT)){
            this.velocity.x = -20;
            this.x -= 0.1;
            facing = FlxObject.LEFT;
            animation.play("WALK"); //talvez trocar por uma animação de "virar"
        }
        else if(this.isTouching(FlxObject.LEFT)){
            this.velocity.x = 20;
            this.x += 0.1;
            facing = FlxObject.RIGHT;
            animation.play("WALK");
        }
    }

}