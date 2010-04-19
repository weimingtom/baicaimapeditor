package com.worms.manager {
    import com.worms.battleField.BattleField;
    import com.worms.events.MatterPondPondEvent;
    import com.worms.explosion.Explosion;
    import com.worms.missile.Missile;
    import com.worms.missleTail.MissileTail;
    
    import flash.events.EventDispatcher;
    
    public class MatterPondManager extends EventDispatcher {
        private static var instance:MatterPondManager;
        
        public static function getInstance():MatterPondManager {
            if(!instance) {
                instance = new MatterPondManager();
            }
            return instance;
        }
        
        private var missilesCaches:Array;
        public function getMissile():Missile {
            if(!missilesCaches) {
                missilesCaches = [];
            }
            
            var m:Missile;
            if(missilesCaches.length) {
                m = missilesCaches.pop() as Missile;
                
                var missilePondEvent:MatterPondPondEvent = new MatterPondPondEvent(MatterPondPondEvent.MISSILE_POND_COUNT_CHANGED);
                missilePondEvent.count = missilesCaches.length;
                
                dispatchEvent(missilePondEvent);
            }
            else {
                m = new Missile();
            }
            
            if(!BattleField.getInstance().contains(m)) {
                BattleField.getInstance().addChild(m);
            }
            
            return m;
        }
        
        public function recycleMissile(m:Missile):void {
            if(!missilesCaches) {
                missilesCaches = [];
            }
            
            if(BattleField.getInstance().contains(m)) {
                BattleField.getInstance().removeChild(m);
            }
            
            missilesCaches.push(m);
            
            var missilePondEvent:MatterPondPondEvent = new MatterPondPondEvent(MatterPondPondEvent.MISSILE_POND_COUNT_CHANGED);
            missilePondEvent.count = missilesCaches.length;
                
            dispatchEvent(missilePondEvent);
        }
        
        private var missileTailsCaches:Array;
        public function getMissileTail():MissileTail {
            if(!missileTailsCaches) {
                missileTailsCaches = [];
            }
            
            var mt:MissileTail;
            if(missileTailsCaches.length) {
                mt = missileTailsCaches.pop() as MissileTail;
                
                var matterPondPondEvent:MatterPondPondEvent = new MatterPondPondEvent(MatterPondPondEvent.MISSILE_TAIL_POND_COUNT_CHANGED);
                matterPondPondEvent.count = missileTailsCaches.length;
                
                dispatchEvent(matterPondPondEvent);
            }
            else {
                mt = new MissileTail();
            }
            
            if(!BattleField.getInstance().contains(mt)) {
                BattleField.getInstance().addChild(mt);
            }
            
            return mt;
        }
        
        public function recycleMissileTail(mt:MissileTail):void {
            if(!missileTailsCaches) {
                missileTailsCaches = [];
            }
            
            if(BattleField.getInstance().contains(mt)) {
                BattleField.getInstance().removeChild(mt);
            }
            
            missileTailsCaches.push(mt);
            
            var matterPondPondEvent:MatterPondPondEvent = new MatterPondPondEvent(MatterPondPondEvent.MISSILE_TAIL_POND_COUNT_CHANGED);
            matterPondPondEvent.count = missileTailsCaches.length;
            
            dispatchEvent(matterPondPondEvent);
        }
        
        private var explosionCaches:Array;
        public function getExposion():Explosion {
            if(!explosionCaches) {
                explosionCaches = [];
            }
            
            var ex:Explosion;
            if(explosionCaches.length) {
                ex = explosionCaches.pop() as Explosion;
                
                var matterPondPondEvent:MatterPondPondEvent = new MatterPondPondEvent(MatterPondPondEvent.EXPLOSION_POND_COUNT_CHANGED);
                matterPondPondEvent.count = explosionCaches.length;
                
                dispatchEvent(matterPondPondEvent);
            }
            else {
                ex = new Explosion();
            }
            
            if(!BattleField.getInstance().contains(ex)) {
                BattleField.getInstance().addChild(ex);
            }
            
            return ex;
        }
        
        public function recycleExposion(ex:Explosion):void {
            if(!explosionCaches) {
                explosionCaches = [];
            }
            
            if(BattleField.getInstance().contains(ex)) {
                BattleField.getInstance().removeChild(ex);
            }
            
            explosionCaches.push(ex);
            
            var matterPondPondEvent:MatterPondPondEvent = new MatterPondPondEvent(MatterPondPondEvent.EXPLOSION_POND_COUNT_CHANGED);
            matterPondPondEvent.count = explosionCaches.length;
            
            dispatchEvent(matterPondPondEvent);
        }
    }
}