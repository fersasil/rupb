package;

import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

class OrcMasked extends FlxSprite{
    var bool = true;
    var count_moviment = 0;
    static var MOVIMENT = 125;

    public function new(X:Float = 0, Y: Float = 0){
        super(X, Y);
        loadGraphic(AssetPaths.orcMasked_w13_h18__png, true, 13, 18);

        setFacingFlip(FlxObject.RIGHT, false, false);
        setFacingFlip(FlxObject.LEFT, true, false);
        
        //acceleration.y = -1000; //Cria Gravidade
        velocity.x = 30;
        //drag.y = 1600;
        acceleration.y = 700;
        // acceleration.x = 300;

        animation.add("WALK", [0, 1, 3], 8, true);

        animation.play("WALK");
    }

    override public function update(elapsed:Float):Void {
        //verifyColision();

        moviment();           
        super.update(elapsed);


        //FlxG.log.add("DEPOIS" + velocity.y);
    }

    function moviment(){
        if(velocity.x > 0){
            facing = FlxObject.RIGHT;
        }
        else{
            facing = FlxObject.LEFT;
            //FlxG.log.add(y);
        }

        if(velocity.y == 0){
            velocity.y = -200;
        }

        count_moviment++;
        if(count_moviment == MOVIMENT){
            count_moviment = 0;
            velocity.x *= -1;
        } 
    }

    
}