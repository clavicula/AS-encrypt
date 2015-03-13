package wiz.encrypt {
	
	import flash.utils.ByteArray;
	
	
	
	/**
	 * テスト用AbstractEncryptor
	 */
	internal final class AbstractEncryptor_forTest extends AbstractEncryptor {
		
		/**
		 * コンストラクタ
		 */
		public function AbstractEncryptor_forTest() {
		}
		
		
		
		/**
		 * バイナリデータを複号化
		 */
		public override function decryptBinary(source:ByteArray):ByteArray {
			return deepCopyByteArray(source);
		}
		
		/**
		 * バイナリデータを暗号化
		 */
		public override function encryptBinary(source:ByteArray):ByteArray {
			return deepCopyByteArray(source);
		}
		
		
		
		/**
		 * ByteArrayをディープコピー
		 * 
		 * @param source 複製元。
		 * @return 複製結果。
		 */
		private function deepCopyByteArray(source:ByteArray):ByteArray {
			const position:uint = source.position;
			
			const result:ByteArray = new ByteArray();
			try {
				source.readBytes(result);
				result.position = 0;
			}
			finally {
				source.position = position;
			}
			return result;
		}
		
	}
	
}
