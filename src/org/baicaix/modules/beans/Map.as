/**
 * @file Map.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-20
 * @updatedate 2010-1-20
 */   
package org.baicaix.modules.beans {

	/**
	 * @author dengyang
	 */
	public class Map {
		
		public var index : int;
		public var width : int = 16;
		public var height : int = 16;
		//地图层
		public var layers : Array;
		public var ress : Array;
		
		public function Map(width : int = 16, height : int = 16) {
			this.width = width;
			this.height = height;
			init();
		}
		
		private function init() : void {
			layers = [];
			ress = [];
		}
		
		private function loadLayer(obj : Object) : Layer {
			var layer : Layer = new Layer(this);
			layer.convertObjToTiles(obj);
			layers.unshift(layer);
			return layer;
		}
		
		private function copyProperty(obj : Object) : void {
			index = obj.index;
			width = obj.width;
			height = obj.height;
			ress = obj.ress;
		}

		public function createResourceLayer(index : int) : Layer {
			this.index = index;
			return createTemptyLayer(index);
		}
		
		public function createTemptyLayer(index : int = 0, z : int = -2000, name : String = "default name") : Layer {
			var layer : Layer = new Layer(this, z, name);
			layer.initTiles(index, width, height);
			layers.unshift(layer);
			return layer;
		}
		
		public function convert(obj : Object) : void {
			this.init();
			this.copyProperty(obj);
			for each (var layer : Object in obj.layers) {
				loadLayer(layer);
			}
		}
		
		public function getTiles(x : int, y : int) : Array {
			var temp : Array = [];
 			for each (var layer : Layer in this.layers) {
				temp.push(layer.getTile(x, y));
			}
			return temp;
		}
	}
}
