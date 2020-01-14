import flixel.math.FlxPoint;

class ClickHandler {
    public var click: Bool;
    public var inUse: Bool;
    
    public var count: Int = 0;
    var _screenFirstPress: Bool;
    var _screenPressedPosition: FlxPoint;

    var _owner: Int;

    public var mutex: Bool = true;

	public function new():Void {
        _screenFirstPress = true;
        _screenPressedPosition = null;
        count = 0;
        click = false;
    }

    public function getMutex(owner) {
        if(mutex){
            mutex = !mutex;
            _owner = owner;
            return true;
        }
        else if(owner == _owner) return true;
        else //mutex não disponivel
            return false;
        
    }

    public function inUseMutex(){
        return mutex ? false : true;
    }

    public function cleanCount() {
        count = 0;
    }

    public function freeMutex() {
        mutex = !mutex;
    }

    public function newClick() {
        click = true;
    }

    public function freeClick() {
        click = false;
    }

    public function tryMove(pressed, justPressed, justReleased) {
        
    }

    public function isFirstPress() {
        if(_screenFirstPress) return true;
        else return false;
    }

    public function resetFirstPresss() {
        _screenFirstPress = true;
    }

    public function resetScreenPressedPosition(){
        _screenPressedPosition = null;
    }

    public function setFirstPressedPosition(pressedPoint: FlxPoint) {
        _screenPressedPosition = pressedPoint;
    }

    public function getFirstPressedPosition() {
        return _screenPressedPosition;
    }

    public function getFirstPress(){
        if(_screenFirstPress){
            _screenFirstPress = !_screenFirstPress;
            return true;
        }
        else return false;
        
    }

}