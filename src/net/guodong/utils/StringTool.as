/**
 * ...
 * @author johnzhang
 */
package net.guodong.utils 
{
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import net.guodong.utils.StringUtil;

	public class StringTool 
	{
		
		public function StringTool() 
		{
			
		}
		/**
		 * 数字（字符）用0补充在最前面
		 * @param	numStr      数值的字符串
		 * @param	zeroNum     位数
		 * @return
		 */
		public static function numToX(numStr:String, zeroNum:Number):String {
			var outString:String = "";
			if (numStr.length<zeroNum) {
				for (var i:int = numStr.length; i<zeroNum; i++) {
					outString += "0";
				}
			}
			outString += numStr;
			return outString;
		}
		
		
		/**
		 * 把数字转为带逗号的字符 如: 1,112,334 
		 * @param num
		 * @return 
		 * 
		 */		
		public static function getDotTxt(num:Number):String
		{
			var flag:Boolean = num < 0;
			num = Math.abs(num);
			var str:String = num.toString();
			
			var dotStr:String = "";
			for (var i:int = str.length - 1; i >= 0; i--) 
			{
				dotStr = str.charAt(i) + dotStr;
				if ((str.length - i) % 3 == 0 && i > 0)
					dotStr = "," + dotStr;
			}
			if (flag)
				dotStr = "-" + dotStr;
			return dotStr;
		}
		
		/**
		 * 把轉成有位數符號的字符串的數字轉成number ,getDotTxt反向
		 * @param str
		 * @return 
		 * 
		 */		
		public static function parseDotTxt(str:String):Number
		{
			var arr:Array = str.split(",");
			
			var num:Number = 0;
			for (var i:int = 0; i < arr.length; i++) 
			{
				num = int(arr[i]) + num * 1000;
			}
			return num;
		}
		
		
		public static function replaceAngle(str:String):String
		{
			str = str.replace(/</g, "&lt;");
			str = str.replace(/>/g, "&gt;");
			return str;
		}
		
		
		/**
		 * 比较str1是否拼音在str2之前
		 * 一样返回false
		 * @param	str1
		 * @param	str2
		 * @return
		 */
		public static function compareString(str1:String , str2:String):Boolean
		{
			var len:int = str1.length > str2.length ? str2.length : str1.length;
			
			for (var i:int = 0; i < len; i++) 
			{
				var byte1:ByteArray = new ByteArray();
				var byte2:ByteArray = new ByteArray();
				byte1.writeMultiByte(str1.charAt(i), "gb2312");
				byte2.writeMultiByte(str2.charAt(i), "gb2312");
				
				if (byte1[0] < byte2[0])
					return true;
				
				if (byte1[0] == byte2[0])
				{
					if(byte1[1] < byte2[1])
						return true;
					if (byte1[1] == byte2[1])
						continue;
				}
				return false;
			}
			
			// 相等
			return str1.length < str2.length;
		}
		
		
		/**
		 * 限制文本输入长度
		 * @param	tf	文本框
		 * @param	maxLength 最大字符长度(中文字符长度为2)
		 */
		public static function  setMaxChar(tf:TextField, maxLength:int):void
		{
			while (!StringUtil.checkTextLen(tf.text, maxLength))
			{
				tf.text = tf.text.substr(0, tf.text.length - 2);
			}
		}
		
		
		/**
		 * 获取HTML的颜色文本
		 * @param	string			需要颜色的文本
		 * @param	color			颜色值
		 */
		public static function getHtmlColorString(string:String , color:uint):String
		{
			var colorStr:String = color.toString(16);
			return "<font color='#" + colorStr + "'>" + string + "</font>";
		}
		
		/**
		 * 从左边截取字符串，超过字符用...代替
		 * @param str
		 * @param len
		 * @param endStr
		 * @return 
		 * 
		 */		
		public static  function getLimitLengthString(str:String,len:Number,endStr:String="..."):String {
			if (StringUtil.getRealLength(str) > len) {
				var temp:String = "";
				for (var i:int=0; i<str.length; i++) {			
					if (StringUtil.getRealLength(temp) < len ) {
						temp +=  str.substr(i,1);
						//trace(temp,getRealLength(temp))
					}			
				}
				return temp+endStr;
			} else {
				return str;
			}
		}
		
		
	}

}