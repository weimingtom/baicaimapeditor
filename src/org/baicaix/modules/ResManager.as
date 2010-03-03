/**
 * @file MapManager.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-3-2
 * @updatedate 2010-3-2
 */   
package org.baicaix.modules {
	import org.baicaix.modules.beans.Map;
	import org.baicaix.modules.beans.Reslist;
	import org.baicaix.modules.serialization.FileManager;
	import org.baicaix.single.resource.ResourceCreator;
	import org.baicaix.single.resource.ResourceDataLoader;
	import org.baicaix.single.resource.ResourceImgLoader;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author dengyang
	 */
	public class ResManager extends EventDispatcher {
		
		private var imgLoader : ResourceImgLoader;
		private var dataLoader : ResourceDataLoader;
		private var dataConvertor : DataConvertor;
		private var fileMnger : FileManager;
		
		private var _base : *;
		
		public function ResManager(base : *) {
			_base = base;
			imgLoader = ResourceImgLoader.getInstance();
			dataLoader = ResourceDataLoader.getInstance();
			
			dataConvertor = new DataConvertor();
			fileMnger = new FileManager();
		}
		
		public function openImg():void {
			fileMnger.onOpen = onOpenImg;
			fileMnger.openImgFile();
		}
		
		private static const REGEX_INDEX : RegExp = new RegExp('(\\w+?)\\.');
		private static const REGEX_SUBFIX : RegExp = new RegExp('\\.(\\w+?)$');
        private function onOpenImg(url : String) : void {
        	//only for test
        	var keystr : String = REGEX_INDEX.exec(url)[1];
			loadRes(url, keystr);      	
        }
		
        private function loadRes(url : String, key : String) : void {
        	imgLoader.loadResource(url, function() : void {
        		dataLoader.loadResource(url.replace(REGEX_SUBFIX, ".res"), function (event:Event = null):void {
	        		//实际中应该是读取
					var map : Map = dataLoader.getResourceMap(key);
					_base.resbrowser.map = map;
				});
        	});
        }
	}
}
