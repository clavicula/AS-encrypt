package wiz.encrypt {
	
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;
	
	import flexunit.framework.Assert;
	
	
	
	/**
	 * XOREncryptorのテスト
	 */
	public final class XOREncryptorTest {		
		
		/**
		 * decryptBinary() のテスト
		 * 
		 * @type 正常系。
		 */
		[Test]
		public function testDecryptBinary_Normal():void {
			const source:ByteArray = new ByteArray();
			const target:ByteArray = new ByteArray();
			for (var i:uint = 0x00; i < 0xFF; i++) {
				source.writeByte(i ^ CRIPT_KEY);
				target.writeByte(i);
			}
			target.position = 0;
			const targetPosition:uint = source.position;
			
			const encryptor:Encryptor = createEncryptor();
			const result:ByteArray = encryptor.decryptBinary(source);
			
			Assert.assertEquals(targetPosition, source.position);
			while (target.bytesAvailable) {
				Assert.assertEquals(target.readByte(), result.readByte());
			}
		}
		
		/**
		 * decryptBinary() のテスト
		 * 
		 * @type 異常系。
		 * @comment 元バイナリデータがnull。
		 */
		[Test]
		public function testDecryptBinary_Error_SourceBinaryDataIsNull():void {
			const source:ByteArray = null;
			
			const encryptor:Encryptor = createEncryptor();
			const result:ByteArray = encryptor.decryptBinary(source);
			
			Assert.assertEquals(0, result.bytesAvailable);
		}
		
		/**
		 * decryptBinary() のテスト
		 * 
		 * @type 異常系。
		 * @comment 空の元バイナリデータ。
		 */
		[Test]
		public function testDecryptBinary_Error_SourceBinaryDataIsEmpty():void {
			const source:ByteArray = new ByteArray();
			const targetPosition:uint = source.position;
			
			const encryptor:Encryptor = createEncryptor();
			const result:ByteArray = encryptor.decryptBinary(source);
			
			Assert.assertEquals(targetPosition, source.position);
			Assert.assertEquals(0, result.bytesAvailable);
		}
		
		/**
		 * decryptString() のテスト
		 * 
		 * @type 正常系。
		 * @comment デフォルト文字コード。
		 */
		[Test]
		public function testDecryptString_Normal_DefaultCharset():void {
			const charset:String = Charset.UTF8;
			const target:String = createString(SOURCE_STRING_UTF8, charset);
			const source:ByteArray = encryptString(target, charset);
			
			const encryptor:Encryptor = createEncryptor();
			const result:String = encryptor.decryptString(source);
			
			Assert.assertEquals(target, result);
		}
		
		/**
		 * decryptString() のテスト
		 * 
		 * @type 正常系。
		 * @comment UTF-8文字列。
		 */
		[Test]
		public function testDecryptString_Normal_UTF8():void {
			const charset:String = Charset.UTF8;
			const target:String = createString(SOURCE_STRING_UTF8, charset);
			const source:ByteArray = encryptString(target, charset);
			
			const encryptor:Encryptor = createEncryptor();
			const result:String = encryptor.decryptString(source, charset);
			
			Assert.assertEquals(target, result);
		}
		
		/**
		 * decryptString() のテスト
		 * 
		 * @type 正常系。
		 * @comment EUC-JP文字列。
		 */
		[Test]
		public function testDecryptString_Normal_EUC_JP():void {
			const charset:String = Charset.EUC_JP;
			const target:String = createString(SOURCE_STRING_EUC_JP, charset);
			const source:ByteArray = encryptString(target, charset);
			
			const encryptor:Encryptor = createEncryptor();
			const result:String = encryptor.decryptString(source, charset);
			
			Assert.assertEquals(target, result);
		}
		
		/**
		 * decryptString() のテスト
		 * 
		 * @type 正常系。
		 * @comment Shift_JIS文字列。
		 */
		[Test]
		public function testDecryptString_Normal_SHIFT_JIS():void {
			const charset:String = Charset.SHIFT_JIS;
			const target:String = createString(SOURCE_STRING_SHIFT_JIS, charset);
			const source:ByteArray = encryptString(target, charset);
			
			const encryptor:Encryptor = createEncryptor();
			const result:String = encryptor.decryptString(source, charset);
			
			Assert.assertEquals(target, result);
		}
		
		/**
		 * decryptString() のテスト
		 * 
		 * @type 異常系。
		 * @comment 複合化元バイナリデータがnull。
		 */
		[Test]
		public function testDecryptString_Error_SourceBinaryDataIsNull():void {
			const source:ByteArray = null;
			
			const encryptor:Encryptor = createEncryptor();
			const result:String = encryptor.decryptString(source);
			
			Assert.assertEquals(0, result.length);
		}
		
		/**
		 * decryptString() のテスト
		 * 
		 * @type 異常系。
		 * @comment 空の複合化元バイナリデータ。
		 */
		[Test]
		public function testDecryptString_Error_SourceBinaryDataIsEmpty():void {
			const source:ByteArray = new ByteArray();
			
			const encryptor:Encryptor = createEncryptor();
			const result:String = encryptor.decryptString(source);
			
			Assert.assertEquals(0, result.length);
		}
		
		/**
		 * encryptBinary() のテスト
		 * 
		 * @type 正常系。
		 */
		[Test]
		public function testEncryptBinary_Normal():void {
			const source:ByteArray = new ByteArray();
			const target:ByteArray = new ByteArray();
			for (var i:uint = 0x00; i < 0xFF; i++) {
				source.writeByte(i);
				target.writeByte(i ^ CRIPT_KEY);
			}
			target.position = 0;
			const targetPosition:uint = source.position;
			
			const encryptor:Encryptor = createEncryptor();
			const result:ByteArray = encryptor.encryptBinary(source);
			
			Assert.assertEquals(targetPosition, source.position);
			while (target.bytesAvailable) {
				Assert.assertEquals(target.readByte(), result.readByte());
			}
		}
		
		/**
		 * encryptBinary() のテスト
		 * 
		 * @type 異常系。
		 * @comment 元バイナリデータがnull。
		 */
		[Test]
		public function testEncryptBinary_Error_SourceBinaryDataIsNull():void {
			const source:ByteArray = null;
			
			const encryptor:Encryptor = createEncryptor();
			const result:ByteArray = encryptor.encryptBinary(source);
			
			Assert.assertEquals(0, result.bytesAvailable);
		}
		
		/**
		 * encryptBinary() のテスト
		 * 
		 * @type 異常系。
		 * @comment 空の元バイナリデータ。
		 */
		[Test]
		public function testEncryptBinary_Error_SourceBinaryDataIsEmpty():void {
			const source:ByteArray = new ByteArray();
			const targetPosition:uint = source.position;
			
			const encryptor:Encryptor = createEncryptor();
			const result:ByteArray = encryptor.encryptBinary(source);
			
			Assert.assertEquals(targetPosition, source.position);
			Assert.assertEquals(0, result.bytesAvailable);
		}
		
		/**
		 * encryptString() のテスト
		 * 
		 * @type 正常系。
		 * @comment デフォルト文字コード。
		 */
		[Test]
		public function testEncryptString_Normal_DefaultCharset():void {
			const charset:String = Charset.UTF8;
			const source:String = createString(SOURCE_STRING_UTF8, charset);
			
			const encryptor:Encryptor = createEncryptor();
			const result:ByteArray = encryptor.encryptString(source);
			
			Assert.assertNotNull(result);
			Assert.assertEquals(source, decryptString(result, charset));
		}
		
		/**
		 * encryptString() のテスト
		 * 
		 * @type 正常系。
		 * @comment UTF-8文字列。
		 */
		[Test]
		public function testEncryptString_Normal_UTF8():void {
			const charset:String = Charset.UTF8;
			const source:String = createString(SOURCE_STRING_UTF8, charset);
			
			const encryptor:Encryptor = createEncryptor();
			const result:ByteArray = encryptor.encryptString(source, charset);
			
			Assert.assertNotNull(result);
			Assert.assertEquals(source, decryptString(result, charset));
		}
		
		/**
		 * encryptString() のテスト
		 * 
		 * @type 正常系。
		 * @comment EUC-JP文字列。
		 */
		[Test]
		public function testEncryptString_Normal_EUC_JP():void {
			const charset:String = Charset.EUC_JP;
			const source:String = createString(SOURCE_STRING_EUC_JP, charset);
			
			const encryptor:Encryptor = createEncryptor();
			const result:ByteArray = encryptor.encryptString(source, charset);
			
			Assert.assertNotNull(result);
			Assert.assertEquals(source, decryptString(result, charset));
		}
		
		/**
		 * encryptString() のテスト
		 * 
		 * @type 正常系。
		 * @comment Shift_JIS文字列。
		 */
		[Test]
		public function testEncryptString_Normal_SHIFT_JIS():void {
			const charset:String = Charset.SHIFT_JIS;
			const source:String = createString(SOURCE_STRING_SHIFT_JIS, charset);
			
			const encryptor:Encryptor = createEncryptor();
			const result:ByteArray = encryptor.encryptString(source,　charset);
			
			Assert.assertNotNull(result);
			Assert.assertEquals(source, decryptString(result, charset));
		}
		
		/**
		 * encryptString() のテスト
		 * 
		 * @type 異常系。
		 * @comment 暗号化元文字列がnull。
		 */
		[Test]
		public function testEncryptString_Error_SourceStringIsNull():void {
			const source:String = null;
			
			const encryptor:Encryptor = createEncryptor();
			const result:ByteArray = encryptor.encryptString(source);
			
			Assert.assertNotNull(result);
			Assert.assertEquals(0, result.length);
		}
		
		/**
		 * encryptString() のテスト
		 * 
		 * @type 異常系。
		 * @comment 空の暗号化元文字列。
		 */
		[Test]
		public function testEncryptString_Error_SourceStringIsEmpty():void {
			const source:String = "";
			
			const encryptor:Encryptor = createEncryptor();
			const result:ByteArray = encryptor.encryptString(source);
			
			Assert.assertNotNull(result);
			Assert.assertEquals(0, result.length);
		}
		
		/**
		 * encryptString() のテスト
		 * 
		 * @type 異常系。
		 * @comment 文字コードがnull。
		 */
		[Test]
		public function testEncryptString_Error_CharsetIsNull():void {
			const source:String = createString(SOURCE_STRING_UTF8, Charset.UTF8);
			const charset:String = null;
			
			try {
				const encryptor:Encryptor = createEncryptor();
				encryptor.encryptString(source,　charset);
				Assert.fail("Expect: ArgumentError");
			}
			catch (e:ArgumentError) {}
		}
		
		/**
		 * encryptString() のテスト
		 * 
		 * @type 異常系。
		 * @comment 空の文字コード。
		 */
		[Test]
		public function testEncryptString_Error_CharsetIsEmpty():void {
			const source:String = createString(SOURCE_STRING_UTF8, Charset.UTF8);
			const charset:String = "";
			
			try {
				const encryptor:Encryptor = createEncryptor();
				encryptor.encryptString(source,　charset);
				Assert.fail("Expect: ArgumentError");
			}
			catch (e:ArgumentError) {}
		}
		
		/**
		 * encryptString() のテスト
		 * 
		 * @type 異常系。
		 * @comment サポート対象外の文字コード。
		 */
		[Test]
		public function testEncryptString_Error_UnsuppoertedCharset():void {
			const source:String = createString(SOURCE_STRING_UTF8, Charset.UTF8);
			const charset:String = "UTF-16";
			
			try {
				const encryptor:Encryptor = createEncryptor();
				encryptor.encryptString(source,　charset);
				Assert.fail("Expect: IllegalOperationError");
			}
			catch (e:IllegalOperationError) {}
		}
		
		
		
		/**
		 * 暗号化オブジェクトを生成
		 * 
		 * @return 暗号化オブジェクト。
		 */
		private function createEncryptor():Encryptor {
			return new XOREncryptor();
		}
		
		/**
		 * 文字列を生成
		 * 
		 * @param characterCodeList 文字コードリスト。
		 * @param charset 文字コード。
		 * @return 文字列。
		 */
		private function createString(characterCodeList:Vector.<int>, charset:String):String {
			const buf:ByteArray = new ByteArray();
			for each (var code:int in characterCodeList) {
				buf.writeByte(code);
			}
			
			// 先頭にシーク
			buf.position = 0;
			return buf.readMultiByte(buf.length, charset);
		}
		
		/**
		 * バイナリデータを暗号化/複号化
		 * 
		 * @param source 元バイナリデータ。
		 * @return 変換結果。
		 */
		private function cryptBinary(source:ByteArray):ByteArray {
			const encryptor:Encryptor = createEncryptor();
			return encryptor.encryptBinary(source);  // XORなので暗号化も複号化も内部処理は同じ
		}
		
		/**
		 * 文字列を復号化
		 * 
		 * @param source 復号化元文字列。
		 * @param charset 文字コード。
		 * @return 復号化結果。
		 */
		private function decryptString(source:ByteArray, charset:String):String {
			const encryptor:Encryptor = createEncryptor();
			return encryptor.decryptString(source, charset);
		}
		
		/**
		 * 文字列を暗号化
		 * 
		 * @param source 暗号化元文字列。
		 * @param charset 文字コード。
		 * @return 暗号化結果。
		 */
		private function encryptString(source:String, charset:String):ByteArray {
			const encryptor:Encryptor = createEncryptor();
			return encryptor.encryptString(source, charset);
		}
		
		
		
		/**
		 * 暗号化キー
		 */
		private static const CRIPT_KEY:uint = 0xC7;
		
		/**
		 * テスト用文字列 (UTF-8)
		 */
		private static const SOURCE_STRING_UTF8:Vector.<int> = new <int>[ 0xE2, 0x80, 0x95,  // ―
																		  0xE2, 0x80, 0x95,  // ―
																		  0xE3, 0x83, 0x86,  // テ
																		  0xE3, 0x82, 0xB9,  // ス
																		  0xE3, 0x83, 0x88,  // ト
																		  0xE2, 0x80, 0x95,  // ―
																		  0xE2, 0x80, 0x95 ];  // ―
		
		/**
		 * テスト用文字列 (EUC-JP)
		 */
		private static const SOURCE_STRING_EUC_JP:Vector.<int> = new <int>[ 0xA1, 0xBD,  // ―
																			0xA1, 0xBD,  // ―
																			0xA5, 0xC6,  // テ
																			0xA5, 0xB9,  // ス
																			0xA5, 0xC8,  // ト
																			0xA1, 0xBD,  // ―
																			0xA1, 0xBD ];  // ―
		
		/**
		 * テスト用文字列 (Shift_JIS)
		 */
		private static const SOURCE_STRING_SHIFT_JIS:Vector.<int> = new <int>[ 0x81, 0x5C,  // ―
																			   0x81, 0x5C,  // ―
																			   0x83, 0x65,  // テ
																			   0x83, 0x58,  // ス
																			   0x83, 0x67,  // ト
																			   0x81, 0x5C,  // ―
																			   0x81, 0x5C ];  // ―
	}
	
}
