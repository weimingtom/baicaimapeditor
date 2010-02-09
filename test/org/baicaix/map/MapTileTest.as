/**
 * @file Tile.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-20
 * @updatedate 2010-1-20
 */   
package org.baicaix.map {
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;

	/**
	 * @author dengyang
	 */
	public class MapTileTest extends TestCase {
		//------------------------------------
		// private, protected properties
		//------------------------------------

		private var tile : MapTile;

		//------------------------------------
		// public properties
		//------------------------------------
		

		//------------------------------------
		// constructor
		//------------------------------------

		public function MapTileTest(methodName : String = null) {
			super.methodName = methodName;
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________

		

		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function setUp() : void {
			super.setUp();
			tile = new MapTile();
		}

		override public function tearDown() : void {
			super.tearDown();
		}	
		
		public function testSetSource() : void {
			setUp();
			
			var src : int = -1000;
			var srcX : int = 11;
			var srcY : int = 22;
			
			tile.setSource(src, srcX, srcY);
			assertEquals(tile.src , src);
			assertEquals(tile.srcX , srcX);
			assertEquals(tile.srcY , srcY);
		}

		public function testPaste() : void {
			setUp();
			
			var src : int = -1000;
			var srcX : int = 11;
			var srcY : int = 22;
			
			var tempTile : MapTile = new MapTile();
			tempTile.setSource(src, srcX, srcY);
			
			tile.paste(tempTile);
			assertEquals(tile.src , tempTile.src);
			assertEquals(tile.srcX , tempTile.srcX);
			assertEquals(tile.srcY , tempTile.srcY);
		}
		
		public function buildAllTest() : TestSuite {
			var suite:TestSuite = new TestSuite();  
			suite.addTest(new MapTileTest("testPaste"));
            suite.addTest(new MapTileTest("testSetSource"));
            return suite;
		}
	}
}
