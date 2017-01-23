/**
 * ...
 * FlashVars.parse(this.loaderInfo.parameters);
 * 
 * @author johnzhang
 */
package net.guodong.utils 
{

	public class FlashVars 
	{
		private static var params:Object={};
		public function FlashVars() 
		{
			
		}
		public static function parse(_obj:Object):void {
			params=_obj;
		}
		public static function getVariable(vName:String):*{
			return params[vName];
		}
		public static function setVariable(vName:String,value:*):void{
			params[vName]=value;
		}
		
	}

}