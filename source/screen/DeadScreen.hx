package screen;

import flixel.ui.FlxButton;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSprite;

class DeadScreen extends FlxTypedGroup<FlxSprite>{
    var _infoText: FlxText;
    var _deathText: FlxText;
    var _background: FlxSprite;
    var _btnPlay: FlxButton;
    var _btnMainMenu: FlxButton;
    var _btnSelected: Int = 0;

    public static inline var SELECT_PLAY: Int = 0; 
	public static inline var SELECT_MENU: Int = 1;
	public static inline var NUMBER_OF_BUTTONS: Int = 2;

    public function new():Void{
        super();

        _background = new FlxSprite();
        _deathText = new FlxText();
        _infoText = new FlxText();
        _btnPlay = new FlxButton(0, 0, "PLAY AGAIN", resetGame);
        _btnMainMenu = new FlxButton(0, 0, "I GIVE UP!", mainMenu);

        //quadrado de 200 x 200;
        _background.makeGraphic(300, 200, FlxColor.BLACK);
        _background.x = FlxG.width/2 - _background.width/2;
        _background.y = FlxG.height/2 - _background.height/2;

        //
        _deathText.text = "YOU'RE DEAD";
        _deathText.size = 30;
        _deathText.x = _background.x + _background.width/2 - _deathText.width/2;
        _deathText.y = _background.y + _deathText.height;

        _infoText.size = 30;
        _infoText.text = "COINS: 30";
        _infoText.x = _background.x + _background.width/2 - _infoText.width/2;
        _infoText.y = _background.y + _deathText.height + _infoText.height + 15;

        _btnPlay.x = _background.x + _background.width/2 - (_btnPlay.width + _btnMainMenu.width)/2 -10;
        _btnPlay.y = _infoText.y + _infoText.height + 15;

        _btnMainMenu.x = _btnPlay.x + _btnPlay.width + 20;
        _btnMainMenu.y = _btnPlay.y;

        #if mobile
        _deathText.scale.x = .5;
        _deathText.scale.y = .5;

        _infoText.scale.x = .5;
        _infoText.scale.y = .5;

        _btnPlay.scale.x = .5;
        _btnPlay.scale.y = .5;

        _btnMainMenu.scale.x = .5;
        _btnMainMenu.scale.y = .5;

        _infoText.y = _background.y + _deathText.height + _infoText.height + 3;
        _btnPlay.y = _infoText.y + _infoText.height + 5;
        _btnMainMenu.y = _btnPlay.y;

        #end


        //alive = false;
        add(_background);
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
            #if (desktop|| html5)
                verifyButtonSelected();
                verifyButtonPressed();
            #end
        }
        
        super.update(elapsed);
    }

    #if (desktop|| html5)
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

    #end

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

    public function newDeath(coin: Int = 0):Void{
        _infoText.text = "COINS " + coin;

        exists = true;
        alive = true;   
    }

    function mainMenu(): Void {
        FlxG.switchState(new MenuState());
    }

    function resetGame(): Void {
        FlxG.resetState();
    }
}