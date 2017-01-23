/**
 * ...
 * @author johnzhang
 */
package  net.guodong.utils
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.system.LoaderContext; 
	import flash.net.URLRequest;


	public class DisplayObjectUtilities 
	{
		
		public function DisplayObjectUtilities() 
		{
			
		}
		
		
		
		/**
		 * 基础的图片加载方法
		 * @param	con           加载容器
		 * @param	url           加载地址
		 * @param	w             图片宽度
		 * @param	h             图片高度
		 * @param   isSmoothing   是否平滑
		 */
		public static function loadImage(con:DisplayObjectContainer, url:String, w:Number, h:Number, isSmoothing:Boolean=false):Loader {
			var _loader:Loader = new Loader();
			var completeHandler:Function;
			var ioErrorHandler:Function;
			completeHandler = function (e:Event) : void{ 
				var bit:Bitmap = e.target.content;           
				if(bit != null && isSmoothing == true){
					bit.smoothing = true;
				}
				_loader.width = w;
				_loader.height = h;
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
				_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            }  
			ioErrorHandler = function (e:IOErrorEvent) : void{
                trace("load image IOError",e);
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
				_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            }  
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
			//DisplayObjectUtilities.removeAllChildren(con);
			con.addChild(_loader);
			
			var lc:LoaderContext = new LoaderContext(true); 
			_loader.load(new URLRequest(url),lc);
			
			return _loader;
		}
		
		
		/**
		 * 自动等比缩放居中的图片加载方法
		 * @param	con        加载容器   
		 * @param	url        加载地址
		 * @param	w          图片宽度(按数值大的算缩放值)
		 * @param	h          图片高度(按数值大的算缩放值)
		 * @param	center     是否居中于加载容器
		 * @param	smoothing  是否平滑
		 * @return  Loader     Loader对象
		 */
		public static function loadImage2(con:DisplayObjectContainer, url:String, w:Number, h:Number, center:Boolean = false, smoothing:Boolean = false):Loader {
			var _loader:Loader = new Loader();
			var completeHandler:Function;
			var ioErrorHandler:Function;
			completeHandler = function (e:Event) : void{ 
				var scaleFactor:Number = 0;
				if (w > h) {
					scaleFactor = w/_loader.width;
				} else {
					scaleFactor = h/_loader.height;
				}				
				_loader.scaleX = _loader.scaleY = scaleFactor;	
				
				if (center) {
					_loader.x = -1 * _loader.width / 2;
					_loader.y = -1 * _loader.height / 2;
				}		
				
				var bit:Bitmap = e.target.content as Bitmap;
				if(bit != null && smoothing == true){
					bit.smoothing = true;
				}
				
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
				_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			}  
			ioErrorHandler = function (e:IOErrorEvent) : void{
				trace("load image IOError",e);
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
				_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			}  
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
			con.addChild(_loader);
			
			var lc:LoaderContext = new LoaderContext(true); 
			_loader.load(new URLRequest(url), lc);
			
			return _loader;
		}		

		
		/**
		 * 移除显示对象内的所有子级
		 * @param	container
		 */
		public static function removeAllChildren( container:DisplayObjectContainer ):void {
			  
			// Because the numChildren value changes after every time we remove
			// a child, save the original value so we can count correctly
			var count:int = container.numChildren;
			
			// Loop over the children in the container and remove them
			for ( var i:int = 0; i < count; i++ ) {
				container.removeChildAt( 0 );
			}
		}
		
		/**
		 * 移除显示对象内的所有子级(自带)
		 * @param	container
		 */
		public static function removeAllChildren2( container:DisplayObjectContainer ):void {
			container.removeChildren();			
		}
		
		/**
		 * 将显示对象从显示列表移除
		 * @param	displayObj
		 */
		public static function removeFromStage(displayObj:DisplayObject):void
		{
			if ( displayObj && displayObj.parent )
				displayObj.parent.removeChild(displayObj);
		}
		
		/**
		 * 停止所有动画
		 * @param	displayObjContainer
		 */
		public static function stopAll(displayObjContainer:DisplayObjectContainer):void
		{
			if (!displayObjContainer)
				return;
			if (displayObjContainer is MovieClip)
				displayObjContainer["stop"]();
			for (var i:int = 0; i < displayObjContainer.numChildren; i++) 
			{
				var obj:DisplayObjectContainer = displayObjContainer.getChildAt(i) as DisplayObjectContainer;
				if (obj)
				{
					if (obj is MovieClip)
						obj["stop"]();
					stopAll(obj);
				}
			}
		}
		
		/**
		 * 播放所有动画
		 * @param	displayObjContainer
		 */
		public static function playAll(displayObjContainer:DisplayObjectContainer):void
		{
			if (!displayObjContainer)
				return;
			if (displayObjContainer is MovieClip)
				displayObjContainer["play"]();
			for (var i:int = 0; i < displayObjContainer.numChildren; i++) 
			{
				var obj:DisplayObjectContainer = displayObjContainer.getChildAt(i) as DisplayObjectContainer;
				if (obj)
				{
					if (obj is MovieClip)
						obj["play"]();
					playAll(obj);
				}
			}
		}
		
	}

}