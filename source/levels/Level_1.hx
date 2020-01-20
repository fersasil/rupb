package levels;
import player.Sword;

using helperClass.ogmo.FlxOgmoUtils;


class Level_1 extends PlayState{
	override public function create():Void { 
        _map = FlxOgmoUtils.get_ogmo_package(AssetPaths.Rup__ogmo, AssetPaths.tutorial__json);
        
        setMap(_map);
        
        var s = new Sword();
        setWeapon(s);

        // _sndBackground = FlxG.sound.play(AssetPaths.flags__ogg, 0.1, true);

        // setSound(_sndBackground);

        super.create();

    }

}