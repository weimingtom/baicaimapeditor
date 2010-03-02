/**
 * @file FileManager.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-3-1
 * @updatedate 2010-3-1
 */   
package org.baicaix.modules {
	import org.baicaix.modules.beans.Reslist;

	/**
	 * 统一管理资源
	 * @author dengyang
	 */
	public class ResourceManager {
		
		private var _reslist : Reslist;

		public function ResourceManager() {
		}

		private function readOrCreateReslist() : void {
			ResourceDataLoader.getInstance().loadResource("./assets/Reslist.xml");
		}
	}
}
