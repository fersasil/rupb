package;

import flixel.FlxSprite;

class BoardNext extends Entity{
    var _nextLevel: NextLevel;
    public function new(X: Float = 0, Y: Float = 0){
        super(X, Y);
        loadGraphic(AssetPaths.nextlevel__png, false, 13, 12);
        _nextLevel = new NextLevel();
        immovable = true;
    }

    public function message(coins: Float) {
        _nextLevel.wins(coins);
    }
    //Da entidade
    override public function onMessage(m: Message){
        if(m.op == Message.OP_WINS){
            m.from.exists = false;
            //EFEITOS, ETC.
            //MATAR JOGADOR PROVISORIAMENTE
        }
    }
}