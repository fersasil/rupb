package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.FlxCamera;

class MenuState extends FlxState{
    var _mainText:FlxText;
    var _btnPlay: FlxButton;
    var _btnCredits: FlxButton;
    var _btnInstructions: FlxButton;
    var _btnExit: FlxButton;
    var _btnSelected: Int = 0;
    var _cam:FlxCamera;

    public static inline var SELECT_PLAY: Int = 0; 
	public static inline var SELECT_HELP: Int = 1;
	public static inline var SELECT_CRED: Int = 2;
	public static inline var SELECT_EXIT: Int = 3;
	public static inline var NUMBER_OF_BUTTONS: Int = 4;
	
    override public function create():Void{
        _mainText = new FlxText(0, 0, 0, "RUP", 100);
        _btnPlay = new FlxButton(0, 0, "Play", goPlay);
        _btnInstructions = new FlxButton(0, 0, "Instructions", goInstructions);
        _btnCredits = new FlxButton(0, 0, "Credits", goCredits);
        _btnExit = new FlxButton(0, 0, "Exit", goExit);

        _mainText.x = FlxG.width/2 - _mainText.width/2;
        _mainText.y = FlxG.height/3 - _mainText.height/2;
        
        _btnPlay.x = FlxG.width/2 - _btnPlay.width/2;
        _btnPlay.y = _mainText.y + _mainText.height + 10;

        // _btnInstructions.x = _btnPlay.x;
        // _btnInstructions.y = _btnPlay.y + 40;

        // _btnCredits.x = _btnInstructions.x;
        // _btnCredits.y = _btnInstructions.y + 40;

        // _btnExit.x = _btnInstructions.x;
        // _btnExit.y = _btnCredits.y + 40;

        // _btnPlay.scale.x = 1.5;
        // _btnPlay.scale.y = 1.5;

        // _btnExit.scale.x = 1.5;
        // _btnExit.scale.y = 1.5;

        // _btnCredits.scale.x = 1.5;
        // _btnCredits.scale.y = 1.5;
        
        // _btnInstructions.scale.x = 1.5;
        // _btnInstructions.scale.y = 1.5;

        #if mobile
        _btnPlay.scale.x = 3;
        _btnPlay.scale.y = 3;

        // _btnExit.scale.x = 10;
        // _btnExit.scale.y = 10;

        // _btnCredits.scale.x = 10;
        // _btnCredits.scale.y = 10;
        
        // _btnInstructions.scale.x = 10;
        // _btnInstructions.scale.y = 10;
        // _mainText.scale.x = 10;
        // _mainText.scale.y = 10;

        #end

        _btnCredits.kill();
        _btnExit.kill();
        _btnInstructions.kill();


        add(_btnCredits);
        add(_btnPlay);
        add(_btnExit);
        add(_btnInstructions);
        add(_mainText);

        FlxG.fullscreen = true;

        #if ((desktop || html5) || html5)
		    FlxG.mouse.visible = false;
        #end

        setCamera();
        
        super.create();

	}

    override public function update(elapsed:Float):Void{
		super.update(elapsed);
        
        
        #if (desktop|| html5)
            verifyButtonSelected();
            verifyButtonPressed();
        #end
	}

    #if (desktop|| html5)
    function verifyButtonPressed(): Void{
        if(FlxG.keys.justPressed.W)
            _btnSelected = ((_btnSelected - 1) + NUMBER_OF_BUTTONS) % NUMBER_OF_BUTTONS;

        if(FlxG.keys.justPressed.S)
            _btnSelected = ((_btnSelected + 1) + NUMBER_OF_BUTTONS) % NUMBER_OF_BUTTONS;
        
        if(FlxG.keys.justPressed.UP) {
            if(_btnSelected == SELECT_PLAY) goPlay();
            else if(_btnSelected == SELECT_HELP) goInstructions();
            else if(_btnSelected == SELECT_CRED) goCredits();
            else if(_btnSelected == SELECT_EXIT) goExit();
        }
    }
    #end

    function verifyButtonSelected(): Void{
        _btnPlay.scale.x = 1.5;
        _btnPlay.scale.y = 1.5;

        _btnInstructions.scale.x = 1.5;
        _btnInstructions.scale.y = 1.5;

        _btnCredits.scale.x = 1.5;
        _btnCredits.scale.y = 1.5;

        _btnExit.scale.x = 1.5;
        _btnExit.scale.y = 1.5;

        if(_btnSelected == SELECT_PLAY){
            _btnPlay.scale.x = 1.7;
            _btnPlay.scale.y = 1.7;
        }
        else if(_btnSelected == SELECT_HELP){
            _btnInstructions.scale.x = 1.7;
            _btnInstructions.scale.y = 1.7;
        }
        else if(_btnSelected == SELECT_CRED){
            _btnCredits.scale.x = 1.7;
            _btnCredits.scale.y = 1.7;
        }
        else if(_btnSelected == SELECT_EXIT){
            _btnExit.scale.x = 1.7;
            _btnExit.scale.y = 1.7;
        }
    }

    function goCredits(): Void{
        FlxG.switchState(new CreditState());
    }

    function goPlay(): Void{
        FlxG.switchState(new PlayState());
    }
    function goInstructions(): Void{
        FlxG.switchState(new InstructionsState());
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