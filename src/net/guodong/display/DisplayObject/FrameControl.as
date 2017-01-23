/**
* 2008-10-31
* @author john
* 小巧的帧控制类，静态调用
*/
package net.guodong.display.DisplayObject
{
	import flash.events.Event;
	import flash.errors.*;
	import flash.events.EventDispatcher;
	import flash.display.MovieClip;	
	public class  FrameControl extends EventDispatcher
	{		
		function FrameControl()
		{
			
		}
		/**
		* 倒播
		* @param	target
		*/
		public static function frameToFirst(target:MovieClip):void {
			clearAllListener(target)
			target.addEventListener(Event.ENTER_FRAME, frameToFirstHandler);
		}
		/**
		* 正播
		* @param	target
		*/
		public static function frameToEnd(target:MovieClip):void
		{			
			clearAllListener(target)
			target.addEventListener(Event.ENTER_FRAME, frameToEndHandler);
		}
		
		public static function frameTo(target:MovieClip, frame:Number):void
		{		
			clearAllListener(target);			
			target._targetFrame = frame
			target.addEventListener(Event.ENTER_FRAME, frameToHandler);			
		}
		
		/**
		 * 处理方法
		 */
		public static function frameToFirstHandler(e:Event):void
		{
			var target:MovieClip = e.target as MovieClip;
			if (target.currentFrame != 1 )
			{
				target.prevFrame();
			} else {
				clearAllListener(target);				
			}
		}
		public static function frameToEndHandler(e:Event):void
		{
			var target:MovieClip = e.target as MovieClip;			
			if (target.currentFrame != target.totalFrames)
			{
				target.nextFrame();
			} else {
				clearAllListener(target);				
			}
		}
		public static function frameToHandler(e:Event):void
		{
			var target:MovieClip = e.target as MovieClip;
			trace(target._targetFrame)
			
			if (target.currentFrame > target._targetFrame) {
				target.prevFrame();
			}else if(target.currentFrame < target._targetFrame){
				target.nextFrame();
			}else {
				clearAllListener(target);
			}
		}		
		
		
		public static function clearAllListener(target:MovieClip):void
		{
			try
			{
				target.removeEventListener(Event.ENTER_FRAME, frameToEndHandler);
				target.removeEventListener(Event.ENTER_FRAME, frameToFirstHandler);
				target.removeEventListener(Event.ENTER_FRAME, frameToEndHandler);
			}catch(e:Error){
					throw e;
			}
		}
		
	
		
	}
	
	
	
}