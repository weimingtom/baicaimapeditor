/**
 * @file DataEvent.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-8
 * @updatedate 2010-2-8
 */   
package org.baicaix.flow.events {
	import flash.events.Event;

	/**
	 * @author dengyang
	 */
	public class DataEvent extends Event {
		
		private var _data : Object;
		
		public function DataEvent(type : String, data : Object, bubbles : Boolean = false, cancelable : Boolean = false) {
			this._data = data;
			super(type, bubbles, cancelable);
		}
		
		public function get data() : Object {
			return _data;
		}
	}
}
