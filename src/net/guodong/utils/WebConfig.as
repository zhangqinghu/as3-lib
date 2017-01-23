/**
 * 配置类
 * @author johnzhang
 */
/*


WebConfig.init();

CustomEventDispatcher.addListener(CustomEvent.LOAD_CONFIG_COMPLETE,onCompleteHandler);


WebConfig.loadXMLConfig("siteConfig.xml");
function onCompleteHandler(e:CustomEvent):void {


trace(WebConfig.toString() );
trace(WebConfig.isLocal)
trace(WebConfig.getConfig("setting").deBug)
trace(WebConfig.getConfig("siteApi").doClearWork);


WebConfig.setConfig("aaa",1111);

trace(WebConfig.getConfig("aaa"))
}
*/
package net.guodong.utils {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.LocalConnection;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import net.guodong.debug.Debug;
	import net.guodong.events.CustomEvent;
	import net.guodong.events.CustomEventDispatcher;


	public class WebConfig  extends EventDispatcher{
		private static var settings : Object = new Object;		
		private static var _isLocal : Boolean;
		public static var isInit : Boolean = false;
		/**
		 * 配置初始化
		 * 
		 */
		public static function init() : void {			
			var _myURL : String = new LocalConnection().domain;			
			if (_myURL.substr( 0 , 5 ) == "local" ) {
				_isLocal = true;// local
			}
			else {
				_isLocal = false;// server
			}
			
			isInit = true; 
		}

		/**
		 * 设置配置项组
		 * @param Object obj 配置组对象
		 */
		public static function setConfigs(obj : Object) : void {
			for ( var key:String in obj ) {
				setConfig(key, obj[key]);
			}
		}

		/**
		 * 设置配置项
		 * @param String key 键
		 * @param Object value 键值
		 */
		public static function setConfig(key : String, value : Object) : void {
			settings[key] = value;
		}

		/**
		 * 读取配置项
		 * @param String key 键
		 * @return 键值
		 * <br>
		 * Example usage:
		 * <code>
		 * Config.getConfig(key).value
		 * <code>
		 */
		public static function getConfig(key : String) : * {
			if ( settings[key] ) return settings[key];
			var set : Object = settings;
			var keys : Array = key.split('.');
			for ( var i:String in keys ) {
				set = set[keys[i]];
			}
			//trace("set::::"+set);
			return set.toString();
		}

		/**
		 * 读取XML配置文件
		 * @param String file XML文件相对路径
		 */
		public static function loadXMLConfig(urlStr : String) : void {
			trace('Load XML config file: ', urlStr);
			if(!_isLocal){
				if (urlStr.indexOf("?") < 0) {
					urlStr += "?_____="+(new Date()).getTime().toString()+"&";
				} else {
					urlStr += "&_____="+(new Date()).getTime().toString()+"&";
				}
			}
			
			var urlLoader:URLLoader = new URLLoader();			
			urlLoader.addEventListener(Event.COMPLETE, onLoadHandler);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			urlLoader.load(new URLRequest(urlStr));
			
			function onLoadHandler(e:Event) : void {
				urlLoader.removeEventListener(Event.COMPLETE, onLoadHandler);
				urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				var xml : XML = new XML(e.currentTarget.data);
				var setting : XMLList = xml.children();
				for ( var i:String in setting ) {
					setConfig(setting[i].name(), setting[i]);
				}
				CustomEventDispatcher.dispatch(CustomEvent.LOAD_CONFIG_COMPLETE, null);
			}
			function ioErrorHandler(e:IOErrorEvent):void {	
				urlLoader.removeEventListener(Event.COMPLETE, onLoadHandler);
				urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				trace("Load XML config file ioError")
			}
		}

		/**
		 * 读取JSON串配置文件
		 * @param String file 文件相对路径
		 */
		public static function loadJSONConfig(urlStr : String) : void {
			trace('Load JSON config file: ', urlStr);
			if(!_isLocal){
				if (urlStr.indexOf("?") < 0) {
					urlStr += "?_____="+(new Date()).getTime().toString()+"&";
				} else {
					urlStr += "&_____="+(new Date()).getTime().toString()+"&";
				}
			}
			var urlLoader:URLLoader = new URLLoader();			
			urlLoader.addEventListener(Event.COMPLETE, onLoadHandler);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			urlLoader.load(new URLRequest(urlStr));
			
			function onLoadHandler(e:Event) : void {				
				urlLoader.removeEventListener(Event.COMPLETE,  onLoadHandler);
				urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				var str:String = e.currentTarget.data as String;
				var obj:Object =  JSON.parse(urlStr);
				setConfigs(obj);
				CustomEventDispatcher.dispatch(CustomEvent.LOAD_CONFIG_COMPLETE, null);
			}
			function ioErrorHandler(e:IOErrorEvent):void {	
				urlLoader.removeEventListener(Event.COMPLETE,  onLoadHandler);
				urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				trace("Load JSON config file ioError")
			}
		}

		/**
		 * 取入口FLash路径
		 * @param String str LoaderInfo路径
		 * @return 入口FLash路径
		 */
		private static function getRootPath(str : String) : String {
			var debugN : int = str.lastIndexOf('\\');
			if ( debugN == -1 ) {
				var subN : int = str.lastIndexOf('/');
				str = str.substring(0, subN);
			} else {
				str = str.substring(0, debugN);
			}
			return str;
		}

		/**
		 * 路径修正,处理../的情况下调用
		 * @param String file 配置文件相对路径
		 * @return 配置文件绝对路径
		 * 
		 */
		public static function fixPath(file : String) : * {
			var res : Array = file.split('../');
			var root : String = WebConfig.getConfig('rootPath');
			if ( res && res.length > 0 ) {
				var ps : Array = root.split('/');
				for ( var i : int = 0; i < res.length; i++ ) {
					ps.pop();
				}
				root = ps.join('/') + '/';
				while ( file.indexOf('../') != -1 ) {
					file = file.replace('../', '');
				}
			}
			return root + file;
		}

		/**
		 * 打印配置串
		 * @return 字符串
		 */
		public static function toString() : String {
			var str : String = '\nConfig data:\n';
			str += '-------------------------\n';
			str += Debug.printS(settings);
			str += '-------------------------\n';
			return str;
		}

		public static function get isLocal() : Boolean {
			return _isLocal;
		}
	
	}
}
