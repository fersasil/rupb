package monster;

import helperClass.Message;
import flixel.effects.FlxFlicker;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.system.FlxSound;

class Skeleton extends Monster{
    public function new(X:Float = 0, Y:Float = 0, D: Bool = true): Void {
        super(X, Y, 0);
        health = 2;

        loadGraphic(AssetPaths.skull12x14__png , true, 12, 14);

        //Fazer com que só precise de um dos lados da animação
        setFacingFlip(FlxObject.RIGHT, false, false);
        setFacingFlip(FlxObject.LEFT, true, false);

        //Criar animações

        animation.add("WALK", [1, 2, 3], 7, false);

        //Direção em que os esqueletos andam ao nascer
        if(D) velocity.x = 20;
        else velocity.x = -20;

    	_sndHit = FlxG.sound.load(AssetPaths.box__wav, 0.4);
        //acceleration.y = 200;
    }
    
    override public function onMessage(m: Message): Void{
        if(m.op == Message.OP_HURT){
            hurt(m.data);
            FlxFlicker.flicker(this, .4);
    	    _sndHit.play();
            m.from.kill(); //destroi a espada
        }
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