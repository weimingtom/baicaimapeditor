package com.worms.events {
    import flash.events.Event;
    
    public class BattleFieldEvent extends Event {
        public static const GUN_ROTATE:String = "gunRotate";
        
        public var gunAngle:Number=0;
        public function BattleFieldEvent(type:String) {
            super(type,false,false);
        }
    }
}