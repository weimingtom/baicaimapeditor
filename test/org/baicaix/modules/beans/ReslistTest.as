/**
 * @file ReslistTest.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-3-1
 * @updatedate 2010-3-1
 */   
package org.baicaix.modules.beans {
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;

	/**
	 * @author dengyang
	 */
	public class ReslistTest extends TestCase {
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _reslist : Reslist;

		//------------------------------------
		// public properties
		//------------------------------------
		

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function ReslistTest(methodName : String = null) {
			super(methodName);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________

		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function setUp() : void {
			super.setUp();
			_reslist = new Reslist();
		}

		override public function tearDown() : void {
			super.tearDown();
		}	
		
		public function testToXML() : void {
			setUp();
			
			//数据准备
			var key : String = "01";
			var key2 : String = "02";
			var valueBefor : String = "awel;ifgorpiweurfewkjf";
			var valueAfter : String = "34rpiou3oijg09837urofi";
			
			//单资源测试
			var resultXML : XML = 	<Resources>
										<res id={key} name={valueBefor}/>
									</Resources>;
			
			_reslist.add(key, valueBefor);
			assertEquals(resultXML, _reslist.toXML());
			
			//资源替换测试
			resultXML = <Resources>
							<res id={key} name={valueAfter}/>
						</Resources>;
						
			_reslist.add(key, valueAfter);
			assertEquals(resultXML, _reslist.toXML());
			
			//多资源测试
			resultXML = <Resources>
							<res id={key} name={valueAfter}/>
							<res id={key2} name={valueBefor}/>
						</Resources>;
			
			_reslist.add(key2, valueBefor);
			var baseXML : XML = _reslist.toXML();
			assertEquals(baseXML.res.(@id == key).@name, valueAfter);
			assertEquals(baseXML.res.(@id == key2).@name, valueBefor);
		}
		
		public function testRead() : void {
			setUp();
			
			var key : String = "01";
			var key2 : String = "02";
			var valueBefor : String = "awel;ifgorpiweurfewkjf";
			var valueAfter : String = "34rpiou3oijg09837urofi";
			
			var resultXML : XML = <Resources>
							<res id={key} name={valueAfter}/>
							<res id={key2} name={valueBefor}/>
						</Resources>;
						
			_reslist.read(resultXML);
			
			assertEquals(valueAfter, _reslist.getName(key));
			assertEquals(valueBefor, _reslist.getName(key2));
		}
		
		public function testAdd() : void {
			setUp();
			
			var key : String = "01";
			var valueBefor : String = "awel;ifgorpiweurfewkjf";
			var valueAfter : String = "34rpiou3oijg09837urofi";
			
			_reslist.add(key, valueBefor);
			assertEquals(valueBefor, _reslist.getName(key));
			
			_reslist.add(key, valueAfter);
			assertEquals(valueAfter, _reslist.getName(key));
		}
		
		public function buildAllTest() : TestSuite {
			var suite : TestSuite = new TestSuite();  
			suite.addTest(new ReslistTest("testToXML"));
			suite.addTest(new ReslistTest("testAdd"));
			suite.addTest(new ReslistTest("testRead"));
			return suite;
		}
	}
}
