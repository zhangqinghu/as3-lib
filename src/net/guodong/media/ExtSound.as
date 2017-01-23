/**
* 声音类
* 2008-11-21
* @author johnzhang
* 
* 
* 
* 
*/
package net.guodong.media 
{
	import flash.events.*;
	import flash.media.*;
	import flash.utils.*;
	import net.guodong.events.CustomEvent;
	import flash.net.URLRequest;
	
	public class ExtSound extends EventDispatcher
	{
		public static const ON_PLAYING:String = "onPlaying";
		private var _sound:Sound;
		private var _buffer:SoundLoaderContext;
		private var _soundChannel:SoundChannel;
		private var _soundtrans:SoundTransform;
		private var _state:String;
		private var _loops:uint;
		private var _startTime:Number;
		private var _timer:Timer;
		private var _isLoadOk:Boolean;
		public function ExtSound(bufferTime:uint = 1) 
		{
			_sound = new Sound();
			_soundChannel = new SoundChannel();
			_soundtrans = new SoundTransform();
			_buffer = new SoundLoaderContext(bufferTime * 1000);
			_state = "";
			_loops = 1;
			_startTime = 0;
			
			
			_timer = new Timer(100);
			_timer.addEventListener(TimerEvent.TIMER, broadcastMsg);
			
		}
		private function addListeners(mySound:Sound,myChannel:SoundChannel):void {           
            mySound.addEventListener(Event.COMPLETE, completeHandler);
            mySound.addEventListener(Event.ID3, id3Handler);
            mySound.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            mySound.addEventListener(ProgressEvent.PROGRESS, progressHandler);	
			
			
        }
		private function removeListeners(mySound:Sound,myChannel:SoundChannel):void {           
            mySound.removeEventListener(Event.COMPLETE, completeHandler);
            mySound.addEventListener(Event.ID3, id3Handler);
            mySound.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            mySound.addEventListener(ProgressEvent.PROGRESS, progressHandler);	
			
			mySound.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
        }
		private function completeHandler(event:Event):void {
			_isLoadOk = true;
            dispatchEvent(event);
        }
        private function id3Handler(event:Event):void {
            dispatchEvent(event);
        }
        private function ioErrorHandler(event:Event):void {
            dispatchEvent(event);
        }
        private function progressHandler(event:ProgressEvent):void {
            dispatchEvent(event);
        }
		private function soundCompleteHandler(event:Event):void{
			dispatchEvent(event);
			trace("soundCompleteHandler");
		}		
		//
		public function set volume(n:Number):void{
			_soundtrans.volume = n;
			_soundChannel.soundTransform = _soundtrans;//放在play里 只能 播放时指定音量，无法之后改变
		}
		public function get volume():Number{
			return _soundtrans.volume;
		}
		public function set pan(n:Number):void{
			_soundtrans.pan = n;
		}
		public function get pan():Number{
			return _soundtrans.pan;
		}
		public function get state():String{
			return _state;
		}
		private function broadcastMsg(e:TimerEvent):void{
			if (_isLoadOk ) {
				//广播当前时间 和 总时间
				dispatchEvent(new CustomEvent(ON_PLAYING, {position:_soundChannel.position, length:_sound.length} ));	
			}			
		}
		/**
		 * 载入
		 * @param	src 路径
		 * @param	isStream 是否流式
		 */
		public function load(src:String, isStream:Boolean = false):void{			
			_isLoadOk = false;
			removeListeners(_sound, _soundChannel);
			
			_sound = new Sound();//比较变态 还要重 申明个新的
			addListeners(_sound, _soundChannel);
			var request:URLRequest = new URLRequest(src);
			
			if (!isStream){				
				_sound.load(request, _buffer);
			}else{
				_sound.load(request);
			}
			
			_timer.start();
		}
		public function play(startTime:Number = 0, loops:int = 1):void{
			if (_state != "play")
			{
				_loops = loops;
				_startTime = startTime
				_soundChannel = _sound.play(_startTime, _loops, _soundtrans);	
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
				_state = "play";
			}
		}
		public function pause():void{
			if (_state != "pause")
			{
				_startTime = _soundChannel.position;
				_soundChannel.stop();
				_soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
				_state = "pause";
			}else{
				_soundChannel = _sound.play(_startTime, _loops, _soundtrans);
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
				_state = "play";
			}
		}
		public function stop():void{
			_soundChannel.stop();
			_soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			_state = "stop";
			_timer.stop();
		}
		public function close():void{
			try{
				_sound.close();			
			}
			catch (err:Error) {
                trace(err.message);
            }	
		}
		public function destroy():void {
			_timer.stop();
			_timer = null;
			this.close();
			removeListeners(_sound, _soundChannel);
			_sound = null;
			_soundChannel.stop();
			_soundChannel = null;
			_soundtrans = null;
			_state = null;
		}
		
	}
	
}