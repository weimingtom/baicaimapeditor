package com.bit101.baicaix.components {
	import com.bit101.components.VBox;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	/**
	 * @author Poplar
	 */
	public class LayerBox extends VBox {
		
		private var _selected : *;
		private var _layers : Array;
				
		public function LayerBox(parent : DisplayObjectContainer = null, xpos : Number = 0, ypos : Number = 0) {
			super(parent, xpos, ypos);
			_layers = [];
		}
		
		/**
		 * Override of addChild to force layout;
		 */
		override public function addChild(child:DisplayObject) : DisplayObject
		{
			super.addChild(child);
			child.removeEventListener(Event.SELECT, onSelected);
			child.addEventListener(Event.SELECT, onSelected);
			if(_selected == null)
				_selected = child;
			if(_layers.indexOf(child) < 0)
				_layers.push(child);
			return child;
		}

		private function onSelected(event : Event) : void {
			_selected = event.currentTarget;
		}
		
		public function get selected() : * {
			return _selected;
		}
		
		public function get layers() : Array {
			return _layers;
		}
		
		public function reload() : void {
			for (var i : int = 0; i < this.numChildren; i++) {
				this.removeChildAt(i);
			}
			for each (var layer : DisplayObject in _layers) {
				this.addChild(layer);
			}
		}
	}
}
