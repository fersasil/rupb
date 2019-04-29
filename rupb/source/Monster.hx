package;

import flixel.FlxG;
import flixel.effects.FlxFlicker;
import flixel.FlxObject;
import flixel.FlxSprite;

class Monster extends Entity{
    public var monsterType: Int;
    public var VELOCITY: Float;
    public var count_moviment = 0;
    public var MOVIMENT = 125;

    public function new(X:Float = 0, Y: Float = 0, monsterType:Int){
        super(X, Y);
        this.monsterType = monsterType;
        health = 1;
    }

    //Da entidade
    override public function onMessage(m: Message){
        if(m.op == Message.OP_HURT){
            hurt(m.data);
        }
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