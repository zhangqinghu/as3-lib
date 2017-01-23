/**
 简单服务器数据交换类
 */
package net.guodong.net
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	
	public class JQuest
	{
		
		public function JQuest()
		{
			
		}
		
		/**
		 * 提交或读取数据
		 * @param String url           地址
		 * @param Object parameter     参数
		 * @param Function completeFun 成功方法
		 * @param Function errorFun    失败方法
		 * @param Boolean isPost       是否为post
		 */
		public static function swap(url:String, parameter:Object, completeFun:Function, errorFun:Function, isPost:Boolean	=true	):void{
			var loader:URLLoader = new URLLoader()
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.addEventListener(Event.COMPLETE,completeHandler );
			var request:URLRequest = new URLRequest(url);
			if (isPost) {
				request.method = URLRequestMethod.POST;
			}else {
				request.method = URLRequestMethod.GET;
			}
			
			var urlVar:URLVariables = new URLVariables();
			urlVar.__random = Math.round(Math.random() * 9999);
			if(parameter != null){
				for (var i:String  in parameter) {				
					urlVar[i] = parameter[i]
				}
				request.data = urlVar;	
			}
			
			request.data = urlVar;
			loader.load(request);
			
			function completeHandler(e:Event):void {
				var obj:Object = loader.data as Object;
				if(completeFun != null){
					completeFun.apply(null,[obj]);
				}
				
				loader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				loader.removeEventListener(Event.COMPLETE,completeHandler );
			}
			function errorHandler(e:IOErrorEvent):void {
				if(errorFun != null){
					errorFun.apply();
				}
				
				loader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				loader.removeEventListener(Event.COMPLETE,completeHandler );
			}
			
		}
	}
}