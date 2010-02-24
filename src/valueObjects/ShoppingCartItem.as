package valueObjects
{
	public class ShoppingCartItem 
	{
		public var product:Product;
		private var _quantity:uint;
		public var subtotal:Number;
		
		public function ShoppingCartItem(product:Product, quantity:uint=1)
		{
			this.product = product;
			this.quantity = quantity;
			this.subtotal = product.listPrice * quantity;
		}
		
		public function set quantity(qty:uint):void{
			_quantity = qty;
			recalc();
		}

		public function get quantity():uint{
			return _quantity;
		}
		
		public function recalc():void{
			this.subtotal = product.listPrice * quantity;
		}

		public function toString():String{ 
			return this.quantity.toString() + ": " + this.product.prodName;
		}
	}
}