/**
 * @file FlowBrowserTest.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-28
 * @updatedate 2010-1-28
 */   
package org.baicaix.view {
	import org.baicaix.flow.display.FlowShower;
	import com.bit101.components.FPSMeter;

	import org.baicaix.flow.FlowResourceSelector;
	import org.baicaix.flow.display.FlowBrowser;
	import org.baicaix.flow.resouece.ResourceCreator;
	import org.baicaix.flow.resouece.ResourceImgLoader;
	import org.baicaix.units.Command;
	import org.baicaix.units.KeyboardManager;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;

	/**
	 * @author dengyang
	 */
	public class FlowBrowserTest extends Sprite {
		
		public var flowBrowser : FlowBrowser;
		private var loader : ResourceImgLoader;
		private var resourceCreator : ResourceCreator;
		
		public function FlowBrowserTest() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			new FPSMeter(this);
			resourceCreator = new ResourceCreator();
			
			loader = new ResourceImgLoader();
			var timer : Timer = new Timer(1000, 1);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, test);

//			flowBrowser = FlowBrowser(this.addChild(new FlowBrowser(100, 150, 3)));
			
			KeyboardManager.getInstance().init(this.stage);
			KeyboardManager.registerKeyCommand(Keyboard.UP, new Command(this, up, null));
			KeyboardManager.registerKeyCommand(Keyboard.DOWN, new Command(this, down, null));
			KeyboardManager.registerKeyCommand(Keyboard.LEFT, new Command(this, left, null));
			KeyboardManager.registerKeyCommand(Keyboard.RIGHT, new Command(this, right, null));
		}
		
		private function test(event : Event = null) : void {
			var firstSourceIndex : int = 1;
			var flowShower : FlowShower = new FlowShower(loader, 400, 400, FlowResourceSelector);
			this.addChild(flowShower);
			flowShower.loadMap(resourceCreator.createDataByResource(firstSourceIndex, loader.getResourceByIndex(firstSourceIndex)));
			
			var secondSourceIndex : int = 0;
			flowShower = new FlowShower(loader, 600, 500, FlowResourceSelector);
			this.addChild(flowShower);
			flowShower.x = 450;
			trace(loader.getResourceByIndex(secondSourceIndex) == loader.getResourceByIndex(firstSourceIndex));
			flowShower.loadMap(resourceCreator.createDataByResource(firstSourceIndex, loader.getResourceByIndex(firstSourceIndex)));
		}

		private function left(event : Event) : void {
			flowBrowser.x--;
		}
		
		private function right(event : Event) : void {
			flowBrowser.x++;
		}
		
		private function up(event : Event) : void {
			flowBrowser.y--;
		}
		
		private function down(event : Event) : void {
			flowBrowser.y++;
		}
	}
}
