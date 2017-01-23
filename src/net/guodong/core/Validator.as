package net.guodong.core 
{
	/**
	 * ...
	 * @author johnzhang
	 */
	public class Validator
	{
		
		public function Validator() 
		{
			
		}
		/**
		 * 验证是否为省份证
		 * @param	str
		 * @return
		 */
		public static function isCard(str:String):Boolean {
			var isIDCard2:RegExp=/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[X|x])$/

			//var idCard:String="51052119800616407X";
			//trace(isIDCard2.test(idCard))
			return isIDCard2.test(str);
		}
		/**
		 * 验证是否为 手机号
		 * @param	str
		 * @return
		 */
		public static function isMobile(str:String):Boolean {
			//var mobile:RegExp = /^((\+86)|(86))?(1)\d{10}$/;
			//var mobile :RegExp = /^0{0,1}(13[4-9]|15[7-9]|15[0-2]|18[7-8])[0-9]{8}$/;
			var mobile :RegExp = /^0{0,1}(13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9])[0-9]{8}$/;
			//trace(pattern1.test("13816594828"))
			return mobile.test(str);
		}
		
		
		
		/**
		 * 是否为Email地址
		 * @param	char
		 * @return
		 */
		public static function isEmail(char:String):Boolean {
			if (char == null) {
				return false;
			}
			var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
			var result:Object = pattern.exec(char);
			if (result == null) {
				return false;
			}
			return true;
		}
		
		
		
		
		
		
		
		
	}

}