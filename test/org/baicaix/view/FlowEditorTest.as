/**
 * @file FlowEditorTest.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-3
 * @updatedate 2010-2-3
 */   
package org.baicaix.view {
	import com.bit101.components.CheckBox;
	import com.bit101.components.FPSMeter;
	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;
	import com.bit101.components.WheelMenu;

	import org.baicaix.file.FileManager;
	import org.baicaix.flow.FlowEditor;
	import org.baicaix.flow.FlowMapSelector;
	import org.baicaix.flow.FlowResourceSelector;
	import org.baicaix.flow.display.FlowShower;
	import org.baicaix.flow.resouece.DataConvertor;
	import org.baicaix.flow.resouece.ResourceCreator;
	import org.baicaix.flow.resouece.ResourceDataLoader;
	import org.baicaix.flow.resouece.ResourceImgLoader;
	import org.baicaix.map.Map;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author dengyang
	 */
	public class FlowEditorTest extends Sprite {
		
		private var map : Map;
		private var timer : Timer;
		
		private var editor : FlowEditor;
		public var flowShower : FlowShower;
		public var flowShower2 : FlowShower;
		private var imgLoader : ResourceImgLoader;
		private var dataLoader : ResourceDataLoader = ResourceDataLoader.getInstance();
		
		private var fileManager : FileManager;
		private var dataConvertor : DataConvertor;
		
		private var firstSourceIndex : uint = 22213312;
		private var secondSourceIndex : uint = 11212212;
		
		private var resourceCreator : ResourceCreator;
		
		private var wheelMene : WheelMenu;
		
		private var leftBottomVBox : VBox;
		
		public function FlowEditorTest() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			new FPSMeter(this);
			resourceCreator = new ResourceCreator();
			
			dataLoader= new ResourceDataLoader();
			imgLoader = new ResourceImgLoader();
			imgLoader.loadResource("img/"+firstSourceIndex+".jpg");
			imgLoader.loadResource("img/"+secondSourceIndex+".jpeg");
			
			timer = new Timer(1000, 1);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, test);
		}
		
		private function test(event : Event = null) : void {
			timer.removeEventListener(TimerEvent.TIMER, test);
			timer.stop();
			
			editor = new FlowEditor();
			
			flowShower = new FlowShower(imgLoader, 400, 400, FlowResourceSelector);
			flowShower.register(editor);
			this.addChild(flowShower);
			flowShower2 = flowShower;
			loadLayerOne();
			
			flowShower = new FlowShower(imgLoader, 600, 500, FlowMapSelector);
			flowShower.register(editor);
			this.addChild(flowShower);
			flowShower.x = 450;
			//加载新地图
			map = new Map();
			map.createResourceLayer(0);
			loadMap();
			
			fileManager = new FileManager();
			
			dataConvertor = new DataConvertor();
			
			leftBottomVBox  = new VBox(this);
			leftBottomVBox.y = 400;
			leftBottomVBox.addChild(new PushButton(this, 0, 0, "copy range", copyRange));
			leftBottomVBox.addChild(new PushButton(this, 0, 0, "paste range", pasteRange));
			leftBottomVBox.addChild(new PushButton(this, 0, 0, "load Layer 1", loadLayerOne));
			leftBottomVBox.addChild(new PushButton(this, 0, 0, "load Layer 2", loadLayerTwo));
			leftBottomVBox.addChild(new CheckBox(this, 0, 0, "drawLine", drawLine));
			leftBottomVBox.addChild(new CheckBox(this, 0, 0, "drawType", drawType));
			leftBottomVBox.addChild(new PushButton(this, 0, 0, "refresh", refresh));
			
			var rightBottomVBox : VBox  = new VBox(this);
			rightBottomVBox.y = 400;
			rightBottomVBox.x = 150;
		 	rightBottomVBox.addChild(new PushButton(this, 0, 0, "none", none));
			rightBottomVBox.addChild(new PushButton(this, 0, 0, "zudang", zudang));
			rightBottomVBox.addChild(new PushButton(this, 0, 0, "cloud", cloud));
			rightBottomVBox.addChild(new PushButton(this, 0, 0, "water", water));
			rightBottomVBox.addChild(new PushButton(this, 0, 0, "tizi", tizi));
			rightBottomVBox.addChild(new PushButton(this, 0, 0, "door", door));
			
			var menuVBox : VBox  = new VBox(this);
			menuVBox.y = 400;
			menuVBox.x = 250;
		 	menuVBox.addChild(new PushButton(this, 0, 0, "openImg", openImg));
		 	menuVBox.addChild(new PushButton(this, 0, 0, "openMap", openMap));
		 	menuVBox.addChild(new PushButton(this, 0, 0, "saveMap", saveMap));
		 	menuVBox.addChild(new PushButton(this, 0, 0, "saveImg", saveImg));
			
			wheelMene = new WheelMenu(this, 5, 100, 20, 50);
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}

		private function loadMap() : void {
			editor.loadMap(map);
			flowShower.loadMap(map);
		}

		
