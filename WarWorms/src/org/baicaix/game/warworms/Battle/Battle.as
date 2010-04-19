package org.baicaix.game.warworms.Battle {
	import org.baicaix.game.warworms.managers.MatterPondManager;
	import org.baicaix.game.warworms.weapon.Weapon;
	import org.baicaix.utils.RadiansUtil;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;

	/**
	 * 
	 * 主要提供战场范围、枪的角度、射击以及射击间隔等
	 * @author baicaix
	 */
	public class Battle extends Sprite {
		
		private var weapon : Weapon;

		public function Battle() {
			initStage();
			weapon = this.addChild(new Weapon()) as Weapon;
			weapon.x = 200;
			weapon.y = 200;
			
			MatterPondManager.getInstance().container = stage;
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.addEventListener(MouseEvent.CLICK, mouseClickHandler);
		}

		private function mouseMoveHandler(event : MouseEvent) : void {
			var radians : Number = Math.atan2(event.stageY - weapon.y, event.stageX - weapon.x);
			weapon.rotation = RadiansUtil.radiansToAngle(radians);
		}

		private function mouseClickHandler(event : MouseEvent) : void {
			weapon.fire();			
		}
		
		private function initStage() : void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
	}
}
