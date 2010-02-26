package events {
	import flash.events.Event;
	import flash.geom.Rectangle;

	public class RangeEvent extends Event {
		
		public static const CLEAR_RANGE : String = "CLEAR_RANGE";
		
		public static const FOCUS_RANGE : String = "FOCUS_RANGE";
		
		public static const RANGE_POS_CHANGE : String = "RANGE_POS_CHANGE";
		
		protected var _range : Rectangle;
		
		public function RangeEvent(type:String, range : Rectangle=null, bubbles:Boolean=false){
			super(type, bubbles);
			_range = range;
		}
		
		public override function clone():Event{
			return new RangeEvent(type, _range, bubbles);
		}
		
		public function get range() : Rectangle {
			return _range;
		}
	}
}