/**
 * 调试类
 * @author johnzhang
 */
package net.guodong.debug
{
	import flash.external.ExternalInterface;
	public class Debug
	{
		private static var repeat:String = '\t';
		public function Debug() 
		{
			
		}
		/**
		 * 打印Object对象结构
		 * @param Object obj Object对象
		 */
		public static function printR( obj:Object ):void{
			var str:String = printS( obj );
			trace( str );
		}
		/**
		 * 返回Object对象结构
		 * @param Object obj Object对象
		 * @return String 返回对象结构
		 */
		public static function printS( obj:Object, level:int=1 ):String{
			var temp:String = '';
			for( var j:int=0; j<level; j++ ){
				temp += repeat;
			}
			var str:String = '';
			if( level == 1 ) str += obj.constructor.prototype + '{\n';
			for( var i:String in obj ){
				
				if( obj[i] && (obj[i].constructor == Object || obj[i].constructor == Array) ){
					if( obj[i].constructor == Object )
						str += temp+i+' = Object{\n';
					else
						str += temp+i+' = Array[\n';
					level++;
					str += printS( obj[i], level );
					level--;
					if( obj[i].constructor == Object )
						str += temp+'}\n';
					else
						str += temp+']\n';
				}else{
					str += temp+i + ' = ' + obj[i] + '\n';	
				}
			}
			if( level == 1 ) str += '}\n'
			return str;
		}
		
		
		public static function alert(str:String):void {
			if(ExternalInterface.available){
				ExternalInterface.call("alert", str);
			}
			trace("alert " + str)
		}
		
		public static function info(str:String):void {
			if(ExternalInterface.available){
				ExternalInterface.call("console.info", str);
			}
			trace("console.info " + str)
		}
		
		public static function debug(str:String):void {
			if(ExternalInterface.available){
				ExternalInterface.call("console.debug", str);
			}
			trace("console.debug " + str)
		}
		
		public static function warn(str:String):void {
			if(ExternalInterface.available){
				ExternalInterface.call("console.warn", str);
			}
			trace("console.warn " + str)
		}
		
		public static function error(str:String):void {
			if(ExternalInterface.available){
				ExternalInterface.call("console.error", str);
			}
			trace("console.error " + str)
		}
		
	}

}