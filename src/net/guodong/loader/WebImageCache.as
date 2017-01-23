

/**
 * 简单缓存类
   适用于被加载图片重复使用
 * @author johnzhang
 */
package  net.guodong.loader 
{
	import flash.display.BitmapData;
	import flash.net.URLRequest;

	public class WebImageCache 
	{
		private static var _instance:WebImageCache;
		private var _loaderArr:Array;
		private var _urlArr:Array;
		public function WebImageCache(fileArr:Array) 
		{
			_urlArr = fileArr;
			_loaderArr = new Array();
			
			for (var i:int = 0; i < _urlArr.length; i++ ) {
				loadPic(_urlArr[i]);
			}
			
		}
		
		/*
		public static function get instance():WebImageCache {
			if (_instance) return _instance
			_instance = new WebImageCache()
			return _instance
		}*/
		
		/*
		没做容错，被加载的必须是图片
		*/
		private function loadPic(url:String):Boolean {
			if (!isExist(url)) {
				var newItem:ResourceInfo = new ResourceInfo(url);
				newItem.resourceLoader.load(new URLRequest(url));
				_loaderArr.push(newItem);				
				return true;				
			}else {
				//存在了
				return false;
				
				
		
			}
		}
		
		/*
		根据url获取bmp
		*/
		public function getPic(url:String):BitmapData {			
			var bmd:BitmapData = null;
			for (var i:int = 0; i < _loaderArr.length; i++ ) {
				var item:ResourceInfo = _loaderArr[i] as ResourceInfo;
				if (item.resourceURL == url) {
					bmd =  item.resourceBitmapData;					
				}				
			}
			return bmd;	
		}
		
		
		/*
		是否存在于cache中
		*/
		private function isExist(url:String):Boolean {
			for (var i:int = 0; i < _loaderArr.length; i++ ) {
				var item:ResourceInfo = _loaderArr[i] as ResourceInfo;
				if (item.resourceURL == url) {
					return true;					
				}				
			}
			return false;	
		}
		
		/*
		获取成功数量
		*/
		public function getLoadCompleteItem():int{
			var result:int = 0;
			for (var i:int = 0; i < _loaderArr.length; i++ ) {
				var item:ResourceInfo = _loaderArr[i] as ResourceInfo;
				if (item.loadState == 1) {
					result++;					
				}				
			}
			return result;	
		}
		/*
		获取失败数量
		*/
		public function getLoadErrorItem():int{
			var result:int = 0;
			for (var i:int = 0; i < _loaderArr.length; i++ ) {
				var item:ResourceInfo = _loaderArr[i] as ResourceInfo;
				if (item.loadState == -1) {
					result++;					
				}				
			}
			return result;	
		}
		
		public function destroy():void {
			for (var l in _loaderArr) {
				_loaderArr[l].dispose();
				delete _loaderArr[l];
			}
		}
		
		
	}

}

import flash.display.*;
import flash.events.*;
internal class ResourceInfo extends Loader {
	
	public var resourceURL:String;
	public var resourceLoader:Loader;
	public var resourceBitmapData:BitmapData;;
	public var loadState:int;

	
	public function ResourceInfo(imageURL:String)
	{
		resourceBitmapData = null;
		loadState = 0;//0无状态  1成功  -1失败
		resourceURL = imageURL;
		resourceLoader = new Loader();
		resourceLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadCompleteHandler);
		resourceLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		
	}
	private function loadCompleteHandler(e:Event):void {
		resourceLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadCompleteHandler);
		//var bmp:BitmapData = new BitmapData(this.resourceLoader.width, this.resourceLoader.height, true,0);
		//bmp.draw(this.resourceLoader);
		//_fontBitmapData.push(bmp);
		loadState = 1;
		var bit:Bitmap = e.target.content;           
        if(bit != null){
           resourceBitmapData = bit.bitmapData;
        }
	}
	private function ioErrorHandler(e:IOErrorEvent):void{
		resourceLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		loadState = -1;
	}
	public function dispose():void{
		if(resourceBitmapData){
			resourceBitmapData.dispose();
			resourceLoader.unloadAndStop(true);
			resourceLoader = null;
		}
	}
	
}