package com.worms.gameInfo {
    import flash.display.Sprite;
    import flash.text.TextField;
    
    public class GameInfo extends Sprite{
        public function GameInfo() {
            super();
            
            this.mouseEnabled = false;
            this.mouseChildren = false;
        }
        
        public function set fps(value:String):void {
            TextField(this["infoFPS"]).text = value;
        }
        
        public function set gunAngle(value:String):void {
            TextField(this["infoGunAngle"]).text = value;
        }
        
        public function set missileCount(value:String):void {
            TextField(this["infoMissileCount"]).text = value;
        }
        
        public function set missileTailCount(value:String):void {
            TextField(this["infoMissileTailCount"]).text = value;
        }
        
        public function set explosionCount(value:String):void {
            TextField(this["infoExplosionCount"]).text = value;
        }
    }
}