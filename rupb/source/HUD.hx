package;

import js.html.Animation;
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

    public function new(){
        super();
        _fundo = new FlxSprite(); //poderia colocar a linha de baixo aqui com ponto
        _fundo.makeGraphic(FlxG.width, 20, FlxColor.BLACK);
        

        _life = new FlxSprite(20, 4);
        _life.loadGraphic(AssetPaths.lifeBar41x12__png , true, 41, 12);

        _coin = new FlxSprite(_life.width + _life.x + 20, 4);
        _coin.loadGraphic(AssetPaths.coin__png, false, 16, 16);

        _textCoin = new FlxText(_coin.x + _coin.width + 1, _coin.y - 2);
        _textCoin.text = ": 0";

        _life.animation.add("3", [0], 1, false);
        _life.animation.add("2", [1], 1, false);
        _life.animation.add("1", [2], 1, false);
        _life.animation.add("0", [3], 1, false);

        add(_fundo);
        add(_life);
        add(_coin);
        add(_textCoin);
  

        //Impedir que o scroll de tela ocorra
        //mesmo que o jogador se mova a tela não ira se mexer também

        //Poderia se adicionar um a um, mas esse é um jeito mais limpo e mais facil leitura
        forEach(function(sprite: FlxSprite){
            sprite.scrollFactor.set(0, 0);
        });

    }

    public function updateHUD(health:Int = 0, money:Int = 0): Void {
        _textCoin.text = ": " + money;
        if(health == 3){
            _life.animation.play("3");
        }
        if(health == 2){
            _life.animation.play("2");
        }
        else if(health == 1){
            _life.animation.play("1");
        }
        else if(health == 0){
            _life.animation.play("0");
        }
    }
}