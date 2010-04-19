package com.worms.gun {
    import com.worms.manager.MatterPondManager;
    import com.worms.missile.Missile;
    import com.worms.utility.WormsBatleUtility;
    
    import flash.display.Sprite;
    import flash.geom.Point;
    
	public class Gun extends Sprite {
	    public static const CIRCLE_RADIUS:Number = 5;
		public function Gun() {
		    super();
		}
		
		public function fire():void {
		    var m:Missile = MatterPondManager.getInstance().getMissile();
		    
		    var startP:Point = getMissileFirePoint();
		    m.fire(rotation,startP.x,startP.y);
		}
		
		private function getMissileFirePoint():Point {
		    var radians:Number = WormsBatleUtility.convertAngleToRadians(rotation);
		    var startX:Number = x + Math.cos(radians)*CIRCLE_RADIUS;
		    var startY:Number = y + Math.sin(radians)*CIRCLE_RADIUS;
		    
		    return new Point(startX,startY);
		}
	}
}