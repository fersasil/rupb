package;

import flixel.FlxSprite;

class BoardNext extends FlxSprite{
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
}