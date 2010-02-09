/**
 * @file IManager.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-23
 * @updatedate 2010-1-23
 */   
package org.baicaix.source {
	import flash.display.BitmapData;

	/**
	 * @author dengyang
	 */
	public interface IManager {
		function save(bitmapdata : BitmapData) : int;
		function load(index : int) : BitmapData;
	}
}
