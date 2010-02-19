/**
 * @file Tile.as
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
	public class MapTile {
		
		public static const NONE_RIM : int = 0;
		public static const TOP_RIM : int = 1;
		public static const BOTTOM_RIM : int = 2;
		public static const RIGHT_RIM : int = 4;
		public static const LEFT_RIM : int = 8;
		
		public static const DEFAULT_TILE_TYPE : int = 0;
		
		public var x : int;
		public var y : int;
		//---------阻挡类型-----------
		/**
		 * 0=無
		 * 1=阻擋
		 * 2=雲
		 * 3=水
		 * 4=梯子
		 * 5=门
		 */
		public var type : int;
		//其他附加参数，比如传送点编号等
		public var param : Object = {};
		//-----------资源-------------
		public var src : int;
		public var srcX : int;
		public var srcY : int;
		private var _parent : Map;
		
		private var _rim : int;
		
		public function MapTile(parent : Map=null, src : int = -1, srcX : int = -1, srcY : int = -1) {
			setSource(src, srcX, srcY);
			this._parent = parent;
		}

		public function setSource(src : int, srcX : int, srcY : int, type : int = DEFAULT_TILE_TYPE) : void {
			this.src = src;
			this.srcX = srcX;
			this.srcY = srcY;
			this.type = type;
		}
		
		public function clear() : void {
			setSource(0, 0, 0);
		}

		public function paste(tile : MapTile) : void {
			if(tile == null) return;
			setSource(tile.src, tile.srcX, tile.srcY, tile.type);
			if(_parent.ress.indexOf(tile.src) < 0)
				_parent.ress.push(tile.src);
		}

		public function get rim() : int {
			return _rim;
		}
		
		public function get map() : Map {
			return _parent;
		}
		
		public function set rim(value : int) : void {
			this._rim = _rim | value;
		}
		
		public function clearRim() : void {
			this._rim = MapTile.NONE_RIM;
		}

		public function isRimBySide(rim : int) : Boolean {
			return (this._rim & rim) != 0;
		}
	}
}
