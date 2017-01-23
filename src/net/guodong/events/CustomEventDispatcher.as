/**
 * 自定义事件调度器
 * @author johnzhang
 */
package net.guodong.events{
	
	
	import net.guodong.debug.Debug;
	import flash.events.EventDispatcher;
	

	public class CustomEventDispatcher extends EventDispatcher{
		
		private static var _instance:CustomEventDispatcher;
		private static var listeners:Array = new Array();
		public var id:int;
		public function CustomEventDispatcher(){
			super();
			id = int( Math.random()*10000 );
		}
		
		public static function printAllListeners():void{
			Debug.printR( listeners );
		}
		
		/**
		 * 单例模式, 返回事件调度器实例
		 * @return CustomEventDispatcher实例
		 */
		public static function getInstance():CustomEventDispatcher{
			if(!_instance){
				_instance=new CustomEventDispatcher();
			}
			return _instance;
		}
		
		/**
		 * 增加监听
		 * @param String _type EVENT_TYPE
		 * @param Function _func Listener function
		 */
		public static function addListener( _type:String, _func:Function, _once:Boolean=true ):void{
			var callback:Function = function( e:CustomEvent ):void{
				if( _func != null )
					_func(e);
				if( _once ){
					CustomEventDispatcher.removeListener( e.type, callback );
				}
			};
			listeners.push( {type:_type, func:callback, once:_once} );
			getInstance().addEventListener( _type, callback );
		}
		
		public static function dispatch( _type:String, _data:* ):void{
			getInstance().dispatchEvent( new CustomEvent( _type, _data ) );
			//CustomEventDispatcher.printAllListeners();
		}
		
		/**
		 * 删除监听
		 * @param String _type EVENT_TYPE
		 * @param Function _func Listener function
		 */
		public static function removeListener( _type:String, _callback:Function=null ):void{
			var temp:Array = [];
			for( var i:int=0; i<listeners.length; i++ ){
				if( listeners[i].type == _type && ( _callback == null || _callback == listeners[i].func ) ){
					getInstance().removeEventListener( listeners[i].type, listeners[i].func );
					continue;
				}
				temp.push( listeners[i] );
			}
			listeners = temp;
		}
		
		/**
		 * 清除所有监听
		 * @param String _type EVENT_TYPE
		 * @param Function _func Listener function
		 */
		public static function clearListener():void{
			for( var i:int=0; i<listeners.length; i++ ){
				getInstance().removeEventListener( listeners[i].type, listeners[i].func );
			}
			listeners = [];
		}
	}
}