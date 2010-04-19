package org.baicaix.utils {

	/**
	 * @author baicaix
	 */
	public class RadiansUtil {
		
		public static function angleToRadians(angle : Number) : Number {
			return angle / 180 * Math.PI;
		}
		
		public static function radiansToAngle(radians : Number) : Number {
			return radians / Math.PI * 180;
		}
	}
}
