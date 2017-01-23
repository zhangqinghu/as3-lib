/**
 * ...
 * @author johnzhang
 */
package  net.guodong.display.DisplayObject
{
	import flash.display.*;
	import flash.events.*;
	import net.guodong.display.DisplayObject.FrameControl;

	public class CustomBtn 
	{
		
		public function CustomBtn() 
		{
			
		}
		public static function init(target:MovieClip):void {
			target.gotoAndStop(1);
			target.buttonMode = true;
			target.addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler, false, 0, true);
			target.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler, false, 0, true);
		}
		public static function destroy(target:MovieClip):void {
			FrameControl.clearAllListener(target);
			target.removeEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
			target.removeEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
		}
		
		
		public static function onRollOverHandler(e:MouseEvent):void {
			var mc:MovieClip = e.currentTarget as MovieClip;
			if (mc.mouseEnabled) {
				FrameControl.frameToEnd(mc)
			}
		}
		public static function onRollOutHandler(e:MouseEvent):void {
			var mc:MovieClip = e.currentTarget as MovieClip;	
			if (mc.mouseEnabled) {
				FrameControl.frameToFirst(mc);
			}
		}
	}

}