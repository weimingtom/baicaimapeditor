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
		private var _tiles : Array; 
		
		private var cellWidth : int;
		private var cellHeight : int;
		
		public var x : int;
		public var y : int;
		private var _logicX : int;
		private var _logicY : int;
		
		private var _resourceLoader : ResourceImgLoader;
		
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
			redrawResource();
		}
		
		private function registerPosition() : void {
			_tiles = _browser.position.register(this, _logicX, _logicY);
		}

		public function redrawResource() : void {
			if(_canvasLayer == null) return;
			//clear
//			_canvasLayer.setPixel32(x, y, color);
			//copy
			for each (var tile : MapTile in _tiles) {
				var res : BitmapData = _resourceLoader.load(tile.src, tile.srcX, tile.srcY);
				_canvasLayer.bitmapData.copyPixels(res, 
					new Rectangle(0, 0, cellWidth, cellHeight), 
					new Point(_logicX * cellWidth, _logicY * cellHeight));
			}
		}
		
		public function drawTopRim(color : uint = FOCUS_RIM_COLOR) : void {
			drawRect(_focusLayer, 0, 0, cellWidth, FOCUS_RIM_LENGTH, color);
		}
		
		public function drawBottomRim(color : uint = FOCUS_RIM_COLOR) : void {
			drawRect(_focusLayer, 0, cellHeight - FOCUS_RIM_LENGTH, cellWidth, FOCUS_RIM_LENGTH, color);
		}
		
		public function drawLeftRim(color : uint = FOCUS_RIM_COLOR) : void {
			drawRect(_focusLayer, 0, 0, FOCUS_RIM_LENGTH, cellHeight, color);
		}
		
		public function drawRightRim(color : uint = FOCUS_RIM_COLOR) : void {
			drawRect(_focusLayer, cellWidth - FOCUS_RIM_LENGTH, 0, FOCUS_RIM_LENGTH, cellHeight, color);
		}
		
		private function drawRect(layer : Bitmap, x : int, y : int, width : int, height : int, color : uint) : void {
			for (var offsetX : int = x; offsetX < x + width; offsetX++) {
				for (var offsetY : int = y; offsetY < y + height; offsetY++) {
					layer.bitmapData.setPixel32(this.x + offsetX, this.y + offsetY, color);
				}
			}
		}
		
		public function clearRim() : void {
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
		
		public function drawType() : void {
			if(_tiles[0].type == MapTile.DEFAULT_TILE_TYPE) return;
			for (var x : int = 0; x < cellWidth; x++) {
				for (var y : int = 0; y < cellHeight;y++) {
					_typeLayer.bitmapData.setPixel32(this.x + x, this.y + y, TILE_TYPE_COLOR[_tiles[0].type]);
				}
			}
		}
		
		public function clearType() : void {
			var touming : uint = 0x00000000;
			if(_typeLayer.bitmapData.getPixel32(this.x, this.y) == touming) return;
			for (var x : int = 0; x < cellWidth; x++) {
				for (var y : int = 0; y < cellHeight;y++) {
					_typeLayer.bitmapData.setPixel32(this.x + x, this.y + y, touming);
				}
			}
		}
	}
}
