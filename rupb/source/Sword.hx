package;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Sword extends Entity{
    public function new() {
        super();
        x = 154;
        y = 448;
        //makeGraphic(5, 8, FlxColor.TRANSPARENT);
        makeGraphic(4, 8, FlxColor.TRANSPARENT);
        kill();
    }
    public function attackFront(Location:FlxPoint, side:Float) {
        super.reset(Location.x + side, Location.y + 10); //Jogador 8 mais alto que 16...
		solid = true;
    }

    //Da entidade
    override public function onMessage(m: Message){
        if(m.op == Message.OP_ATTACK){
            m.from.animation.play("SLASH");
            var side = m.from.movimentSide ? (m.from.width + 3) : -3; //O lado em que a espada aparece
            attackFront(m.from.last, side);
        }
    }
}