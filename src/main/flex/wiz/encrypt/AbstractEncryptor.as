package wiz.encrypt {
	
	import flash.utils.ByteArray;
	import flash.errors.IllegalOperationError;
	
	
	
	/**
	 * 暗号化抽象クラス
	 */
	internal class AbstractEncryptor implements Encryptor {
		
		/**
		 * コンストラクタをサブクラスに限定許可
		 */
		public function AbstractEncryptor() {
			if (Object(this).constructor == AbstractEncryptor) {
				throw new IllegalOperationError("AbstractEncryptor is Abstract.");
			}
		}
		
		
		
		/**
		 * バイナリデータを複号化
		 */
		public function decryptBinary(source:ByteArray):ByteArray {
			throw new IllegalOperationError("Must override - decryptBinary()");
		}
		
		/**
		 * 文字列を復号化
		 */
		public function decryptString(source:ByteArray, charset:String = null):String {
			if (source == null) {
				return "";
			}
			if (!charset) {
				return decryptString(source, Charset.UTF8);
			}
			if (Charset.values().indexOf(charset) == -1) {
				throw new IllegalOperationError("Unsupported charset : " + charset);
			}
			
			const buf:ByteArray = decryptBinary(source);
			return buf.readMultiByte(buf.length, charset);
		}
		
		/**
		 * バイナリデータを暗号化
		 */
		public function encryptBinary(source:ByteArray):ByteArray {
			throw new IllegalOperationError("Must override - encryptBinary()");
		}
		
		/**
		 * 文字列を暗号化
		 */
		public function encryptString(source:String, charset:String = null):ByteArray {
			if (!source) {
				return new ByteArray();
			}
			if (!charset) {
				return encryptString(source, Charset.UTF8);
			}
			if (Charset.values().indexOf(charset) == -1) {
				throw new IllegalOperationError("Unsupported charset : " + charset);
			}
			
			const sourceBinaryData:ByteArray = new ByteArray();
			sourceBinaryData.writeMultiByte(source, charset);
			sourceBinaryData.position = 0;
			return encryptBinary(sourceBinaryData);
		}
		
	}
	
}
