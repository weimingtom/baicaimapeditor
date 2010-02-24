package events {
	import flash.events.Event;
	public class ObjectDataEvent extends Event{
		public var data:Object;
		public function ObjectDataEvent(type:String,data:Object){
			super(type);
			this.data = data;
		}
		override public function clone():Event {
			return new ObjectDataEvent(type, data);
		}
	}
}
