/**
 * 原作者spe
 * 
 */
package net.guodong.debug
{
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	/**
	 * 小型debug
	 * @author magic
	 */
	
	 
	public class Echo
	{
		private static const dic:Dictionary = new Dictionary();
		private static var txt:TextField;
		
		/**
		 * 
		 * @param	tag
		 */
		public static function jl(tag:String):void {
			dic[tag] = getTimer();
		}
		
		/**
		 * 查看记录
		 * @param	tag
		 * @param	other
		 */
		public static function showJl(tag:String, other:*= null):void {
			if(other==null){
				Echo.trace(tag, getTimer() - dic[tag]);
			}else {
				Echo.trace(other, getTimer() - dic[tag]);
			}
		}
		
		/**
		 * 在场景中打印
		 * @param	...value
		 */
		public static function trace(...value):void {
			txt.appendText(value.join("")+"\n");
		}
		
		/**
		 * 清除记录
		 */
		public static function clear():void {
			txt.text = "";
		}
		
		/**
		 * 设置场景
		 * @param	stage
		 */
		public static function setStage(stage:Stage):void {
			txt = new TextField();
			txt.mouseEnabled = false;
			txt.height = stage.stageHeight;
			txt.width = stage.stageWidth;
			txt.wordWrap = true;
			txt.multiline = true;
			stage.addChild(txt);
		}
	}
}