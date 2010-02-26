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
	public class MapSelector extends AbsSelector {
		
		public function MapSelector(base : MapBrowserPanel, offsetUtil : OffsetUtil) {
			super(base, offsetUtil);
		}
		
		override protected function initEditEvent() : void {
			super.initEditEvent();
			_base.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_base.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}

		override protected function onMouseMove(event : MouseEvent) : void {
			var localPos : Point = _offsetUtil.getCellOffset(event);
			selectStart(localPos);
			selectEnd(localPos);
		}

		private function onMouseOut(event : MouseEvent) : void {
			_startPos = null;
			_endPos = null;
			setNewRange(null);
			clearOldRange();
		}
		
		override protected function selectEnd(pos : Point) : void {
			if(_startPos == null) return;
			_endPos = new Point(pos.x + _base.copyRange.width, pos.y + _base.copyRange.height);
			selectRange(buildRectangle());
		}
	}
}
