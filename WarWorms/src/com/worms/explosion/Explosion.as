package com.worms.explosion {
	import com.worms.manager.MatterPondManager;
	import com.worms.map.BattleMap;

	import flash.display.MovieClip;
	import flash.geom.Point;

	/**
	 * 爆炸
	 */
	public class Explosion extends MovieClip {

		public function Explosion() {
		}

		public function startEffect(x : Number,y : Number,power : Number,globalPoint : Point) : void {
			this.x = x;
			this.y = y;
            
			this.gotoAndPlay(2);
			this.scaleX = this.scaleY = 2;
            
			BattleMap.getInstance().explosion(globalPoint, power);
		}

		public function endEffect() : void {
			MatterPondManager.getInstance().recycleExposion(this);
		}
	}
}