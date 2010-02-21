/**
 * @file ResourceImgLoader.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-8
 * @updatedate 2010-2-8
 */   
package org.baicaix.flow.resouece {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author dengyang
	 */
	public class ResourceImgLoader extends ResourceLoaderAbs {
		
		private var _cellWidth : int = 32;
		private var _cellHeight : int = 32;
		
		private static const DEFAULT_DRAW_TO_POINT : Point = new Point(0, 0);
		private static const DEFAULT_RESOURCE_RANGE : Rectangle = new Rectangle(-1, -1, -1, -1);
		
		public function ResourceImgLoader() {
			super();
			this._subfix = "png";
			this._path = "";
		}
		
		override protected function onComplete(event : Event) : void {
			_datas[_loaders[LoaderInfo(event.target).loader]] = Bitmap(event.target.content).bitmapData;
			var func : Function = _callbackFuncs[_loaders[LoaderInfo(event.target).loader]];
			if(func != null) 
				func();
		}

		public function load(index : int, x : int, y : int) : BitmapData {
			var copyRange : Rectangle = createResourceRange(index, x, y);
			return getPieceOfResourceFromRange(copyRange, index);
		}
		
		private function createResourceRange(index : int, x : int, y : int) : Rectangle {
			var copyRange : Rectangle = new Rectangle(x * _cellWidth, y * _cellHeight, _cellWidth, _cellHeight);
			if(!sourceImageRange(getResourceByIndex(index)).containsRect(copyRange)) {
				return DEFAULT_RESOURCE_RANGE;
			} else {
				return copyRange;
			}
		}
		
		private function sourceImageRange(imageData : BitmapData) : Rectangle {
			if(imageData == null) {
				return DEFAULT_RESOURCE_RANGE;
			} else {
				return new Rectangle(0, 0, imageData.width, imageData.height);
			}
		}

		private function getPieceOfResourceFromRange(copyRange : Rectangle, index : int) : BitmapData {
			var copy : BitmapData = new BitmapData(_cellWidth, _cellHeight);
			var resource : BitmapData = getResourceByIndex(index);
			if(resource != null) {
				copy.copyPixels(resource, copyRange, DEFAULT_DRAW_TO_POINT);
			}
			return copy;
		}
		
		public function getResourceByIndex(index : int) : BitmapData {
			//TODO 实现对资源的管理
			return _datas[""+index];
		}
	}
}

