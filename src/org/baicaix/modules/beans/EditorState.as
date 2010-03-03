/**
 * @file EditorState.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-3-3
 * @updatedate 2010-3-3
 */   
package org.baicaix.modules.beans {
	import mx.utils.ObjectProxy;

	/**
	 * @author dengyang
	 */
	public class EditorState extends ObjectProxy {
		
		private var _isDrawLine : Boolean;
		
		public function get isDrawLine() : Boolean {
			return _isDrawLine;
		}
		
		[Bindable]
		public function set isDrawLine(value : Boolean) : void {
			_isDrawLine = value;
		}
	}
}
