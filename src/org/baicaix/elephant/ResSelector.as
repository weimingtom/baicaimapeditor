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
package org.baicaix.elephant {
	import events.RangeEvent;

	import views.MapBrowserPanel;

	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author dengyang
	 */
	public class ResSelector extends EventDispatcher {
		
		protected var _base : MapBrowserPanel;
		private var _offsetUtil : OffsetUtil;
		
		protected var _startPos : Point;
		protected var _endPos : Point;
		protected var _selectedRange : Rectangle;
		protected var _oldRange : Rectangle;
		
		private var _isInSelect : Boolean;
		
		public function ResSelector(base : MapBrowserPanel, offsetUtil : OffsetUtil) {
			_base = base;
			_offsetUtil = offsetUtil;
			initEditEvent();
			selectDefaultCell();
		}
		
		private function initEditEvent() : void {
			_base.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function selectDefaultCell() : void {
			selectRange(new Rectangle(0, 0, 0, 0));
		}

		protected function selectRange(range : Rectangle) : void {
			_oldRange = _selectedRange;
			_selectedRange = range;
			if(_oldRange == null || _selectedRange.equals(_oldRange)) return;
			clearOldRange();
			focusRange();
		}
		
		private function clearOldRange() : void {
			dispatchEvent(new RangeEvent(_oldRange, RangeEvent.CLEAR_RANGE));
		}

		private function focusRange() : void {
			dispatchEvent(new RangeEvent(_selectedRange, RangeEvent.FOCUS_RANGE));
		}
		
		protected function onMouseDown(event : MouseEvent) : void {
			_base.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_base.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			var localPos : Point = _offsetUtil.getCellOffset(event);
			selectStart(localPos);
			selectEnd(localPos);
		}
		
		protected function onMouseUp(event : MouseEvent) : void {
			_base.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_base.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_isInSelect = false;
		}

		protected function onMouseMove(event : MouseEvent) : void {
			selectEnd(_offsetUtil.getCellOffset(event));
		}
		
		private function selectStart(pos : Point) : void {
			_startPos = pos;
			_isInSelect = true;
		}
		
		private function selectEnd(pos : Point) : void {
			if(_startPos == null || !_isInSelect) return;
			_endPos = pos;
			selectRange(buildRectangle());
		}
		
		private function buildRectangle() : Rectangle {
			var fromX : int = Math.min(_startPos.x, _endPos.x);
			var fromY : int = Math.min(_startPos.y, _endPos.y);
			var width : int = Math.max(_startPos.x, _endPos.x) - fromX + 1;
			var height : int = Math.max(_startPos.y, _endPos.y) - fromY + 1;
			return new Rectangle(fromX, fromY, width, height);
		}
		
		public function get selectedRange() : Rectangle {
			return _selectedRange;
		}
	}
}
