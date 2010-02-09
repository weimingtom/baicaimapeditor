/**
 * @file FlowBrowser.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-28
 * @updatedate 2010-1-28
 */   
package org.baicaix.flow.display {
	import org.baicaix.flow.FlowEditor;
	import org.baicaix.flow.FlowPosition;
	import org.baicaix.flow.events.FlowCellEvent;
	import org.baicaix.flow.events.FlowEvent;
	import org.baicaix.flow.resouece.ResourceImgLoader;
	import org.baicaix.map.MapLayer;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author dengyang
	 */
	public class FlowBrowser extends Sprite {
		
		//TODO 将来使用ioc来代替这种做法
		private var Selector : Class;
		private var _layer : MapLayer;
		private var _position : FlowPosition;
		
		private var resourceLoader : ResourceImgLoader;
		
		private var _editor : FlowEditor;
		private var camera : FlowCamera;
		
		private var colRow : FlowColRow;
		
		public function FlowBrowser(camera : FlowCamera, actualSize : Point, loader : ResourceImgLoader, Selector : Class) {
			
			this.Selector = Selector;
			this.resourceLoader = loader;
			
			this.camera = camera;
			this.camera.regester(this);
			initEvent();
			
			colRow = new FlowColRow(camera.cellPosLogicRange.width, camera.cellPosLogicRange.height);
			createDemoLayer();
			drawActualRange(actualSize);
			createCellsBySize();
		}
		
		private function createDemoLayer() : void {
			var layer : MapLayer = new MapLayer();
			layer.initTiles(0, 16, 16);
			this.showLayer(layer);
		}

		private function drawActualRange(actualSize : Point) : void {
			this.graphics.lineStyle(0x00);
			this.graphics.lineTo(actualSize.x * camera.cellWidth, actualSize.y * camera.cellHeight);
			this.graphics.endFill();
		}
		
		private function initEvent() : void {
			camera.addEventListener(FlowEvent.GOTO_TOP, gotoTop);
			camera.addEventListener(FlowEvent.GOTO_BOTTOM, gotoBottom);
			camera.addEventListener(FlowEvent.GOTO_LEFT, gotoLeft);
			camera.addEventListener(FlowEvent.GOTO_RIGHT, gotoRight);
			addEventListener(FlowCellEvent.RELOAD_CELL, reloadCell);
		}
		
		private function createCellsBySize() : void {
			//多_cache个单元格缓冲,但目前只有右边和下边
			for (var x : int = 0; x < camera.cellPosLogicRange.width;x++) {
				for (var y : int = 0; y < camera.cellPosLogicRange.height;y++) {
					createCell(x, y);
				}
			}
		}
		
		private function createCell(x : int, y : int) : void {
			var cell : FlowCell = new FlowCell(this, x-camera.cache, y-camera.cache, 
										camera.cellWidth, camera.cellHeight, resourceLoader);
			addChild(cell);
			colRow.addCell(x, y, cell);
		}

		private function gotoTop(event : FlowEvent) : void {
			var topRow : Array = colRow.bottomRowGotoTop();
			for each (var cell : FlowCell in topRow) {
				cell.setCellPosition(cell.x / camera.cellWidth, camera.cellPosLogicRange.top);
			}
		}
		
		private function gotoBottom(event : FlowEvent) : void {
			var bottomRow : Array = colRow.topRowGotoBottom();
			for each (var cell : FlowCell in bottomRow) {
				cell.setCellPosition(cell.x / camera.cellWidth, camera.cellPosLogicRange.bottom - 1);
			}
		}
		
		private function gotoLeft(event : FlowEvent) : void {
			var leftCol : Array = colRow.rightColGotoLeft();
			for each (var cell : FlowCell in leftCol) {
				cell.setCellPosition(camera.cellPosLogicRange.left, cell.y / camera.cellHeight);
			}
		}
		
		private function gotoRight(event : FlowEvent) : void {
			var rightCol : Array = colRow.leftColGotoRight();
			for each (var cell : FlowCell in rightCol) {
				cell.setCellPosition(camera.cellPosLogicRange.right - 1, cell.y / camera.cellHeight);
			}
		}
		
		public function register(editor :FlowEditor) : void {
			this._editor = editor;
			this._editor.addEventListener(FlowCellEvent.RELOAD_CELL, reloadCell);
			this._editor.addEventListener(FlowCellEvent.DRAW_LINE, drawLine);
			this._editor.addEventListener(FlowCellEvent.DRAW_TYPE, drawType);
			new Selector(this);
		}

		public function showLayer(layer : MapLayer) : void {
			//更新layer和pos
			this._layer = layer;
			this._position = new FlowPosition(_layer);
			//根据camera更新cell的tile
			loopAllCell(function(cell : FlowCell) : void {
				cell.reload();
			});
			//重新加载新的层内容
			dispatchEvent(new FlowCellEvent(FlowCellEvent.RELOAD_CELL, {}));
		}
		
		public function reloadCell(event : FlowCellEvent) : void {
//			var range : Rectangle = event.data["range"];
			//TODO 实现区域加载
			//TODO rim 应该跟 tile 分离
//			if(range == null) {
				loopAllCell(function(cell : FlowCell) : void {
					cell.redrawResource();
					cell.drawType();
				});
//			}
		}

		private function loopAllCell(func : Function) : void {
			for each (var row : Array in colRow.getRows()) {
				for each (var cell : FlowCell in row) {
					func(cell);
				}
			}
		}
		
		public function drawRim(event : FlowCellEvent) : void {
			var range : Rectangle = event.data["range"];
			var cellsInRange : Array = _position.getCellsByRange(range);
			for each (var cell : FlowCell in cellsInRange) {
				cell.drawRim();
			}
		}
		
		public function drawLine(event : FlowCellEvent) : void {
			var drawLine : Boolean = event.data["drawLine"];
			loopAllCell(function(cell : FlowCell) : void {
				if(drawLine) {
					cell.drawLine();
				} else {
					cell.clearLine();
				}
			});
		}
		
		public function drawType(event : FlowCellEvent) : void {
			var drawLine : Boolean = event.data["drawType"];
			loopAllCell(function(cell : FlowCell) : void {
				if(drawLine) {
					cell.drawType();
				} else {
					cell.clearType();
				}
			});
		}

		override public function set x(value : Number) : void {
			super.x = value;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		override public function set y(value : Number) : void {
			super.y = value;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function resize(pixelWidth : int, pixelHeight : int) : void {
			//TODO 实现
		}
		
		public function get layer() : MapLayer {
			return _layer;
		}

		public function get position() : FlowPosition {
			return _position;
		}
		
		public function get editor() : FlowEditor {
			return _editor;
		}

		public function get cellWidth() : int {
			return camera.cellWidth;
		}
		
		public function get cellHeight() : int {
			return camera.cellHeight;
		}
	}
}
