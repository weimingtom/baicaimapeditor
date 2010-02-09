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
package org.baicaix.map {

	/**
	 * @author dengyang
	 */
	public class Map {
		
		public var index : int;
		public var width : int = 16;
		public var height : int = 16;
		//地图层
		public var layers : Array;
		//背景层
//		public var backLayers : Array;
		
		public function Map(width : int = 16, height : int = 16) {
			this.width = width;
			this.height = height;
			init();
//			this.test();
		}
		
		private function init() : void {
			layers = [];
//			backLayers = [];
		}
		
		private function test() : void {
			this.createResourceLayer(0001);
			this.createResourceLayer(0002);
		}
		
		private function loadLayer(obj : Object) : MapLayer {
			var layer : MapLayer = new MapLayer();
			layer.convertObjToTiles(obj);
			layers.push(layer);
			return layer;
		}
		
		private function copyProperty(obj : Object) : void {
			width = obj.width;
			height = obj.height;
		}

		public function createResourceLayer(index : int) : MapLayer {
			this.index = index;
			return createTemptyLayer(index);
		}
		
		public function createTemptyLayer(index : int = 0, z : int = -2000, name : String = "default name") : MapLayer {
			var layer : MapLayer = new MapLayer(z, name);
			layer.initTiles(index, width, height);
			layers.push(layer);
			return layer;
		}
		
		public function convert(obj : Object) : void {
			this.init();
			this.copyProperty(obj);
			for each (var layer : Object in obj.layers) {
				loadLayer(layer);
			}
		}
	}
}
