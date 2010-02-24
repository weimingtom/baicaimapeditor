package views{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.containers.Panel;
	import mx.controls.Button;

	[Event(name="restore")]
	[Event(name="maximize")]

	public class MaxRestorePanel extends Panel{
		private var state:int = 0;
		private var btStateUp: Button;
		private var btStateDown: Button;

		[Embed("../assets/upArrow.gif")]
		private var buttonUpIcon:Class;
		[Embed("../assets/downArrow.gif")]
		private var buttonDownIcon:Class;

		private function setState(state:int):void{
			this.state=state;
			if (state==0){
				this.dispatchEvent(new Event('restore'));
			} else {
				this.dispatchEvent(new Event('maximize'));
			}
		}

		protected override function createChildren(): void {
			super.createChildren();
			btStateUp = new Button();
			btStateDown = new Button();
			btStateUp.addEventListener("click",doMaximize);
			btStateDown.addEventListener("click",doRestore);
			btStateUp.setStyle("overIcon",buttonUpIcon);
			btStateUp.setStyle("downIcon",buttonUpIcon);
			btStateUp.setStyle("upIcon",buttonUpIcon);
			btStateDown.setStyle("overIcon",buttonDownIcon);
			btStateDown.setStyle("downIcon",buttonDownIcon);
			btStateDown.setStyle("upIcon",buttonDownIcon);
			btStateUp.visible =true;
			btStateDown.visible =false;
			rawChildren.addChild(btStateUp);
			rawChildren.addChild(btStateDown);
		}

		protected override function updateDisplayList(unscaledWidth: Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if(unscaledWidth > 0){
				this.visible = true;
			} else {
				this.visible = false;
			}
			
			var upAsset:DisplayObject = btStateUp.getChildByName("upIcon");
			var downAsset:DisplayObject = btStateDown.getChildByName("upIcon");
			var margin:int = 4;

			btStateUp.setActualSize(upAsset.width+margin, upAsset.height+margin);
			btStateDown.setActualSize(downAsset.width+margin, downAsset.height+margin);

			var pixelsFromTop:int = 5;
			var pixelsFromRight:int = 10;
			var buttonWidth:int=btStateUp.width;

			var x:Number = unscaledWidth - buttonWidth - pixelsFromRight;
			var y:Number = pixelsFromTop;
			
			btStateDown.move(x, y);
			btStateUp.move(x, y);

		}

		private function doMaximize(event:Event) :void{
			setState(1);
			btStateUp.visible = false;
			btStateDown.visible = true;
		}

		private function doRestore(event:Event) :void{
			setState(0);
			btStateUp.visible = true;
			btStateDown.visible = false;
		}
	}
}
