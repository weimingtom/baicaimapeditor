/**
 * @file FlowCellEvent.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-2
 * @updatedate 2010-2-2
 */   
package org.baicaix.flow.events {

	/**
	 * @author dengyang
	 */
	public class FlowCellEvent extends DataEvent {
		
		public static const RELOAD_CELL : String = "RELOAD_CELL";
		
		public static const RELOAD_RIM : String = "RELOAD_RIM";
		
		public static const DRAW_LINE : String = "DRAW_LINE";
		
		public static const DRAW_TYPE : String = "DRAW_TYPE";
		
		public static const OVER_CELL : String = "OVER_CELL";
		
		public function FlowCellEvent(type : String, data : Object, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, data, bubbles, cancelable);
		}
	}
}
