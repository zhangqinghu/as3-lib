/**
 * 
 * 扩展event
 * @author johnzhang
 */
package net.guodong.events{
	
	import flash.events.Event;


	public class CustomEvent extends Event{
		/**
		 * 事件类型 - 配置文件载入完成
		 */
		public static const LOAD_CONFIG_COMPLETE:String = 'loadConfigComplete';
		/**
		 * 事件类型 - 地址请求载入完成
		 */
		public static const LOAD_URL_COMPLETE:String = 'loadURLComplete';
		/**
		 * 事件类型 - 请求地址不存在或出现错误
		 */
		public static const LOAD_URL_ERROR:String = 'loadURLError';
		
		/**
		 * 自定义事件参数
		 */
		public var data:Object;
		
		/**
		 * 自定义事件构造函数
		 * @param String _type 事件类型
		 * @param Boolean _bubbles 是否冒泡
		 * @param Object _obj 事件参数
		 */
		public function CustomEvent( _type:String, _obj:Object ){
			super( _type, false, true );
			data = _obj;
		}
	}
}