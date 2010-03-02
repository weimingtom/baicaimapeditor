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
	import org.baicaix.events.ReslistEvent;
	import org.baicaix.modules.beans.Map;
	import org.baicaix.modules.beans.Reslist;
	import org.baicaix.modules.serialization.FileManager;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author dengyang
	 */
	public class MapManager extends EventDispatcher {
		
		private var map : Map;
		private var mapFileUrl : String;
		private var imgLoader : ResourceImgLoader;
		private var dataLoader : ResourceDataLoader;
		private var dataConvertor : DataConvertor;
		private var fileMnger : FileManager;
		
		private var _base : *;
		
		private static const REGEX_INDEX : RegExp = new RegExp('(\\w+?)\\.');
    	private static const REGEX_FILENAME : RegExp = new RegExp('(\\w+?)\\.\\w+$');

		public function MapManager(base : *) {
			_base = base;
			imgLoader = ResourceImgLoader.getInstance();
			dataLoader = ResourceDataLoader.getInstance();
			
			dataConvertor = new DataConvertor();
			fileMnger = new FileManager();
			fileMnger.addEventListener(ReslistEvent.RESLIST_LOAD_COMPLETE, loadReslist);
			fileMnger.readReslist();
//			fileMnger.addEventListener(ResLoadEvent.LOAD_MAP_DATA, loadMap); //太早了
			this.addEventListener("loadMap", loadMap);
		}
		
		private function loadReslist(event : ReslistEvent) : void {
			var reslist : Reslist = Reslist(event.data);
			for each (var id : int in reslist._ids) {
				var name : String = reslist.getName(Reslist.ID_FORMAT.format(id));
				if(name != null) {
					_base.resedit.addItem(Reslist.ID_FORMAT.format(id), name);	
				}
			}
		}
		
		public function saveMapAS():void {
			var cont : String = dataConvertor.saveMap(map);
			fileMnger.saveFileTo(cont);
		}
		
		public function saveMap():void {
			var cont : String = dataConvertor.saveMap(map);
			fileMnger.save(mapFileUrl, cont);
		}
		
		public function openMap() : void {
			fileMnger.onOpen = onOpenMap;
			fileMnger.openMapFile();
		}
		
		public function closeMap() : void {
			map = null;
			_base.mapbrowser.map = map;
		}
		
		private function onOpenMap(url : String) : void {
    		//加载map				module
    		//加载map中的资源		module
    		//资源夹在成功后通知界面 control
    		mapFileUrl = url;
    		dataLoader.loadResource(url, function():void {
				var name : String = REGEX_INDEX.exec(url)[1];
				map = dataLoader.getResourceMap(name);
				//加载所有资源
				for each (var key : String in map.ress) {
					loadRes(url, key);
				}
				//延迟加载
				var timer : Timer = new Timer(2000, 1);
				timer.addEventListener(TimerEvent.TIMER, loadMapAndRefresh);
				timer.start();
				function loadMapAndRefresh(event : Event) : void {
					timer.removeEventListener(TimerEvent.TIMER, loadMapAndRefresh);
					timer.stop();
					//显示map
					dispatchEvent(new Event("loadMap"));//响应部分refresh
				}
			});
			trace("load map");
    	}	
    	
    	private function loadMap(event : Event) : void {
    		_base.mapbrowser.map = map;
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