//		private function imageLoaded(event:Event):void {
//            event.target.removeEventListener(Event.COMPLETE, imageLoaded);
//        	
//            var bitmap:Bitmap = Bitmap(event.target.loader.content);
//            this.addChild(bitmap);
//        }
        
        private static const REGEX_SUBFIX : RegExp = new RegExp('\\.(\\w+?)$');
        private function onOpenImg(url : String) : void {
        	imgLoader.loadResource(url);
//        	var name : String = REGEX_SUBFIX.exec(url)[1];
			try {
				dataLoader.loadResource(url.replace(REGEX_SUBFIX, ".txt"));
			} catch (e:Error) {
			
			}
        	
        	//only for test
        	var keystr : String = REGEX_INDEX.exec(url)[1];
        	var key : int = int(keystr);
        	
        	leftBottomVBox.addChild(new PushButton(this, 0, 0, "load Layer "+key, function (e:Event = null):void {
        		//实际中应该是读取
				var map : Map = dataLoader.getResourceMap(""+key);
				if(map == null) {
					//新建,加入到管理中
					map = resourceCreator.createDataByResource(key, imgLoader.getResourceByIndex(key));
					dataLoader.put(key, map);
				}
				flowShower2.loadMap(map);
			}));
        }
        
        private static const REGEX_INDEX : RegExp = new RegExp('(\\w+?)\\.');
        private function onOpenMap(url : String) : void {
        	dataLoader.loadResource(url);
        	var name : String = REGEX_INDEX.exec(url)[1];
        	
        	leftBottomVBox.addChild(new PushButton(this, 0, 0, "load map "+name, function(e:Event):void {
				map = dataLoader.getResourceMap(name);
				loadMap();
			}));
        }
		
		private function openImg(e:Event):void {
			fileManager.onOpen = onOpenImg;
			fileManager.openFile(e);
		}
		
		private function openMap(e:Event):void {
			fileManager.onOpen = onOpenMap;
			fileManager.openFile(e);
		}
		
		private function saveMap(e:Event):void {
			var cont : String = dataConvertor.saveMap(map);
			fileManager.content = cont;
			fileManager.saveFileTo(e);
		}
		
		private function saveImg(e:Event):void {
			//测试需要，暂时省去了定位图片data存放位置
			var datas : Array = dataLoader.datas;
			for each (var data : Map in datas) {
				var cont : String = dataConvertor.saveMap(data);
				fileManager.content = cont;
				fileManager.saveFile(e);
			}
		}
		
		private function none(e:Event):void {
			editor.setTileType(0);
		}
		
		private function zudang(e:Event):void {
			editor.setTileType(1);
		}
		
		private function cloud(e:Event):void {
			editor.setTileType(2);
		}
		
		private function water(e:Event):void {
			editor.setTileType(3);
		}
		
		private function tizi(e:Event):void {
			editor.setTileType(4);
		}
		
		private function door(e:Event):void {
			editor.setTileType(5);
		}
		
		private function drawLine(e:Event):void {
			//FIXME 此处获取checkbox的方式不妥
			editor.drawLine(CheckBox(e.target.parent).selected);
		}
		
		private function drawType(e:Event):void {
			//FIXME 此处获取checkbox的方式不妥
			editor.drawType(CheckBox(e.target.parent).selected);
		}
		
		private function refresh(e:Event):void {
			editor.refreshMap();
		}
		
		private function onClick(e:MouseEvent):void {
			if(e.altKey) {
				wheelMene.show();
			}
		}
		
		private function copyRange(e:MouseEvent):void {
			this.editor.copyRange();
		}
		
		private function pasteRange(e:MouseEvent):void {
			this.editor.pasteRange();
		}
		
		private function loadLayerOne(e:Event = null):void {
			var map : Map = resourceCreator.createDataByResource(firstSourceIndex, imgLoader.getResourceByIndex(firstSourceIndex));
			flowShower2.loadMap(map);
		}
		
		private function loadLayerTwo(e:Event = null):void {
			var map : Map = resourceCreator.createDataByResource(secondSourceIndex, imgLoader.getResourceByIndex(secondSourceIndex));
			flowShower2.loadMap(map);
			
		}
	}
}
