package;

import flixel.effects.FlxFlicker;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxSprite;

class Player extends Entity{
    var flikers: Bool = true;
    var climbing: Bool = false;
    public var timer: FlxTimer;
    public static inline var VELOCITY_X = 120;
    public static inline var VELOCITY_Y = 200;

    override public function new(?X:Float = 0, ?Y: Float = 0, Parent:PlayState){
        super(X, Y);

        health = 3;
        movimentSide = true; //0 esquerda 1 direta

        loadGraphic(AssetPaths.gnome__png, true, 20, 24);
        
        //Faz com que não se precise de uma imagem diferente para a 
        //esquerda e para a direita
        setFacingFlip(FlxObject.RIGHT, false, false);
        setFacingFlip(FlxObject.LEFT, true, false);

        //Criar animações
        animation.add("WALK", [1, 2, 3, 4], 10, false);
        animation.add("JUMP", [5, 6], 6, false);
        animation.add("JUMP-FALL", [7, 8], 6, false);
        animation.add("SLASH", [12, 11, 12, 13], 10, false);
        animation.add("CLIMB", [19, 20, 21, 22], 6, true);
        
        timer = new FlxTimer();
        
        //FISICA DO PERSONAGEM
        drag.x = drag.y = 1600;
        acceleration.y = 1000; //Cria Gravidade
        this.maxVelocity.set(120, 200);
        
        //TEMPORARIO, REDIMENSIONA IMAGEM DO JOGADOR
        setGraphicSize(16, 22);
        updateHitbox();

    }

    override public function update(elapsed:Float):Void{
        movement();
        super.update(elapsed);
    }

    /**
	Apenas um hurt faria com que o jogador morresse instaneamente
	O timer faz com que o jogador leve dano apenas após 0.3 segundos
	O hud é atualizado, porem. Caso a vida chegue a 0, o timer não é
	acionado.
	 */
    override public function onMessage(m: Message){
        if(m.op == Message.OP_HURT){
            if(flikers){
                FlxFlicker.flicker(this);
                flikers = false;
            }

            if(health - 1 == 0){
                FlxG.camera.flash();
                hurt(1);
            }
            else{
                FlxG.camera.shake(1);
                timer.start(0.3, function(Timer:FlxTimer){
                    hurt(m.data);
                    flikers = true;
                });
            }
        }
        else if(m.op == Message.OP_CLIMB){
            velocity.y = - 120;
            climbing = true;
        }
        else if(m.op == Message.OP_KILL){
            FlxG.camera.flash();
            kill();
        }
        else if(m.op == Message.OP_HEAL){

        }
    }


    function movement():Void {
        //suporte a varias teclas
        var _cima:Bool = FlxG.keys.anyPressed([UP, W]) ? true : false;
        var _baixo:Bool = FlxG.keys.anyPressed([DOWN, S]) ? true : false;
        var _esquerda:Bool = FlxG.keys.anyPressed([LEFT, A]) ? true : false;
        var _direita:Bool = FlxG.keys.anyPressed([RIGHT, D]) ? true : false;

        //Anular movimentos contrarios
        if(_cima && _baixo ) _cima =_baixo = false;
        if(_esquerda && _direita) _esquerda = _direita = false;
        
        //MOVIMENTO
        if(_cima && this.isTouching(FlxObject.DOWN)){ //Só pula quando estiver encostando no chão
       // if(_cima && velocity.y == 0){
            velocity.y = - VELOCITY_Y;
            facing = FlxObject.UP;
        }
        if(_baixo){
            //O personagem devera abaixar?
            facing = FlxObject.DOWN;
        }
        if(_direita){
            velocity.x = VELOCITY_X;
            movimentSide = true;
            facing = FlxObject.RIGHT;
        }
        if(_esquerda){
            velocity.x = -VELOCITY_X;
            movimentSide = false;
            facing = FlxObject.LEFT;
        }

        if(climbing){
            animation.play("CLIMB");
            climbing = false; //Isso evita que a animação de escalando continue mesmo depois que sair da escada
        }
        else{
        //Só devera haver animação enquanto as teclas serem pressionadas
            if((velocity.x != 0 || velocity.y != 0) && !isTouching(facing)){
                switch (facing){
                case FlxObject.LEFT, FlxObject.RIGHT:
                    animation.play("WALK");
                case FlxObject.UP:
                    animation.play("JUMP");
                case FlxObject.DOWN:
                }
            }
        }
    }

}