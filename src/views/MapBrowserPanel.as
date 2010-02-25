package views{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.containers.Panel;
	import mx.core.UIComponent;
	import mx.events.ScrollEvent;
  
	
	public class MapBrowserPanel extends Panel {
		
		public var _resourceBitmap : Bitmap;
	    private var _showRangeBitmap : Bitmap;
	    private var uc : UIComponent;
	    privatre var a : ResSelector;
	    private static const DEFAULT_POINT : Point = new Point(0,0);
		
		public function MapBrowserPanel() {
			uc = new UIComponent();
			addChild(uc);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(ScrollEvent.SCROLL, scrollMove);
		}
        
        public function set resourceBitmap(value : Bitmap) : void {
        	_resourceBitmap = value;
        	uc.width = _resourceBitmap.width;
			uc.height = _resourceBitmap.height;   
			browserResize();
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
							this.horizontalScrollPosition, 
							this.verticalScrollPosition, 
							this.width, this.height);
			_showRangeBitmap.bitmapData.copyPixels(_resourceBitmap.bitmapData, rect, DEFAULT_POINT);
			_showRangeBitmap.x = this.horizontalScrollPosition;
			_showRangeBitmap.y = this.verticalScrollPosition;
		}
			
		private function drawLine(fromX : int = 0, fromY : int = 0) : void {
			var lineColor : uint = 0xaaffbb;
//				version 1
//				for(var x : int = 0; x < this.width; x++) {
//					for(var y : int = 0; y < this.height; y++) {
//						if(x % 32 == 0 || y % 32 == 0) {
//							showRange.bitmapData.setPixel(x, y, 0xffffbb);
//						}
//					}
//				}
//				version 2
//				for(var x : int = 0; x < this.width; x+=32) {
//					for(var y : int = 0; y < this.height; y++) {
//						showRange.bitmapData.setPixel(x, y, 0xffffbb);
//					}
//				}
//				for(y = 0; y < this.height; y+=32) {
//					for(x = 0; x < this.width; x++) {
//						showRange.bitmapData.setPixel(x, y, 0xffffbb);
//					}
//				}
//				version 3
			var frameWidth : int = 64;
			var frameHeight : int = 32;
			fromX = frameWidth - this.horizontalScrollPosition % frameWidth;
			fromY = frameHeight - this.verticalScrollPosition % frameHeight;
			for(var y : int = fromY; y < this.height; y+=frameHeight) {
				_showRangeBitmap.bitmapData.fillRect(new Rectangle(0, y, this.width, 1), lineColor);
			}
			for(var x : int = fromX; x < this.width; x+=frameWidth) {
				_showRangeBitmap.bitmapData.fillRect(new Rectangle(x, 0, 1, this.height), lineColor);
			}
		}
		
		private function onMouseDown(event : MouseEvent) : void {
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}	
				
		private function onMouseMove(event : MouseEvent) : void {
			if(_showRangeBitmap == null) return;
			var localPos : Point = new Point(event.localX - _showRangeBitmap.x, event.localY - _showRangeBitmap.y);
			fromLogicX = localPos.x / cellWidth;
			fromLogicY = localPos.y / cellHeight;
//TODO				mappos.text = "("+logicX+","+logicY+")";
			drawFocuss();
		}
		
		private function onMouseUp(event : MouseEvent) : void {
			removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private var cellWidth : int = 32; 
		private var cellHeight : int = 32; 
		private var fromLogicX : int;
		private var fromLogicY : int;
		private var toLogicX : int;
		private var toLogicY : int;
		private function drawFocuss() : void {
			var focusColor : uint = 0xaaffbb;
			var fromX : int = fromLogicX * cellWidth;
			var fromY : int = fromLogicY * cellHeight;
			var focusWidth : int = 3;
			_showRangeBitmap.bitmapData.fillRect(new Rectangle(fromX, fromY, cellWidth, focusWidth), focusColor);
			_showRangeBitmap.bitmapData.fillRect(new Rectangle(fromX, fromY, focusWidth, cellHeight), focusColor);
			_showRangeBitmap.bitmapData.fillRect(new Rectangle(fromX + cellWidth - focusWidth, fromY, focusWidth, cellHeight), focusColor);
			_showRangeBitmap.bitmapData.fillRect(new Rectangle(fromX, fromY + cellHeight - focusWidth, cellWidth, focusWidth), focusColor);
		}
		
		private function scrollMove(event : Event) : void {
//TODO				topleftpos.text = "("+this.horizontalScrollPosition + 
//					"," + this.verticalScrollPosition+")";
			copyPixel();
			drawLine();
		}
	}
}
