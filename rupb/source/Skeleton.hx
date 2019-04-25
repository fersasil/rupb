package;

import flixel.FlxG;
import flixel.math.FlxRandom;
import haxe.display.Position.Range;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.math.FlxRandom;

class Skeleton extends FlxSprite{
    public var VELOCITY: Float = 15;
    public var direction: Bool = false;


    public function new(X:Float = 0, Y:Float = 0) {
        super(X, Y);
        //makeGraphic(16, 16, FlxColor.BLUE);
        // loadGraphic(AssetPaths.skeletonSprite__png, true, 16, 16);
        loadGraphic(AssetPaths.skeletonSprite__png, true, 16, 16);


        //Fazer com que só precise de um dos lados da animação
        setFacingFlip(FlxObject.RIGHT, false, false);
        setFacingFlip(FlxObject.LEFT, true, false);

        //Criar animações

        animation.add("WALK", [1, 2, 3], 10, false);

        velocity.x = 20;
        direction = true; //Direita

        //drag.x = drag.y = 1600;
        //acceleration.y = 1000;
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

        if(this.isTouching(FlxObject.RIGHT)){//!sk.justTouched(FlxObject.RIGHT)
            this.velocity.x = -20;
            this.x -= 0.1;
            facing = FlxObject.LEFT;
            animation.play("WALK"); //talver trocar por uma animação de "virar"
        }
        else if(this.isTouching(FlxObject.LEFT)){
            this.velocity.x = 20;
            this.x += 0.1;
            facing = FlxObject.RIGHT;
            animation.play("WALK");
        }
    }

    function onOverlap(a: Skeleton, b:Water):Void{
        a.kill();
        //a.angularVelocity = 100;
    }

    /*function moviment() {
                
        var op = FlxG.random.int(0, 1);

        if(op == 1){
            velocity.x *= -1;
            acceleration.x = FlxG.random.int(-3, 3, [0]);
        }
        //velocity.x = 0;
        
        /*switch op{
            case 0:{ //Mover para esquerda
                acceleration.x = - FlxG.random.int(1, 5);
                
                if(velocity.x > 0)
                    facing = FlxObject.RIGHT;
                else if(velocity.x < 0)
                    facing = FlxObject.LEFT;
               
                animation.play("WALK");
            }
            case 1:{ //Mover para direita
                acceleration.x = FlxG.random.int(1, 5);

                if(velocity.x > 0)
                    facing = FlxObject.RIGHT;
                else if(velocity.x < 0)
                    facing = FlxObject.LEFT;
                
                animation.play("WALK");
            }

            case 2:{ //Pular 

            }

            case 3:{ //Pular mais direita


            }

            case 4:{ //Pular mais esquerda

            }

            case 5:{ //Atirar? 

            }
        }*/
    //}

    function moviment(){

    }

}