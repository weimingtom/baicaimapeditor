/**
 * @file FlowEditor.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-2
 * @updatedate 2010-2-2
 */   
package org.baicaix.flow {
	import org.baicaix.flow.events.FlowCellEvent;
	import org.baicaix.map.Map;

	import flash.events.EventDispatcher;

	/**
	 * @author dengyang
	 */
	public class FlowEditor extends EventDispatcher {
		
		private var _pasteBaseRange : FlowRange;
		private var _selectRange: FlowRange;
		private var _copyRange : FlowRange;
		private var _mapMnger : EditMapManager;
		
		public function FlowEditor() {
			//TODO IOC
			_mapMnger = new EditMapManager();
		}
		
		//=====================Range=====================
		public function selectRange(range : FlowRange) : void {
			_selectRange = range;
		}

		public function copyRange() : void {
			_copyRange = _selectRange;
		}
		
		public function setPasteBaseRange() : void {
			_pasteBaseRange = _selectRange;
		}
		
		public function pasteRange() : void {
			if(_copyRange == null) return;
			_selectRange.pasteRange(_pasteBaseRange, _copyRange);
		}
		//===================End Range===================
		
		
		//===================Edit Tile===================
		public function setTileType(type : int) : void {
			_selectRange.setTileType(type);
		}
		
		public function refreshMap() : void {
			_mapMnger.refresh();
			dispatchEvent(new FlowCellEvent(FlowCellEvent.RELOAD_CELL, {}));
		}
		
		public function drawLine(draw : Boolean) : void {
			dispatchEvent(new FlowCellEvent(FlowCellEvent.DRAW_LINE, {drawLine : draw}));
		}
		
		public function drawType(draw : Boolean) : void {
			dispatchEvent(new FlowCellEvent(FlowCellEvent.DRAW_TYPE, {drawType : draw}));
		}
		
		
		public function loadMap(map : Map) : void {
			_mapMnger.loadMap(map);
		}
		//===================End Tile====================
		
		//====================Getter=====================
		public function get backupRange() : FlowRange {
			return _copyRange;
		}
		
		public function get mapManager() :  EditMapManager {
			return _mapMnger;
		}
		
		private var _zuobiaoChange : Function;
		public function onOverCell(event : FlowCellEvent) : void {
			_zuobiaoChange(event);
		}
		public function set zuobiaoChange(zuobiaoChange : Function) : void {
			_zuobiaoChange = zuobiaoChange;
		}
	}
}
