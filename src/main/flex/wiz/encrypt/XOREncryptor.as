package wiz.encrypt {
	
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;
	
	
	
	/**
	 * XOR演算による暗号化
	 */
	public class XOREncryptor extends AbstractEncryptor {
		
		/**
		 * コンストラクタ
		 */
		public function XOREncryptor() {
		}
		
		
		
		/**
		 * バイナリデータを複号化
		 */
		public override function decryptBinary(source:ByteArray):ByteArray {
			if (!source) {
				return new ByteArray();
			}
			return crypt(source);
		}
		
		/**
		 * バイナリデータを暗号化
		 */
		public override function encryptBinary(source:ByteArray):ByteArray {
			if (!source) {
				return new ByteArray();
			}
			return crypt(source);
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
