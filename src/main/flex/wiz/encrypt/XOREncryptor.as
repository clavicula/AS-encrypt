package wiz.encrypt {
	
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;
	
	
	
	/**
	 * XOR演算による暗号化
	 */
	public class XOREncryptor implements Encryptor {
		
		/**
		 * コンストラクタ
		 */
		public function XOREncryptor() {
		}
		
		
		
		/**
		 * バイナリデータを複号化
		 */
		public function decryptBinary(source:ByteArray):ByteArray {
			if (!source) {
				return new ByteArray();
			}
			return crypt(source);
		}
		
		/**
		 * 文字列を複号化
		 */
		public function decryptString(source:ByteArray, charset:String = "UTF-8"):String {
			if (source == null) {
				return "";
			}
			if (!charset) {
				throw new ArgumentError("Charset is null.");
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
			if (!source) {
				return new ByteArray();
			}
			return crypt(source);
		}
		
		/**
		 * 文字列を暗号化
		 */
		public function encryptString(source:String, charset:String = "UTF-8"):ByteArray {
			if (!source) {
				return new ByteArray();
			}
			if (!charset) {
				throw new ArgumentError("Charset is null.");
			}
			if (Charset.values().indexOf(charset) == -1) {
				throw new IllegalOperationError("Unsupported charset : " + charset);
			}
			
			const sourceBinaryData:ByteArray = new ByteArray();
			sourceBinaryData.writeMultiByte(source, charset);
			sourceBinaryData.position = 0;
			return encryptBinary(sourceBinaryData);
		}
		
		
		
		/**
		 * バイナリデータを暗号化/複号化
		 * 
		 * @param source 元データ。
		 * @return 変換結果。
		 */
		private function crypt(source:ByteArray):ByteArray {
			// XORによる暗号化なので、同じルーチンでOK
			
			const position:uint = source.position;
			
			const result:ByteArray = new ByteArray();
			try {
				source.position = 0;
				while (source.bytesAvailable != 0) {
					result.writeByte(source.readByte() ^ CRIPT_KEY);
				}
				result.position = 0;
			}
			finally {
				source.position = position;
			}
			return result;
		}
		
		
		
		/**
		 * 暗号化キー
		 */
		private static const CRIPT_KEY:uint = 0xC7;
		
	}
	
}
