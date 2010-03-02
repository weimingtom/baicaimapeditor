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
package org.baicaix.controls {
	import org.baicaix.events.EditEvent;
	
	import org.baicaix.utils.OffsetUtil;
	import org.baicaix.views.AbsBrowserPanel;

	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * @author dengyang
	 */
	public class MapSelector extends AbsSelector {
		
//		private var isMouseOut : Boolean;
//		
//		public function MapSelector(base : AbsBrowserPanel, offsetUtil : OffsetUtil) {
//			super(base, offsetUtil);
//		}
//		
//		override protected function initEditEvent() : void {
//			super.initEditEvent();
//			_base.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
//		}
//
//		override protected function onMouseMove(event : MouseEvent) : void {
//			var localPos : Point = _offsetUtil.getCellOffset(event);
//			selectStart(localPos);
//			selectEnd(localPos);
//		}
//		
//		override protected function onMouseDown(event : MouseEvent) : void {
//			super.onMouseDown(event);
//			dispatchEvent(new EditEvent(EditEvent.PASTE_START, _selectedRange));
//		}
//		
//		override protected function onMouseUp(event : MouseEvent) : void {
//			super.onMouseUp(event);
//			dispatchEvent(new EditEvent(EditEvent.PASTE_END, _selectedRange));
//		}
//
//		private function onMouseOut(event : MouseEvent) : void {
//			_base.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
//			_base.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
//			isMouseOut = false;
//			_startPos = null;
//			_endPos = null;
//			setNewRange(null);
//			clearOldRange();
//		}
//		
//		private function onMouseOver(event : MouseEvent) : void {
//			_base.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
//			_base.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
//			isMouseOut = true;
//			onMouseDown(event);
//		}
//		
//		override protected function selectEnd(pos : Point) : void {
//			if(_startPos == null) return;
//			_endPos = new Point(pos.x + _base.copyRange.width, pos.y + _base.copyRange.height);
//			selectRange(buildRectangle());
//		}
	}
}
