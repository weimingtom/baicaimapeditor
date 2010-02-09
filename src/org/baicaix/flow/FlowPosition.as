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
package org.baicaix.flow {
	import org.baicaix.flow.display.FlowCell;
	import flash.geom.Rectangle;
	import org.baicaix.map.MapLayer;
	import org.baicaix.map.MapTile;

	import flash.utils.Dictionary;

	/**
	 * 用于根据Tile定位FlowCell
	 * @author dengyang
	 */
	public class FlowPosition {
		
		private var _layer : MapLayer;
		
		private var _posMap : Dictionary;
		
		public function FlowPosition(layer : MapLayer) {
			this._layer = layer;
			this._posMap = new Dictionary();
		}

		public function register(cell : FlowCell, x : int, y : int) : MapTile {
			var tile : MapTile = _layer.getTile(x, y);
			_posMap[tile] = cell;
			return tile;
		}

		public function getCellsByRange(range : Rectangle) : Array {
			//TODO 优化，可以只取边伤的单元格
			var cells : Array = [];
			for (var x : int = range.left; x <= range.right; x++) {
				for (var y : int = range.top; y <= range.bottom; y++) {
					var cell : FlowCell = _posMap[_layer.getTile(x, y)];
					if(cell == null) continue;
					cells.push(cell);
				}
			}
			return cells;
		}
	}
}
