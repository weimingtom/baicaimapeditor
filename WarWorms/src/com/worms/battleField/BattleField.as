package com.worms.battleField {
	import com.worms.events.BattleFieldEvent;
	import com.worms.gun.Gun;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * 主要提供战场范围、枪的角度、射击以及射击间隔等
	 */
	public class BattleField extends Sprite {

		public function BattleField() {
			super();
            
			_battleFieldWidth = this.width;
			_getBattleFieldHeight = this.height;
            
			addEventListener(Event.ADDED_TO_STAGE, addToSatgeHandler);
			addEventListener(MouseEvent.MOUSE_MOVE, battleFieldMouseMoveHandler);
			//addEventListener(MouseEvent.MOUSE_DOWN,battleFieldMouseDownHandler);

			instance = this;
		}

		//for gun rotate
		private function battleFieldMouseMoveHandler(e : MouseEvent) : void {
			var dx : Number = mouseX - getTheGun().x;
			var dy : Number = mouseY - getTheGun().y;
			var radians : Number = Math.atan2(dy, dx);
			getTheGun().rotation = radians * 180 / Math.PI;
            
			var battleFieldEvent : BattleFieldEvent = new BattleFieldEvent(BattleFieldEvent.GUN_ROTATE);
			battleFieldEvent.gunAngle = getTheGun().rotation;
			dispatchEvent(battleFieldEvent);
            //这句什么意思？
			e.updateAfterEvent();
		}

		private var continualFireTimer : Timer;

		private function addToSatgeHandler(e : Event) : void {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stageMouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler);
		}

		private function stageMouseDownHandler(e : MouseEvent) : void {
			if(!continualFireTimer) {
				continualFireTimer = new Timer(88);
				continualFireTimer.addEventListener(TimerEvent.TIMER, continualFireTimerHandler);
			}
			continualFireTimer.start();
			//即时的一发，其余都由定时器控制
			getTheGun().fire();
		}

		private function continualFireTimerHandler(e : TimerEvent) : void {
			getTheGun().fire();
		}

		private function stageMouseUpHandler(e : MouseEvent) : void {
			continualFireTimer.stop();
		}

//		private function battleFieldMouseDownHandler(e : MouseEvent) : void {
//			getTheGun().fire();
//		}

		public function getTheGun() : Gun {
			return this["gun"] as Gun;
		}

		private var _battleFieldWidth : Number;

		public function getBattleFieldWidth() : Number {
			return _battleFieldWidth;
		}

		private var _getBattleFieldHeight : Number;

		public function getBattleFieldHeight() : Number {
			return _getBattleFieldHeight;
		}

		private static var instance : BattleField;

		public static function getInstance() : BattleField {
			return instance;
		}
	}
}