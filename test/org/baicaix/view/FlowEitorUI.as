package org.baicaix.view {
	import com.bit101.components.InputText;
	import com.bit101.baicaix.components.LayerBox;
	import com.bit101.components.CheckBox;
	import com.bit101.components.HBox;
	import com.bit101.components.PushButton;
	import com.bit101.components.RadioButton;
	import com.bit101.components.VBox;
	import com.bit101.components.Window;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	/**
	 * 1 UI
	 * 2 新建
	 * 3 保存、打开
	 * 4 多层
	 * 5 整体bitmap
	 * 6 资源转换
	 * 7 flex ui
	 * @author Poplar
	 */
	public class FlowEitorUI extends Sprite {
		
		private var window : Window; 
		private var selectedLayer : RadioButton;
		private var layerVBox : LayerBox;
		
		public function FlowEitorUI() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			buildUI();
		}
		
		private function buildUI() : void {
			
			buildEditMenu();
			buildResMenu();
			buildLayerMenu();
			buildCreateMapWindow();
			
//			var wheelMene : WheelMenu = new WheelMenu(this, 5, 100, 20, 50);
//			stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function buildEditMenu() : void {
			var editMenu : Sprite = new Sprite();
			this.addChild(editMenu);
			var menuHBox : HBox  = new HBox(editMenu);
			menuHBox.addChild(new PushButton(editMenu, 0, 0, "new", newMap));
			menuHBox.addChild(new PushButton(editMenu, 0, 0, "refresh"));
			menuHBox.addChild(new PushButton(editMenu, 0, 0, "openImg"));
		 	menuHBox.addChild(new PushButton(editMenu, 0, 0, "openMap"));
		 	menuHBox.addChild(new PushButton(editMenu, 0, 0, "saveMap"));
		 	menuHBox.addChild(new PushButton(editMenu, 0, 0, "saveImg"));
		}

		private function buildResMenu() : void {
			var resMenu : Sprite = new Sprite();
			this.addChild(resMenu);
			resMenu.y = 300;
			var resVBox : VBox  = new VBox(resMenu);
			resVBox.addChild(new CheckBox(resMenu, 0, 0, "drawLine"));
			resVBox.addChild(new CheckBox(resMenu, 0, 0, "drawType"));
		 	resVBox.addChild(new PushButton(resMenu, 0, 0, "none"));
			resVBox.addChild(new PushButton(resMenu, 0, 0, "zudang"));
			resVBox.addChild(new PushButton(resMenu, 0, 0, "cloud"));
			resVBox.addChild(new PushButton(resMenu, 0, 0, "water"));
			resVBox.addChild(new PushButton(resMenu, 0, 0, "tizi"));
			resVBox.addChild(new PushButton(resMenu, 0, 0, "door"));
		}
		
		private function buildLayerMenu() : void {
			var layerMenu : Sprite = new Sprite();
			this.addChild(layerMenu);
			layerMenu.x = 115;
			layerMenu.y = 300;
			var resVBox : VBox  = new VBox(layerMenu);
			resVBox.x = 50;
			resVBox.addChild(new PushButton(layerMenu, 0, 0, "GotoTop", gotoTop));
			resVBox.addChild(new PushButton(layerMenu, 0, 0, "GoUp", goUp));
			resVBox.addChild(new PushButton(layerMenu, 0, 0, "GoDown", goingDown));
			resVBox.addChild(new PushButton(layerMenu, 0, 0, "GotoBottom"));
			
			layerVBox = new LayerBox(layerMenu);
			var layer : RadioButton;
			layer = RadioButton(layerVBox.addChild(new RadioButton(layerMenu, 0, 0, "layer1", true, onSelected)));
			layer = RadioButton(layerVBox.addChild(new RadioButton(layerMenu, 0, 0, "layer2", false, onSelected)));
			layer = RadioButton(layerVBox.addChild(new RadioButton(layerMenu, 0, 0, "layer3", false, onSelected)));
			layer = RadioButton(layerVBox.addChild(new RadioButton(layerMenu, 0, 0, "layer4", false, onSelected)));
		}
		
		private function onSelected(event : Event) : void {
			selectedLayer = RadioButton(event.currentTarget);
			trace('selectedLayer: ' + (selectedLayer));
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
	}
}
