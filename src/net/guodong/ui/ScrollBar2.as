/**
var scrollBar:ScrollBar2 = new ScrollBar2(scrollBar_mc.thumb_mc,scrollBar_mc.track_mc);
scrollBar.init(stage)

scrollBar.addEventListener(ScrollBarEvent.VALUE_CHANGED, scrollBarMoved);

function scrollBarMoved(event:ScrollBarEvent):void {
	var newX:Number = -event.scrollPercent * (content_mc.width - mask_mc.width);
	//TweenLite.to(content_mc, 1, { x:newX } );
	
	content_mc.x = newX
}

 **/
package net.guodong.ui
{
	import flash.display.*;
	//import flash.events.Event;
	import flash.events.MouseEvent;
	import net.guodong.events.ScrollBarEvent;
	
	public class ScrollBar2 extends MovieClip
	{
		private var xOffset:Number;
		private var xMin:Number;
		private var xMax:Number;
		
		private var thumb_mc:MovieClip;
		private var track_mc:MovieClip;
		
		private var _stage:DisplayObject;
		
		public function ScrollBar2(bar:MovieClip,track:MovieClip)
		{
			
			thumb_mc = bar;
			track_mc = track;
			
		}
		public function  init(stage:DisplayObject):void {
			_stage = stage;
			
			xMin = 0;
			xMax = track_mc.width - thumb_mc.width;
			
			thumb_mc.buttonMode = true;
			thumb_mc.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
		}
		public function destroy():void{
			thumb_mc.removeEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
		}
		
		
		
		
		private function thumbDown(event:MouseEvent):void
		{
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
			_stage.addEventListener(MouseEvent.MOUSE_UP, thumbUp);
			xOffset = mouseX - thumb_mc.x;
		}

		private function thumbUp(event:MouseEvent):void
		{
			_stage.removeEventListener(MouseEvent.MOUSE_UP, thumbUp);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
		}

		private function thumbMove(event:MouseEvent):void
		{
			thumb_mc.x = mouseX - xOffset;
			
			if (thumb_mc.x <= xMin)
			{				
				thumb_mc.x = xMin;
			}
			if (thumb_mc.x >= xMax)
			{
				thumb_mc.x = xMax;
			}
			
			dispatchEvent(new ScrollBarEvent(thumb_mc.x / xMax));
			
			event.updateAfterEvent();
		}
	}
}
