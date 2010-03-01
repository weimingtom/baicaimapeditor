package org.baicaix.views {
	import org.baicaix.events.RangeEvent;
	import org.baicaix.events.EditEvent;

	import org.baicaix.controls.MapSelector;
	import org.baicaix.controls.AbsSelector;
	import org.baicaix.utils.OffsetUtil;

	import mx.containers.Panel;
	import mx.core.UIComponent;
	import mx.events.ScrollEvent;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class MapBrowserPanel extends Panel {
		
		public var copyRange : Rectangle;
		
		private var _resourceBitmap : Bitmap;
	    private var _showRangeBitmap : Bitmap;
	    protected var selector : AbsSelector;
	    protected var _offsetUtil : OffsetUtil;
	    protected var uc : UIComponent;
	    private static const DEFAULT_POINT : Point = new Point(0,0);
		
		public function MapBrowserPanel() {
			uc = new UIComponent();
			addChild(uc);
			
			//only for test
			copyRange = new Rectangle(0, 0, 2, 3);
			_offsetUtil = new OffsetUtil(this);
			addEventListener(ScrollEvent.SCROLL, scrollMove);
		}

		public function set resourceBitmap(value : Bitmap) : void {
        	_resourceBitmap = value;
        	uc.width = _resourceBitmap.width;
			uc.height = _resourceBitmap.height; 
			
			initSelector();
			
			browserResize();
		}

		protected function initSelector() : void {
			if(selector != null) {
				selector.removeEventListener(RangeEvent.CLEAR_RANGE, clearRange);
				selector.removeEventListener(RangeEvent.FOCUS_RANGE, focusRange);
			}
			selector = new MapSelector(this, _offsetUtil);
			selector.addEventListener(RangeEvent.CLEAR_RANGE, clearRange);
			selector.addEventListener(RangeEvent.FOCUS_RANGE, focusRange);
			selector.addEventListener(EditEvent.PASTE_START, pasteStart);
			selector.addEventListener(EditEvent.PASTE_END, pasteEnd);
		}
		
		public function get showRangeBitmap() : Bitmap {
        	return _showRangeBitmap;
        }
        
        private function browserResize() : void {
			if(uc == null || _resourceBitmap == null ) return;
			if(_showRangeBitmap != null) {
				uc.removeChild(_showRangeBitmap);
			}
			_showRangeBitmap = new Bitmap(new BitmapData(width, height));
			uc.addChild(_showRangeBitmap);  
			copyPixel();
		}
        
		public function copyPixel() : void {
//				m = new Matrix(1, 0, 0, 1, d.pos.x - p.pos.x, d.pos.y - p.pos.y);
//				r = new Rectangle(d.pos.x, d.pos.y, data.widthTile, data.heightTile);
//				dataCase.draw(p.source, m, null, null, r);
//				showRange.bitmapData.draw(map.bitmapData, new Matrix
			var rect : Rectangle = new Rectangle(
							horizontalScrollPosition, 
							verticalScrollPosition, 
							width, height);
			_showRangeBitmap.bitmapData.copyPixels(_resourceBitmap.bitmapData, rect, DEFAULT_POINT);
			_showRangeBitmap.x = horizontalScrollPosition;
			_showRangeBitmap.y = verticalScrollPosition;
		}
			
		private function drawLine() : void {
			var lineColor : uint = 0x00ffbb;
			var frameWidth : int = 64;
			var frameHeight : int = 32;
			var fromPoint : Point = _offsetUtil.getPixelOffset();
			for(var y : int = fromPoint.y; y < height; y+=frameHeight) {
				_showRangeBitmap.bitmapData.fillRect(new Rectangle(0, y, width, 1), lineColor);
			}
			for(var x : int = fromPoint.x; x < width; x+=frameWidth) {
				_showRangeBitmap.bitmapData.fillRect(new Rectangle(x, 0, 1, height), lineColor);
			}
		}
		
		private var focusWidth : int = 3;
		private var focusColor : uint = 0xFFFF9900;
		
		protected function clearRange(event : RangeEvent) : void {
			var cellRange : Rectangle = event.range;
			var pastePixelRange : Rectangle = _offsetUtil.cellRangeConvertToPixelRange(cellRange);
			var copyPixelRange : Rectangle = _offsetUtil.cellRangeConvertToAbsPixelRange(cellRange);
			
			with(_showRangeBitmap.bitmapData) {
				var src : BitmapData = _resourceBitmap.bitmapData;
				//top;
				var copyRange : Rectangle = new Rectangle(copyPixelRange.x, copyPixelRange.y, copyPixelRange.width, focusWidth);
				var pastePos : Point = new Point(pastePixelRange.x, pastePixelRange.y);
				copyPixels(src, copyRange, pastePos);
				//left
				copyRange = new Rectangle(copyPixelRange.x, copyPixelRange.y, focusWidth, copyPixelRange.height);
				pastePos = new Point(pastePixelRange.x, pastePixelRange.y);
				copyPixels(src, copyRange, pastePos);
				//right
				copyRange = new Rectangle(copyPixelRange.x + copyPixelRange.width - focusWidth, copyPixelRange.y, focusWidth, copyPixelRange.height);
				pastePos = new Point(pastePixelRange.right - focusWidth, pastePixelRange.top);
				copyPixels(src, copyRange, pastePos);
				//bottom
				copyRange = new Rectangle(copyPixelRange.x, copyPixelRange.y + copyPixelRange.height - focusWidth, copyPixelRange.width, focusWidth);
				pastePos = new Point(pastePixelRange.left, pastePixelRange.bottom - focusWidth);
				copyPixels(src, copyRange, pastePos);
			}
		}

		private function pasteStart(event : EditEvent) : void {
			
		}

		private function pasteEnd(event : EditEvent) : void {
			
		}

		protected function focusRange(event : RangeEvent) : void {
			var cellRange : Rectangle = event.range;
			var pixelRange : Rectangle = _offsetUtil.cellRangeConvertToPixelRange(cellRange);
			
			with(_showRangeBitmap.bitmapData) {
				fillRect(new Rectangle(pixelRange.x, pixelRange.y, pixelRange.width, focusWidth), focusColor);
				fillRect(new Rectangle(pixelRange.x, pixelRange.y, focusWidth, pixelRange.height), focusColor);
				fillRect(new Rectangle(pixelRange.x + pixelRange.width - focusWidth, pixelRange.y, focusWidth, pixelRange.height), focusColor);
				fillRect(new Rectangle(pixelRange.x, pixelRange.y + pixelRange.height - focusWidth, pixelRange.width, focusWidth), focusColor);
			}
			
			dispatchEvent(new RangeEvent(RangeEvent.RANGE_POS_CHANGE, event.range));
		}
		
		private function scrollMove(event : Event) : void {
			copyPixel();
			drawLine();
		}
	}
}
