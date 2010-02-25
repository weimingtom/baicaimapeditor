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
package org.baicaix.single.display {
	import org.baicaix.map.Map;
	import org.baicaix.map.MapLayer;
	import org.baicaix.single.EditMapManager;
	import org.baicaix.single.FlowEditor;
	import org.baicaix.single.FlowPosition;
	import org.baicaix.single.events.FlowCellEvent;
	import org.baicaix.single.events.FlowEvent;
	import org.baicaix.single.events.LayerEvent;
	import org.baicaix.single.resource.ResourceImgLoader;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author dengyang
	 */
	public class FlowBrowser extends Sprite {
		
		//TODO 将来使用ioc来代替这种做法
		private var Selector : Class;
		private var _activtyMap : Map;
		private var _position : FlowPosition;
		
		private var resourceLoader : ResourceImgLoader;
		
		private var _editor : FlowEditor;
		private var camera : FlowCamera;
		
		private var _mapMnger : EditMapManager;
		
		private var colRow : FlowColRow;
		private var _lineLayer : Bitmap;
		private var _typeLayer : Bitmap;
		private var _canvasLayer : Bitmap;
		private var _focusLayer : Bitmap;
		
		public function FlowBrowser(camera : FlowCamera, actualSize : Point, loader : ResourceImgLoader, Selector : Class) {
			
			this.Selector = Selector;
			this.resourceLoader = loader;
			
			this.camera = camera;
			this.camera.regester(this);
			initEvent();
			
			_canvasLayer = Bitmap(this.addChild(new Bitmap()));
			_typeLayer = Bitmap(this.addChild(new Bitmap()));
			_lineLayer = Bitmap(this.addChild(new Bitmap()));
			_focusLayer = Bitmap(this.addChild(new Bitmap()));
			
			colRow = new FlowColRow(camera.cellPosLogicRange.width, camera.cellPosLogicRange.height);
			
			//TODO IOC
			_mapMnger = new EditMapManager();
			_mapMnger.addEventListener(LayerEvent.LAYER_SELECT, onSelectLayer);
			
			createDemoLayer();
			drawActualRange(actualSize);
			createCellsBySize();
		}
		
		private var _activityLayer : MapLayer;
		private function onSelectLayer(event : LayerEvent) : void {
			_activityLayer = event.data["layer"];
			//TODO 操作改为操作此layer
			//不重绘 不用程序选择
		}
		
		private function createDemoLayer() : void {
			var map : Map = new Map();
			var layer : MapLayer = map.createTemptyLayer(0);
			layer.initTiles(0, 16, 16);
			this.loadMap(map);
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
			addEventListener(FlowCellEvent.RELOAD_CELL, redrawCell);
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
			cell.setCanvas(_canvasLayer, _typeLayer, _focusLayer);
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
			this._editor.addEventListener(FlowCellEvent.RELOAD_CELL, redrawCell);
			this._editor.addEventListener(FlowCellEvent.REFRESH_CELL, refresh);
			this._editor.addEventListener(FlowCellEvent.DRAW_LINE, drawLine);
			this._editor.addEventListener(FlowCellEvent.DRAW_TYPE, drawType);
			var selector : EventDispatcher = new Selector(this);
			selector.addEventListener(FlowCellEvent.OVER_CELL, _editor.onOverCell);
		}

		public function loadMap(map : Map) : void {
			//更新layer和pos
			this._activtyMap = map;
			this._position = new FlowPosition(_activtyMap);
			
			_mapMnger.loadMap(map);
			
			var canvaWidth : int = map.width * 32;
			var convaHeight : int = map.height * 32;
			
			_typeLayer.bitmapData = new BitmapData(canvaWidth, convaHeight, true, 0x00000000);
			_canvasLayer.bitmapData = new BitmapData(canvaWidth, convaHeight, true, 0x00000000);
			_lineLayer.bitmapData = new BitmapData(canvaWidth, convaHeight, true, 0x00000000);
			_focusLayer.bitmapData = new BitmapData(canvaWidth, convaHeight, true, 0x00000000);
			
			//根据camera更新cell的tile
			loopAllCell(function(cell : FlowCell) : void {
				cell.reload();
			});
			//重新加载新的层内容
			dispatchEvent(new FlowCellEvent(FlowCellEvent.RELOAD_CELL, {}));
		}
		
		public function refresh(event : FlowCellEvent) : void {
			_mapMnger.refresh();
			redrawCell(event);
		}
		
		public function redrawCell(event : FlowCellEvent) : void {
			var range : Rectangle = event.data["range"];
			if(range == null) {
				loopAllCell(redraw);
			} else {
				reloadCellInRange(range, redraw);
			}
			function redraw(cell : FlowCell) : void {
				cell.redrawResource();
				if(_isDrawType) {
					cell.drawType();
				}
			}
		}
		private function reloadCellInRange(range : Rectangle, callback : Function) : void {
			var cellsInRange : Array = _position.getCellsByRange(range);
			for each (var cell : FlowCell in cellsInRange) {
				callback(cell);
			}
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
			rimAction2Range(range, 
					function(cell : FlowCell) : void {cell.drawTopRim();},
					function(cell : FlowCell) : void {cell.drawBottomRim();},
					function(cell : FlowCell) : void {cell.drawLeftRim();},
					function(cell : FlowCell) : void {cell.drawRightRim();});
		}
		
		public function clearRim(event : FlowCellEvent) : void {
			var range : Rectangle = event.data["range"];
			rimAction2Range(range, clear, clear, clear, clear);
			function clear(cell : FlowCell) : void {
				cell.clearRim();
			}
		}
		
		private function rimAction2Range(range : Rectangle, topFunc : Function, 
				bottomFunc : Function, leftFunc : Function, rightFunc : Function) : void {
			var cellsInRange : Array = _position.getCellsByRange(range);
			for each (var cell : FlowCell in cellsInRange) {
				//边框的cell的选择移动到此处
				if(cell.logicY == range.top) {
					topFunc(cell);
				}
				if(cell.logicY == range.bottom) {
					bottomFunc(cell);
				}
				if(cell.logicX == range.left) {
					leftFunc(cell);
				}
				if(cell.logicX == range.right) {
					rightFunc(cell);
				}
			}
		}
		
		public function drawLine(event : FlowCellEvent) : void {
			var drawLine : Boolean = event.data["drawLine"];
			if(drawLine) {
				for (var x : int = 0; x < _lineLayer.bitmapData.width; x += cellWidth) {
					for (var y : int = 0; y < _lineLayer.bitmapData.height; y++) {
						_lineLayer.bitmapData.setPixel32(x, y, 0xff43CD80);
					}
				}
				for (y = 0; y < _lineLayer.bitmapData.height; y += cellHeight) {
					for (x = 0; x < _lineLayer.bitmapData.width; x++) {
						_lineLayer.bitmapData.setPixel32(x, y, 0xff43CD80);
					}
				}
			} else {
				for (x = 0; x < _lineLayer.bitmapData.width; x += cellWidth) {
					for (y = 0; y < _lineLayer.bitmapData.height; y++) {
						_lineLayer.bitmapData.setPixel32(x, y, 0x0043CD80);
					}
				}
				for (y = 0; y < _lineLayer.bitmapData.height; y += cellHeight) {
					for (x = 0; x < _lineLayer.bitmapData.width; x++) {
						_lineLayer.bitmapData.setPixel32(x, y, 0x0043CD80);
					}
				}
			}
		}
		
		private var _isDrawType : Boolean = true;
		public function drawType(event : FlowCellEvent) : void {
			_isDrawType = event.data["drawType"];
			loopAllCell(function(cell : FlowCell) : void {
				if(_isDrawType) {
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
		
		public function get activityMap() : Map {
			return _activtyMap;
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
		
		public function get focusLayer() : Bitmap {
			return _focusLayer;
		}
	}
}
