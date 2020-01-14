class ClickHandler {
    public var click: Bool;
    public var inUse: Bool;
    public var justReleased: Bool;
    public var count: Int = 0;

    var _owner: Int;

    public var mutex: Bool = true;

	public function new(?X:Float = 0, ?Y:Float = 0):Void {

    }

    public function getMutex(owner) {
        if(mutex){
            mutex = !mutex;
            _owner = owner;
            return true;
        }
        else if(owner == _owner) return true;
        else{ //mutex não disponivel
            return false;
        }
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

    public function setUse(use) {
        inUse = use;
    }

    public function setJustReleased(use){
        justReleased = use;
    }

    public function tryMove(pressed, justPressed, justReleased) {
        
    }

}