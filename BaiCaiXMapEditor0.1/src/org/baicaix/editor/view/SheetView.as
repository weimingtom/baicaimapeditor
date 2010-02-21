/**
 * @file SheetView.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-26
 * @updatedate 2010-1-26
 */   
package org.baicaix.editor.view {
	import org.baicaix.editor.Cell;
	import org.baicaix.editor.Editor;
	import org.baicaix.editor.Sheet;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * @author dengyang
	 */
	public class SheetView extends Sprite {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _startCell : Cell;
		private var _endCell : Cell;
		
		private var _isInSelect : Boolean;
		
		private var _sheet : Sheet;
		private var _editor : Editor;

		//------------------------------------
		// public properties
		//------------------------------------
		

		//------------------------------------
		// constructor
		//------------------------------------

		public function SheetView(sheet : Sheet, editor : Editor) {
			this._sheet = sheet;
			this._editor = editor;
			initEvent();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________

		private function initEvent() : void {
			this.addEventListener(MouseEvent.MOUSE_DOWN, selectStart);
			this.addEventListener(MouseEvent.MOUSE_MOVE, updataSelectEnd);
			this.addEventListener(MouseEvent.MOUSE_UP, selectEnd);
		}
				
		private function selectStart(event : MouseEvent) : void {
			_startCell = CellView(event.target).cell;
			//清除原有选取或者复制
			_startCell.sheet.cancelSelectRange();
			
			//选取
			updataSelectEnd(event);
			_isInSelect = true;
		}

		private function selectEnd(event : MouseEvent) : void {
			updataSelectEnd(event);
			_isInSelect = false;
		}

		private function updataSelectEnd(event : MouseEvent) : void {
			if(_startCell == null || !_isInSelect) return;
			_endCell = CellView(event.target).cell;
			_sheet.selectRange(buildRectangle());
		}
		
		private function buildRectangle() : Rectangle {
			var fromX : int = Math.min(_startCell.tile.x, _endCell.tile.x);
			var fromY : int = Math.min(_startCell.tile.y, _endCell.tile.y);
			var width : int = Math.max(_startCell.tile.x, _endCell.tile.x) - fromX;
			var height : int = Math.max(_startCell.tile.y, _endCell.tile.y) - fromY;
			return new Rectangle(fromX, fromY, width, height);
		}

		// PUBLIC
		//________________________________________________________________________________________________
		
		public function destroyEvent() : void {
			this.removeEventListener(MouseEvent.MOUSE_DOWN, selectStart);
			this.removeEventListener(MouseEvent.MOUSE_MOVE, updataSelectEnd);
			this.removeEventListener(MouseEvent.MOUSE_UP, selectEnd);
		}
	}
}
