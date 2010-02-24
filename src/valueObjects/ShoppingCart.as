package valueObjects
{
	import flash.utils.*;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	public class ShoppingCart 
	{
		[Bindable]
		public var aItems:ArrayCollection = new ArrayCollection();
		[Bindable]
		public var total:Number=0;
		private var cursor:IViewCursor;
		
		public function addItem(item:ShoppingCartItem):void{
			manageAddItem(item);
			calcTotal();
		}

		private function sortItems():void{
			var prodSort:Sort=new Sort();
			var sortField:SortField=new SortField("product");
			prodSort.fields=new Array(sortField);
			aItems.sort=prodSort;
			aItems.refresh();
		}

		private function manageAddItem(item:ShoppingCartItem):void{
			if (isItemInCart(item)){
				updateItem(item);
			}else{
				aItems.addItem(item);
			}
		}

		private function isItemInCart(item:ShoppingCartItem):Boolean{
			var sci:ShoppingCartItem = getItemInCart(item);
			if(sci == null){
				return false;
			} else {
				return true;
			}
		}

		private function getItemInCart(item:ShoppingCartItem):ShoppingCartItem{
			cursor = aItems.createCursor();
			sortItems();
			var found:Boolean = cursor.findFirst(item);
			if(found){
				var sci:ShoppingCartItem = cursor.current as ShoppingCartItem;
			}else{
				return null;
			}
			return sci;
		}

		private function updateItem(item:ShoppingCartItem):void{
			var sci:ShoppingCartItem = cursor.current as ShoppingCartItem;
			sci.quantity += item.quantity;
			sci.recalc();
		}

		private function calcTotal():void{
			this.total = 0;
			for(var i:int=0;i<aItems.length;i++){
				this.total += aItems.getItemAt(i).subtotal;
			}
		}

		public function removeItem(prod:Product):void{
			var item:ShoppingCartItem = new ShoppingCartItem(prod);
			var sci:ShoppingCartItem = getItemInCart(item);
			if(sci != null){
				cursor.remove();
			}
			calcTotal();
		}
	}
}
