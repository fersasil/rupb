package object;

import helperClass.Message;
import helperClass.Entity;
import flixel.FlxG;
import flixel.system.FlxSound;

class Box extends Entity {
    var _sndBox:FlxSound;

    public function new(X:Float = 0, Y:Float = 0): Void{
        super(X + 2, Y + 2);
        loadGraphic(AssetPaths.box12x12__png, false, 12, 12);
        this.immovable = true;
        health = 1;

    	_sndBox = FlxG.sound.load(AssetPaths.box__wav, 0.7);
    }
    //Da entidade
    override public function onMessage(m: Message):Void{
        if(m.op == Message.OP_KILL){
            kill();
            m.from.kill(); //Faz a espada desaparecer!
    	    _sndBox.play();
        }

        if(m.op == Message.OP_HURT){
            hurt(m.data);

            m.from.kill(); //Faz a espada desaparecer!
    	    _sndBox.play();
        }    
    }
}