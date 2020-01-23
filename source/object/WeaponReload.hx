package object;

import flixel.FlxG;
import player.Player;
import helperClass.Message;
import helperClass.Entity;

class WeaponReload extends Entity{
    public function new(X: Float, Y: Float): Void{
        super(X, Y);
        loadGraphic(AssetPaths.sword__png, false, 13, 12);
        scale.x = .6;
        scale.y = .6;
        angle = -45;
        updateHitbox();

    }

    //Da entidade
    override public function onMessage(m: Message):Void{
        if(m.op == Message.OP_CREATE_WEAPON){
            var player = cast(m.from, Player);
            player.setWeapon(m.dynamicData);
            kill();
        }
        else if(m.op == Message.OP_RELOAD_WEAPON){
            //TODO: ADD MUNIÇÃO
            kill();
        }
    }
}