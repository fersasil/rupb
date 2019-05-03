package;

class Box extends Entity {
    public function new(X:Float = 0, Y:Float = 0): Void{
        super(X + 2, Y + 2);
        loadGraphic(AssetPaths.box12x12__png, false, 12, 12);
        this.immovable = true;
        health = 1;
    }
    //Da entidade
    override public function onMessage(m: Message):Void{
        if(m.op == Message.OP_KILL){
            kill();
            m.from.kill(); //Faz a espada desaparecer!
        }    
    }
}