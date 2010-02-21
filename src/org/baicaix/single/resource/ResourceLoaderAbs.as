/**
 * @file CellLoader.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-29
 * @updatedate 2010-1-29
 */   
package org.baicaix.single.resource {
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	/**
	 * @author dengyang
	 */
	public class ResourceLoaderAbs extends EventDispatcher{

		protected var _loaders : Dictionary;
		protected var _callbackFuncs : Dictionary;
		protected var _datas : Dictionary;
		protected var _path : String;
		protected var _subfix : String;
		
		protected static const REGEX_INDEX : RegExp = new RegExp('(\\w+?)\\.');
		
		public function ResourceLoaderAbs() {
			_loaders = new Dictionary();
			_datas = new Dictionary();
			_callbackFuncs = new Dictionary();
		}
		
		public function loadResource(url : String, callBack : Function = null) : void {
			var loader : Loader = new Loader();
			var result : Object = REGEX_INDEX.exec(url);
			_loaders[loader] = result[1];
			_callbackFuncs[result[1]] = callBack;
			var m_request : URLRequest = new URLRequest(url);//sanguoxin.jpg");
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.load(m_request);
		}
		
		protected function onComplete(event : Event) : void {
			throw new Error("Do not support yet...");
		}
		
		public function addTask(indexs : Array) : void {
			for each (var index : int in indexs) {
				loadResource(_path + index + "." + _subfix);
			}
		}
	}
}
