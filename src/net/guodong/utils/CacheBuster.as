/*
缓存控制
*/

package net.guodong.utils
{
	
	public class CacheBuster
	{
		public static var isOnline:Boolean = false;
		
		public static function create(url:String):String
		{
			if (isOnline) 
			{
				var d:Date = new Date();
				var nc:String = "nocache=" + d.getTime();
				if (url.indexOf("?") > -1) return url + "&" + nc;
				return url + "?" + nc;
			}
			return url;
		}

	}
}