/*
 倒计时类

 用于游戏之类 倒计时用

john
2014/12/14
*/

package net.guodong.time {

	import flash.utils.getTimer;
	
	public class TimerWatch {
		
		//计时器开始时间
		private var _startTime:Number;
		//开始时间，运行时间 时间差
		private var _difference:Number;		
		//倒计时总时间
		private var _totalTime:Number;
		//暂停时候记录时间
		private var _pauseTime:Number;
		//当前运行时间
		private var _currentTime:Number
		
		private var _isPause:Boolean;

		public function TimerWatch() {
			_isPause = false;
			
			
			
			
			
		}
		
		/**
		 * 开始倒计时
		 * @param time 倒计时 时间 毫秒
		 * 
		 */		
		public function start(time:Number):void {
			_totalTime = time;
			_startTime =  getTimer();
		}
		/**
		 *暂停 
		 * 
		 */		
		public function pause():void{
			if(!_isPause){
				_pauseTime = getTimer();
				_isPause = true;
			}
		}
		/**
		 *继续 
		 * 
		 */		
		public function resume():void{
			if(_isPause){
				//开始时间加上 暂停等待的时间 
				_startTime += getTimer()-_pauseTime;
				_isPause = false;
			}
		}
		
		/*
		是否为暂停状态
		*/
		public function get isPause():Boolean{
			return _isPause;
		}
		
		/**
		 *更新时间 
		 * 
		 */		
		public function update():void {			
			 if(!_isPause){
				_currentTime = getTimer();
			}
			_difference = _currentTime - _startTime;
		}
		/**
		 * 时间差 越来越大 
		 * @return 当前时间-开始时间
		 * 
		 */		
		public function getDifferenceTime():Number{
			return _difference;
		}
		/**
		 * 剩余时间 越来越小 
		 * @return 总时间 - 时间差
		 * 
		 */		
		public function getDistanceTime():Number {
			return _totalTime - _difference;
		}


	}

}