package helperClass;

import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;


class HUD extends FlxTypedGroup<FlxSprite>{
    var _fundo:FlxSprite;
    var _textCoin:FlxText;
    var _life:FlxSprite;
    var _coin:FlxSprite;

    public function new(): Void{
        super();
        _fundo = new FlxSprite(); //poderia colocar a linha de baixo aqui com ponto
        _fundo.makeGraphic(FlxG.width, 10, FlxColor.BLACK);
 
        _life = new FlxSprite(10, 323);
        _life.loadGraphic(AssetPaths.lifeBar41x12__png , true, 41, 12);

        _coin = new FlxSprite(_life.width + _life.x + 20, 4);
        _coin.loadGraphic(AssetPaths.coin__png, false, 16, 16);

        _textCoin = new FlxText(_coin.x + _coin.width + 1, _coin.y);
        _textCoin.text = ": 0";

        _life.animation.add("3", [0], 1, false);
        _life.animation.add("2", [1], 1, false);
        _life.animation.add("1", [2], 1, false);
        _life.animation.add("0", [3], 1, false);

        add(_fundo);
        add(_life);
        add(_coin);
        add(_textCoin);

        //Poderia se adicionar um a um, mas esse é um jeito mais limpo e mais facil leitura
        forEach(function(sprite: FlxSprite){
            sprite.scrollFactor.set(0, 0);
        });

        _fundo.kill();
    }

    public function hideHUD(){
        forEach(function(sprite: FlxSprite){
            sprite.kill();
        });
    }

    public function showHUD(){
        forEach(function(sprite: FlxSprite){
            if(sprite == _fundo) return;
            sprite.revive();
        });
    }

    public function changePosition(cam: FlxCamera): Void{
        _fundo.y = FlxG.height - cam.maxScrollY + cam.scroll.y;
        _fundo.x = -cam.scroll.x;

        _life.y = _fundo.y;
        _life.x = _fundo.x;

        _textCoin.y = _coin.y = _fundo.y;
        _coin.y += 1;
        _coin.x = _life.x + _life.width + 20;
        _textCoin.x = _coin.x + _coin.width;
        _textCoin.y -= 3;
    }

    public function updateHUD(health:Int = 0, money:Int = 0): Void {
        _textCoin.text = ": " + money;
        _life.animation.play(Std.string(health));
    }
}