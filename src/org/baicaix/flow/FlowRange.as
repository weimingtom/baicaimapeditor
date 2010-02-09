/**
 * @file IFlowRange.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-8
 * @updatedate 2010-2-8
 */   
package org.baicaix.flow {
	import org.baicaix.map.MapLayer;

	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	/**
	 * @author dengyang
	 */
	public interface FlowRange {
		
		function get range() : Rectangle;

		function get cells() : Dictionary;
		
		/**
		 * 選取區域
		 */
		function selectRange(layer: MapLayer, range : Rectangle) : void;
		
		/**
		 * 粘贴区域
		 */
		function pasteRange(baseRange : FlowRange, sourceCellRange : FlowRange) : void;
		
		function setTileType(type : int) : void;

		function cancelRange() : void;

		/**
		 * 顯示邊框
		 */
		function drawRim() : void;
		
		/**
		 * 清除邊框
		 */
		function clearRim() : void;
		
		function clear() : void;

		function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void;
		
		function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void;
	}
}
