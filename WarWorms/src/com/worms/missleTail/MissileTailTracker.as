package com.worms.missleTail {
    import com.worms.manager.MatterPondManager;
    import com.worms.missile.Missile;
    
    import flash.events.Event;
    
    public class MissileTailTracker {
        private var _target:Missile;
        
        public function set target(value:Missile):void {
            _target = value;
        }
        
        public function get target():Missile {
            return _target;
        }
        
        public function MissileTailTracker() {
        }
        
        public function startTrack():void {
            if(_target) {
                _target.addEventListener(Event.ENTER_FRAME,enterframehandler);
            }
        }
        
        public function endTracker():void {
            if(_target) {
                _target.removeEventListener(Event.ENTER_FRAME,enterframehandler);
            }
        }
        
        private function enterframehandler(e:Event):void {
            generateMisstail();
        }
        
        private function generateMisstail():void {
            if(_target) {
                var mt:MissileTail = MatterPondManager.getInstance().getMissileTail();
                mt.startEffect(_target.x,_target.y);
            }
        }
    }
}