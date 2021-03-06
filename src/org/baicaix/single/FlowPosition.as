/**
 * @file FlowPosition.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-2
 * @updatedate 2010-2-2
 */   
package org.baicaix.single {
	import org.baicaix.map.Map;
	import org.baicaix.map.MapLayer;
	import org.baicaix.map.MapTile;
	import org.baicaix.single.display.FlowCell;

	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	/**
	 * 用于根据Tile定位FlowCell
	 * @author dengyang
	 */
	public class FlowPosition {
		
		private var _map : Map;
		
		private var _posMap : Dictionary;
		
		public function FlowPosition(map : Map) {
			this._map = map;
			this._posMap = new Dictionary();
		}

		public function register(cell : FlowCell, x : int, y : int) : Array {
			var tiles : Array = _map.getTiles(x, y);
			_posMap[x+','+y] = cell;
			return tiles;
		}

		public function getCellsByRange(range : Rectangle) : Array {
			//TODO 优化，可以只取边伤的单元格
			var cells : Array = [];
			for (var x : int = range.left; x <= range.right; x++) {
				for (var y : int = range.top; y <= range.bottom; y++) {
					var cell : FlowCell = _posMap[x + ',' + y];
					if(cell == null) continue;
					cells.push(cell);
				}
			}
			return cells;
		}
	}
}
