/**
 * @file MapLayer.as
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
	 * 1 根据元素生成序列
	 * 2 读取已有序列
	 * @author dengyang
	 */
	public class MapLayer {
		/**
		 * Z轴层次
		 */
		public var z : int;
		public var name : String ;
		
		public static const DEFAULT_TILE : MapTile = new MapTile();
		public var tiles : Object = {};
		
		public function MapLayer(z : int = -2000, name : String = "default name") {
			this.z = z;
			this.name = name;
//			test();
		}
		
		private function test() : void {
			getOrCreateTile(getIndex(), getIndex());
			getOrCreateTile(getIndex(), getIndex());
			getOrCreateTile(getIndex(), getIndex());
			getOrCreateTile(getIndex(), getIndex());
		}

		private function getIndex() : int {
			return Math.round(Math.random()*100);
		}
		
		public function createKey(x : int, y : int) : String {
			return x + "," + y;
		}
		
		public function getTile(x : int, y : int) : MapTile {
			var tile : MapTile =  this.tiles[createKey(x, y)];
			return tile == null ? DEFAULT_TILE : tile;
		}
		
		public function getOrCreateTile(x : int, y : int) : MapTile {
			var tile : MapTile = this.tiles[createKey(x, y)];
			return tile != null ? tile : createTile(x, y);
		}
		
		private function createTile(x : int, y : int) : MapTile {
			var key : String = createKey(x, y);
			var tile : MapTile = new MapTile();
			tile.x = x;
			tile.y = y;
			tiles[key] = tile;
			return tile;
		}
		
		/**
		 * 根据资源生成 Tile
		 * x,y 与 srcX,srcY 默认相同
		 */
		public function initTiles(src : int, width : int, height : int) : void {
			var tile : MapTile;
			for (var x : int = 0; x < width; x++) {
				for (var y : int = 0; y < height; y++) {
					tile = createTile(x, y);
					tile.setSource(src, x, y);
				}
			}
		}
		
		/**
		 * 根据读取的数据对象
		 */
		public function convertObjToTiles(layer : Object) : void {
			this.z = layer.z;
			var tile : MapTile;
			for each (var tileObj : Object in layer.tiles) {
				tile = createTile(tileObj.x, tileObj.y);
				tile.setSource(tileObj.src, tileObj.srcX, tileObj.srcY);
			}
		}
	}
}
