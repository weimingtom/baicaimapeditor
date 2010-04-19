package com.worms.missile {
    import com.worms.battleField.BattleField;
    import com.worms.explosion.Explosion;
    import com.worms.manager.MatterPondManager;
    import com.worms.manager.WormsBattleFieldSoundControllManager;
    import com.worms.map.BattleMap;
    import com.worms.missleTail.MissileTailTracker;
    import com.worms.utility.WormsBatleUtility;
    
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Point;
    
    public class Missile extends Sprite {
        public static const MISSILE_SPEED:uint = 6;
        public static const MISSILE_POSWER:uint = 18;
        
        private var _speed:Number = MISSILE_SPEED;
        private var _missiletailTracker:MissileTailTracker; 
        
        public function Missile() {
            super();
        }
        
        public function fire(angle:Number,startX:Number,startY:Number):void {
            this.rotation = angle;
            
            this.x = startX;
            this.y = startY;
            
            startTrackMissileTail();
            playFireSound();
            
            this.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
        }
        
        private function startTrackMissileTail():void {
            if(!_missiletailTracker) {
                _missiletailTracker = new MissileTailTracker();
                _missiletailTracker.target = this;
                
                _missiletailTracker.startTrack();
            }
        }
        
        private function endTrackMissileTail():void {
            if(_missiletailTracker) {
                _missiletailTracker.endTracker();
                _missiletailTracker.target = null;
                _missiletailTracker = null;
            }
        }
        
        private function playFireSound():void {
            WormsBattleFieldSoundControllManager.getInstance().playMissileFireSound();
        }
        
        private function enterFrameHandler(e:Event):void {
            hitTest();
            moveMissile();
        }
        
        private function hitTest():void {
            var bitmapData:BitmapData = BattleMap.getCurrentBitmapData();
            var p:Point = new Point(0,0);
            p = this.localToGlobal(p);
            
            if(bitmapData.hitTest(BattleMap.getHitFirstPoint(),0xFF,p)) {
                recycleMissile();
                
                var ex:Explosion = MatterPondManager.getInstance().getExposion();
                ex.startEffect(this.x,this.y,MISSILE_POSWER,p);
            }
        }
        
        private function moveMissile():void {
            var radians:Number = WormsBatleUtility.convertAngleToRadians(rotation);
            var vx:Number = Math.cos(radians)*_speed;
            var vy:Number = Math.sin(radians)*_speed;
            
            this.x += vx;
            this.y += vy;
            
            if(checkIsOutOfBattleFieldBound()) {//已经超出边界，需要被回收
                recycleMissile();
            }
        }
        
        private function recycleMissile():void {
            this.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
            endTrackMissileTail();
            MatterPondManager.getInstance().recycleMissile(this);
        }
        
        private function checkIsOutOfBattleFieldBound():Boolean {
            var battleField:BattleField = BattleField.getInstance();
            if(x < 0 || x > battleField.getBattleFieldWidth() || y < 0 || y > battleField.getBattleFieldHeight()) {
                return true;
            }
            else {
                return false;
            }
        }
    }
}