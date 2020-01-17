package levels;
import flixel.FlxG;
import flixel.util.FlxTimer;
import player.Sword;
import flixel.addons.editors.ogmo.FlxOgmoLoader;

class Level_1 extends PlayState{
	override public function create():Void { 
		_map = new FlxOgmoLoader(AssetPaths.room_002__oel);
        
        setMap(_map);
        
        var s = new Sword();
        setWeapon(s);

        _sndBackground = FlxG.sound.play(AssetPaths.flags__ogg, 0.1, true);

        setSound(_sndBackground);

        super.create();

    }

}