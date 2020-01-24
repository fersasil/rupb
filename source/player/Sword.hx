package player;

import helperClass.Message;
import helperClass.Entity;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.system.FlxSound;

class Sword extends Weapon{
    var _sndSword:FlxSound; 
	public static inline var SWORD_WIDTH = 3;


    public function new(?X: Float, ?Y: Float): Void {
        // super();
        
        super(X, Y);
        loadGraphic(AssetPaths.sword__png, false, 13, 12);
        scale.x = .6;
        scale.y = .6;
        angle = -45;
        updateHitbox();

        // kill();
    }
    public function attackFront(location:FlxPoint, side:Bool, playerWidth: Float, playerHeight: Float): Void {
        var x: Float;
        var y = location.y + playerHeight - height - 1;

        if(side == false) { //left
            x = location.x - width;
        }
        else { // right
            x = location.x  + playerWidth;
        }


        reset(x, y); //Jogador 8 mais alto que 16...
		solid = true;
    }

    //Da entidade
    override public function onMessage(m: Message): Void{
        switch m.op{
            case Message.OP_ATTACK: {
                m.from.animation.play("SLASH");
                _sndSword.play();

                // var side = m.from.movimentSide ? (m.from.width) : -2; //O lado em que a espada aparece

                // trace(alive);
                attackFront(m.from.last, m.from.movimentSide, m.from.width, m.from.height);
            }
            case Message.OP_KILL: {
                kill();
            }
            case Message.OP_WEAPON_GET: {
                // Retransformar a espada em "espada"
                makeGraphic(SWORD_WIDTH, 6, FlxColor.TRANSPARENT);
                _sndSword = FlxG.sound.load(AssetPaths.slash__wav, 0.2);
                angle = 0;

                updateHitbox();
                kill();
            }
        }
    }

    function transformOnPlayerSword(){

    }
}