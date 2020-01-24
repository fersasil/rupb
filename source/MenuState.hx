package;

import screen.CreditState;
import screen.InstructionsState;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.FlxCamera;
import helperClass.Store;
import levels.Level_1;

class MenuState extends FlxState{
    var _mainText:FlxText;
    var _btnPlay: FlxButton;
    var _btnCredits: FlxButton;
    var _btnInstructions: FlxButton;
    var _btnExit: FlxButton;
    var _btnSelected: Int = 0;
    var _cam:FlxCamera;
    var store: Store;

    public static inline var SELECT_PLAY: Int = 0; 
	public static inline var SELECT_HELP: Int = 1;
	public static inline var SELECT_CRED: Int = 2;
	public static inline var SELECT_EXIT: Int = 3;
	public static inline var NUMBER_OF_BUTTONS: Int = 4;
	
    override public function create():Void{
        _mainText = new FlxText(0, 0, 0, "RUP", 100);
        _btnPlay = new FlxButton(0, 0, "Play", goPlay);
        // _btnInstructions = new FlxButton(0, 0, "Instructions", goInstructions);
        // _btnCredits = new FlxButton(0, 0, "Credits", goCredits);
        // _btnExit = new FlxButton(0, 0, "Exit", goExit);

        _mainText.x = FlxG.width/2 - _mainText.width/2;
        _mainText.y = FlxG.height/3 - _mainText.height/2;
        
        




        store = new Store();

        
        _btnPlay.scale.x = 7;
        _btnPlay.scale.y = 7;
        
        _btnPlay.label.scale.x = 7;
        _btnPlay.label.scale.y = 7;

        _btnPlay.updateHitbox();
        _btnPlay.label.updateHitbox();

        _btnPlay.x = FlxG.width/2 - _btnPlay.width/2;
        _btnPlay.y = _mainText.y + _mainText.height + 10;


        // trace(store);


        add(_btnPlay);

        add(_mainText);

        #if ((desktop || html5) || html5)
		    FlxG.mouse.visible = true;
        #end

        setCamera();
        
        super.create();

	}

    override public function update(elapsed:Float):Void{
		super.update(elapsed);
	}

    function goPlay(): Void{
        FlxG.switchState(new Level_1(store));
    }

    function goExit(): Void{
        // Sys.exit(0);
    }

    function setCamera(){
		_cam = new FlxCamera(0, 0, FlxG.width, FlxG.height, 1);
 
		FlxG.cameras.reset(_cam);

        FlxG.fullscreen = true;
        
        #if (desktop || html5)
            FlxG.mouse.visible = true;
        #end
	}

}