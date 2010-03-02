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
	import org.baicaix.modules.serialization.FileManager;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author dengyang
	 */
	public class ResManager extends EventDispatcher {
		
		private var map : Map;
		private var imgLoader : ResourceImgLoader;
		private var dataLoader : ResourceDataLoader;
		private var dataConvertor : DataConvertor;
		private var fileMnger : FileManager;
		
		private var _base : *;
		
		private static const REGEX_INDEX : RegExp = new RegExp('(\\w+?)\\.');
    	private static const REGEX_FILENAME : RegExp = new RegExp('(\\w+?)\\.\\w+$');

		public function ResManager(base : *) {
			_base = base;
			imgLoader = ResourceImgLoader.getInstance();
			dataLoader = ResourceDataLoader.getInstance();
			
			dataConvertor = new DataConvertor();
			fileMnger = new FileManager();
			addEventListener("loadMap", loadMap);
		}
		
		public function openImg():void {
			fileMnger.onOpen = onOpenImg;
			fileMnger.openImgFile();
		}
		
		private static const REGEX_SUBFIX : RegExp = new RegExp('\\.(\\w+?)$');
        private function onOpenImg(url : String) : void {
        	//only for test
        	var keystr : String = REGEX_INDEX.exec(url)[1];
        	var key : int = int(keystr);
        	
        	imgLoader.loadResource(url);
    		dataLoader.loadResource(url.replace(REGEX_FILENAME, key+".txt"), loadmap);
			
			function loadmap(event:Event = null):void {
				map = dataLoader.getResourceMap(""+key);
				dispatchEvent(new Event("loadMap"));
			}
        }
    	
    	private function loadMap(event : Event) : void {
    		//TODO 显示图片到 
    		_base.resbrowser.map = map;
//			mapFlowShower.loadMap(map);
		}
		
		public function refresh(e:Event=null):void {
//			editor.refreshMap();
		}
    	
        private function loadRes(url : String, key : String) : void {
        	//TODO 地址的获取方式需要修改
        	imgLoader.loadResource(url.replace(REGEX_FILENAME, key+".png"));
    		dataLoader.loadResource(url.replace(REGEX_FILENAME, key+".txt"));
        }
	}
}
