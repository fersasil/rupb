package;

import flixel.util.FlxTimer;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Player extends FlxSprite {
    var velocidade:Float = 200;
    //public var _climbing = false;
    var _parent:PlayState;
    public var timer: FlxTimer;
    public var movimentSide = true; //0 esquerda 1 direta

    override public function new(?X:Float = 0, ?Y: Float = 0, Parent:PlayState){
        super(X, Y);

        timer = new FlxTimer();

        health = 3;
        
        //makeGraphic(16, 16, FlxColor.BLUE);
        loadGraphic(AssetPaths.gnome__png, true, 20, 24);
        
        //Faz com que não se precise de uma imagem diferente para a 
        //esquerda e para a direita
        setFacingFlip(FlxObject.RIGHT, false, false);
        setFacingFlip(FlxObject.LEFT, true, false);

        //Cria as animações
        animation.add("WALK", [1, 2, 3, 4], 10, false);
        animation.add("JUMP", [5, 6], 6, false);
        animation.add("JUMP-FALL", [7, 8], 6, false);
        
        animation.add("SLASH", [12, 11, 12, 13], 10, false);
        animation.add("CLIMB", [19, 20, 21, 22], 6, false);
        
        
        
        drag.x = drag.y = 1600;
        acceleration.y = 1000; //Cria Gravidade
        //Criar animações
        this.maxVelocity.set(120, 200);
        setGraphicSize(16, 22);
        //updateHitbox(16, 16);
        //setGraphicSize(16, 16);
        //scale.set(0.5, 0.5);
        updateHitbox();

    }

    override public function update(elapsed:Float):Void{
        movement();
        super.update(elapsed);
    }

   

    function movement():Void {
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
        

        if(_cima && this.isTouching(FlxObject.FLOOR)){
            velocity.y = - velocidade;
            facing = FlxObject.UP;
        }
        if(_baixo){
            //velocity.y = velocidade;
           // velocity.y = 0;
            //O personagem devera abaixar?
            facing = FlxObject.DOWN;
        }
        if(_direita){
            velocity.x = velocidade - 30;
            movimentSide = true;
            facing = FlxObject.RIGHT;
        }
        if(_esquerda){
            velocity.x = -velocidade + 30;
            movimentSide = false;
            facing = FlxObject.LEFT;
        }
        //Só devera haver animação enquanto as teclas serem pressionadas
        if ((velocity.x != 0 || velocity.y != 0) && !isTouching(facing)){
            switch (facing){
            case FlxObject.LEFT, FlxObject.RIGHT:
                animation.play("WALK");
            case FlxObject.UP:
                animation.play("JUMP");
            case FlxObject.DOWN:
                //animation.play("d");
            }
        }
    }

}