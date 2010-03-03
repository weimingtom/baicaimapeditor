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
package org.baicaix.controls {
	import org.baicaix.single.display.Browser;
	import org.baicaix.single.events.CellEvent;

	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author dengyang
	 */
	public class MapSelector extends ResSelector {
		
		private var inPaste : Boolean;
		private var _pasteStartPos : Point;
		
		public function MapSelector(base : Browser) {
			super(base);
			_base.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		override protected function onMouseDown(event : MouseEvent) : void {
			_base.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			var browser : Browser = Browser(event.target);
			_pasteStartPos = getPos(event.localX, event.localY, browser);
			
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

		override protected function onMouseMove(event : MouseEvent) : void {
			if(!(event.target is Browser)) return;
			if(_base.editor.backupRange == null) return;
			
			var browser : Browser = Browser(event.target);
			var pos : Point = getPos(event.localX, event.localY, browser);
			select(pos);
			
			dispatchEvent(new CellEvent(CellEvent.OVER_CELL, {x:_startPos.x, y:_startPos.y}));
			
			if(inPaste) paste();
		}
		
		private function select(pos : Point) : void {
			_startPos = pos;
			selectRange(buildRectangle());
			_selectRange.drawRim();
		}

		private function buildRectangle() : Rectangle {
			var backupRange : Rectangle = _base.editor.backupRange.range;
			return new Rectangle(int(_startPos.x / _base.cellWidth), int(_startPos.y / _base.cellHeight), backupRange.width, backupRange.height);
		}
		
	}
}
