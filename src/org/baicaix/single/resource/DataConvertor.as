/**
 * @file DataLoader.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-5
 * @updatedate 2010-2-5
 */   
package org.baicaix.single.resource {
	import org.baicaix.modules.beans.Map;
	import org.baicaix.modules.serialization.ISerialization;
	import org.baicaix.modules.serialization.SerializeToJSON;

	/**
	 * @author dengyang
	 */
	public class DataConvertor {
		
		private var _serialize : ISerialization;

		public function DataConvertor() {
			//TODO 将采用ioc代替
			_serialize = new SerializeToJSON();
		}

		
		public function set serialize(value : ISerialization) : void {
			_serialize = value;
		}
		
		public function convertToMap(value : String) : Map {
			var obj : Object = _serialize.unmask(value);
			return convert(obj);
		}
		
		public function convert(obj : Object) : Map {
			var map : Map = new Map();
			map.convert(obj);
			return map;
		}
		
//		public function loadLayer(value : String) : MapLayer {
//			var obj : Object = _serialize.unmask(value);
//			var layer : MapLayer = new MapLayer();
//			layer.convertObjToTiles(obj);
//			return layer;
//		}
		
		public function saveMap(value : Object) : * {
			return _serialize.mask(value);
		}
//
//		public function saveLayer(value : Object) : * {
//			return _serialize.mask(value);	
//		}
	}
}
