/**
 * @file OffsetUtil.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-25
 * @updatedate 2010-2-25
 */   
package org.baicaix.utils {
	import org.baicaix.views.AbsBrowserPanel;

	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author dengyang
	 */
	public class OffsetUtil {
		
		private var cellWidth : int = 32; 
		private var cellHeight : int = 32;
		
		private var _base : AbsBrowserPanel;

		public function OffsetUtil(base : AbsBrowserPanel) {
			_base = base;
		}

		public function getCellOffset(event : MouseEvent) : Point {
			var pixelOffset : Point = getPixelOffset();
			var fromLogicX : int = (event.localX - _base.browser.x - pixelOffset.x) / cellWidth;
			var fromLogicY : int = (event.localY - _base.browser.y - pixelOffset.y) / cellHeight;
			return new Point(fromLogicX, fromLogicY);
		}
		
		public function getPixelOffset() : Point {
			var fromX : int = cellWidth - _base.horizontalScrollPosition % cellWidth;
			var fromY : int = cellHeight - _base.verticalScrollPosition % cellHeight;
			return new Point(fromX == cellWidth ? 0 : fromX, fromY == cellHeight ? 0 : fromY);
		}

		public function cellRangeConvertToPixelRange(range : Rectangle) : Rectangle {
			var pixelOffset : Point = getPixelOffset();
			var fromX : int = range.left * cellWidth + pixelOffset.x;
			var fromY : int = range.top * cellHeight + pixelOffset.y;
			var rangeWidth : int = range.width * cellWidth;
			var rangeHeight : int = range.height * cellHeight;
			return new Rectangle(fromX, fromY, rangeWidth, rangeHeight);
		}
		
		public function cellRangeConvertToAbsPixelRange(range : Rectangle) : Rectangle {
			var absPixelRange : Rectangle =  cellRangeConvertToPixelRange(range);
			absPixelRange.offset(_base.browser.x, _base.browser.y);
			return absPixelRange;
		}
	}
}
