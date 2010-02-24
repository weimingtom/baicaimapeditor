package utils
{
	import mx.validators.Validator;
	import mx.validators.ValidationResult;

	public class AddressValidator extends Validator
	{
		private var results:Array;

		public function AddressValidator(){
			super();
		}
		
		override protected function doValidation(value:Object):Array{
			results = [];
			results = super.doValidation(value);
			if(value!=null)
			{
				var pattern:RegExp = new RegExp("\\d+\\x20[A-Za-z]+", "");
				if(value.search(pattern) == -1)
				{
					results.push(new ValidationResult(true, null, "notAddress", "This is not a valid US address"));
				}
			}
			return results;
		}
	}
}