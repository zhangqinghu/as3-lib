/**
 * ...
 * @author johnzhang
 */
package net.guodong.utils 
{

	public class NumberUtilities 
	{
		
		public function NumberUtilities() 
		{
			
		}
		
		public static function randRange(min:Number, max:Number):Number {
			var randomNum:Number = Math.floor(Math.random()*(max-min+1))+min;
			return randomNum;
		}
		/**
		 * 将数值精确到小数点到几位
		 * @param	value		要精确的数字
		 * @param	bit			位数
		 * @return
		 */
		public static function precision(value:Number , bit:Number = 10):Number
		{
			if ( isNaN(value) )
				return 0;
			return Number(value.toFixed(bit));
		}
		/**
		 * 把秒转化为时：分：秒
		 * @param	secs
		 * @return
		 */
		public static function secToHMS(secs:Number,zero:Number=0):String {
			var h:Number = Math.floor(secs/3600);
			var m:Number = Math.floor((secs-h*3600)/60);
			var s:Number = secs-h*3600-m*60;
			var result:String = "";
			if (zero == 0) {
				result = h + ":" + m + ":" + s;
			}else {
				result = StringTool.numToX(h.toString(), zero) + ":" + StringTool.numToX(m.toString(), zero) + ":" + StringTool.numToX(s.toString(), zero);
			}
			return result;
		}
		
		/**
		 * 把秒转化为分：秒
		 * @param	secs
		 * @param	zero
		 * @return
		 */
		public static function secToMS(secs:Number,zero:Number=0):String {
			var h:Number = Math.floor(secs/3600);
			var m:Number = Math.floor((secs-h*3600)/60);
			var s:Number = secs - h * 3600 - m * 60;
			m +=  h * 60;
			var result:String = "";
			if (zero == 0) {
				result = m+":"+s;
			}else {
				
				result = StringTool.numToX(m.toString(), zero) + ":" + StringTool.numToX(s.toString(), zero);
			}
			return result;
		}
		
	}

}