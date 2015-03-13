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
		 * 暗号化オブジェクトを生成
		 * 
		 * @return 暗号化オブジェクト。
		 */
		private function createEncryptor():Encryptor {
			return new XOREncryptor();
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
		 * 暗号化キー
		 */
		private static const CRIPT_KEY:uint = 0xC7;
		
	}
	
}
