package helperClass;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;


class HUD extends FlxTypedGroup<FlxSprite>{
    var _background:FlxSprite;
    var _textCoin:FlxText;
    var _life:FlxSprite;
    var _coin:FlxSprite;
    var count = 0.0;

    public function new(scale: Float): Void{
        super();
        _background = new FlxSprite();
        _background.makeGraphic(FlxG.width, 10, FlxColor.TRANSPARENT);
        
        _background.scale.x = scale;
        _background.scale.y = scale;

        _background.updateHitbox();


        _life = new FlxSprite(10, 323);
        _life.loadGraphic(AssetPaths.lifeBar41x12__png , true, 41, 12);

        _life.scale.x = scale;
        _life.scale.y = scale;


        _coin = new FlxSprite(_life.width + _life.x + 20, 4);
        _coin.loadGraphic(AssetPaths.coin__png, false, 16, 16);

        _textCoin = new FlxText(_coin.x + _coin.width + 1, _coin.y);
        _textCoin.text = ": 0";

        _life.animation.add("3", [0], 1, false);
        _life.animation.add("2", [1], 1, false);
        _life.animation.add("1", [2], 1, false);
        _life.animation.add("0", [3], 1, false);
       
        add(_background);
        add(_life);
        add(_coin);
        add(_textCoin);


        forEach(function (sprite) {
            sprite.scale.x = scale;
            sprite.scale.y = scale;
            sprite.updateHitbox();
        });

        _life.y = _background.y + 2  * scale;
        _life.x = _background.x + 2 * scale;

        _coin.x = _life.x + _life.width + 20 * scale;
        
        _textCoin.y = _coin.y = _life.y;
        _textCoin.x = _coin.x + _coin.width;
        _textCoin.y -= 3 * scale;
    }

    public function hideHUD(){
        forEach(function(sprite: FlxSprite){
            sprite.kill();
        });
    }

    public function showHUD(){
        forEach(function(sprite: FlxSprite){
            if(sprite == _background) return;
            sprite.revive();
        });
    }

    override function update(elapsed:Float) {
        //TODO hud has a reference to user data

        super.update(elapsed);
    }

    public function updateHUD(health:Int = 0, money:Int = 0): Void {
        _textCoin.text = ": " + money;
        _life.animation.play(Std.string(health));
    }
}