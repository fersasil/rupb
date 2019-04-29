package;

import flixel.FlxSprite;

class Coin extends Entity{
    public function new(X: Float = 0, Y:Float = 0){
        super(X, Y);
        loadGraphic(AssetPaths.coin_w6_h7__png, true, 6, 7);
        animation.add("IDLE", [0, 1, 2, 3], 6, true);
        animation.play("IDLE");
    }

    override public function onMessage(m: Message){
        if(m.op == Message.OP_KILL){
            kill();
        }
    }

}