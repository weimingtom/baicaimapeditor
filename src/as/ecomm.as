import events.CategoryEvent;

import mx.collections.ArrayCollection;
import mx.events.DragEvent;
import mx.managers.DragManager;

import valueObjects.Product;
import valueObjects.ShoppingCart;
import valueObjects.ShoppingCartItem;

import mx.core.IUIComponent;

[Bindable]
public var cart:ShoppingCart = new ShoppingCart();

[Bindable]
private var theProduct:Product;

[Bindable]
private var categories:ArrayCollection;

[Bindable]
private var prodByCategory:ArrayCollection;

public function addToCart(product:Product):void {
	var sci:ShoppingCartItem = new ShoppingCartItem(product);

	cart.addItem(sci);
	btnViewCart.enabled=true;
}

private function deleteProd(product:Product):void{
	cart.removeItem(product);
}

private function categorizedProductDataLoaded():void{
	categories=new ArrayCollection(catProds.getCats());
}

private function displayProdByCategory(event:CategoryEvent):void{
	if ( event.cat != null ) {
		var prodArray:Array=catProds.getProdsForCat(event.cat.catID);
		prodByCategory=new ArrayCollection(prodArray);
	} else {
		prodByCategory=new ArrayCollection();
	}
}

private function doDragEnter( event:DragEvent, format:String ):void
{
	if(event.dragSource.hasFormat(format))
	{
		DragManager.acceptDragDrop(IUIComponent(event.target));
	}
}

private function doDragDrop( event:DragEvent, format:String ):void
{
	var prodObj:Product=Product.buildProduct(event.dragSource.dataForFormat(format));
	var sci:ShoppingCartItem = new ShoppingCartItem(prodObj);
	cart.addItem(sci);
}

private function showCart():void{
	ecommNav.selectedChild=bodyBox;
	this.currentState='cartView';
}

private function showProducts():void{
	ecommNav.selectedChild=bodyBox;
	currentState='';
}
