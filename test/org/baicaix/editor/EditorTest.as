///////////////////////////////////////////////////////////
//  Editor.as
//  Macromedia ActionScript Implementation of the Class Editor
//  Generated by Enterprise Architect
//  Created on:      22-һ��-2010 10:41:16
//  Original author: dengyang
///////////////////////////////////////////////////////////

package org.baicaix.editor {
	import flexunit.framework.TestCase;

	import flash.geom.Rectangle;

	/**
	 * @author dengyang
	 * @version 1.0
	 * @created 22-һ��-2010 10:41:16
	 */
	public class EditorTest extends TestCase {
		
		override public function setUp():void{
	        super.setUp();
	    }

	    override public function tearDown():void   {
	        super.tearDown();
	    }	
		
		/**
		 * 根据类型和序号，寻找相应的层
		 */
		private function findLayer() : void {
		}
				
		/**
		 * 選取區域
		 * @param index    index
		 */
		public function selectRange() : void {
		}

		/**
		 * 拷貝區域
		 */
		public function copyRange() : void {
		}

		/**
		 * 粘貼區域
		 */
		public function testPasteRange() : void {
//			var startX : int = 3;
//			var startY : int = 4;
//			var width : int = 5; 
//			var height : int = 6;
//			var srcSheet : Sheet = new Sheet(new Editor(), new MapLayer());
//			srcSheet.initCellsBySrc(new BitmapData(3111, 1333), -1333);
//			var srcRange : Range = new Range();
//			srcRange.selectRange(srcSheet, new Rectangle(startX, startY, width, height));
//			
//			this._range.p
		}
		
		/**
		 * 取消选取区域
		 */
		public function cancelSelectRange() : void {
		}
		
		/**
		 * 取消拷贝内容
		 */
		public function clearCopyRange() : void {
		}

		/**
		 * 
		 * @param index    index
		 */
		public function selectLayer(index : int) : void {
		}

		/**
		 * 
		 * @param index    index
		 */
		public function turnUpLayer(index : int) : void {
		}

		/**
		 * 
		 * @param index    index
		 */
		public function turnDownLayer(index : int) : void {
		}

		/**
		 * 
		 * @param index    index
		 */
		public function hideLayer(index : int) : void {
		}

		/**
		 * 
		 * @param index    index
		 */
		public function showLayer(index : int) : void {
		}

		/**
		 * 
		 * @param index    index
		 */
		public function lockLayer(index : int) : void {
		}

		/**
		 * 
		 * @param index    index
		 */
		public function unlockLayer(index : int) : void {
		}

		/**
		 * 
		 * @param z
		 * @param name    name
		 */
		public function addLayer(z : int, name : String) : void {
		}
	}//end Editor
}