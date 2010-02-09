/**
 * @file line.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-25
 * @updatedate 2010-1-25
 */   
package org.baicaix.units{
	import flash.display.Sprite;

	/**
	 * @author dengyang
	 */
	public class line extends Sprite {
		internal static const LINE_RIM_COLOR : uint = 0x00FF00;
		
		public function line() {
			with(this.graphics) {
				
				lineStyle(2, LINE_RIM_COLOR);
				moveTo(0, 0);
				lineTo(0, 32);
				lineTo(32, 32);
				lineTo(32, 0);
				lineTo(0, 0);
			}
		}
	}
}
