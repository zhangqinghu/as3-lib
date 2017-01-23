/**
* 2008-11-3
* 静态动态类
* 用于临时交换数据，能象as2的_root一样，随意赋值，同时也提供基于Dictionary的存取方式
* @author johnzhang
*/
package net.guodong.data 
{	
	import flash.utils.Dictionary;
	public dynamic  class StaticData
	{
		private static var _table:Dictionary;
		private static var _this:StaticData = new StaticData;
		function StaticData() 
		{ 		
			if(_this) throw new Error("错误！实例化单例类请调用 getClass");
		}		
		/**
		 * 获得单例
		 * @return
		 */
		public static function getClass():StaticData
		{
			if (_table == null)
			{				
				_table = new Dictionary();
			}			
			return _this;			
		}		
		/**
		 * 赋值
		 * @param	key
		 * @param	value
		 * @return
		 */
		public function put(key:*,value:*):*{
			_table[key] = value;
		}
		/**
		 * 取值
		 * @param	key
		 * @return
		 */
		public function get(key:*):*{
            return _table[key];
        }
		
		
	}
	
}