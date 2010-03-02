/**
 * @file ResourceCreator.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-5
 * @updatedate 2010-2-5
 */   
package org.baicaix.single.resource {
	import org.baicaix.modules.beans.Map;

	import flash.display.BitmapData;
	import flash.utils.getTimer;

	/**
	 * @author dengyang
	 */
	public class ResourceCreator {
		
		//TODO 这两个应该改为全局变量
		private var cellWidth : int = 32;
		private var cellHeight : int = 32;
		
		public function createResourceKey() : int {
			return getTimer();
		}
		
		public function createDataByResource(index : int, imageData : BitmapData) : Map {
			var width : int = Math.ceil(imageData.width / cellWidth);
			var height : int = Math.ceil(imageData.height / cellHeight);
			var map : Map = new Map(width, height);
			map.createResourceLayer(index);
			return map;
		}
	}
}
