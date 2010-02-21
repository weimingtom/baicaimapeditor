/**
 * @file EditorViewTest.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-26
 * @updatedate 2010-1-26
 */   
package org.baicaix.editor {
	import com.bit101.baicaix.components.ScrollPane;
	import com.bit101.components.HBox;
	import com.bit101.components.InputText;
	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;

	import org.baicaix.units.Command;
	import org.baicaix.units.KeyboardManager;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;

	/**
	 * @author dengyang
	 */
	public class EditorViewTest extends Sprite {
		//------------------------------------
		// private, protected properties
		//------------------------------------
		private var leftTopPane : ScrollPane;
		private var leftBottomVBox : VBox;
//		private var rightPane : ScrollPane;
		
		private var input:InputText;
		private var editor : Editor;
		private var _loader : Loader;
		private static var _imageData : BitmapData;

		//------------------------------------
		// public properties
		//------------------------------------
		

		//------------------------------------
		// constructor
		//------------------------------------

		public function EditorViewTest() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			initButton();
			
			testCreateEmptyEditor(100, 100);
//			testCreateEmptyEditor(350, 400);
			loadImage();
		}
		
		private function initButton() : void {
			editor = new Editor();
			
			var mainHbox : HBox = new HBox(this);
			
			var leftVbox : VBox = VBox(mainHbox.addChild(new VBox(this)));
			leftTopPane = ScrollPane(leftVbox.addChild(new ScrollPane(this, 0, 0, 300, 400)));
			var leftBottomPane : ScrollPane = ScrollPane(leftVbox.addChild(new ScrollPane(this, 0, 0, 300, 400)));
			leftBottomVBox  = VBox(leftBottomPane.addChild(new VBox(this)));
			
//			rightPane = ScrollPane(mainHbox.addChild(new ScrollPane(this, 0, 0, 300, 400)));
			
			//			var rightBox : VBox = VBox(mainHbox.addChild(new VBox(this)));
			PushButton(leftBottomVBox.addChild(new PushButton(this, 0, 0, "copy range", copyRange)));
			PushButton(leftBottomVBox.addChild(new PushButton(this, 0, 0, "paste range", pasteRange)));
			PushButton(leftBottomVBox.addChild(new PushButton(this, 0, 0, "set tile type", setType)));
			PushButton(leftBottomVBox.addChild(new PushButton(this, 0, 0, "show tile type", showType)));
			PushButton(leftBottomVBox.addChild(new PushButton(this, 0, 0, "hide tile type", hideType)));
			
			input = InputText(leftBottomVBox.addChild(new InputText(this, 0, 0, "1")));
			input.width = 100;
			
			KeyboardManager.getInstance().init(this.stage);
			KeyboardManager.registerKeyCommand(67, new Command(editor, copyRange, null), null, [Keyboard.CONTROL]);
			KeyboardManager.registerKeyCommand(86, new Command(editor, pasteRange, null), null, [Keyboard.CONTROL]);
		}

		private function copyRange(e:MouseEvent):void {
			this.editor.copyRange();
		}
		
		private function pasteRange(e:MouseEvent):void {
			this.editor.pasteRange();
		}
		
		private function setType(e:MouseEvent):void {
			this.editor.setTileType(int(input.text));
		}

		private function showType(e:MouseEvent):void {
			this.editor.showTileType();
		}
		
		private function hideType(e:MouseEvent):void {
			this.editor.hideTileType();
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function loadImage() : void {
			if(_imageData == null) {
				_loader = new Loader();
				var m_request : URLRequest = new URLRequest("img/shoushou2.jpeg");//neil_webb.jpg");//
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
				_loader.load(m_request);
			}
		}
		
		private function onComplete(event : Event) : void {
			_imageData = Bitmap(_loader.content).bitmapData;
			testCreateResourceEditor();
		}

		// PUBLIC
		//________________________________________________________________________________________________
		
		private function testCreateEmptyEditor(width : int = 0, height : int = 0) : void {
			editor.createMap(width, height);
			var sheet : Sheet = editor.addEmptyLayer(-100, "firstLayer");
//			sheet.drawLine();
			
//			rightPane.addChild(sheet.view);
		}

		private function testCreateResourceEditor() : void {
			editor.createMap(15, 10);
			var sheet : Sheet = editor.addResourceLayer(_imageData, 10000010);
			sheet.drawLine();
			leftTopPane.addChild(sheet.view);
		}
	}
}