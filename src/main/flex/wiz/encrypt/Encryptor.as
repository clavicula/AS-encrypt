package wiz.encrypt {
	
	import flash.utils.ByteArray;
	
	
	
	/**
	 * 暗号化処理
	 */
	public interface Encryptor {
		
		/**
		 * バイナリデータを複号化
		 * 
		 * @param source 複号化元バイナリ。
		 * @return 複号化結果。
		 */
		function decryptBinary(source:ByteArray):ByteArray;
		
		/**
		 * 文字列を複号化
		 * 
		 * @param source 複号化元バイナリ。
		 * @param charset 文字コード。
		 * @return 複号化結果。
		 */
		function decryptString(source:ByteArray, charset:String = "UTF-8"):String;
		
		/**
		 * バイナリデータを暗号化
		 * 
		 * @param source 暗号化元バイナリデータ。
		 * @return 暗号化結果。
		 */
		function encryptBinary(source:ByteArray):ByteArray;
		
		/**
		 * 文字列を暗号化
		 * 
		 * @param source 暗号化元文字列。
		 * @param charset 文字コード。
		 * @return 暗号化結果。
		 */
		function encryptString(source:String, charset:String = "UTF-8"):ByteArray;
		
	}
	
}
