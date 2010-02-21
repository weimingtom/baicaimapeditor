/**
 * @file Map.as
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
	public class MapTest extends TestCase {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------

		private var map : Map;
		
		//------------------------------------
		// public properties
		//------------------------------------
		

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function MapTest(methodName : String = null) {
			super.methodName = methodName;
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________

		

		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function setUp():void{
	        super.setUp();
	        map = new Map();
	    }

	    override public function tearDown():void   {
	        super.tearDown();
	    }	

		public function testConvert() : void {
			setUp();
			
			var obj : Object = {layers:[{z:-1000,tiles:{}},{z:-2000,tiles:{}}],height:16,width:18};
			map.convert(obj);
			assertEquals(map.layers.length, 2);
			assertEquals(MapLayer(map.layers[0]).z, -1000);
			assertEquals(map.height, 16);
			assertEquals(map.width, 18);
		}
		
		public function testCreateResourceLayer() : void {
			setUp();
			
			var srcIndex : int = -1111;
			assertEquals(map.layers.length, 0);
			map.createResourceLayer(srcIndex);
			assertEquals(map.layers.length, 1);
			var firstTile : MapTile = MapLayer(map.layers[0]).getTile(0, 0);
			assertNotNull(firstTile);
			var secondTile : MapTile = MapLayer(map.layers[0]).getTile(map.height - 1, map.width - 1);
			assertNotNull(secondTile);
			assertEquals(firstTile.src, srcIndex);
			assertEquals(secondTile.src, srcIndex);
			assertEquals(firstTile.x, firstTile.srcX);
			assertEquals(firstTile.y, firstTile.srcY);
		}
		
		public function testCreateMapLayer() : void {
			setUp();
			
			assertEquals(map.layers.length, 0);
			map.createTemptyLayer();
			assertEquals(map.layers.length, 1);
			assertNull(MapLayer(map.layers[0]).getTile(0, 0));
			assertNull(MapLayer(map.layers[0]).getTile(map.height - 1, map.width - 1));
		}

		public function buildAllTest() : TestSuite {
			var suite:TestSuite = new TestSuite();  
			suite.addTest(new MapTest("testConvert"));
            suite.addTest(new MapTest("testCreateMapLayer"));
            suite.addTest(new MapTest("testCreateResourceLayer"));
            return suite;
		}
	}
}
