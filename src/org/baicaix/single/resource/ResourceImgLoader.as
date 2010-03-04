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
package org.baicaix.single.resource {
	import org.baicaix.modules.beans.Reslist;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
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
		
		private static var _me : ResourceImgLoader;
		
		public function ResourceImgLoader() {
			super();
			this._subfix = "png";
			this._path = "";
		}
		
		public static function getInstance() : ResourceImgLoader {
			if(_me == null)
				_me = new ResourceImgLoader();
			return _me;
		}
		
		override protected function onComplete(event : Event) : void {
			_datas[_loaders[LoaderInfo(event.target).loader]] = Bitmap(event.target.content).bitmapData;
			var func : Function = _callbackFuncs[_loaders[LoaderInfo(event.target).loader]];
			if(func != null) 
				func();
		}
		
		public function loadRes(index : int) : BitmapData {
			return getResourceByIndex(index);
		}
		
		private var copyRange : Rectangle = new Rectangle();
		public function load(index : int, x : int, y : int) : BitmapData {
			createResourceRange(index, x, y);
			return getPieceOfResourceFromRange(copyRange, index);
		}
		
		private function createResourceRange(index : int, x : int, y : int) : void {
			setposition(copyRange, x * _cellWidth, y * _cellHeight, _cellWidth, _cellHeight);
			if(!sourceImageRange(getResourceByIndex(index)).containsRect(copyRange)) {
				setposition(copyRange, DEFAULT_RESOURCE_RANGE.x, DEFAULT_RESOURCE_RANGE.y, 
						DEFAULT_RESOURCE_RANGE.width, DEFAULT_RESOURCE_RANGE.height);
			} 
		}
		
		private function setposition(range : Rectangle, x : int, y : int, width : int, height : int) : void {
			range.setEmpty();
			range.offset(x, y);
			range.inflate(width, height);
		}
		
		private var srcImageRange : Rectangle = new Rectangle();
		private function sourceImageRange(imageData : BitmapData) : Rectangle {
			if(imageData == null) {
				setposition(srcImageRange, DEFAULT_RESOURCE_RANGE.x, DEFAULT_RESOURCE_RANGE.y, 
						DEFAULT_RESOURCE_RANGE.width, DEFAULT_RESOURCE_RANGE.height);
			} else {
				setposition(srcImageRange, 0, 0, imageData.width, imageData.height);
			}
			return srcImageRange;
		}
		
		private var copy : BitmapData = new BitmapData(_cellWidth, _cellHeight, true, 0x00000000);
		private function getPieceOfResourceFromRange(copyRange : Rectangle, index : int) : BitmapData {
			var resource : BitmapData = getResourceByIndex(index);
			if(resource != null) {
				copy.copyPixels(resource, copyRange, DEFAULT_DRAW_TO_POINT);
			}
			return copy;
		}
		
		public function getResourceByIndex(index : int) : BitmapData {
			//TODO 实现对资源的管理
			return _datas[Reslist.ID_FORMAT.format(index)];
		}
	}
}

