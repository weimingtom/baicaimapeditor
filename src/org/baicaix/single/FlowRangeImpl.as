/**
 * @file FlowRange.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-2
 * @updatedate 2010-2-2
 */   
package org.baicaix.single {
	import org.baicaix.map.MapLayer;
	import org.baicaix.map.MapTile;
	import org.baicaix.single.events.FlowCellEvent;

	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	/**
	 * @author dengyang
	 */
	public class FlowRangeImpl extends EventDispatcher implements FlowRange {
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		protected var _layer : MapLayer;
		protected var _range : Rectangle;
		protected var _tiles : Dictionary;

		//------------------------------------
		// public properties
		//------------------------------------
		

		//------------------------------------
		// constructor
		//------------------------------------

		public function FlowRangeImpl(layer: MapLayer, range : Rectangle = null) {
			this._layer = layer;
			this._range = range;
			if(range != null) {
				selectRange(layer, range);
			}
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		/**
		 * 清除邊框
		 */
		private function clearCellRim(tile : MapTile, index : int, array : Array) : void {
			tile.clearRim();
		}
		
		/**
		 * 查找上邊緣單元格
		 */
		protected function findTopCells() : Array {
			var topCells : Array = [];
			for (var x : int = _range.left; x <= _range.right; x++) {
				topCells.push(_tiles[x + "," + _range.top]);
			}
			return topCells;
		}
		
		/**
		 * 查找下邊緣單元格
		 */
		protected function findBottomCells() : Array {
			var topCells : Array = [];
			for (var x : int = _range.left; x <= _range.right; x++) {
				topCells.push(_tiles[x + "," + _range.bottom]);
			}
			return topCells;
		}
		
		/**
		 * 查找左邊緣單元格
		 */
		protected function findLeftCells() : Array {
			var topCells : Array = [];
			for (var y : int = _range.top; y <= _range.bottom; y++) {
				topCells.push(_tiles[_range.left + "," + y]);
			}
			return topCells;
		}
		
		/**
		 * 查找右邊緣單元格
		 */
		protected function findRightCells() : Array {
			var topCells : Array = [];
			for (var y : int = _range.top; y <= _range.bottom; y++) {
				topCells.push(_tiles[_range.right + "," + y]);
			}
			return topCells;
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function get range() : Rectangle {
			return this._range;
		}

		public function get cells() : Dictionary {
			return this._tiles;
		}
		
		/**
		 * 選取區域
		 */
		public function selectRange(layer: MapLayer, range : Rectangle) : void {
			this._layer = layer;
			this._range = range;
			this._tiles = new Dictionary();
			var key : String;
			for (var x : int = _range.left;x <= _range.right;x++) {
				for (var y : int = _range.top;y <= _range.bottom;y++) {
					key = x + "," + y;
					this._tiles[key] = _layer.getOrCreateTile(x, y);
				}
			}
		}
		
		/**
		 * 粘贴区域
		 */
		public function pasteRange(baseRange : FlowRange, sourceCellRange : FlowRange) : void {
			//跟基准粘贴区域的偏移
			var offsetXfromBase : int = -(this.range.left - baseRange.range.left) % (sourceCellRange.range.width + 1); 
			var offsetYfromBase : int = -(this.range.top - baseRange.range.top) % (sourceCellRange.range.height + 1); 
			
			//偏移量
			var offsetX : int = this.range.left - sourceCellRange.range.left;
			var offsetY : int = this.range.top - sourceCellRange.range.top;
			//粘貼
			for each (var sourcetile : MapTile in sourceCellRange.cells) {
				
				var targetX : int = sourcetile.x + offsetX + offsetXfromBase;
				//左侧越界
				targetX = targetX < this.range.left ? targetX + (sourceCellRange.range.width + 1) : targetX; 
				//右侧越界
				targetX = targetX > this.range.left + sourceCellRange.range.width ? targetX - (sourceCellRange.range.width + 1) : targetX; 
				var targetY : int = sourcetile.y + offsetY + offsetYfromBase;
				//上方越界
				targetY = targetY < this.range.top ? targetY + (sourceCellRange.range.height + 1) : targetY; 
				//下方越界
				targetY = targetY > this.range.top + sourceCellRange.range.height ? targetY - (sourceCellRange.range.height + 1) : targetY; 
				
				var targettile : MapTile = this._layer.getTile(targetX, targetY);
				//超出边界的处理
				if(targettile == null) continue;
				targettile.paste(sourcetile);
			}
			
			refreshRim();
			refreshCell();
		}
		
		public function setTileType(type : int) : void {
			for each (var tile : MapTile in _tiles) {
				tile.type = type;
			}
			refreshCell();
		}

		public function cancelRange() : void {
			for each (var tile : MapTile in _tiles) {
				tile.rim = MapTile.NONE_RIM;
			}
			refreshRim();
		}
		
		private function refreshRim() : void {
			dispatchEvent(new FlowCellEvent(FlowCellEvent.RELOAD_RIM, {range : _range}));
		}
		
		private function refreshCell() : void {
			dispatchEvent(new FlowCellEvent(FlowCellEvent.RELOAD_CELL, {range : _range}));
		}

		/**
		 * 顯示邊框
		 */
		public function drawRim() : void {
			//设置tile
			findTopCells().forEach( function (tile : MapTile, index : int, array : Array) : void {
				tile.rim = MapTile.TOP_RIM;
			});
			findBottomCells().forEach( function (tile : MapTile, index : int, array : Array) : void {
				tile.rim = MapTile.BOTTOM_RIM;
			});
			findLeftCells().forEach( function (tile : MapTile, index : int, array : Array) : void {
				tile.rim = MapTile.LEFT_RIM;
			});
			findRightCells().forEach( function (tile : MapTile, index : int, array : Array) : void {
				tile.rim = MapTile.RIGHT_RIM;
			});
			refreshRim();
		}
		
		/**
		 * 清除邊框
		 */
		public function clearRim() : void {
			findTopCells().forEach(clearCellRim);
			findBottomCells().forEach(clearCellRim);
			findLeftCells().forEach(clearCellRim);
			findRightCells().forEach(clearCellRim);
			refreshRim();
		}
		
		public function clear() : void {
			for each (var tile : MapTile in _tiles) {
				tile.clear();
			}
			dispatchEvent(new FlowCellEvent(FlowCellEvent.RELOAD_CELL, {range : _range}));
		}
	}//end Range
}