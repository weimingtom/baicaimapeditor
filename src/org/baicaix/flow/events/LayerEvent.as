/**
 * @file LayerEvent.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-8
 * @updatedate 2010-2-8
 */   
package org.baicaix.flow.events {

	/**
	 * @author dengyang
	 */
	public class LayerEvent extends DataEvent {
		
		public static const LAYER_CHANGE	: String = "LAYER_CHANGE";
		public static const LAYER_SELECT	: String = "LAYER_SELECT";
		
		public function LayerEvent(type : String, data : Object, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, data, bubbles, cancelable);
		}
	}
}
