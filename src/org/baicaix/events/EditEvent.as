package org.baicaix.events {
	import flash.events.Event;
	import flash.geom.Rectangle;

	public class EditEvent extends RangeEvent {
		
		public static const PASTE_START : String = "PASTE_START";
		public static const PASTE_END : String = "PASTE_END";
		
		public function EditEvent(type:String, range : Rectangle=null, bubbles:Boolean=false){
			super(type, range, bubbles);
		}
		
		public override function clone():Event{
			return new RangeEvent(type, _range, bubbles);
		}
	}
}