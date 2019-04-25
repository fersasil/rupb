package;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Sword extends FlxSprite {
    public function new() {
        super();
        x = 154;
        y = 448;
        makeGraphic(16, 16, FlxColor.TRANSPARENT);
        kill();
    }
    public function attackFront(Location:FlxPoint, side:Int) {
        
        super.reset(Location.x + side, Location.y + 8); //Jogador 8 mais alto que 16...
        //velocity.x = Location.x + 10;
        //velocity.y = Location.y;
        //_point.set(x, y);
        
        FlxG.log.add("OOO");
        
        //live = true;
        //exists = true;
		solid = true;
        
    }
}