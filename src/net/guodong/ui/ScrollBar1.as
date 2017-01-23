/**
var scrollBar:ScrollBar1 = new ScrollBar1(scrollBar_mc.thumb_mc,scrollBar_mc.track_mc);
scrollBar.init(stage)

scrollBar.addEventListener(ScrollBarEvent.VALUE_CHANGED, scrollBarMoved);

function scrollBarMoved(event:ScrollBarEvent):void
{
	var newY:Number = -event.scrollPercent * (content_mc.height - mask_mc.height);
	//TweenLite.to(content_mc, 1, { y:newY } );	
	content_mc.y = newY;
}
 **/
package net.guodong.ui
{
	import flash.display.*;
	//import flash.events.Event;
	import flash.events.MouseEvent;
	import net.guodong.events.ScrollBarEvent;
	
	public class ScrollBar1 extends MovieClip
	{
		private var yOffset:Number;
		private var yMin:Number;
		private var yMax:Number;
		
		private var thumb_mc:MovieClip;
		private var track_mc:MovieClip;
		
		private var _stage:DisplayObject;
		
		public function ScrollBar1(bar:MovieClip,track:MovieClip)
		{
			thumb_mc = bar;
			track_mc = track;
		}
		public function  init(stage:DisplayObject):void {
			_stage = stage;
			
			yMin = 0;
			yMax = track_mc.height - thumb_mc.height;
			thumb_mc.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			
		}
		public function destroy():void{
			thumb_mc.removeEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
		}
		
		
		
		private function thumbDown(event:MouseEvent):void
		{
			_stage.addEventListener(MouseEvent.MOUSE_UP, thumbUp);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
			yOffset = mouseY - thumb_mc.y;
		}

		private function thumbUp(event:MouseEvent):void
		{
			_stage.removeEventListener(MouseEvent.MOUSE_UP, thumbUp);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
		}

		private function thumbMove(event:MouseEvent):void
		{
			thumb_mc.y = mouseY - yOffset;
			
			if (thumb_mc.y <= yMin)
			{				
				thumb_mc.y = yMin;
			}
			if (thumb_mc.y >= yMax)
			{
				thumb_mc.y = yMax;
			}
			
			dispatchEvent(new ScrollBarEvent(thumb_mc.y / yMax));
			
			event.updateAfterEvent();
		}
	}
}
