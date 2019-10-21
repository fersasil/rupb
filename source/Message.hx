package;

class Message{
    public static inline var OP_HURT = 0;
    public static inline  var OP_HEAL = 1;
    public static inline var OP_KILL = 2;
    public static inline var OP_CLIMB = 3;
    public static inline var OP_WINS = 4;
    public static inline var OP_ATTACK = 5;
    //public static inline var OP_DANO = 0;

    public var to:Entity;
    public var from:Entity;
    public var op:Int;
    public var data:Float;

    public function new(?from: Entity, ?to: Entity, ?op: Int, ?data:Float): Void{
        this.to = to;
        this.from = from;
        this.op = op;
        this.data = data;
    }
}