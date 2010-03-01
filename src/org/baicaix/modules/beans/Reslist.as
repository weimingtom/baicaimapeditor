/**
 * @file ResList.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-3-1
 * @updatedate 2010-3-1
 */   
package org.baicaix.modules.beans {
	import org.baicaix.utils.NumberFormat;

	import flash.utils.Dictionary;

	/**
	 * @author dengyang
	 */
	public class Reslist {
		
		private var _maxId : int = 0;
		private var _reslist : Dictionary;
		
		private static const ID_FORMAT : NumberFormat = new NumberFormat("00000000"); 

		public function Reslist() {
			_reslist = new Dictionary();
		}
		
		public function read(xml : XML) : void {
			_maxId = int(String(xml.maxid));
			for each (var res : XML in xml.res) {
				add(res.@id.toString(), res.@name.toString());
			}
		}
		
		public function toXML() : XML {
			var root : XML = new XML(<Resources/>);
			root.appendChild(<maxid id={_maxId}/>);
			for (var id : String in _reslist) {
				var res : XML = <res/>;
				root.appendChild(res);
				res.@id = id;
				res.@name = _reslist[id];
			}
			return root;
		}
		
		public function add(id : String, name : String) : void {
			_maxId = Math.max(_maxId, int(id));
			_reslist[id] = name;
		}
		
		public function getName(id : String) : String {
			return _reslist[id]; 
		}
		
		public function generatNewId() : String {
			return ID_FORMAT.format(++_maxId);
		}
	}
}
