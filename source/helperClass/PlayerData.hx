package helperClass;

import player.Weapon;

class PlayerData {
    var weapon: Weapon;
    var ammunition: Int;
    var coin: Int;
    var level: Int;
    var health: Int;
    var flikers: Bool; 

    public function new() {
        health = 3;
        weapon = null;
        ammunition = 0;
        coin = 0;
        level = 0;
    }

    public function updateCoin(amountOfNewCoin: Int){
        coin += amountOfNewCoin;
    }
    public function updateAmmunttion(newAmmunition: Int){
        ammunition += newAmmunition;

        if(ammunition < 0) ammunition = 0; 
    }

    public function hurt(damage: Int){
        health -= damage;
    }

    public function setHealth(health: Int){
        this.health = health;
    }

    public function updateWeapon(weapon: Weapon){
        this.weapon = weapon;
    }

    public function takeCoin() {
        coin += 1;
    }


    public function getHealth(): Float{
        return health;
    }

    public function getWeapon(): Weapon {
        return weapon;
    }

    public function getAmmunition(): Int{
        return ammunition;
    }

    public function getCoin(): Int {
        return coin;
    }

    public function getLevel(): Int {
        return level;
    } 
}