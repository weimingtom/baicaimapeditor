/**
 * @file FlowColRow.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-1
 * @updatedate 2010-2-1
 */   
package org.baicaix.flow.display {

	
	/**
	 * @author dengyang
	 */
	public class FlowColRow {
		
		private var _row : Array;
		private var _col : Array;
		
		public function FlowColRow(totalLogicWidth : int, totalLogicHeight : int) {
			_row = [];
			_col = [];
			
			for (var col : int = 0; col < totalLogicWidth; col++) {
				_col.push([]);
			}
			for (var row : int = 0; row < totalLogicHeight; row++) {
				_row.push([]);
			}
		}

		public function bottomRowGotoTop() : Array {
			var lastRow : Array = _row.pop();
			_row.unshift(lastRow);
			return lastRow;
		}

		public function topRowGotoBottom() : Array {
			var lastRow : Array = _row.shift();
			_row.push(lastRow);
			return lastRow;
		}

		public function rightColGotoLeft() : Array {
			var lastRow : Array = _col.pop();
			_col.unshift(lastRow);
			return lastRow;
		}

		public function leftColGotoRight() : Array {
			var lastRow : Array = _col.shift();
			_col.push(lastRow);
			return lastRow;
		}

		public function addCell(x : int, y : int, cell : FlowCell) : void {
			//此处不能使用Array(_col[x]).push(cell);
			_col[x].push(cell);
			_row[y].push(cell);
		}
		
		public function getRows() : Array {
			return _row;
		}
	}
}
