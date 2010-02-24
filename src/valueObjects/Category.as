package valueObjects
{
	[Bindable]
	public class Category
	{
		public var catID:int;
		public var catName:String;
		
		public function Category(id:int,catName:String){
			this.catID=id;
			this.catName=catName;
		}

		public function toString():String{
			return "[Category] "+ catName;
		}	
	}
}