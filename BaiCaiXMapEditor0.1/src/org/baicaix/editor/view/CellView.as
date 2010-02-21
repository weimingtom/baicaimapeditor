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
package org.baicaix.editor.view {
	import org.baicaix.editor.Cell;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author dengyang
	 */
	public class CellView extends Sprite {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _cell : Cell;
		/**
		 * 用于贴资源的画布
		 */
		private var _canvas : Bitmap;
		/**
		 * 显示选取格子的层
		 */
		private var _focusLayer : Shape;
		/**
		 * 显示 type 的层
		 */
		private var _typeLayer : Shape;
		
		private var _lineLayer : Shape;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const COPY_RIM_COLOR : uint = 0x0000FF;		
		public static const FOCUS_RIM_COLOR : uint = 0xFF0000;
		public static const FOCUS_RIM_LENGTH : uint = 2;
		
		public static const TILE_TYPE_COLOR : Array = [
			0x11, 0xFF0000, 0x0011, 0x000011, 0x111100, 0x001111 
		]; 
		
		public static const LINE_RIM_COLOR : uint = 0x00FF00;
		private static const DEFAULT_DEST_POINT : Point = new Point(0, 0);

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function CellView(cell : Cell, width : uint = 32, height : uint = 32) {
			this._cell = cell;
			this._canvas = Bitmap(this.addChild(new Bitmap()));
			this._typeLayer = Shape(this.addChild(new Shape()));
			this._lineLayer = Shape(this.addChild(new Shape()));
			this._focusLayer = Shape(this.addChild(new Shape()));
			this._canvas.bitmapData = new BitmapData(width, height);
			//从创建的时候就已经画好了TileType
			this.drawTileType();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function draw(x : Number, y : Number, width : Number, height : Number, color : int) : void {
			with(_focusLayer) {
				graphics.beginFill(color);
				graphics.drawRect(x, y, width, height);
				graphics.endFill();
			}
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function get cell() : Cell {
			return this._cell;
		}
		
		public function get canvas() : Bitmap {
			return this._canvas;
		}
		
		/**
		 * 画选取上边框
		 */
		public function drawTopRim(color : int = FOCUS_RIM_COLOR) : void {
			draw(0, 0, this._canvas.width, FOCUS_RIM_LENGTH, color);
		}
		
		/**
		 * 画选取下边框
		 */
		public function drawBottomRim(color : int = FOCUS_RIM_COLOR) : void {
			draw(0, this._canvas.height - FOCUS_RIM_LENGTH, this._canvas.width, FOCUS_RIM_LENGTH, color);
		}
		
		/**
		 * 画选取左边框
		 */
		public function drawLeftRim(color : int = FOCUS_RIM_COLOR) : void {
			draw(0, 0, FOCUS_RIM_LENGTH, this._canvas.height, color);
		}
		
		/**
		 * 画选取右边框
		 */
		public function drawRightRim(color : int = FOCUS_RIM_COLOR) : void {
			draw(this._canvas.width - FOCUS_RIM_LENGTH, 0, FOCUS_RIM_LENGTH, this._canvas.height, color);
		}
		
		/**
		 * 清除线框
		 */
		public function clearRim() : void {
			_focusLayer.graphics.clear();
		}
		
		/**
		 * 
		 * 拷贝一份画布上的信息
		 */
		public function copyCanvas() : BitmapData {
			return this._canvas.bitmapData != null ? this._canvas.bitmapData.clone() : null;
		}

		/**
		 * 拷贝一份画布上的BitmapData
		 * 
		 * @param sourceBitmapData    画到画布上的图片
		 */
		public function drawCanvas(sourceBitmapData : BitmapData, rectangle : Rectangle) : void {
			this._canvas.bitmapData = new BitmapData(rectangle.width, rectangle.height);
			this._canvas.bitmapData.copyPixels(sourceBitmapData, rectangle, DEFAULT_DEST_POINT);
		}
		
		/**
		 * 粘贴单元格信息
		 * @param sourceBitmapData    画到画布上的图片
		 */
		public function paste(srcCell : Cell) : void {
			this._canvas.bitmapData = srcCell.copyCanvas();
			this.drawTileType();
		}

		/**
		 * 显示当前单元格类型
		 * 
		 * @param type    type
		 */
		public function drawTileType() : void {
			//FIXME 此处可能异常
			var color : int = TILE_TYPE_COLOR[_cell.tile.type];
			var width : int = this._canvas.width - 1;
			var height : int = this._canvas.height - 1;
			with(_typeLayer.graphics) {
				clear();
				beginFill(color, .5);
				drawRect(0, 0, width, height);
				endFill();
			}
		}
		
		public function set showTileType(show : Boolean) : void {
			_typeLayer.visible = show;
		}

		/**
		 * 画线框
		 */
		public function drawLine() : void {
			var toLineY : int = this._canvas.width - 1;
			var toLineX : int = this._canvas.height - 1;
			with(this._lineLayer.graphics) {
				lineStyle(1, LINE_RIM_COLOR);
//				moveTo(0, 0);
//				lineTo(0, toLineY);
				moveTo(0, toLineY);
				lineTo(toLineX, toLineY);
				lineTo(toLineX, 0);
//				lineTo(0, 0);
			}
		}
		
		public function clear() : void {
			_canvas.bitmapData = null;
		}
	}
}
