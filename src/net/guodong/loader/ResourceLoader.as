/*
资源加载类
加载不同资源，有不同处理方法
*/

/*

ResourceLoader.INSTANCE.load("asset/Sample.swf", onLoadSWF, false);
ResourceLoader.INSTANCE.load("asset/1.jpg", onLoadIMG, false);

private function onLoadSWF(content:MovieClip):void
{
addChild(content);
content.setText("오빤 강남 스타일");
}

private function onLoadIMG(content:DisplayObject):void
{
addChild(content);
content.x = 200;

}

*/


package net.guodong.loader
{
	//import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public final class ResourceLoader
	{
		public static const INSTANCE:ResourceLoader = new ResourceLoader();
		private var loader:Loader = new Loader();
		private const urlRequest:URLRequest = new URLRequest();
		private var urlQueue:Array;
		private var currentQueue:ResourceInfo;
		
		public function ResourceLoader()
		{
			if(INSTANCE){
				throw new Error("实例不能生成.");
			}
			
			init();
			
			function init():void
			{
				urlQueue = [];
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			}
		}
		
		public function load(resourceURL:String, callback:Function, needUnload:Boolean = false):void
		{
			urlQueue.push(new ResourceInfo(resourceURL, callback, needUnload));
			loadNextQueue();
		}
		
		public function empty():void
		{
			urlQueue = [];
		}
		
		private function loadNextQueue():void
		{
			if(urlQueue.length == 0 || currentQueue){
				return;
			}
			
			currentQueue = urlQueue.shift();
			urlRequest.url = currentQueue.resourceURL;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.load(urlRequest);
			
			function onLoadComplete(event:Event):void
			{
				var targetLoader:LoaderInfo = event.target as LoaderInfo;
				targetLoader.removeEventListener(event.type, arguments.callee);
				currentQueue.callback(targetLoader.content);
				if(currentQueue.needUnload){
					targetLoader.loader.unloadAndStop();
				}
				
				currentQueue = null;
				loadNextQueue();
			}
		}
		
		private function ioErrorHandler(ioe:IOErrorEvent):void 
		{
			trace('Caught\nIOError:\n' + ioe);
		}
	}
}

class ResourceInfo
{
	public var resourceURL:String;
	public var callback:Function;
	public var needUnload:Boolean;
	
	public function ResourceInfo(imageURL:String, callback:Function, needUnload:Boolean)
	{
		this.resourceURL = imageURL;
		this.callback = callback;
		this.needUnload = needUnload;
	}
}