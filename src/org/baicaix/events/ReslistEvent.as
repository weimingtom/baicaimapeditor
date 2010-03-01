/**
 * @file ReslistEvent.as
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
	public class ReslistEvent extends ObjectDataEvent {
		
		public static const RESLIST_LOAD_COMPLETE : String = "RESLIST_LOAD_COMPLETE";
		
		public function ReslistEvent(type : String, data:Object) {
			super(type, data);
		}
	}
}
