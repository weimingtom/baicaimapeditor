package com.worms.utility {
    public class WormsBatleUtility {
        public static function convertAngleToRadians(angle:Number):Number {
            return angle*Math.PI/180;
        }
        
        public static function convertRadiansToAngle(radians:Number):Number {
            return radians*180/Math.PI;
        }
    }
}