package org.baicaix.file {
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;
	import com.bit101.components.VBox;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ReadFileMain extends Sprite
	{
		//only for test
		private var text : Text;
		private var fileMnger : FileManager;
		
		public function ReadFileMain()
		{
			super();
			fileMnger = new FileManager();
			this.addChild(fileMnger);
			text = new Text(this, 0, 0, "aaaa");
			var vbox : VBox = new VBox(this, 400, 0);
			vbox.addChild(new PushButton(this, 0, 0, "open", fileMnger.openFile));
			vbox.addChild(new PushButton(this, 0, 0, "save", fileMnger.saveFile));
			vbox.addChild(new PushButton(this, 0, 0, "save as", fileMnger.saveFileTo));
			
			fileMnger.addEventListener(Event.OPEN, onOpen);
		}
		
		private function onOpen(event : Event) : void {
			text.text = String(FileManager(event.target).content);
		}
	}
}