package object;

import helperClass.Message;
import helperClass.Entity;
import flixel.FlxG;
import flixel.system.FlxSound;


class Coin extends Entity{
    var _sndCoin:FlxSound;
    public static inline var WIDTH = 6;
	public static inline var HEIGHT = 7;
    


    public function new(X: Float = 0, Y:Float = 0): Void{
        super(X, Y);
        loadGraphic(AssetPaths.coin_w6_h7__png, true, 6, 7);
        animation.add("IDLE", [0, 1, 2, 3], 8, true);
        animation.play("IDLE");
    	_sndCoin = FlxG.sound.load(AssetPaths.coin__wav);
    }

    override public function onMessage(m: Message):Void{
        if(m.op == Message.OP_KILL){
    		_sndCoin.play();
            kill();
        }
    }

}