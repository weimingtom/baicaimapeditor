/**
 * @file CellViewTest.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-26
 * @updatedate 2010-1-26
 */   
package org.baicaix.editor {
	import org.baicaix.editor.view.CellView;
	import org.baicaix.map.MapLayer;
	import org.baicaix.map.MapTile;

	import flash.display.Sprite;

	/**
	 * @author dengyang
	 */
	public class CellViewTest extends Sprite {
		public function CellViewTest() {
			var cellView : CellView = new CellView(new Cell(new Sheet(new Editor(), new MapLayer()), new MapTile()));
			this.addChild(cellView);
			cellView.drawLine();
			cellView.drawBottomRim();
			cellView.drawTopRim();
			cellView.drawRightRim();
			cellView.drawLeftRim();
		}
	}
}
