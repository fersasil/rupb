package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Player extends FlxSprite {
    var velocidade:Float = 100;

    override public function new(?X:Float = 0, ?Y: Float = 0){
        super(X, Y);
        
        makeGraphic(16, 16, FlxColor.BLUE);
        drag.x = drag.y = 1600;

        //Criar animações

    }

    override public function update(elapsed:Float):Void{
        movement();
        super.update(elapsed);
    }

    function movement(){
        var _cima:Bool = false;
        var _baixo:Bool = false;
        var _esquerda:Bool = false;
        var _direita:Bool = false;

        //Caso uma das teclas apertadas a variavel
        //Sera setada como true

        _cima = FlxG.keys.anyPressed([UP, W]);
        _baixo = FlxG.keys.anyPressed([DOWN, S]);
        _esquerda = FlxG.keys.anyPressed([LEFT, A]);
        _direita = FlxG.keys.anyPressed([RIGHT, D]);

        //Anular movimentos contrarios

        if(_cima && _baixo ){
            _cima =_baixo = false;
        }
        if(_esquerda && _direita){
            _esquerda = _direita = false;
        }

        if(_cima){
            velocity.y = -velocidade;
            //facing = FlxObject.UP;
        }
        if(_baixo){
            //velocity.y = velocidade;
            velocity.y = 0;
            //O personagem devera abaixar?
            //facing = FlxObject.DOWN;
        }
        if(_direita){
            velocity.x = velocidade;
            //facing = FlxObject.RIGHT;
        }
        if(_esquerda){
            velocity.x = -velocidade;
            //facing = FlxObject.LEFT;
        }

        //Só devera haver animação enquanto as teclas serem pressionadas
    /*
        if ((velocity.x != 0 || velocity.y != 0) && !isTouching(facing)){
            switch (facing){
            case FlxObject.LEFT, FlxObject.RIGHT:
                animation.play("lr");
            case FlxObject.UP:
                animation.play("u");
            case FlxObject.DOWN:
                animation.play("d");
            }
        }
     */
    }

}