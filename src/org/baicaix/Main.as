/**
 * @file Main.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-20
 * @updatedate 2010-1-20
 */   
package org.baicaix {
	import org.baicaix.serialization.SerializeToJSON;
	import flash.display.Sprite;

	/**
	 * @author dengyang
	 */
	public class Main extends Sprite {
		public function Main() {
			new SerializeToJSON();
		}
	}
}
