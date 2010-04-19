package com.worms.events {
    import flash.events.Event;
    
    public class MatterPondPondEvent extends Event {
        public static const MISSILE_POND_COUNT_CHANGED:String = "missilePondCountChanged";
        public static const MISSILE_TAIL_POND_COUNT_CHANGED:String = "missileTailPondCountChanged";
        public static const EXPLOSION_POND_COUNT_CHANGED:String = "explosionPondCountChanged";
        public var count:int;
        public function MatterPondPondEvent(type:String) {
            super(type,false,false);
        }
    }
}