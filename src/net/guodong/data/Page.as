/**
* 翻页类(基于数组)
* @author john
*/
package net.guodong.data 
{
	
	
	public class Page 
	{
		private var _data:Array;
		private var _pageSize:uint;
		/**
		 * 构造
		 * @param	data_arr 数据源arr
		 * @param	pageSize 每页数量
		 */
		public function Page(data_arr:Array,pageSize:uint = 3) 
		{
			_data = data_arr;
			_pageSize = pageSize;
		}
		
		
		/**
		 * 根据页数返回结果
		 * @param	newPage 页数
		 * @return 结果数组
		 */
		public function pageSet(newPage:uint=1):Array
		{
			var result:Array = new Array();
			for (var i:uint = (newPage - 1) * _pageSize; i <= (newPage * _pageSize)-1;i++ )
			{				
				if (i<_data.length)
				{
					result.push(_data[i]);	
				}
			}
			return result;
		}
		
		
		
		public function set pageSize(n:uint):void
		{
			_pageSize = n;
		}
		public function get pageSize():uint
		{
			return _pageSize;
		}
		
	}
	
}