///////////////////////////////////////////////////////////
//  Sheet.as
//  Macromedia ActionScript Implementation of the Class Sheet
//  Generated by Enterprise Architect
//  Created on:      22-01-2010 10:41:35
//  Original author: dengyang
///////////////////////////////////////////////////////////

package org.baicaix.editor {
	import org.baicaix.editor.view.SheetView;
	import org.baicaix.map.MapLayer;
	import org.baicaix.map.MapTile;

	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	/**
	 * @author dengyang
	 * @version 1.0
	 * @created 22-01-2010 10:41:35
	 */
	public class Sheet {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		protected 	var _cells : Dictionary;
		
		protected	var _layerData : MapLayer;
		protected	var _view : SheetView;
		protected 	var _editor : Editor;
		
		//only for resource
		private 	var _sourceIndex : int;
		private 	var _selectRange : Range;
		
		private 	var _islock : Boolean;

		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const DEFAULT_SOURC_INDEX : int = 0; 

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Sheet(editor : Editor, layer : MapLayer) {
			this._layerData = layer;
			this._editor = editor;
			this._view = new SheetView(this, _editor);
			this._cells = new Dictionary();
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function createCellByTile(tile : MapTile) : Cell {
			var cell : Cell = new Cell(this, tile);
			this._cells[_layerData.createKey(cell.tile.x, cell.tile.y)] = cell;
			this._view.addChild(cell.view);
			return cell;
		}
		
//		private function getCell(key : String) : Cell {
//			return this._cells[key];
//		}
		
		/**
		 * 如果原有選取區域，清除原有區域邊框
		 */
		private function clearOldRange() : void {
			if(this._selectRange != null) {
				this._selectRange.clearRim();
			}
		}
		
		private function updataSelectRange(range : Rectangle) : void {
			//如果知识更新，那么copy的时候就必须clone
			//所以暂时使用new的方式
//			if(this._selectRange == null) {
				this._selectRange = new Range(this, range);
//			} else {
//				this._selectRange.selectRange(this, range);
//			}
		}
		
		private function updataEditorSelectRange() : void {
			this._editor.selectRange = this._selectRange;
		}
		
		private function focusRange() : void {
			this._selectRange.drawRim();
		}
		
		private function initCells(srcIndex : int, width : int, height : int) : void {
			this._layerData.initTiles(srcIndex, width, height);
			var cell : Cell;
			for each (var tile : MapTile in this._layerData.tiles) {
				cell = createCellByTile(tile);
			}
		}
		
		private function setShowTileType(show : Boolean) : void {
			for each (var cell : Cell in this._cells) {
				cell.showTileType = show;
			}
		}
		
		private function reloadResource() : void {
			for each (var cell : Cell in _cells) {
				cell.drawCanvas(this._editor.loadResource(cell.tile.src));
			}
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function get view() : SheetView {
			return this._view;
		}
		
		public function get editor() : Editor {
			return this._editor;
		}
		
		public function get isLock() : Boolean {
			return this._islock;
		}
		
		public function get isResource() : Boolean {
			return _sourceIndex != DEFAULT_SOURC_INDEX;
		}

		public function lock() : void {
			this._islock = true;
		}

		public function unlock() : void {
			this._islock = false;
		}

		public function hide() : void {
			this._view.visible = false;
		}

		public function show() : void {
			this._view.visible = true;
		}
		
		public function getCellByKey(key : String) : Cell {
			return this._cells[key];
		}
		
		/**
		 * 选取区域
		 */
		public function selectRange(range : Rectangle) : void {
			clearOldRange();
			updataSelectRange(range);
			updataEditorSelectRange();
			//标高亮
			focusRange();
		}
		
		public function cancelSelectRange() : void {
			clearOldRange();
		}
		
		/**
		 * 根据资源生成 Tile
		 * x,y 与 srcX,srcY 默认相同
		 */
		public function initCellsBySrc(sourceBitmapData : BitmapData, srcIndex : int) : void {
			if(sourceBitmapData == null) throw new Error("SourceBitmapData is null!");
			this._sourceIndex = srcIndex;
			var width : int = Math.ceil(sourceBitmapData.width / this.editor.cellWidth);
			var height : int = Math.ceil(sourceBitmapData.height / this.editor.cellHeight);
			initCells(srcIndex, width, height);
			for each (var cell : Cell in _cells) {
				cell.drawCanvas(sourceBitmapData);
			}
		}
		
		public function initEditableCells() : void {
			initCells(DEFAULT_SOURC_INDEX, this.editor.map.width, this.editor.map.height);
		}

		/**
		 * 根据读取的数据对象
		 */
		public function initCellsByObj(layer : Object) : void {
			this._layerData.convertObjToTiles(layer);
			initEditableCells();
			reloadResource();
		}
		
		public function clear() : void {
			for each (var cell : Cell in this._cells) {
				cell.clear();
			}
		}
		
		public function clearRange() : void {
			this._selectRange.clear();
		}

		public function drawLine() : void {
			for each (var cell : Cell in this._cells) {
				cell.drawLine();
			}
		}
		
		public function showTileType() : void {
			setShowTileType(true);
		}
		
		public function hideTileType() : void {
			setShowTileType(false);
		}
		
		public function toString() : String {
			return "{z:" + _layerData.z + ", name:"+_layerData.name + "}";
		}
	}//end Sheet
}
