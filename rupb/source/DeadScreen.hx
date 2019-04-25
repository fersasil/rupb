package;

import flixel.ui.FlxButton;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import js.html.ConsoleInstance;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSprite;

class DeadScreen extends FlxTypedGroup<FlxSprite>{
    var _infoText: FlxText;
    var _deathText: FlxText;
    var _fundo: FlxSprite;
    var _btnJogar: FlxButton;
    var _btnMenuPrincipal: FlxButton;

    public function new():Void{
        super();

        _fundo = new FlxSprite();
        _deathText = new FlxText();
        _infoText = new FlxText();
        _btnJogar = new FlxButton(0, 0, "Jogar", resetGame);
        _btnMenuPrincipal = new FlxButton(0, 0, "Voltar", menuPrincial);

        //quadrado de 200 x 200;
        _fundo.makeGraphic(300, 200, FlxColor.BLACK);
        _fundo.x = FlxG.width/2 - _fundo.width/2;
        _fundo.y = FlxG.height/2 - _fundo.height/2;

        //
        _deathText.text = "YOU'RE DEAD";
        _deathText.size = 30;
        _deathText.x = _fundo.x + _fundo.width/2 - _deathText.width/2;
        _deathText.y = _fundo.y + _deathText.height;

        _infoText.size = 30;
        _infoText.text = "COINS: 30";
        _infoText.x = _fundo.x + _fundo.width/2 - _infoText.width/2;
        _infoText.y = _fundo.y + _deathText.height + _infoText.height + 15;

        _btnJogar.x = _fundo.x + _fundo.width/2 - (_btnJogar.width + _btnMenuPrincipal.width)/2 ;
        _btnJogar.y = _infoText.y + _infoText.height + 15;

        _btnMenuPrincipal.x = _btnJogar.x + _btnJogar.width + 10;
        _btnMenuPrincipal.y = _btnJogar.y;


        //alive = false;
        add(_fundo);
        add(_deathText);
        add(_infoText);
        add(_btnJogar);
        add(_btnMenuPrincipal);

        forEach(function(sprite: FlxSprite){
            sprite.scrollFactor.set(0, 0);
        });

        exists = false;
    }

    public function newDeath(coin: Int = 0){
        //Adicionar o numero de moedas
        _infoText.text = "COINS: " + coin;
        //Recentralizar texto
       // _infoText.x = _fundo.x + _fundo.width/2 - _infoText.width/2;
        //_infoText.y = _fundo.y + _deathText.height + _infoText.height + 15;

        exists = true;
        
    }

    function menuPrincial(): Void {
        FlxG.switchState(new MenuState());
    }

    function resetGame(): Void {
        FlxG.switchState(new PlayState());
    }
}