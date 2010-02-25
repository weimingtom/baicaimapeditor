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
	import com.bit101.baicaix.components.FlowScrollPane;

	import org.baicaix.map.Map;
	import org.baicaix.single.FlowEditor;
	import org.baicaix.single.resource.ResourceDataLoader;
	import org.baicaix.single.resource.ResourceImgLoader;

	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * @author dengyang
	 */
	public class FlowShower extends Sprite {
		
		private var cellWidth : int;
		private var cellHeight : int;
		private var flowBrowser : FlowBrowser;
		
		public function FlowShower(loader : ResourceImgLoader, width : int, height : int, Selector : Class, cellWidth : int = 32, cellHeight : int = 32) {
			
			this.cellWidth = cellWidth;
			this.cellHeight = cellHeight;
			
			var scrollPane : FlowScrollPane = FlowScrollPane(this.addChild(new FlowScrollPane(this, 0, 0, width, height)));
			var camera : FlowCamera = new FlowCamera(width, height, cellWidth, cellHeight, 5);
			flowBrowser = FlowBrowser(scrollPane.addChild(new FlowBrowser(camera, new Point(88, 88), loader, Selector)));
		}
		
		public function register(editor :FlowEditor) : void {
			flowBrowser.register(editor);
		}
		
		public function loadMap(map : Map, name : String = "") : void {
			//TODO 需要支持多层
			//测试期间 注册到loader中
			ResourceDataLoader.getInstance().put(map.index, map);
			flowBrowser.loadMap(map);
		}

//		public function loadLayer(layer : MapLayer) : void {
//			flowBrowser.showLayer(layer);
//		}
//		
		public function showLayer(map : Map) : void {
			flowBrowser.loadMap(map);
		}
	}
}
