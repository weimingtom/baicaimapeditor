/**
 * @file ScrollPane.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-28
 * @updatedate 2010-1-28
 */   
package com.bit101.baicaix.components {
	import com.bit101.components.Component;
	import com.bit101.components.HSlider;
	import com.bit101.components.Slider;
	import com.bit101.components.VSlider;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;

	/**
	 * @author dengyang
	 */
	public class ScrollPane extends Component {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		protected var _mainPane : MainPane;
		private var _mask : Shape;
		
		protected var _vslider : Slider;
		protected var _hslider : Slider;
		
		protected var _centerWidth : int;
		protected var _centerHeight : int;

		//------------------------------------
		// public properties
		//------------------------------------
		

		//------------------------------------
		// constructor
		//------------------------------------

		public function ScrollPane(parent : DisplayObjectContainer = null, xpos : Number = 0, ypos : Number = 0, width : int = 100, height : int = 100) {
			this._width = width;
			this._height = height;
			this.mouseEnabled = false;
			super(parent, xpos, ypos);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function onChildResize(event : Event) : void {
			setScrollByChild();
		}
		
		private function setScrollWhenAddChild(child : DisplayObject) : void {
			setScrollByChild(child);
		}
		
		private function setScrollWhenRemoveChild() : void {
			setScrollByChild();
		}
		
		private function setScrollByChild(child : DisplayObject = null) : void {
			var childWidth : int = child == null ? 0 : child.width;
			var childHeight : int = child == null ? 0 : child.height;
			
			var vScrollLength : int = Math.max(_mainPane.height, childHeight) - this._centerHeight;
			var hScrollLength : int = Math.max(_mainPane.width, childWidth) - this._centerWidth;
				
			//是否显示
			setVisibleByLength(_hslider, hScrollLength);
			setVisibleByLength(_vslider, vScrollLength);
			//设置行程
			this._vslider.maximum = vScrollLength;
			this._hslider.maximum = hScrollLength;
			//设置起点
			this._vslider.value = this._vslider.maximum;
			this._hslider.value = this._hslider.minimum;
		}

		private function setVisibleByLength(target : DisplayObject, length : int = 0) : void {
			if(length > 0) {
				target.visible = true;
			} else {
				target.visible = false;
			}
		}		

		private function drawSlider() : void {
			this._vslider.x = this.x + this._centerWidth;
			this._vslider.y = this.y;
			this._vslider.height = this._centerHeight;

			this._hslider.y = this.y + this._centerHeight;
			this._hslider.x = this.x;
			this._hslider.width = this._centerWidth;
		}
	
		private function initEvent() : void {
			this._vslider.addEventListener(Event.CHANGE, onVChange);
			this._hslider.addEventListener(Event.CHANGE, onHChange);
		}
		
		private function onVChange(event : Event) : void {
			var pos : int = this._vslider.maximum - this._vslider.value;
			_mainPane.y = -pos;
		}

		private function onHChange(event : Event) : void {
			_mainPane.x = -this._hslider.value;
		}
		
		private function onResize(event : Event) : void {
			invalidate();
		}

		// PUBLIC
		//________________________________________________________________________________________________
		
		override protected function init() : void {
			super.init();
			initEvent();
		}
		
		override protected function addChildren() : void {
			this._mainPane = MainPane(super.addChild(new MainPane()));
			
			this._vslider = new VSlider(parent); 
			this._hslider = new HSlider(parent);
			
			this._centerWidth = this._width - this._vslider.width;
			this._centerHeight = this._height - this._hslider.height;
			
			this._mask = new Shape();
			this._mask.graphics.beginFill(0x0000ff);
			this._mask.graphics.drawRect(0, 0, _centerWidth, _centerHeight);
			this._mask.graphics.endFill();
			super.addChild(_mask);
			this._mainPane.mask = this._mask;
			
//			this._mainPane.addEventListener(Event.RESIZE, onChildResize);
		}
		
		override public function addChild(child : DisplayObject) : DisplayObject {
			this._mainPane.addChild(child);
			setScrollWhenAddChild(child);
//			child.addEventListener(Event.RESIZE, onResize);
			invalidate();
			return child;
		}
		
		override public function removeChild(child : DisplayObject) : DisplayObject {
			this._mainPane.removeChild(child);
			setScrollWhenRemoveChild();
			return child;
		}
		
		override public function draw() : void {
			drawSlider();
		}
	}
}

import com.bit101.components.Component;

import flash.display.DisplayObject;
import flash.events.Event;

class MainPane extends Component {
	
	override public function addChild(child : DisplayObject) : DisplayObject {
		super.addChild(child);
		dispatchEvent(new Event(Event.RESIZE));
		return child;
	}
	
	override public function removeChild(child : DisplayObject) : DisplayObject {
		super.removeChild(child);
		dispatchEvent(new Event(Event.RESIZE));
		return child;
	}
}
