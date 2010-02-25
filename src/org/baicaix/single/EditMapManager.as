/**
 * @file LayerManager.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-27
 * @updatedate 2010-1-27
 */   
package org.baicaix.single {
	import org.baicaix.map.Map;
	import org.baicaix.map.MapLayer;
	import org.baicaix.map.MapTile;
	import org.baicaix.single.events.LayerEvent;
	import org.baicaix.single.resource.ResourceDataLoader;

	import flash.events.EventDispatcher;

	/**
	 * 负责管理层的关系
	 * @author dengyang
	 */
	public class EditMapManager extends EventDispatcher {
				
		//------------------------------------
		// private, protected properties
		//------------------------------------
		//可能会移动到专门管理map的类中
		private var _map : Map;
		//用于保存
		private var _mapName : String;
		private var _currentLayer : MapLayer;
		
		//------------------------------------
		// public properties
		//------------------------------------
		

		//------------------------------------
		// constructor
		//------------------------------------

		public function EditMapManager() {
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function turnup(index : int) : void {
			var temp : Array = _map.layers.slice(index - 1, index + 1);
			_map.layers.splice(index -1, 2, temp.pop(), temp.pop());
		}

		// PUBLIC
		//________________________________________________________________________________________________
		
		public function get layers() : Array {
			return _map.layers;
		}
		
		/**
		 * 
		 * @param index    index
		 */
		public function selectLayer(layer : MapLayer) : void {
			_currentLayer = layer;
			dispatchEvent(new LayerEvent(LayerEvent.LAYER_SELECT, {"layer" : _currentLayer}));
		}

		/**
		 * 
		 * @param index    index
		 */
		public function turnUpLayer(index : int) : void {
			if(index == 0) return;
			turnup(index);
			//TODO 显示层待实现
			dispatchEvent(new LayerEvent(LayerEvent.LAYER_CHANGE, {"layer" : _currentLayer}));
		}

		/**
		 * 
		 * @param index    index
		 */
		public function turnDownLayer(index : int) : void {
			if(index == _map.layers.length - 1) return;
			turnup(index + 1);
			//TODO 显示层待实现
			dispatchEvent(new LayerEvent(LayerEvent.LAYER_CHANGE, {"layer" : _currentLayer}));
		}

//		public function hideLayer(layer : MapLayer) : void {
//			layer.hide();
//		}
//
//		public function showLayer(layer : MapLayer) : void {
//			layer.show();
//		}
//
//		public function lockLayer(layer : MapLayer) : void {
//			layer.lock();
//			//TODO 显示层待实现
//		}
//
//		public function unlockLayer(layer : MapLayer) : void {
//			layer.unlock();
//			//TODO 显示层待实现
//		}

		public function loadMap(map : Map) : void {
			this._map = map;
			this._currentLayer = map.layers[0];
			dispatchEvent(new LayerEvent(LayerEvent.LAYER_SELECT, {"layer" : _currentLayer}));
		}
		
		public function refresh() : void {
			for each (var layer : MapLayer in _map.layers) {
				for each (var tile : MapTile in layer.tiles) {
					//TODO IOC
					tile.paste(ResourceDataLoader.getInstance().load(tile.src+"", tile.srcX, tile.srcY));
				}
			}
		}
		
		public function createLayer(name : String) : void {
			//TODO 层级的存储还需推敲
			_map.createTemptyLayer(_map.index, 0, name);
		}
	}
}
