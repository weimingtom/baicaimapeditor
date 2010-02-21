/**
 * @file FlowMapSelector.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-3
 * @updatedate 2010-2-3
 */   
package org.baicaix.single {
	import org.baicaix.single.display.FlowBrowser;
	import org.baicaix.single.display.FlowCell;
	import org.baicaix.single.events.FlowCellEvent;

	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * @author dengyang
	 */
	public class FlowMapSelector extends FlowResourceSelector {
		
		private var inPaste : Boolean;
		private var _pasteStartCell : FlowCell;
		
		public function FlowMapSelector(base : FlowBrowser) {
			super(base);
			_base.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		}
		
		override protected function onMouseDown(event : MouseEvent) : void {
			_base.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			var startCell : FlowCell = FlowCell(event.target);
			
			_pasteStartCell = startCell;
			
			setbaseRange();
			paste();
		}
		
		private function setbaseRange() : void {
			_base.editor.setPasteBaseRange();
		}
		
		private function paste() : void {
			_base.editor.pasteRange();
			inPaste = true;
		}
		
		override protected function onMouseUp(event : MouseEvent) : void {
			_base.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			inPaste = false;
		}

		override protected function onMouseOver(event : MouseEvent) : void {
			if(!(event.target is FlowCell)) return;
			if(_base.editor.backupRange == null) return;
			
			var startCell : FlowCell = FlowCell(event.target);
			select(startCell);
			
			dispatchEvent(new FlowCellEvent(FlowCellEvent.OVER_CELL, {x:startCell.logicX, y:startCell.logicY}));
			
			if(inPaste) paste();
		}
		
		private function select(startCell : FlowCell) : void {
			_startCell = startCell;
			selectRange(buildRectangle());
			_selectRange.drawRim();
		}

		private function buildRectangle() : Rectangle {
			var backupRange : Rectangle = _base.editor.backupRange.range;
			return new Rectangle(_startCell.x / _base.cellWidth, _startCell.y / _base.cellHeight, backupRange.width, backupRange.height);
		}
		
	}
}
