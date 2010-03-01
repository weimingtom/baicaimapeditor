package org.baicaix.views
{
	public class ListItemValueObject
	{
		[Bindable]
        public var label:String;
  
        [Bindable]
        public var isSelected:Boolean;
  
		public function ListItemValueObject(value : String) {
			super();
			label = value;
			isSeledted = false;
		}
	}
}