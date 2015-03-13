package wiz.test {
	
	import wiz.encrypt.AbstractEncryptorTest;
	import wiz.encrypt.CharsetTest;
	import wiz.encrypt.XOREncryptorTest;
	
	
	
	/**
	 * テストスイート
	 */
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class EncryptorTestSuite {
		public var abstractEncryptorTest:wiz.encrypt.AbstractEncryptorTest;
		public var charsetTest:wiz.encrypt.CharsetTest;
		public var xorEncryptorTest:wiz.encrypt.XOREncryptorTest;
	}
	
}
