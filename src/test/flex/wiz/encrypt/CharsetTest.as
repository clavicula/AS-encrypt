package wiz.encrypt {
	
	import flash.errors.IllegalOperationError;
	
	import flexunit.framework.Assert;
	
	import mx.effects.Resize;
	
	
	
	/**
	 * Charsetのテスト
	 */
	public final class CharsetTest {
		
		/**
		 * コンストラクタのテスト
		 * 
		 * @type 異常系。
		 * @comment コンストラクタ利用禁止。
		 */
		[Test]
		public function testConstructor_Error_UnsupportedOperation():void {
			try {
				new Charset();
				Assert.fail("Expect: IllegalOperationError");
			}
			catch (e:IllegalOperationError) {}
		}
		
		/**
		 * values() のテスト
		 * 
		 * @type 正常系。
		 */
		[Test]
		public function testValues_Normal():void {
			const result:Vector.<String> = Charset.values();
			
			const checkList:Object = {};
			for each (var charset:String in result) {
				checkList[charset] = true;
			}
			
			Assert.assertTrue(checkList["UTF-8"]);
			Assert.assertTrue(checkList["EUC-JP"]);
			Assert.assertTrue(checkList["Shift_JIS"]);
		}
		
	}
	
}
