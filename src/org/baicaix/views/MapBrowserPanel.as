package org.baicaix.views {
	import org.baicaix.single.MapSelector;

	import mx.core.UIComponent;
	import mx.events.ScrollEvent;

	import flash.events.Event;
	import flash.geom.Rectangle;

	public class MapBrowserPanel extends AbsBrowserPanel {
		
		public function MapBrowserPanel() {
			_totalRange = new UIComponent();
			addChild(_totalRange);
			Selector = MapSelector;
			//only for test
			_copyRange = new Rectangle(0, 0, 2, 3);
			addEventListener(ScrollEvent.SCROLL, scrollMove);
		}
		
		override public function copyPixel() : void {
			var rect : Rectangle = new Rectangle(
							horizontalScrollPosition, 
							verticalScrollPosition, 
							width, height);
			trace(rect);
//			_showRangeBitmap.bitmapData.copyPixels(_resourceBitmap.bitmapData, rect, DEFAULT_POINT);
			_browser.x = horizontalScrollPosition;
			_browser.y = verticalScrollPosition;
		}
		
		private function scrollMove(event : Event) : void {
			copyPixel();
		}
	}
}
