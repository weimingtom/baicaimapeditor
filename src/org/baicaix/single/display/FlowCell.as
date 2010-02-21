/**
 * @file CellView.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-26
 * @updatedate 2010-1-26
 */   
package org.baicaix.single.display {
	import org.baicaix.map.MapTile;
	import org.baicaix.single.resource.ResourceImgLoader;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author dengyang
	 */
	public class FlowCell {
		
		public static const TILE_TYPE_COLOR : Array = [
			0x00000000, 0xA6363636, 0xA6B0E2FF, 0xA600688B, 0xA68B0A50, 0xA69400D3 
		];
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _browser : FlowBrowser;
		private var _tile : MapTile; 
		
		private var cellWidth : int;
		private var cellHeight : int;
		
		public var x : int;
		public var y : int;
		private var _logicX : int;
		private var _logicY : int;
		
		private var _resourceLoader : ResourceImgLoader;
//		private var _lastResource : DisplayObject;
		
		private var _typeLayer : Bitmap;
		private var _canvasLayer : Bitmap;
		private var _focusLayer : Bitmap;
		
		//------------------------------------
		// public properties
		//------------------------------------

		public static const FOCUS_RIM_COLOR : uint = 0xFF00BFFF;
		public static const FOCUS_RIM_LENGTH : uint = 2;

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function FlowCell(base : FlowBrowser, logicX : int, logicY : int, cellWidth: int, cellHeight : int, loader : ResourceImgLoader) {
			
			this._browser = base;
			
			this.cellWidth =  cellWidth;
			this.cellHeight = cellHeight;
			
			this._resourceLoader = loader;
			
//			_focusLayer = Shape(addChild(new Shape()));
//			_typeLayer = new Shape();
//			_lineLayer = new Shape();
			setCellPosition(logicX, logicY);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		public function setCellPosition(logicX : int, logicY : int) : void {
			this._logicX = logicX;
			this._logicY = logicY;
			this.x = logicX * cellWidth;
			this.y = logicY * cellHeight;
			reload();
		}
		
		public function setCanvas(canvasLayer : Bitmap, typeLayer : Bitmap, focusLayer : Bitmap) : void {
			_canvasLayer = canvasLayer;
			_typeLayer = typeLayer;
			_focusLayer = focusLayer;
		}
		
		public function reload() : void {
			registerPosition();
//			if(_browser.showType) {
//				drawType();
//			}
			redrawResource();
//			drawRim();
		}
		
		private function registerPosition() : void {
			_tile = _browser.position.register(this, _logicX, _logicY);
		}

		public function redrawResource() : void {
			if(_canvasLayer == null) return;
//			if(_lastResource != null) {
//				this.removeChild(_lastResource);
//				_lastResource = null;
//			}
			//clear
//			_canvasLayer.setPixel32(x, y, color)
			//copy
			var res : BitmapData = _resourceLoader.load(_tile.src, _tile.srcX, _tile.srcY);
			_canvasLayer.bitmapData.copyPixels(res, new Rectangle(0, 0, cellWidth, cellHeight), new Point(_logicX * cellWidth, _logicY * cellHeight));
//			if(showResource != null) {
//				_lastResource = this.addChildAt(showResource, 0);
//			}
		}
		
		private function drawTopRim(color : uint = FOCUS_RIM_COLOR) : void {
			drawRect(_focusLayer, 0, 0, cellWidth, FOCUS_RIM_LENGTH, color);
		}
		
		private function drawBottomRim(color : uint = FOCUS_RIM_COLOR) : void {
			drawRect(_focusLayer, 0, cellHeight - FOCUS_RIM_LENGTH, cellWidth, FOCUS_RIM_LENGTH, color);
		}
		
		private function drawLeftRim(color : uint = FOCUS_RIM_COLOR) : void {
			drawRect(_focusLayer, 0, 0, FOCUS_RIM_LENGTH, cellHeight, color);
		}
		
		private function drawRightRim(color : uint = FOCUS_RIM_COLOR) : void {
			drawRect(_focusLayer, cellWidth - FOCUS_RIM_LENGTH, 0, FOCUS_RIM_LENGTH, cellHeight, color);
		}
		
		private function drawRect(layer : Bitmap, x : int, y : int, width : int, height : int, color : uint) : void {
			for (var offsetX : int = x; offsetX < x + width; offsetX++) {
				for (var offsetY : int = y; offsetY < y + height; offsetY++) {
					layer.bitmapData.setPixel32(this.x + offsetX, this.y + offsetY, color);
				}
			}
		}
		
		private function clearRim() : void {
			for (var offsetX : int = 0;offsetX < cellWidth; offsetX++) {
				for (var offsetY : int = 0; offsetY < cellHeight; offsetY++) {
					_focusLayer.bitmapData.setPixel32(this.x + offsetX, this.y + offsetY, 0x00000000);
				}
			}
		}
		
		// PUBLIC
		//________________________________________________________________________________________________

		public function get logicX() : int {
			return _logicX;
		}
		
		public function get logicY() : int {
			return _logicY;
		}
		
		public function drawRim() : void {
			if(_tile.isRimBySide(MapTile.TOP_RIM)) {
				drawTopRim();
			}
			if(_tile.isRimBySide(MapTile.BOTTOM_RIM)) {
				drawBottomRim();
			}
			if(_tile.isRimBySide(MapTile.LEFT_RIM)) {
				drawLeftRim();
			}
			if(_tile.isRimBySide(MapTile.RIGHT_RIM)) {
				drawRightRim();
			}
			
			if(_tile.rim == MapTile.NONE_RIM) {
				clearRim();
			}
		}
//		
//		public function drawLine() : void {
////			if(!contains(_lineLayer)) {
////				addChild(_lineLayer);
//				_lineLayer.graphics.lineStyle(1, 0x43CD80);
//				_lineLayer.graphics.drawRect(0, 0, cellWidth, cellHeight);
//				_lineLayer.graphics.endFill();
////			}
//		}
		
//		public function clearLine() : void {
//			if(contains(_lineLayer)) {
//				removeChild(_lineLayer);
//			}
//		}
		
		public function drawType() : void {
//			if(!contains(_typeLayer)) {
//				addChild(_typeLayer);
//			}
//			
//			_typeLayer.graphics.clear();
			if(_tile.type == MapTile.DEFAULT_TILE_TYPE) return;
			for (var x : int = 0; x < cellWidth; x++) {
				for (var y : int = 0; y < cellHeight;y++) {
					_typeLayer.bitmapData.setPixel32(this.x + x, this.y + y, TILE_TYPE_COLOR[_tile.type]);
				}
			}
//			drawRect(_typeLayer, 0, 0, cellWidth, cellHeight, TILE_TYPE_COLOR[_tile.type], .7);
		}
//		
		public function clearType() : void {
			for (var x : int = 0; x < cellWidth; x++) {
				for (var y : int = 0; y < cellHeight;y++) {
					_typeLayer.bitmapData.setPixel32(this.x + x, this.y + y, 0x00000000);
				}
			}
		}
	}
}
