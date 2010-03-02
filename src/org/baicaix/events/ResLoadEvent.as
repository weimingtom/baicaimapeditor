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

	/**
	 * @author dengyang
	 */
	public class ResLoadEvent extends ObjectDataEvent {
		
		public static const LOAD_RES_IMG : String = "LOAD_RES_IMG";
		
		public static const LOAD_RES_DATA : String = "LOAD_RES_DATA";
		
		public static const LOAD_MAP_DATA : String = "LOAD_MAP_DATA";
		
		public function ResLoadEvent(type : String, data : *) {
			super(type, data);
		}
	}
}
