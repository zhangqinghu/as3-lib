package net.guodong.utils
{
	public class ArrayPlus
	{
		public static function remove(arr:Array, ...items):void
		{
			removeArr(arr, items);
		}
		
		public static function removeArr(arr:Array, del:Array):void
		{
			for each (var value:* in del)
			{
				removeIt(arr, value);
			}
		}
		
		private static function removeIt(arr:Array, value:*):void
		{
			for (var i:int = 0; i < arr.length; i++)
			{
				if (arr[i] == value)
				{
					arr.splice(i, 1);
					i--;
				}
			}
		}
	}
}