/**
 * @file FlowSelector.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-3
 * @updatedate 2010-2-3
 */   
package org.baicaix.flow {
	import org.baicaix.flow.display.FlowCell;
	import org.baicaix.flow.display.FlowBrowser;
	import org.baicaix.flow.events.FlowCellEvent;

	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * @author dengyang
	 */
	public class FlowResourceSelector extends EventDispatcher {
		
		protected var _selectRange : FlowRange;
		protected var _base : FlowBrowser;
		
		public function FlowResourceSelector(base : FlowBrowser) {
			_base = base;
			initEditEvent();
			selectDefaultCell();
		}
		
		private function selectDefaultCell() : void {
			selectRange(new Rectangle(0, 0, 0, 0));
		}

		protected function selectRange(range : Rectangle) : void {
			clearOldRange();
			updataSelectRange(range);
			updataEditorSelectRange();
			focusRange();
		}
		
		private function clearOldRange() : void {
			if(_selectRange == null) return;
			_selectRange.clearRim();
			_selectRange.removeEventListener(FlowCellEvent.RELOAD_RIM, _base.drawRim);
			_selectRange.removeEventListener(FlowCellEvent.RELOAD_CELL, _base.reloadCell);
		}
		
		private function updataSelectRange(range : Rectangle) : void {
			_selectRange = new FlowRangeImpl(_base.layer, range);
			_selectRange.addEventListener(FlowCellEvent.RELOAD_RIM, _base.drawRim);
			_selectRange.addEventListener(FlowCellEvent.RELOAD_CELL, _base.reloadCell);
		}
		
		private function updataEditorSelectRange() : void {
			_base.editor.selectRange(_selectRange);
		}
		
		private function copyEditorRange() : void {
			_base.editor.copyRange();
		}

		private function focusRange() : void {
			_selectRange.drawRim();
		}
		
		protected var _startCell : FlowCell;
		protected var _endCell : FlowCell;
		
		private var _isInSelect : Boolean;
		
		private function initEditEvent() : void {
			_base.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
				
		protected function onMouseDown(event : MouseEvent) : void {
			_base.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_base.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			var startCell : FlowCell = FlowCell(event.target);
			selectStart(startCell);
			selectEnd(startCell);
		}
		
		private function selectStart(startCell : FlowCell) : void {
			_startCell = startCell;
			_isInSelect = true;
		}
		
		private function selectEnd(endCell : FlowCell) : void {
			if(_startCell == null || !_isInSelect) return;
			_endCell = endCell;
			selectRange(buildRectangle());
			copyEditorRange();
		}

		protected function onMouseUp(event : MouseEvent) : void {
			_base.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_base.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_isInSelect = false;
		}

		protected function onMouseOver(event : MouseEvent) : void {
			if(!(event.target is FlowCell)) return;
			var endCell : FlowCell = FlowCell(event.target);
			selectEnd(endCell);
		}

		private function buildRectangle() : Rectangle {
			var fromX : int = Math.min(_startCell.x, _endCell.x) / _base.cellWidth;
			var fromY : int = Math.min(_startCell.y, _endCell.y) / _base.cellHeight;
			var width : int = Math.max(_startCell.x, _endCell.x) / _base.cellWidth - fromX;
			var height : int = Math.max(_startCell.y, _endCell.y) / _base.cellHeight - fromY;
			return new Rectangle(fromX, fromY, width, height);
		}
	}
}
