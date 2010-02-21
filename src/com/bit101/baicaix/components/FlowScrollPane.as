/**
 * @file FlowScrollPane.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-1
 * @updatedate 2010-2-1
 */   
package com.bit101.baicaix.components {
	import org.baicaix.single.display.FlowBrowser;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	/**
	 * @author dengyang
	 */
	public class FlowScrollPane extends ScrollPane {
		
		public function FlowScrollPane(parent : DisplayObjectContainer = null, xpos : Number = 0, ypos : Number = 0, width : int = 100, height : int = 100) {
			super(parent, xpos, ypos, width, height);
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override protected function init() : void {
			addChildren();
			invalidate();
			initEvent();
		}
		
		private function initEvent() : void {
			this._vslider.addEventListener(Event.CHANGE, onVChange);
			this._hslider.addEventListener(Event.CHANGE, onHChange);
		}
		
		private function onVChange(event : Event) : void {
			var pos : int = this._vslider.maximum - this._vslider.value;
			var child : FlowBrowser = FlowBrowser(this._mainPane.getChildAt(0));
			child.y = -pos;
		}

		private function onHChange(event : Event) : void {
			var child : FlowBrowser = FlowBrowser(this._mainPane.getChildAt(0));
			child.x = -this._hslider.value;
		}
	}
}
