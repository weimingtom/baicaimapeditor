package events 
{
	import flash.events.Event;
	
	import valueObjects.Product;

	public class ProductEvent extends Event 
	{
		public var product:Product;
		
		public function ProductEvent(prod:Product, type:String, bubbles:Boolean=false){
			super(type, bubbles);
			product = prod;
		}
		
		public override function clone():Event{
			return new ProductEvent(product, type, bubbles);
		}
	}
}