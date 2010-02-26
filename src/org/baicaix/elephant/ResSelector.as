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
	import views.MapBrowserPanel;

	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * @author dengyang
	 */
	public class ResSelector extends AbsSelector {
		
		private var _isInSelect : Boolean;
		
		public function ResSelector(base : MapBrowserPanel, offsetUtil : OffsetUtil) {
			super(base, offsetUtil);
		}
		
		override protected function onMouseDown(event : MouseEvent) : void {
			super.onMouseDown(event);
			_base.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			var localPos : Point = _offsetUtil.getCellOffset(event);
			selectStart(localPos);
			selectEnd(localPos);
		}
		
		override protected function onMouseUp(event : MouseEvent) : void {
			super.onMouseUp(event);
			_base.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_isInSelect = false;
		}

		override protected function onMouseMove(event : MouseEvent) : void {
			selectEnd(_offsetUtil.getCellOffset(event));
		}
		
		override protected function selectStart(pos : Point) : void {
			super.selectStart(pos);
			_isInSelect = true;
		}
		
		override protected function selectEnd(pos : Point) : void {
			if(_startPos == null || !_isInSelect) return;
			_endPos = pos;
			selectRange(buildRectangle());
		}
	}
}
