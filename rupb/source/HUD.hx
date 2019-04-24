package;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;


class HUD extends FlxTypedGroup<FlxSprite>{
    var _fundo:FlxSprite;
    var _txtHealth:FlxText;
    var _txtMoney:FlxText;
    var _sprHealth:FlxSprite;
    var _sprMoney:FlxSprite;

    public function new(){
        super();
        _fundo = new FlxSprite(); //poderia colocar a linha de baixo aqui com ponto
        _fundo.makeGraphic(FlxG.width, 20, FlxColor.BLACK);
        //FlxSpriteUtil.drawRect(_fundo, 0, 19, FlxG.width, 1, FlxColor.WHITE); //)drawRect(0, 19, FlxG.width, 1, FlxColor.WHITE);
        _txtHealth = new FlxText(16, 2, 0, "3 / 3", 8);
        _txtHealth.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
        _txtMoney = new FlxText(0, 2, 0, "0", 8);
        _txtMoney.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);

        //Criar sprite para ter o coração 
        //criar o sprite que representa a moeda


        _txtMoney.alignment = RIGHT;
        //_txtMoney.x = _sprMoney.x - _txtMoney.width - 4;

        add(_fundo);
        add(_txtHealth);
        add(_txtMoney);

        //Impedir que o scroll de tela ocorra
        //mesmo que o jogador se mova a tela não ira se mexer também

        //Poderia se adicionar um a um, mas esse é um jeito mais limpo e mais facil leitura
        forEach(function(sprite: FlxSprite){
            sprite.scrollFactor.set(0, 0);
        });
    }

    public function updateHUD(Health:Int = 0, Money:Int = 0): Void {
        //Mudar o texto do hud
        _txtHealth.text = Std.string(Health) + "/3";
        _txtMoney.text = Std.string(Money);
        //linha a ver com o sprite
        //_txtMoney.x = _sprMoney.x - _txtMoney.width - 4;
    }
}