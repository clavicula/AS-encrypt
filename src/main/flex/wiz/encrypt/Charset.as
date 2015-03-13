package wiz.encrypt {
	
	import flash.errors.IllegalOperationError;
	
	
	
	/**
	 * 文字コード定義
	 */
	public final class Charset {
		
		/**
		 * コンストラクタ利用禁止
		 */
		public function Charset() {
			throw new IllegalOperationError("Charset is Enumrate.");
		}
		
		
		
		/**
		 * 全要素リストを取得
		 * 
		 * @return 全要素リスト。
		 */
		public static function values():Vector.<String> {
			return new <String>[ UTF8, EUC_JP, SHIFT_JIS ];
		}
		
		
		
		/**
		 * UTF-8
		 */
		public static const UTF8:String = "UTF-8";
		
		/**
		 * EUC-JP
		 */
		public static const EUC_JP:String = "EUC-JP";
		
		/**
		 * Shift_JIS
		 */
		public static const SHIFT_JIS:String = "Shift_JIS";
		
	}
	
}
