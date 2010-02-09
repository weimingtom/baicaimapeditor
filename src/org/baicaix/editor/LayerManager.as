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
package org.baicaix.editor {
	import org.baicaix.editor.Sheet;
	import org.baicaix.map.Map;
	import org.baicaix.map.MapLayer;

	/**
	 * 负责管理层的关系
	 * @author dengyang
	 */
	public class LayerManager {
				
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _currentLayer : Sheet;
		private var _layers : Array;
		
		//------------------------------------
		// public properties
		//------------------------------------
		

		//------------------------------------
		// constructor
		//------------------------------------

		public function LayerManager() {
			init();
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function init() : void {
			_layers = [];
		}

		private function addLayer(layer : Sheet) : void {
			_layers.push(layer);
		}
		
		private function turnup(index : int) : void {
			var temp : Array = _layers.slice(index - 1, index + 1);
			_layers.splice(index -1, 2, temp.pop(), temp.pop());
		}

		// PUBLIC
		//________________________________________________________________________________________________
		
		public function get layers() : Array {
			return _layers;
		}
		
		public function registerLayer(layer : Sheet) : void {
			addLayer(layer);
			selectLayer(layer);
		}
		
		/**
		 * 
		 * @param index    index
		 */
		public function selectLayer(layer : Sheet) : void {
			_currentLayer = layer;
			//TODO 显示层待实现
		}

		/**
		 * 
		 * @param index    index
		 */
		public function turnUpLayer(index : int) : void {
			if(index == 0) return;
			turnup(index);
			//TODO 显示层待实现
		}

		/**
		 * 
		 * @param index    index
		 */
		public function turnDownLayer(index : int) : void {
			if(index == _layers.length - 1) return;
			turnup(index + 1);
			//TODO 显示层待实现
		}

		public function hideLayer(layer : Sheet) : void {
			layer.hide();
		}

		public function showLayer(layer : Sheet) : void {
			layer.show();
		}

		public function lockLayer(layer : Sheet) : void {
			layer.lock();
			//TODO 显示层待实现
		}

		public function unlockLayer(layer : Sheet) : void {
			layer.unlock();
			//TODO 显示层待实现
		}

		public function loadMap(map : Map) : void {
			init();
		}
		
		public function loadLayer(layer : MapLayer) : void {
			init();
		}
	}
}
