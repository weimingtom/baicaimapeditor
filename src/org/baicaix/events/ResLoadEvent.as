/**
 * @file FileLoadEvent.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-3-1
 * @updatedate 2010-3-1
 */   
package org.baicaix.events {
	import flash.events.Event;

	/**
	 * @author dengyang
	 */
	public class ResLoadEvent extends Event {
		
		public static const LOAD_RES_IMG : String = "LOAD_RES_IMG";
		
		public static const LOAD_RES_DATA : String = "LOAD_RES_DATA";
		
		public function ResLoadEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
