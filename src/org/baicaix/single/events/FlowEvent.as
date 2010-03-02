/**
 * @file FlowEvent.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-29
 * @updatedate 2010-1-29
 */   
package org.baicaix.single.events {
	import flash.events.Event;

	/**
	 * @author dengyang
	 */
	public class FlowEvent extends Event {
		
		public static const GOTO_TOP	: String = "GOTO_TOP";
		public static const GOTO_BOTTOM	: String = "GOTO_BOTTOM";
		public static const GOTO_LEFT	: String = "GOTO_LEFT";
		public static const GOTO_RIGHT	: String = "GOTO_RIGHT";
		
		private var _offset : int;
		
		public function FlowEvent(type : String, offset : int = 1, bubbles : Boolean = false, cancelable : Boolean = false) {
			this._offset = offset;
			super(type, bubbles, cancelable);
		}
		
		public function get offset() : int { 
			return this._offset;
		}
	}
}
