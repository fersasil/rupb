package;

import flixel.ui.FlxButton;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSprite;

class NextLevel extends FlxTypedGroup<FlxSprite>{
    var _infoText: FlxText;
    var _deathText: FlxText;
    var _fundo: FlxSprite;
    var _btnPlay: FlxButton;
    var _btnMainMenu: FlxButton;
    var _btnSelected: Int = 0;

    public static inline var SELECT_PLAY: Int = 0; 
	public static inline var SELECT_MENU: Int = 1;
	public static inline var NUMBER_OF_BUTTONS: Int = 2;

    public function new():Void{
        super();

        _fundo = new FlxSprite();
        _deathText = new FlxText();
        _infoText = new FlxText();
        _btnPlay = new FlxButton(0, 0, "PLAY AGAIN", resetGame);
        _btnMainMenu = new FlxButton(0, 0, "MAIN MENU", mainMenu);

        //quadrado de 200 x 200;
        _fundo.makeGraphic(300, 200, FlxColor.BLACK);
        _fundo.x = FlxG.width/2 - _fundo.width/2;
        _fundo.y = FlxG.height/2 - _fundo.height/2;

        //
        _deathText.text = "YOU WON";
        _deathText.size = 30;
        _deathText.x = _fundo.x + _fundo.width/2 - _deathText.width/2;
        _deathText.y = _fundo.y + _deathText.height;

        _infoText.size = 30;
        _infoText.text = "COINS: 30";
        _infoText.x = _fundo.x + _fundo.width/2 - _infoText.width/2;
        _infoText.y = _fundo.y + _deathText.height + _infoText.height + 15;

        _btnPlay.x = _fundo.x + _fundo.width/2 - (_btnPlay.width + _btnMainMenu.width)/2 ;
        _btnPlay.y = _infoText.y + _infoText.height + 15;

        _btnMainMenu.x = _btnPlay.x + _btnPlay.width + 10;
        _btnMainMenu.y = _btnPlay.y;


        //alive = false;
        add(_fundo);
        add(_deathText);
        add(_infoText);
        add(_btnPlay);
        add(_btnMainMenu);

        forEach(function(sprite: FlxSprite){
            sprite.scrollFactor.set(0, 0);
        });

        exists = false;
        alive = false;
    }

    override public function update(elapsed:Float):Void{
        if(this.exists && this.alive){
            verifyButtonSelected();
            verifyButtonPressed();
        }
        
        super.update(elapsed);
    }

    public function wins(coin: Float = 0): Void{
        //Adicionar o numero de moedas
        _infoText.text = "COINS: " + coin;

        exists = true;
        alive = true;   
    }

    function verifyButtonPressed(): Void{
        if(FlxG.keys.justPressed.A)
            _btnSelected = ((_btnSelected - 1) + NUMBER_OF_BUTTONS) % NUMBER_OF_BUTTONS;

        if(FlxG.keys.justPressed.D)
            _btnSelected = ((_btnSelected + 1) + NUMBER_OF_BUTTONS) % NUMBER_OF_BUTTONS;
        
        if(FlxG.keys.justPressed.UP) {
            if(_btnSelected == SELECT_PLAY) resetGame();
            else if(_btnSelected == SELECT_MENU) mainMenu();
        }
    }

    function verifyButtonSelected(): Void{
        _btnPlay.scale.x = 1;
        _btnPlay.scale.y = 1;

        _btnMainMenu.scale.x = 1;
        _btnMainMenu.scale.y = 1;

        if(_btnSelected == SELECT_PLAY){
            _btnPlay.scale.x = 1.3;
            _btnPlay.scale.y = 1.3;
        }
        else if(_btnSelected == SELECT_MENU){
            _btnMainMenu.scale.x = 1.3;
            _btnMainMenu.scale.y = 1.3;
        }
    }

    function mainMenu(): Void {
        FlxG.switchState(new MenuState());
    }

    function resetGame(): Void {
        FlxG.switchState(new PlayState());
    }
}