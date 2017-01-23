/**
 * Scroller
 * ---------------------
 * VERSION: 1.0
 * DATE: 4/08/2010
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 * 
 * 配合ScrollBar1 ScrollBar2使用
 **/
package net.guodong.events
{
	import flash.events.Event;
	
	public class ScrollBarEvent extends Event
	{
		public static const VALUE_CHANGED:String = "valueChanged";
		public var scrollPercent:Number;
		
		public function ScrollBarEvent($scrollPercent:Number)
		{
			super(VALUE_CHANGED);
			scrollPercent = $scrollPercent;
		}
		
	}
}
