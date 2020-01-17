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
    var df: Float = 20;
    var df2: Float = 323;
    public var parent: Dynamic;
    var count = 0.0;
    var cam: FlxCamera;

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

        // // _life.y = _fundo.y + 2;
        // _life.x = 650;

        // FlxG.log.add(_life.cameras);

        // _life.scale.x = 4;
        // _life.scale.y = 4;

        // FlxG.log.add(_life);


        add(_fundo);
        add(_life);
        add(_coin);
        add(_textCoin);
  
        // this._life.y = this._fundo.y + 20;
        // FlxG.log.add(this._life.y);
        // FlxG.log.add(y);

        // this._coin.y = this._fundo.y + 4;
        // this._coin.x = 80;
        // this._life.x = 50;
        // this._coin.scale.x = 5;
        // this._coin.scale.y = 5;


        // FlxG.log.add(FlxG.camera.visible);

        // _fundo.drag.x = _fundo.drag.y = 1600;
		// _fundo.acceleration.y = 1000; // Cria Gravidade

        // this._textCoin.y = this._coin.y - 2;
        //Impedir que o scroll de tela ocorra
        //mesmo que o jogador se mova a tela não ira se mexer também

        //Poderia se adicionar um a um, mas esse é um jeito mais limpo e mais facil leitura
        forEach(function(sprite: FlxSprite){
            sprite.scrollFactor.set(0, 0);
        });

    }

    override public function update(elapsed:Float):Void{
        count += elapsed;

        FlxG.watch.add(_life, "x", "lx");

        // _life.x += count/10;

        // _fundo.y -= count/10;
        
        // _fundo.y = FlxG.height - cam.maxScrollY + cam.scroll.y;

        // FlxG.log.add(FlxG.height);

        super.update(elapsed);

    }
    public function changePosition(cam: FlxCamera): Void{
        // FlxG.watch.add(cam, "x", "x");
        // FlxG.watch.add(cam, "y", "y");
        // FlxG.watch.add(cam, "width", "width");
        // FlxG.watch.add(cam, "height", "height");
        FlxG.watch.add(cam, "maxScrollX", "maxScrollX");
        // FlxG.watch.add(cam, "minScrollY", "minScrollY");
        // FlxG.watch.add(cam, "scaleY", "scaleY");
        // FlxG.watch.add(cam, "totalScaleY", "totalScaleY:");
        FlxG.watch.add(cam.scroll, "x", "scroll");
        FlxG.watch.add(FlxG, "width", "width");
        


        // _fundo.y = 0 - cam.scroll.y;
        // _fundo.y = 330;
        this.cam = cam;

        _fundo.kill();
        
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

    public function getHeigth(){
        return this._fundo.height;
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