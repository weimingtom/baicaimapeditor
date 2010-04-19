package com {
	import com.worms.battleField.BattleField;
	import com.worms.events.BattleFieldEvent;
	import com.worms.events.MatterPondPondEvent;
	import com.worms.gameInfo.GameInfo;
	import com.worms.manager.MatterPondManager;

	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getTimer;

	public class WormsBattleGame extends Sprite {

		public function WormsBattleGame() {
			super();
            
			initStage();
			initEventListener();
		}

		/**
		 * 方法初始化stage数据
		 */
		private function initStage() : void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
            //stage.align = StageAlign.TOP_LEFT;
		}

		/**
		 * 方法初始化所有事件监听
		 */
		private function initEventListener() : void {
			getBattleField().addEventListener(BattleFieldEvent.GUN_ROTATE, gunRatateHandler);
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			MatterPondManager.getInstance().addEventListener(MatterPondPondEvent.MISSILE_POND_COUNT_CHANGED, missilePondCountChangedHandler);
			MatterPondManager.getInstance().addEventListener(MatterPondPondEvent.MISSILE_TAIL_POND_COUNT_CHANGED, missileTailPondCountChangedHandler);
			MatterPondManager.getInstance().addEventListener(MatterPondPondEvent.EXPLOSION_POND_COUNT_CHANGED, explosionPondCountChangedhandler);
		}

		/**
		 * 显示数据
		 */
		private function missilePondCountChangedHandler(e : MatterPondPondEvent) : void {
			getGameInfo().missileCount = e.count.toString();
		}

		private function missileTailPondCountChangedHandler(e : MatterPondPondEvent) : void {
			getGameInfo().missileTailCount = e.count.toString();
		}

		private function explosionPondCountChangedhandler(e : MatterPondPondEvent) : void {
			getGameInfo().explosionCount = e.count.toString();
		}

		private var timeRecordTep : int = 0;

		private function enterFrameHandler(e : Event) : void {
			var nowT : int = getTimer();
			if(timeRecordTep != 0) {
				var diffT : int = nowT - timeRecordTep;
				getGameInfo().fps = Math.floor(1000 / diffT).toString();
			}
			timeRecordTep = nowT;
		}


		/**
		 * 转动
		 */
		private function gunRatateHandler(e : BattleFieldEvent) : void {
			getGameInfo().gunAngle = Math.floor(e.gunAngle).toString() + "°";
		}
		
		/**
		 * 使用方法获取资源
		 */
		private function getGameInfo() : GameInfo {
			return this["gameInfo"];
		}

		private function getBattleField() : BattleField {
			return this["battleField"];
		}
	}
}