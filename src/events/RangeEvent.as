package events {
	import flash.events.Event;
	import flash.geom.Rectangle;

	public class RangeEvent extends Event {
		
		public static const CLEAR_RANGE : String = "CLEAR_RANGE";
		
		public static const FOCUS_RANGE : String = "FOCUS_RANGE";
		
		public static const RANGE_POS_CHANGE : String = "RANGE_POS_CHANGE";
		
		private var _range : Rectangle;
		
		public function RangeEvent(range : Rectangle, type:String, bubbles:Boolean=false){
			super(type, bubbles);
			_range = range;
		}
		
		public override function clone():Event{
			return new RangeEvent(_range, type, bubbles);
		}
		
		public function get range() : Rectangle {
			return _range;
		}
	}
}