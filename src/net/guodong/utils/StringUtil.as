/**
* 2008-12-26
*@author johnzhang
*/
package net.guodong.utils 
{		
	public class StringUtil 
	{
		
		public function StringUtil() 
		{
			throw new Error("StringUtil class is static container only");
		}
		
		/**
		 * 忽略大小字母比较字符是否相等; 
		 * @param char1
		 * @param char2
		 * @return 
		 * 
		 */		
		public static function equalsIgnoreCase(char1:String,char2:String):Boolean {
			return char1.toLowerCase() == char2.toLowerCase();
		}
		
		/**
		 * 比较字符是否相等 
		 * @param char1
		 * @param char2
		 * @return 
		 * 
		 */		
		public static function equals(char1:String,char2:String):Boolean {
			return char1 == char2;
		}
		
		
		/**
		 * 是否是数值字符串 
		 * @param char
		 * @return 
		 * 
		 */		
		public static function isNumber(char:*):Boolean {
			if (char == null) {
				return false;
			}
			return ! isNaN(char);
		}
		
		/**
		 * 是否为Double型数据 
		 * @param char
		 * @return 
		 * 
		 */		
		public static function isDouble(char:String):Boolean {
			char = trim(char);
			var pattern:RegExp = /^[-\+]?\d+(\.\d+)?$/;
			var result:Object = pattern.exec(char);
			if (result == null) {
				return false;
			}
			return true;
		}
		
		/**
		 * 是否Integer 
		 * @param char
		 * @return 
		 * 
		 */		
		public static function isInteger(char:String):Boolean {
			if (char == null) {
				return false;
			}
			char = trim(char);
			var pattern:RegExp = /^[-\+]?\d+$/;
			var result:Object = pattern.exec(char);
			if (result == null) {
				return false;
			}
			return true;
		}
		
		/**
		 * 是否 English 
		 * @param char
		 * @return 
		 * 
		 */		
		public static function isEnglish(char:String):Boolean {
			if (char == null) {
				return false;
			}
			char = trim(char);
			var pattern:RegExp = /^[A-Za-z]+$/;
			var result:Object = pattern.exec(char);
			if (result == null) {
				return false;
			}
			return true;
		}
		/**
		 * 是否为中文 
		 * @param char
		 * @return 
		 * 
		 */		
		public static function isChinese(char:String):Boolean {
			if (char == null) {
				return false;
			}
			char = trim(char);
			var pattern:RegExp = /^[\u0391-\uFFE5]+$/; ;
			var result:Object = pattern.exec(char);
			if (result == null) {
				return false;
			}
			return true;
		}
		//双字节
		public static function isDoubleChar(char:String):Boolean {
			if (char == null) {
				return false;
			}
			char = trim(char);
			var pattern:RegExp = /^[^\x00-\xff]+$/;
			var result:Object = pattern.exec(char);
			if (result == null) {
				return false;
			}
			return true;
		}
		
		/**
		 * 含有中文字符 
		 * @param char
		 * @return 
		 * 
		 */		
		public static function hasChineseChar(char:String):Boolean {
			if (char == null) {
				return false;
			}
			char = trim(char);
			var pattern:RegExp = /[^\x00-\xff]/;
			var result:Object = pattern.exec(char);
			if (result == null) {
				return false;
			}
			return true;
		}
		
		/**
		 * 注册字符 
		 * @param char
		 * @param len
		 * @return 
		 * 
		 */		
		public static function hasAccountChar(char:String,len:uint=15):Boolean {
			if (char == null) {
				return false;
			}
			if (len < 10) {
				len = 15;
			}
			char = trim(char);
			var pattern:RegExp = new RegExp("^[a-zA-Z0-9][a-zA-Z0-9_-]{0,"+len+"}$", "");
			var result:Object = pattern.exec(char);
			if (result == null) {
				return false;
			}
			return true;
		}
		
		/**
		 * URL地址 
		 * @param char
		 * @return 
		 * 
		 */		
		public static function isURL(char:String):Boolean {
			if (char == null) {
				return false;
			}
			char = trim(char).toLowerCase();
			var pattern:RegExp = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
			var result:Object = pattern.exec(char);
			if (result == null) {
				return false;
			}
			return true;
		}
		
		/**
		 * 是否为空白 
		 * @param char
		 * @return 
		 * 
		 */		
		public static function isWhitespace(char:String):Boolean {
			switch (char) {
				case " " :
				case "\t" :
				case "\r" :
				case "\n" :
				case "\f" :
					return true;
				default :
					return false;
			}
		}
		
		/**
		 * 去左右空格 
		 * @param char
		 * @return 
		 * 
		 */		
		public static function trim(char:String):String {
			if (char == null) {
				return null;
			}
			return rtrim(ltrim(char));
		}
		
		/**
		 * 去左空格 
		 * @param char
		 * @return 
		 * 
		 */		
		public static function ltrim(char:String):String {
			if (char == null) {
				return null;
			}
			var pattern:RegExp = /^\s*/;
			return char.replace(pattern,"");
		}
		
		/**
		 * 去右空格 
		 * @param char
		 * @return 
		 * 
		 */		
		public static function rtrim(char:String):String {
			if (char == null) {
				return null;
			}
			var pattern:RegExp = /\s*$/;
			return char.replace(pattern,"");
		}
		
		/**
		 * 是否为前缀字符串 
		 * @param char
		 * @param prefix
		 * @return 
		 * 
		 */		
		public static function beginsWith(char:String, prefix:String):Boolean {
			return prefix == char.substring(0,prefix.length);
		}
		
		/**
		 * 是否为后缀字符串 
		 * @param char
		 * @param suffix
		 * @return 
		 * 
		 */		
		public static function endsWith(char:String, suffix:String):Boolean {
			return (suffix == char.substring(char.length - suffix.length));
		}
		
		/**
		 * 去除指定字符串 
		 * @param char
		 * @param remove
		 * @return 
		 * 
		 */		
		public static function remove(char:String,remove:String):String {
			return replace(char,remove,"");
		}
		
		/**
		 * 字符串替换 
		 * @param char
		 * @param replace
		 * @param replaceWith
		 * @return 
		 * 
		 */		
		public static function replace(char:String, replace:String, replaceWith:String):String {
			return char.split(replace).join(replaceWith);
		}
		
		
		
		/**
		 * 获取字符串的实际长度，区分中英文字符和标点，英文字符计1个字,中文计2个字	 
		 * @return 返回字符串的长度
		 */
		public static function getRealLength(str:String):int {
			var realLength:int = 0;	
			for (var i:int = 0; i < str.length; i++) {
				var charCode:Number = str.charCodeAt(i);
				if (charCode >= 0 && charCode <= 128) {
					//trace("英文");
					realLength +=  1;
				} else {
					//trace("中文");
					realLength +=  2;
				}
				
			}
			return realLength;
		}
		
		/**
		 * 检查长度
		 * 中文等于2个字符,英文等于1个(除数字和字母其他字符都算2个)
		 * @param	text
		 * @param	maxLen
		 * @return
		 */
		public static function checkTextLen(str:String , maxLen:Number):Boolean
		{
			var pattern:RegExp = /[a-z0-9]/ig;
			
			var wordLen:Number = str.match(pattern).length;
			var totalLen:Number = str.length * 2 - wordLen;
			
			return totalLen <= maxLen;
		}

		
	}
	
}