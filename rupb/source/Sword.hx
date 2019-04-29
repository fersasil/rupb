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
        makeGraphic(2, 8, FlxColor.TRANSPARENT);
        kill();
    }
    public function attackFront(Location:FlxPoint, side:Int) {
        super.reset(Location.x + side, Location.y -1); //Jogador 8 mais alto que 16...
        FlxG.log.add(x);
		solid = true;
    }

    //Da entidade
    override public function onMessage(m: Message){
        m.from.animation.play("SLASH");
        var side = m.from.movimentSide ? 16 : -5; //O lado em que a espada aparece
        attackFront(m.from.last, side);
    }
}