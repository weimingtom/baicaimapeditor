/**
 * @file ResourceDataLoader.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-8
 * @updatedate 2010-2-8
 */   
package org.baicaix.modules {
	import org.baicaix.modules.beans.Layer;
	import org.baicaix.modules.beans.Map;
	import org.baicaix.modules.beans.Tile;

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	/**
	 * @author dengyang
	 */
	public class ResourceDataLoader extends ResourceLoaderAbs {
		
		private var _dataConverter : DataConvertor;
		private static var _me : ResourceDataLoader;
		
		public function ResourceDataLoader() {
			super();
			//IOC
			_dataConverter = new DataConvertor();
		}
		
		override public function loadResource(url : String, callBack : Function = null) : void {
			var loader : URLLoader = new URLLoader();
			var result : Object = REGEX_INDEX.exec(url);
			_loaders[loader] = result[1];
			_callbackFuncs[result[1]] = callBack;
			var m_request : URLRequest = new URLRequest(url);//sanguoxin.jpg");
			
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, onComplete);
			try {
				loader.load(m_request);
			} catch (e:Error) {
			
			}
		}
		
		override protected function onComplete(event : Event) : void {
			var index : String = _loaders[event.target];
			var func : Function = _callbackFuncs[index];
			if(event.target.data == null) return;
			_datas[index] = _dataConverter.convertToMap(event.target.data);
			if(func != null) 
				func();
		}
		
		public static function getInstance() : ResourceDataLoader {
			if(_me == null)
				_me = new ResourceDataLoader();
			return _me;
		}
		
		public function load(key : String, x : int, y : int) : Tile {
			if(key == "-1") return null;
			var layer : Layer = getResourceByIndex(key);
			return layer.getTile(x, y);
		}
		
		private function getResourceByIndex(key : String) : Layer {
			return getResourceMap(key).layers[0];
		}
		
		public function getResourceMap(key : String) : Map {
			return _datas[key];
		}
		
		/**
		 * 新建的map
		 */
		public function put(index : int, map : Map) : void {
			//TODO only for test
			_datas[index] = map;
		}
		
		public function get datas() : Array {
			var datas : Array = [];
			for each (var data : * in _datas) {
				datas.push(data);
			}
			return datas;
		}
	}
}

