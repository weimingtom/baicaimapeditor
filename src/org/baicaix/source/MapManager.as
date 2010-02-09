/**
 * @file MapManager.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-23
 * @updatedate 2010-1-23
 */   
package org.baicaix.source {
	import org.baicaix.map.Map;
	import org.baicaix.serialization.ISerialization;
	import org.baicaix.serialization.SerializeToJSON;

	/**
	 * @author dengyang
	 */
	public class MapManager {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _serialize : ISerialization;

		//------------------------------------
		// public properties
		//------------------------------------
		

		//------------------------------------
		// constructor
		//------------------------------------

		public function MapManager() {
			_serialize = new SerializeToJSON();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________

		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function set serialize(serialize : ISerialization) : void {
			this._serialize = serialize;
		}
		
		public function save(path : String, map : Map) : void {
			var data : * = _serialize.mask(map);
			// TODO: 写入文件
		}
		
		public function load(path : String) : Map {
			//TODO 从文件读取
			var json : String = "";
			var obj : Object = _serialize.unmask(json);
			var map : Map = new Map();
			map.convert(obj);
			return map;
		}
	}
}
