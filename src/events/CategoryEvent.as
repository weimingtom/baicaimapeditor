package events
{
	import flash.events.Event;
	
	import valueObjects.Category;

	public class CategoryEvent extends Event
	{
		public var cat:Category;

		public function CategoryEvent(cat:Category, type:String){
			super(type);
			this.cat = cat;
		}

		public override function clone():Event{
			return new CategoryEvent(cat, type);
		}
	}
}