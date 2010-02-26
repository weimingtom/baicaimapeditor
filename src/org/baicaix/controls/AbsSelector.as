/**
 * @file AbsSelector.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-25
 * @updatedate 2010-2-25
 */   
package org.baicaix.controls {
	import org.baicaix.events.RangeEvent;

	import org.baicaix.views.MapBrowserPanel;

	import org.baicaix.utils.OffsetUtil;

	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author dengyang
	 */
	public class AbsSelector extends EventDispatcher {
		
		protected var _base : MapBrowserPanel;
		protected var _offsetUtil : OffsetUtil;
		
		protected var _startPos : Point;
		protected var _endPos : Point;
		protected var _selectedRange : Rectangle;
		protected var _oldRange : Rectangle;
		
		public function AbsSelector(base : MapBrowserPanel, offsetUtil : OffsetUtil) {
			_base = base;
			_offsetUtil = offsetUtil;
			initEditEvent();
			selectDefaultCell();
		}
		
		protected function initEditEvent() : void {
			_base.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		protected function selectDefaultCell() : void {
			selectRange(new Rectangle(0, 0, 0, 0));
		}

		protected function selectRange(range : Rectangle) : void {
			setNewRange(range);
//			var isNewOrInSameRange : Boolean = _oldRange != null && _selectedRange.equals(_oldRange);
//			if(isNewOrInSameRange) return;
			clearOldRange();
			focusRange();
		}
		
		protected function setNewRange(range : Rectangle) : void {
			_oldRange = _selectedRange;
			_selectedRange = range;
		}
		
		protected function clearOldRange() : void {
			if(_oldRange == null) return;
			dispatchEvent(new RangeEvent(RangeEvent.CLEAR_RANGE, _oldRange));
		}

		protected function focusRange() : void {
			if(_oldRange == null) return;
			dispatchEvent(new RangeEvent(RangeEvent.FOCUS_RANGE, _selectedRange));
		}
		
		protected function onMouseDown(event : MouseEvent) : void {
			_base.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		protected function onMouseUp(event : MouseEvent) : void {
			_base.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}

		protected function onMouseMove(event : MouseEvent) : void {
			var localPos : Point = _offsetUtil.getCellOffset(event);
			selectStart(localPos);
			selectEnd(localPos);
		}
		
		protected function selectStart(pos : Point) : void {
			_startPos = pos;
		}
		
		protected function selectEnd(pos : Point) : void {
			throw Error("Not support yet!");
		}
		
		protected function buildRectangle() : Rectangle {
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
