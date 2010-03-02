/**
 * @file FlowShower.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-2
 * @updatedate 2010-2-2
 */   
package org.baicaix.single.display {
	import org.baicaix.modules.beans.Map;
	import org.baicaix.single.Editor;
	import org.baicaix.single.resource.ResourceDataLoader;
	import org.baicaix.single.resource.ResourceImgLoader;

	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * @author dengyang
	 */
	public class Shower extends Sprite {
		
		private var cellWidth : int;
		private var cellHeight : int;
		private var flowBrowser : Browser;
		
		public function Shower(loader : ResourceImgLoader, showPixelWidth : int, showPixelHeight : int, Selector : Class, cellWidth : int = 32, cellHeight : int = 32) {
			
			this.cellWidth = cellWidth;
			this.cellHeight = cellHeight;
			
			var camera : Camera = new Camera(showPixelWidth, showPixelHeight, cellWidth, cellHeight, 2);
			flowBrowser = Browser(new Browser(camera, new Point(88, 88), loader, Selector));
		}
		
		public function register(editor :Editor) : void {
			flowBrowser.register(editor);
		}
		
		public function loadMap(map : Map, width : int, height : int, name : String = "") : void {
			//TODO 需要支持多层
			//测试期间 注册到loader中
			ResourceDataLoader.getInstance().put(map.index, map);
			flowBrowser.loadMap(map, width, height);
		}

		public function get browser() : Browser {
			return flowBrowser;
		}
	}
}
