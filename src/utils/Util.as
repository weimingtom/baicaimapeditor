package utils {
	import flash.utils.*;
	import mx.collections.IList;
	import mx.controls.ComboBox;
	import mx.controls.List;
	import mx.collections.ArrayCollection;
	
	public class Util {

		public static function introspect(o:Object):void{
			var classInfo:XML = describeType(o);
			// trace the entire E4X XML object:
          //  trace("ClassInfo="+ classInfo.toString());

            // List the class name:
            trace("Class " + classInfo.@name.toString());

            // List the object's variables, their values, and their types:
            for each (var v:XML in classInfo..variable) {
            	trace("Variable " + v.@name + "=" + o[v.@name] + " (" + v.@type + ")");
	 			
            }

            // List accessors as properties:
            for each (var a:XML in classInfo..accessor) {
            	trace("Property " + a.@name + "=" + o[a.@name] + " (" + a.@type +")");
            }

            // List the object's methods:
            for each (var m:XML in classInfo..method) {
                trace("Method " + m.@name + "():" + m.@returnType );
            }
		}
		public static function presetCombo(cb:ComboBox, field:String, value:String):void{
			trace("cb:"+cb);
			trace("field:"+field);
			trace("value:"+value);
			trace("cb.length:"+cb.dataProvider.length);
			for(var i:Number=0;i<cb.dataProvider.length;i++){
				trace(i);
				if(cb.dataProvider.getItemAt(i)[field] == value){
					trace(cb.dataProvider.getItemAt(i)[field]);
					cb.selectedIndex=i;
					break;	
				}
			}	
		}
		public static function presetList(myList:List, field:String, value:String):void{
			for(var i:Number=0;i<myList.dataProvider.length;i++){
				if(ArrayCollection(myList.dataProvider).getItemAt(i)[field] == value){
					myList.selectedIndex=i;
					break;	
				}
			}	
		}
		public static function yesNoToBoolean(val:String):Boolean{
			if(val.toLowerCase() == "yes"){
				return true;	
			} else {
				return false;	
			}
		}
	}
}