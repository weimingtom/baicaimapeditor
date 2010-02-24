package valueObjects{
	[Bindable]
	public class OrderInfo{
		public var billingName:String;
		public var billingAddress:String;
		public var billingCity:String;
		public var billingState:String;
		public var billingZip:String;
		public var cardType:String;
		public var cardNumber:Number;
		public var cardExpirationMonth:Number;
		public var cardExpirationYear:Number;
		public var deliveryDate:Date;
	}
}
