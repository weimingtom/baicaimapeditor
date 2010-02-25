/**
 * @file FlowCamera.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-2
 * @updatedate 2010-2-2
 */   
package org.baicaix.single.display {
	import org.baicaix.single.events.FlowEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;

	/**
	 * @author dengyang
	 */
	public class FlowCamera extends EventDispatcher {
		
		private var _base : FlowBrowser;
		
		private var _cellPosLogicRange : Rectangle;
		private var _showRangeLogicRange : Rectangle;
		
		private var _cellWidth : int;
		private var _cellHeight : int;
		private var _cache : int;
		
		private var _baseX : int;
		private var _baseY : int;
		
		public function FlowCamera(showPixelWidth : int, showPixelHeight : int, cellWidth : int, cellHeight : int, cache : int) {
			_cellWidth = cellWidth;
			_cellHeight = cellHeight;
			_cache = cache;
			
			_baseX = 0;
			_baseY = 0;
			
			buildShowRange(showPixelWidth, showPixelHeight);
			buildCellPosLogicRange();
		}
		
		private function buildShowRange(showPixelWidth : int, showPixelHeight : int) : void {
			var showRangeLogicWidth : int = Math.ceil(showPixelWidth / _cellWidth);
			var showRangeLogicHeight : int = Math.ceil(showPixelHeight / _cellHeight);
			_showRangeLogicRange = new Rectangle(0, 0, showRangeLogicWidth, showRangeLogicHeight);
		}
		
		private function buildCellPosLogicRange() : void {
			var totalLogicWidth : int = _showRangeLogicRange.width + _cache*2;
			var totalLogicHeight : int = _showRangeLogicRange.height + _cache*2;
			_cellPosLogicRange = new Rectangle(-_cache, -_cache, totalLogicWidth, totalLogicHeight);
		}
		
		public function regester(base : FlowBrowser) : void {
			_base = base;
			_base.addEventListener(Event.CHANGE, onPositionChange);
		}

		private function offsetCamera(dx : Number, dy : Number) : void {
			_cellPosLogicRange.offset(dx, dy);
			_showRangeLogicRange.offset(dx, dy);
		}
		
		private function onPositionChange(event : Event) : void {
			leftAndRightSideLimitTest();
			upAndDownSideLimitTest();
		}
		 
		 private function leftAndRightSideLimitTest() : void {
			var limit : int = _cellPosLogicRange.left * _cellWidth;
			var absX : int = (_base.x - _baseX)- _cache * _cellWidth;
			
			var crossRightLine : Boolean = absX > limit;
			var crossLeftLine : Boolean = absX < limit;
			
			if(crossRightLine) {
				offsetCamera(-1, 0);
				_baseX += 2*_cellWidth;
				dispatchEvent(new FlowEvent(FlowEvent.GOTO_LEFT));
			} else if(crossLeftLine) {
				offsetCamera(1, 0);
				_baseX += -2*_cellWidth;
				dispatchEvent(new FlowEvent(FlowEvent.GOTO_RIGHT));
			}
		}
		
		private function upAndDownSideLimitTest() : void {
			var limit : int = _cellPosLogicRange.top * _cellHeight;
			var absY : int = (_base.y - _baseY)  - _cache * _cellHeight;
			
			var crossTopLine : Boolean = absY < limit;
			var crossBottomLine : Boolean = absY > limit;
			
			if(crossTopLine) {
				offsetCamera(0, 1);
				_baseY += -2*_cellHeight;
				dispatchEvent(new FlowEvent(FlowEvent.GOTO_BOTTOM));
			} else if (crossBottomLine) {
				offsetCamera(0, -1);
				_baseY += 2*_cellHeight;
				dispatchEvent(new FlowEvent(FlowEvent.GOTO_TOP));
			}
		}
		
		public function get cellWidth() : int {
			return _cellWidth;
		}
		
		public function get cellHeight() : int {
			return _cellHeight;
		}
		
		public function get cache() : int {
			return _cache;
		}
		
		public function get cellPosLogicRange() : Rectangle {
			return _cellPosLogicRange;
		}
		
		public function get showRangeLogicRange() : Rectangle {
			return _showRangeLogicRange;
		}
	}
}
