/**
 * @file LayerManagerTest.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-27
 * @updatedate 2010-1-27
 */   
package org.baicaix.editor {
	import org.baicaix.flow.EditMapManager;
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;

	/**
	 * @author dengyang
	 */
	public class LayerManagerTest extends TestCase {
		
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _layerManager : EditMapManager;

		//------------------------------------
		// public properties
		//------------------------------------
		

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function LayerManagerTest(methodName : String = null) {
			super(methodName);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________

		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function setUp() : void {
			super.setUp();
			_layerManager = new EditMapManager();
			var editor : Editor = new Editor();
			editor.createMap();
//			for (var i : int = 0; i < 10; i++) {
//				_layerManager.registerLayer(editor.addEmptyLayer(i, i+""));
//			}
		}

		override public function tearDown() : void {
			super.tearDown();
		}	
		
		public function testTurnUpLayer() : void {
			setUp();
			
			//功能测试
			var index : int = 3;
			
			var backup : Array = _layerManager.layers.slice(index - 2, index + 2);
			_layerManager.turnUpLayer(index);
			assertEquals(backup[0], _layerManager.layers[index - 2]);
			assertEquals(backup[1], _layerManager.layers[index]);
			assertEquals(backup[2], _layerManager.layers[index - 1]);
			assertEquals(backup[3], _layerManager.layers[index + 1]);	
			
			//边界测试
			index = 0;
			
			backup = _layerManager.layers.slice(index, index + 2);
			_layerManager.turnUpLayer(index);
			assertEquals(backup[0], _layerManager.layers[index]);
			assertEquals(backup[1], _layerManager.layers[index + 1]);
		}

		public function testTurnDownLayer() : void {
			setUp();
			
			//功能测试
			var index : int = 5;
			
			var backup : Array = _layerManager.layers.slice(index - 1, index + 3);
			_layerManager.turnDownLayer(index);
			assertEquals(backup[0], _layerManager.layers[index - 1]);	
			assertEquals(backup[1], _layerManager.layers[index + 1]);
			assertEquals(backup[2], _layerManager.layers[index]);	
			assertEquals(backup[3], _layerManager.layers[index + 2]);	
			
			//边界测试
			index = 9;
			
			backup = _layerManager.layers.slice(index - 1, index + 1);
			_layerManager.turnDownLayer(index);
			assertEquals(backup[0], _layerManager.layers[index - 1]);	
			assertEquals(backup[1], _layerManager.layers[index]);
			assertEquals(null, _layerManager.layers[index + 1]);	
		}
		
		public function buildAllTest() : TestSuite {
			var suite : TestSuite = new TestSuite();  
			suite.addTest(new LayerManagerTest("testTurnUpLayer"));
			suite.addTest(new LayerManagerTest("testTurnDownLayer"));
			return suite;
		}
		
	}
}
