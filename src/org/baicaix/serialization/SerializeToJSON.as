/**
 * @file SerializeToJSON.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-20
 * @updatedate 2010-1-20
 */   
package org.baicaix.serialization {
	import com.adobe.serialization.json.JSON;

	/**
	 * @author dengyang
	 */
	public class SerializeToJSON implements ISerialization {
		public function SerializeToJSON() {
//			unmask('{"length":10,"backLayers":[],"layers":[{"indexs":["26,21","87,50","64,76","23,24"],"gezi":{"26,21":{"zudang":true,"index":1},"87,50":{"zudang":true,"index":1},"23,24":{"zudang":true,"index":1},"64,76":{"zudang":true,"index":1}}},{"indexs":["97,82","57,22","23,17","52,58"],"gezi":{"97,82":{"zudang":true,"index":1},"57,22":{"zudang":true,"index":1},"23,17":{"zudang":true,"index":1},"52,58":{"zudang":true,"index":1}}}],"width":10}');
//			mask(new Map());
		}

		public function unmask(json : Object) : * {
			var jsobj : Object = JSON.decode(String(json));
//			trace(jsobj.layers[0].indexs);
//			for each (var tile : Object in jsobj.layers[0].gezi) {
//				trace(tile.index);
//			}
//			trace(jsobj);
			return jsobj;
		}
		
		public function mask(value : *) : Object {
			var json : String = JSON.encode(value);
			trace(json);
			return json;
		}
	}
}
