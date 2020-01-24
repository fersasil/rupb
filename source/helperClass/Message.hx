package helperClass;

class Message{
    public static inline var OP_HURT = 0;
    public static inline  var OP_HEAL = 1;
    public static inline var OP_KILL = 2;
    public static inline var OP_CLIMB = 3;
    public static inline var OP_WINS = 4;
    public static inline var OP_ATTACK = 5;
    public static inline var OP_WEAPON_GET = 6;
    public static inline var OP_RELOAD_WEAPON = 7;
    
    public static inline var STORE_UPDATE_COINS = 8;
    public static inline var STORE_UPDATE_AMMUNITION = 9;
    public static inline var STORE_UPDATE_PLAYER_LIFE = 10;
    public static inline var STORE_UPDATE_PLAYER_WEAPON = 11;

    //public static inline var OP_DANO = 0;

    public var to:Entity;
    public var from:Entity;
    public var op:Int;
    public var data:Float;
    public var dynamicData: Dynamic;

    public function new(?from: Entity, ?to: Entity, ?op: Int, ?data:Float, ?dynamicData: Dynamic = null): Void{
        this.to = to;
        this.from = from;
        this.op = op;
        this.data = data;
        this.dynamicData = dynamicData;
    }

    public function setMessage(?from: Entity, ?to: Entity, ?op: Int, ?data:Float, ?dynamicData: Dynamic = null): Void{
        this.to = to;
        this.from = from;
        this.op = op;
        this.data = data;
        this.dynamicData = dynamicData;
    }
}