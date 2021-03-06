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
package org.baicaix.single {
	import org.baicaix.single.display.FlowBrowser;
	import org.baicaix.single.events.FlowCellEvent;

	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
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
			_selectRange.removeEventListener(FlowCellEvent.DRAW_RIM, _base.drawRim);
			_selectRange.addEventListener(FlowCellEvent.CLEAR_RIM, _base.clearRim);
			_selectRange.removeEventListener(FlowCellEvent.RELOAD_CELL, _base.reloadCell);
		}
		
		private function updataSelectRange(range : Rectangle) : void {
			_selectRange = new FlowRangeImpl(_base.activityMap, range);
			_selectRange.addEventListener(FlowCellEvent.DRAW_RIM, _base.drawRim);
			_selectRange.addEventListener(FlowCellEvent.CLEAR_RIM, _base.clearRim);
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
		
		protected var _startPos : Point;
		protected var _endPos : Point;
		
		private var _isInSelect : Boolean;
		
		private function initEditEvent() : void {
			_base.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
				
		protected function onMouseDown(event : MouseEvent) : void {
			_base.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_base.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			var browser : FlowBrowser = FlowBrowser(event.target);
			var pos : Point = getPos(event.localX, event.localY, browser);
			selectStart(pos);
			selectEnd(pos);
		}
		
		protected function getPos(x : int, y : int, browser : FlowBrowser) : Point {
			return new Point(x - browser.focusLayer.x, y - browser.focusLayer.y);
		}
		
		private function selectStart(pos : Point) : void {
			_startPos = pos;
			_isInSelect = true;
		}
		
		private function selectEnd(pos : Point) : void {
			if(_startPos == null || !_isInSelect) return;
			_endPos = pos;
			selectRange(buildRectangle());
			copyEditorRange();
		}
		
		protected function onMouseUp(event : MouseEvent) : void {
			_base.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_base.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_isInSelect = false;
		}

		protected function onMouseMove(event : MouseEvent) : void {
			if(!(event.target is FlowBrowser)) return;
			var browser : FlowBrowser = FlowBrowser(event.target);
			selectEnd(getPos(event.localX, event.localY, browser));
		}


		private function buildRectangle() : Rectangle {
			var fromX : int = Math.min(_startPos.x, _endPos.x) / _base.cellWidth;
			var fromY : int = Math.min(_startPos.y, _endPos.y) / _base.cellHeight;
			var width : int = Math.max(_startPos.x, _endPos.x) / _base.cellWidth - fromX;
			var height : int = Math.max(_startPos.y, _endPos.y) / _base.cellHeight - fromY;
			return new Rectangle(fromX, fromY, width, height);
		}
	}
}
