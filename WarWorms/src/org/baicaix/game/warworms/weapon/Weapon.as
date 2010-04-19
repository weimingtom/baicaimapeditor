package org.baicaix.game.warworms.weapon {
	import org.baicaix.game.warworms.managers.MatterPondManager;
	import org.baicaix.game.warworms.missile.Missile;

	import flash.display.Sprite;

	/**
	 * 1 决定发射方向
	 * 2 力度
	 * 2 发射但要可以替换
	 * @author baicaix
	 */
	public class Weapon extends Sprite {
		
		public function Weapon() {
			
			this.graphics.beginFill(0x99cc00);
			this.graphics.drawCircle(x, y, 3);
			this.graphics.drawCircle(150, 0, 10);
			this.graphics.endFill();
			
		}

		public function fire() : void {
			Missile(stage.addChild(MatterPondManager.getInstance().get(Missile))).fire(this.rotation, x, y);
		}
	}
}
