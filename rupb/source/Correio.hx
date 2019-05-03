package;

import flixel.FlxObject;

class Correio extends FlxObject{
    var _heap: Array<Message> = [];

    override public function update(elapsed: Float): Void{
        //Executar tudo que tem no correio!
        for(message in _heap){
            message.to.onMessage(message);
            //Colocar um log de exemplo
        }

        //Limpar a fila
        _heap = [];

        super.update(elapsed);
        
    }

    public function send(message: Message):Void {
        _heap.push(message);
    }
}