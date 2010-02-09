/**
 * @file BackupRange.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-27
 * @updatedate 2010-1-27
 */   
package org.baicaix.editor {

	/**
	 * @author dengyang
	 */
	public class BackupRange extends Range {
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _bakupRange : Range;
		private var _isCut : Boolean;

		//------------------------------------
		// public properties
		//------------------------------------

		public static const COPY_RIM_COLOR : uint = 0x0000FF;		

		//------------------------------------
		// constructor
		//------------------------------------

		public function BackupRange(range : Range) {
			this._sheet = range.sheet;
			this._range = range.range;
			this._cells = range.cells;
			this._bakupRange = range;
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________


		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function get isCut() : Boolean {
			return this._isCut;
		}

		public function set isCut(isCut : Boolean) : void {
			this._isCut = isCut;
		}
		
		/**
		 * 顯示邊框
		 */
		override public function drawRim() : void {
			findTopCells().forEach( function (cell : Cell, index : int, array : Array) : void {
				cell.drawCopyTopRim();
			});
			findBottomCells().forEach( function (cell : Cell, index : int, array : Array) : void {
				cell.drawCopyBottomRim();
			});
			findLeftCells().forEach( function (cell : Cell, index : int, array : Array) : void {
				cell.drawCopyLeftRim();
			});
			findRightCells().forEach( function (cell : Cell, index : int, array : Array) : void {
				cell.drawCopyRightRim();
			});
		}
		
		override public function cancelRange() : void {
			this._sheet.cancelSelectRange();
		}
	}
}
