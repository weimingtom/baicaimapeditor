package valueObjects
{
	[Bindable]
	public class Product
	{
		public var catID:Number;
		public var prodName:String;
		public var unitID:Number;
		public var cost:Number;
		public var listPrice:Number;
		public var description:String;
		public var isOrganic:Boolean;
		public var isLowFat:Boolean;
		public var imageName:String;
	
		public function Product (_catID:Number, _prodName:String, _unitID:Number, _cost:Number, _listPrice:Number, _description:String,_isOrganic:Boolean,	_isLowFat:Boolean, _imageName:String)
		{
			catID = _catID;
			prodName = _prodName;
			unitID = _unitID;
			cost = _cost;
			listPrice = _listPrice;
			description = _description;
			isOrganic = _isOrganic;
			isLowFat = _isLowFat;
			imageName = _imageName;
		}

		public function toString():String
		{
			return "[Product]"+this.prodName;
		}
		
		public static function buildProduct(o:Object):Product
		{
			var p:Product = new Product(o.catID, o.prodName, o.unitID, o.cost, o.listPrice, o.description, Boolean(o.isOrganic), Boolean(o.isLowFat), o.imageName);
			return p;
		}
	}
}
