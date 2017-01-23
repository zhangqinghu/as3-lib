/**
* 
* @author johnzhang
* @link http://www.guodong.net/
* * 
*/
package net.guodong.net{	
    import flash.events.*;
    import flash.net.*;
    
    import net.guodong.events.CustomEvent;
	
	public class LoadVarsBot extends EventDispatcher{
		
		
		
        private var _urlLoader:URLLoader;
        
		
		function LoadVarsBot(type:String = "text") {			
			_urlLoader = new URLLoader();
			
			switch (type) { 
				case "text" : 
					_urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
					break; 
				case "variables" : 
					_urlLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
					break; 		
				case "binary" : 
					_urlLoader.dataFormat = URLLoaderDataFormat.BINARY
					break; 			
				default : 
					trace("Error"); 
			}
			_urlLoader.addEventListener(Event.COMPLETE, completeHandler);;
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
			
		private function completeHandler(event:Event):void {
			dispatchEvent(new CustomEvent(Event.COMPLETE, _urlLoader.data ));	
        }       
        private function ioErrorHandler(event:IOErrorEvent):void {		 
           dispatchEvent(event);
        }

		
		/**
		 * 提交数据
		 * @param	urlStr 地址
		 * @param	obj 变量
		 * @param	isPost 是否为post
		 */
		public function sendAndLoad(urlStr:String, obj:Object = null, isPost:Boolean = false):void {			
			var urlRequest:URLRequest = new URLRequest(urlStr);
			if (isPost) {
				urlRequest.method = URLRequestMethod.POST;
			}else {
				urlRequest.method = URLRequestMethod.GET
			}
			//
			var urlVar:URLVariables = new URLVariables();
			urlVar.__random = Math.round(Math.random() * 9999);
			if(obj != null){
				for (var i:String  in obj) {				
					urlVar[i] = obj[i]
				}
				urlRequest.data = urlVar;	
			}
			//
			_urlLoader.load(urlRequest);
		}
		
		public function destroy():void {
			_urlLoader.removeEventListener(Event.COMPLETE, completeHandler);			
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			try { 
				_urlLoader.close();
			}catch (e:Error) { 
				
			}finally { 
			
			}
			_urlLoader = null
		}
		
	}
	
}