/**
 * @file MapLayer.as
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
	 * 1 根据元素生成序列
	 * 2 读取已有序列
	 * @author dengyang
	 */
	public class MapLayerTest extends TestCase {

		//------------------------------------
		// private, protected properties
		//------------------------------------

		private var layer : MapLayer;

		//------------------------------------
		// public properties
		//------------------------------------
		

		//------------------------------------
		// constructor
		//------------------------------------

		public function MapLayerTest(methodName : String = null) {
			super.methodName = methodName;
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________

		

		// PUBLIC
		//________________________________________________________________________________________________

		override public function setUp() : void {
			super.setUp();
			layer = new MapLayer();
		}

		override public function tearDown() : void {
			super.tearDown();
		}	

		public function testCreateKey() : void {
			assertEquals("10,13", layer.createKey(10, 13));
		}
		
		public function testGetTile() : void {
			var x : int = 10;
			var y : int = 13;
			assertNull(layer.tiles[layer.createKey(x, y)]);
			assertNull(layer.getTile(x, y));
		}

		public function testGetOrCreateTile() : void {
			var x : int = 10;
			var y : int = 13;
			//前提条件
			assertNull(layer.tiles[layer.createKey(x, y)]);
			var firstTime : MapTile = layer.getOrCreateTile(x, y);
			//创建测试
			assertNotNull(firstTime);
			var secondTime : MapTile = layer.getOrCreateTile(x, y);
			assertNotNull(secondTime);
			//对判断方法的验证
			assertEquals(firstTime, firstTime);
			assertFalse(firstTime == new MapTile());
			//排除重复创建的可能
			assertTrue(firstTime == secondTime);
			assertEquals(firstTime, secondTime);
		}

		/**
		 * 根据资源生成 Tile
		 * x,y 与 srcX,srcY 默认相同
		 */
		public function testInitTiles() : void {
			var srcIndex : int = 0001;
			var width : int = 16;
			var height : int = 20;
			layer.initTiles(srcIndex, width, height);
			//验证范围
			assertNull(layer.getTile(height, width));
			//验证顺序
			assertNull(layer.getTile(width - 1, height - 1));
			//验证边界
			assertNotNull(layer.getTile(height - 1, width - 1));
			assertNotNull(layer.getTile(0, 0));
			//验证数据
			var tile : MapTile = layer.getTile(0, 0);
			assertEquals(0, tile.x);
			assertEquals(0, tile.y);
			assertEquals(tile.src, srcIndex);
			assertEquals(tile.srcX, tile.x);
			assertEquals(tile.srcX, tile.y);
		}

		/**
		 * 根据读取的数据对象
		 */
		public function testInitTilesByObj() : void {
			var obj : Object = {
								    "z": -2000,
								    "tiles": {
								        "7,1": {
								            y: 1,
								            src: 00005,
								            type: 0,
								            srcX: 7,
								            srcY: 1,
								            x: 7
								        },
								        "4,2": {
								            y: 2,
								            src: 00005,
								            type: 0,
								            srcX: 4,
								            srcY: 2,
								            x: 4
								        },
								        "7,9": {
								            y: 9,
								            src: 00005,
								            type: 0,
								            srcX: 7,
								            srcY: 12,
								            x: 7
								        },
								        "9,4": {
								            y: 4,
								            src: 00005,
								            type: 0,
								            srcX: 9,
								            srcY: 4,
								            x: 9
								        },
								        "5,1": {
								            y: 1,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 1,
								            x: 5
								        },
								        "8,1": {
								            y: 1,
								            src: 00005,
								            type: 0,
								            srcX: 8,
								            srcY: 1,
								            x: 8
								        },
								        "1,2": {
								            y: 2,
								            src: 00005,
								            type: 0,
								            srcX: 1,
								            srcY: 2,
								            x: 1
								        },
								        "3,2": {
								            y: 2,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 2,
								            x: 3
								        },
								        "5,9": {
								            y: 9,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 12,
								            x: 5
								        },
								        "6,5": {
								            y: 5,
								            src: 00005,
								            type: 0,
								            srcX: 6,
								            srcY: 5,
								            x: 6
								        },
								        "5,3": {
								            y: 3,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 3,
								            x: 5
								        },
								        "4,4": {
								            y: 4,
								            src: 00005,
								            type: 0,
								            srcX: 4,
								            srcY: 4,
								            x: 4
								        },
								        "6,2": {
								            y: 2,
								            src: 00005,
								            type: 0,
								            srcX: 6,
								            srcY: 2,
								            x: 6
								        },
								        "4,5": {
								            y: 5,
								            src: 00005,
								            type: 0,
								            srcX: 4,
								            srcY: 5,
								            x: 4
								        },
								        "8,7": {
								            y: 7,
								            src: 00005,
								            type: 0,
								            srcX: 8,
								            srcY: 7,
								            x: 8
								        },
								        "1,9": {
								            y: 9,
								            src: 00005,
								            type: 0,
								            srcX: 1,
								            srcY: 12,
								            x: 1
								        },
								        "8,8": {
								            y: 8,
								            src: 00005,
								            type: 0,
								            srcX: 8,
								            srcY: 8,
								            x: 8
								        },
								        "7,2": {
								            y: 2,
								            src: 00005,
								            type: 0,
								            srcX: 7,
								            srcY: 2,
								            x: 7
								        },
								        "5,4": {
								            y: 4,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 4,
								            x: 5
								        },
								        "1,3": {
								            y: 3,
								            src: 00005,
								            type: 0,
								            srcX: 1,
								            srcY: 3,
								            x: 1
								        },
								        "2,5": {
								            y: 5,
								            src: 00005,
								            type: 0,
								            srcX: 2,
								            srcY: 5,
								            x: 2
								        },
								        "2,6": {
								            y: 6,
								            src: 00005,
								            type: 0,
								            srcX: 2,
								            srcY: 6,
								            x: 2
								        },
								        "0,3": {
								            y: 3,
								            src: 00005,
								            type: 0,
								            srcX: 0,
								            srcY: 3,
								            x: 0
								        },
								        "0,4": {
								            y: 4,
								            src: 00005,
								            type: 0,
								            srcX: 0,
								            srcY: 4,
								            x: 0
								        },
								        "8,5": {
								            y: 5,
								            src: 00005,
								            type: 0,
								            srcX: 8,
								            srcY: 5,
								            x: 8
								        },
								        "5,2": {
								            y: 2,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 2,
								            x: 5
								        },
								        "0,0": {
								            y: 0,
								            src: 00005,
								            type: 0,
								            srcX: 0,
								            srcY: 0,
								            x: 0
								        },
								        "3,5": {
								            y: 5,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 5,
								            x: 3
								        },
								        "0,5": {
								            y: 5,
								            src: 00005,
								            type: 0,
								            srcX: 0,
								            srcY: 5,
								            x: 0
								        },
								        "9,5": {
								            y: 5,
								            src: 00005,
								            type: 0,
								            srcX: 9,
								            srcY: 5,
								            x: 9
								        },
								        "2,0": {
								            y: 0,
								            src: 00005,
								            type: 0,
								            srcX: 2,
								            srcY: 0,
								            x: 2
								        },
								        "6,4": {
								            y: 4,
								            src: 00005,
								            type: 0,
								            srcX: 6,
								            srcY: 4,
								            x: 6
								        },
								        "9,6": {
								            y: 6,
								            src: 00005,
								            type: 0,
								            srcX: 9,
								            srcY: 6,
								            x: 9
								        },
								        "4,7": {
								            y: 7,
								            src: 00005,
								            type: 0,
								            srcX: 4,
								            srcY: 7,
								            x: 4
								        },
								        "8,9": {
								            y: 9,
								            src: 00005,
								            type: 0,
								            srcX: 8,
								            srcY: 12,
								            x: 8
								        },
								        "1,4": {
								            y: 4,
								            src: 00005,
								            type: 0,
								            srcX: 1,
								            srcY: 4,
								            x: 1
								        },
								        "8,4": {
								            y: 4,
								            src: 00005,
								            type: 0,
								            srcX: 8,
								            srcY: 4,
								            x: 8
								        },
								        "5,6": {
								            y: 6,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 6,
								            x: 5
								        },
								        "6,3": {
								            y: 3,
								            src: 00005,
								            type: 0,
								            srcX: 6,
								            srcY: 3,
								            x: 6
								        },
								        "6,9": {
								            y: 9,
								            src: 00005,
								            type: 0,
								            srcX: 6,
								            srcY: 12,
								            x: 6
								        },
								        "4,1": {
								            y: 1,
								            src: 00005,
								            type: 0,
								            srcX: 4,
								            srcY: 1,
								            x: 4
								        },
								        "0,6": {
								            y: 6,
								            src: 00005,
								            type: 0,
								            srcX: 0,
								            srcY: 6,
								            x: 0
								        },
								        "9,7": {
								            y: 7,
								            src: 00005,
								            type: 0,
								            srcX: 9,
								            srcY: 7,
								            x: 9
								        },
								        "7,8": {
								            y: 8,
								            src: 00005,
								            type: 0,
								            srcX: 7,
								            srcY: 8,
								            x: 7
								        },
								        "3,4": {
								            y: 4,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 4,
								            x: 3
								        },
								        "4,6": {
								            y: 6,
								            src: 00005,
								            type: 0,
								            srcX: 4,
								            srcY: 6,
								            x: 4
								        },
								        "1,5": {
								            y: 5,
								            src: 00005,
								            type: 0,
								            srcX: 1,
								            srcY: 5,
								            x: 1
								        },
								        "9,0": {
								            y: 0,
								            src: 00005,
								            type: 0,
								            srcX: 9,
								            srcY: 0,
								            x: 9
								        },
								        "0,1": {
								            y: 1,
								            src: 00005,
								            type: 0,
								            srcX: 0,
								            srcY: 1,
								            x: 0
								        },
								        "8,3": {
								            y: 3,
								            src: 00005,
								            type: 0,
								            srcX: 8,
								            srcY: 3,
								            x: 8
								        },
								        "3,7": {
								            y: 7,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 7,
								            x: 3
								        },
								        "0,7": {
								            y: 7,
								            src: 00005,
								            type: 0,
								            srcX: 0,
								            srcY: 7,
								            x: 0
								        },
								        "2,7": {
								            y: 7,
								            src: 00005,
								            type: 0,
								            srcX: 2,
								            srcY: 7,
								            x: 2
								        },
								        "3,6": {
								            y: 6,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 6,
								            x: 3
								        },
								        "2,8": {
								            y: 8,
								            src: 00005,
								            type: 0,
								            srcX: 2,
								            srcY: 8,
								            x: 2
								        },
								        "5,5": {
								            y: 5,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 5,
								            x: 5
								        },
								        "4,9": {
								            y: 9,
								            src: 00005,
								            type: 0,
								            srcX: 4,
								            srcY: 12,
								            x: 4
								        },
								        "2,1": {
								            y: 1,
								            src: 00005,
								            type: 0,
								            srcX: 2,
								            srcY: 1,
								            x: 2
								        },
								        "0,2": {
								            y: 2,
								            src: 00005,
								            type: 0,
								            srcX: 0,
								            srcY: 2,
								            x: 0
								        },
								        "8,6": {
								            y: 6,
								            src: 00005,
								            type: 0,
								            srcX: 8,
								            srcY: 6,
								            x: 8
								        },
								        "4,0": {
								            y: 0,
								            src: 00005,
								            type: 0,
								            srcX: 4,
								            srcY: 0,
								            x: 4
								        },
								        "6,0": {
								            y: 0,
								            src: 00005,
								            type: 0,
								            srcX: 6,
								            srcY: 0,
								            x: 6
								        },
								        "1,6": {
								            y: 6,
								            src: 00005,
								            type: 0,
								            srcX: 1,
								            srcY: 6,
								            x: 1
								        },
								        "9,8": {
								            y: 8,
								            src: 00005,
								            type: 0,
								            srcX: 9,
								            srcY: 8,
								            x: 9
								        },
								        "2,2": {
								            y: 2,
								            src: 00005,
								            type: 0,
								            srcX: 2,
								            srcY: 2,
								            x: 2
								        },
								        "6,6": {
								            y: 6,
								            src: 00005,
								            type: 0,
								            srcX: 6,
								            srcY: 6,
								            x: 6
								        },
								        "3,3": {
								            y: 3,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 3,
								            x: 3
								        },
								        "26,2": {
								            y: 2,
								            src: 0,
								            type: 0,
								            srcX: 0,
								            srcY: 0,
								            x: 26
								        },
								        "4,8": {
								            y: 8,
								            src: 00005,
								            type: 0,
								            srcX: 4,
								            srcY: 8,
								            x: 4
								        },
								        "30,29": {
								            y: 29,
								            src: 0,
								            type: 0,
								            srcX: 0,
								            srcY: 0,
								            x: 30
								        },
								        "2,9": {
								            y: 9,
								            src: 00005,
								            type: 0,
								            srcX: 2,
								            srcY: 12,
								            x: 2
								        },
								        "7,0": {
								            y: 0,
								            src: 00005,
								            type: 0,
								            srcX: 7,
								            srcY: 0,
								            x: 7
								        },
								        "7,6": {
								            y: 6,
								            src: 00005,
								            type: 0,
								            srcX: 7,
								            srcY: 6,
								            x: 7
								        },
								        "7,7": {
								            y: 7,
								            src: 00005,
								            type: 0,
								            srcX: 7,
								            srcY: 7,
								            x: 7
								        },
								        "1,7": {
								            y: 7,
								            src: 00005,
								            type: 0,
								            srcX: 1,
								            srcY: 7,
								            x: 1
								        },
								        "0,9": {
								            y: 9,
								            src: 00005,
								            type: 0,
								            srcX: 0,
								            srcY: 12,
								            x: 0
								        },
								        "9,1": {
								            y: 1,
								            src: 00005,
								            type: 0,
								            srcX: 9,
								            srcY: 1,
								            x: 9
								        },
								        "8,2": {
								            y: 2,
								            src: 00005,
								            type: 0,
								            srcX: 8,
								            srcY: 2,
								            x: 8
								        },
								        "1,8": {
								            y: 8,
								            src: 00005,
								            type: 0,
								            srcX: 1,
								            srcY: 8,
								            x: 1
								        },
								        "7,3": {
								            y: 3,
								            src: 00005,
								            type: 0,
								            srcX: 7,
								            srcY: 3,
								            x: 7
								        },
								        "3,0": {
								            y: 0,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 0,
								            x: 3
								        },
								        "0,8": {
								            y: 8,
								            src: 00005,
								            type: 0,
								            srcX: 0,
								            srcY: 8,
								            x: 0
								        },
								        "3,8": {
								            y: 8,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 8,
								            x: 3
								        },
								        "4,3": {
								            y: 3,
								            src: 00005,
								            type: 0,
								            srcX: 4,
								            srcY: 3,
								            x: 4
								        },
								        "5,7": {
								            y: 7,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 7,
								            x: 5
								        },
								        "6,7": {
								            y: 7,
								            src: 00005,
								            type: 0,
								            srcX: 6,
								            srcY: 7,
								            x: 6
								        },
								        "5,0": {
								            y: 0,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 0,
								            x: 5
								        },
								        "2,3": {
								            y: 3,
								            src: 00005,
								            type: 0,
								            srcX: 2,
								            srcY: 3,
								            x: 2
								        },
								        "7,4": {
								            y: 4,
								            src: 00005,
								            type: 0,
								            srcX: 7,
								            srcY: 4,
								            x: 7
								        },
								        "1,0": {
								            y: 0,
								            src: 00005,
								            type: 0,
								            srcX: 1,
								            srcY: 0,
								            x: 1
								        },
								        "9,9": {
								            y: 9,
								            src: 00005,
								            type: 0,
								            srcX: 9,
								            srcY: 12,
								            x: 9
								        },
								        "5,8": {
								            y: 8,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 8,
								            x: 5
								        },
								        "9,2": {
								            y: 2,
								            src: 00005,
								            type: 0,
								            srcX: 9,
								            srcY: 2,
								            x: 9
								        },
								        "79,2": {
								            y: 2,
								            src: 0,
								            type: 0,
								            srcX: 0,
								            srcY: 0,
								            x: 79
								        },
								        "8,0": {
								            y: 0,
								            src: 00005,
								            type: 0,
								            srcX: 8,
								            srcY: 0,
								            x: 8
								        },
								        "6,8": {
								            y: 8,
								            src: 00005,
								            type: 0,
								            srcX: 6,
								            srcY: 8,
								            x: 6
								        },
								        "54,4": {
								            y: 4,
								            src: 0,
								            type: 0,
								            srcX: 0,
								            srcY: 0,
								            x: 54
								        },
								        "7,5": {
								            y: 5,
								            src: 00005,
								            type: 0,
								            srcX: 7,
								            srcY: 5,
								            x: 7
								        },
								        "1,1": {
								            y: 1,
								            src: 00005,
								            type: 0,
								            srcX: 1,
								            srcY: 1,
								            x: 1
								        },
								        "6,1": {
								            y: 1,
								            src: 00005,
								            type: 0,
								            srcX: 6,
								            srcY: 1,
								            x: 6
								        },
								        "9,3": {
								            y: 3,
								            src: 00005,
								            type: 0,
								            srcX: 9,
								            srcY: 3,
								            x: 9
								        },
								        "3,1": {
								            y: 1,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 1,
								            x: 3
								        },
								        "2,4": {
								            y: 4,
								            src: 00005,
								            type: 0,
								            srcX: 2,
								            srcY: 4,
								            x: 2
								        },
								        "3,9": {
								            y: 9,
								            src: 00005,
								            type: 0,
								            srcX: 5,
								            srcY: 12,
								            x: 3
								        }
								    }
								};
			var origX : int = 3;
			var origY : int = 9;
			var srcX : int = 5;
			var srcY : int = 12;
			var src : int = 00005;
			var width : int = 10;
			var height : int = 10;
			//初始化
			layer.convertObjToTiles(obj);
			assertEquals(-2000, layer.z);
			//准备数据
			var tile : MapTile;
			for (var x : int = 0; x < width; x++) {
				for (var y : int = 0; y < height; y++) {
					tile = layer.getTile(x, y);
					assertNotNull(tile);
					assertEquals(x == origX ? srcX : x, tile.srcX);
					assertEquals(y == origY ? srcY : y, tile.srcY);
					assertEquals(src, tile.src);
				}
			}
			assertNull(tile = layer.getTile(width, height));
		}
		
		public function buildAllTest() : TestSuite {
			var suite:TestSuite = new TestSuite();  
            suite.addTest(new MapLayerTest("testCreateKey"));
            suite.addTest(new MapLayerTest("testGetTile"));
            suite.addTest(new MapLayerTest("testGetOrCreateTile"));
            suite.addTest(new MapLayerTest("testInitTiles"));
            suite.addTest(new MapLayerTest("testInitTilesByObj"));
            return suite;
		}
	}
}
