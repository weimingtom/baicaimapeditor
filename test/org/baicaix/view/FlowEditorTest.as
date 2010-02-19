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
	import com.bit101.baicaix.components.LayerBox;
	import com.bit101.components.CheckBox;
	import com.bit101.components.HBox;
	import com.bit101.components.InputText;
	import com.bit101.components.PushButton;
	import com.bit101.components.RadioButton;
	import com.bit101.components.VBox;
	import com.bit101.components.WheelMenu;
	import com.bit101.components.Window;

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

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author dengyang
	 */
	public class FlowEditorTest extends Sprite {
		
		private var map : Map;
		
		private var editor : FlowEditor;
		public var mapFlowShower : FlowShower;
		public var resFlowShower : FlowShower;
		private var imgLoader : ResourceImgLoader;
		private var dataLoader : ResourceDataLoader;
		
		private var fileManager : FileManager;
		private var dataConvertor : DataConvertor;
		
		private var resourceCreator : ResourceCreator;
		
		private var wheelMene : WheelMenu;
		
		private var window : Window; 
		private var selectedLayer : RadioButton;
		private var layerVBox : LayerBox;
		
		public function FlowEditorTest() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			resourceCreator = new ResourceCreator();
			
			dataLoader = ResourceDataLoader.getInstance();
			imgLoader = new ResourceImgLoader();
			
			test();
			buildUI();
		}
		
		private function buildUI() : void {
			buildEditMenu();
			buildResMenu();
			buildLayerMenu();
			buildCreateMapWindow();
		}
		
		private function buildEditMenu() : void {
			var editMenu : Sprite = new Sprite();
			this.addChild(editMenu);
			var menuHBox : HBox  = new HBox(editMenu);
			menuHBox.addChild(new PushButton(editMenu, 0, 0, "new", newMap));
			menuHBox.addChild(new PushButton(editMenu, 0, 0, "refresh", refresh));
		 	menuHBox.addChild(new PushButton(editMenu, 0, 0, "openImg", openImg));
		 	menuHBox.addChild(new PushButton(editMenu, 0, 0, "openMap", openMap));
		 	menuHBox.addChild(new PushButton(editMenu, 0, 0, "saveMap", saveMap));
		 	menuHBox.addChild(new PushButton(editMenu, 0, 0, "saveImg", saveImg));
		}

		private function buildResMenu() : void {
			var resMenu : Sprite = new Sprite();
			this.addChild(resMenu);
			resMenu.y = 450;
			var resVBox : VBox  = new VBox(resMenu);
			resVBox.addChild(new CheckBox(resMenu, 0, 0, "drawLine", drawLine));
			var check : CheckBox = CheckBox(resVBox.addChild(new CheckBox(resMenu, 0, 0, "drawType", drawType)));
			check.selected = true;
			resVBox.addChild(new PushButton(resMenu, 0, 0, "none", none));
			resVBox.addChild(new PushButton(resMenu, 0, 0, "zudang", zudang));
			resVBox.addChild(new PushButton(resMenu, 0, 0, "cloud", cloud));
			resVBox.addChild(new PushButton(resMenu, 0, 0, "water", water));
			resVBox.addChild(new PushButton(resMenu, 0, 0, "tizi", tizi));
			resVBox.addChild(new PushButton(resMenu, 0, 0, "door", door));
		}
		
		private function buildLayerMenu() : void {
			var layerMenu : Sprite = new Sprite();
			this.addChild(layerMenu);
			layerMenu.x = 115;
			layerMenu.y = 450;
			var resVBox : VBox  = new VBox(layerMenu);
			resVBox.x = 100;
			resVBox.addChild(new PushButton(layerMenu, 0, 0, "GotoTop", gotoTop));
			resVBox.addChild(new PushButton(layerMenu, 0, 0, "GoUp", goUp));
			resVBox.addChild(new PushButton(layerMenu, 0, 0, "GoDown", goingDown));
			resVBox.addChild(new PushButton(layerMenu, 0, 0, "GotoBottom"));
			
			layerVBox = new LayerBox(layerMenu);
		}
		
		private function gotoTop(event : Event) : void {
			
		}
		private function goUp(event : Event) : void {
			this.turnUpLayer(layerVBox.layers.indexOf(selectedLayer));
			layerVBox.reload();
		}
		
		private function goingDown(event : Event) : void {
			this.turnDownLayer(layerVBox.layers.indexOf(selectedLayer));
			layerVBox.reload();
		}

		/**
		 * 
		 * @param index    index
		 */
		public function turnUpLayer(index : int) : void {
			if(index == 0) return;
			turnup(index);
		}

		/**
		 * 
		 * @param index    index
		 */
		public function turnDownLayer(index : int) : void {
			if(index == layerVBox.layers.length - 1) return;
			turnup(index + 1);
		}
		
		private function turnup(index : int) : void {
			var temp : Array = layerVBox.layers.slice(index - 1, index + 1);
			layerVBox.layers.splice(index -1, 2, temp.pop(), temp.pop());
		}
		
		private function buildCreateMapWindow() : void {
			window = new Window(this, 250, 250, "create new Map");
			window.width = 250;
			window.height = 200;
			window.shadow = true;
			window.visible = false;
			var windowHBox : HBox = HBox(window.addChild(new HBox(window)));
			windowHBox.y = window.height - 30;
			windowHBox.x = 25;
			windowHBox.addChild(new PushButton(windowHBox, 0, 0, "Yes", createNewMap));
			windowHBox.addChild(new PushButton(windowHBox, 0, 0, "Cancel", closeWindow));
			
			var inputVBox : HBox = HBox(window.addChild(new HBox(window)));
			inputVBox.y = 30;
			inputVBox.x = 30;
			inputVBox.addChild(new InputText(windowHBox, 0, 0, "width"));
			inputVBox.addChild(new InputText(windowHBox, 0, 0, "height"));
		}

		private function newMap(event : Event) : void {
			window.visible = true;
		}
		
		private function createNewMap(event : Event) : void {
			//TODO 实现新建地图
		}

		private function closeWindow(event : Event) : void {
			window.visible = false;
		}
		
		private function test(event : Event = null) : void {
			editor = new FlowEditor();
			
			resFlowShower = new FlowShower(imgLoader, 400, 400, FlowResourceSelector);
			resFlowShower.register(editor);
			this.addChild(resFlowShower);
			resFlowShower.y = 30;
			
			mapFlowShower = new FlowShower(imgLoader, 600, 500, FlowMapSelector);
			mapFlowShower.register(editor);
			this.addChild(mapFlowShower);
			mapFlowShower.x = 410;
			mapFlowShower.y = 30;
			//加载新地图
			map = new Map();
			map.createResourceLayer(0);
			loadMap();
			
			fileManager = new FileManager();
			
			dataConvertor = new DataConvertor();
			
			buildUI();
		}

		private function loadMap() : void {
			editor.loadMap(map);
			mapFlowShower.loadMap(map);
		}
        
        private static const REGEX_SUBFIX : RegExp = new RegExp('\\.(\\w+?)$');
        private function onOpenImg(url : String) : void {
        	imgLoader.loadResource(url, function() : void {
        		layerVBox.addChild(new RadioButton(layerVBox, 0, 0, "load Layer "+key, false, loadmap));
        		dataLoader.loadResource(url.replace(REGEX_SUBFIX, ".txt"));
        	});
        	//only for test
        	var keystr : String = REGEX_INDEX.exec(url)[1];
        	var key : int = int(keystr);
			
			function loadmap(event:Event = null):void {
        		//实际中应该是读取
				var map : Map = dataLoader.getResourceMap(""+key);
				if(map == null) {
					//新建,加入到管理中
					map = resourceCreator.createDataByResource(key, imgLoader.getResourceByIndex(key));
					dataLoader.put(key, map);
				}
				resFlowShower.loadMap(map);
				if(event != null)
					selectedLayer = RadioButton(event.currentTarget);
			}
        }
        
        private static const REGEX_INDEX : RegExp = new RegExp('(\\w+?)\\.');
        private static const REGEX_FILENAME : RegExp = new RegExp('(\\w+?)\\.\\w+$');
        private function onOpenMap(url : String) : void {
        	dataLoader.loadResource(url, function():void {
        		var name : String = REGEX_INDEX.exec(url)[1];
				map = dataLoader.getResourceMap(name);
				for each (var key : String in map.ress) {
					//FIXME only for test
					onOpenImg(url.replace(REGEX_FILENAME, key+".jpeg"));
				}
				loadMap();
				refresh();
			});
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
				fileManager.fileName = data.index+".txt";
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
		
		private function refresh(e:Event=null):void {
			editor.refreshMap();
		}
	}
}
