package player;

import helperClass.Message;
import helperClass.Entity;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.system.FlxSound;

class Sword extends Entity{
    var _sndSword:FlxSound;

    public function new(): Void {
        super();
        makeGraphic(4, 8, FlxColor.TRANSPARENT);
    	_sndSword = FlxG.sound.load(AssetPaths.slash__wav, 0.2);
        kill();
    }
    public function attackFront(Location:FlxPoint, side:Float): Void {
        super.reset(Location.x + side, Location.y + 10); //Jogador 8 mais alto que 16...
		solid = true;
    }

    //Da entidade
    override public function onMessage(m: Message): Void{
        if(m.op == Message.OP_ATTACK){
            m.from.animation.play("SLASH");
    	    _sndSword.play();

            var side = m.from.movimentSide ? (m.from.width + 5) : -5; //O lado em que a espada aparece
            attackFront(m.from.last, side);
        }
    }
}