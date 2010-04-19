package org.baicaix.game.warworms.missile {
	import org.baicaix.utils.RadiansUtil;
	import com.worms.explosion.Explosion;
	import flash.events.Event;
	import flash.display.Sprite;

	/**
	 * 1 发射速度
	 * 2 爆炸延时
	 * 3 爆炸范围 
	 * 
	 * a 焰尾
	 * b 爆炸效果
	 * @author baicaix
	 */
	public class Missile extends Sprite {
		
		private var _speed : Number;
		private var _delay : int;
		private var _power : int;

		public function Missile() {
			this.graphics.beginFill(0xcc9900);
			this.graphics.drawCircle(x, y, 3);
			this.graphics.endFill();
		}
		
		public function fire(angle:Number, x : Number, y : Number) : void {
			this._speed = 20;
			this._power = 1;
			this._delay = 1;
			
			this.x = x; 
			this.y = y;
			this.rotation = angle;
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(event : Event) : void {
			//碰撞检测
			hitTest();
			//武器运动
			missileRun();
		}

		private function hitTest() : void {
			var isOver : Boolean = false;
			if(isOver) {
				collection();
				explosion();
			}				
		}
		
		private function collection() : void {
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			//TODO hui shou
		}
		
		private function explosion() : void {
			var ex : Explosion = new Explosion();	
			ex.endEffect();
		}

		private var earthSpeed : Number = 0;
		private var windSpeed : Number = 5;
		private function missileRun() : void {
			var radians : Number = RadiansUtil.angleToRadians(rotation);
			var vx : Number = Math.cos(radians) * _speed;
			var vy : Number = Math.sin(radians) * _speed;
			
			//风速
			//重力
			earthSpeed += 1;
			vy += earthSpeed;
			
//			vx += windSpeed;
			
			this.x += vx;
			this.y += vy;
		}
	}
}
