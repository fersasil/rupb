package;

import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Sword extends Entity{
    public function new(): Void {
        super();
        //x = 154;
        //y = 448;
        //makeGraphic(5, 8, FlxColor.TRANSPARENT);
        makeGraphic(4, 8, FlxColor.TRANSPARENT);
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
            var side = m.from.movimentSide ? (m.from.width + 5) : -5; //O lado em que a espada aparece
            attackFront(m.from.last, side);
        }
    }
}