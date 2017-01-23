/**
* 2008-11-21
* @author john
*/
package net.guodong.media 
{
	import flash.display.Sprite;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	import net.guodong.events.CustomEvent;
	
	
	public class FlvPlayer extends Sprite
	{
		
		public static const ON_STATUS:String = "onStatus";
		public static const ON_PLAYING:String = "onPlaying";
		public static const ON_PROGRESS:String = "onProgress";
		public static const ON_PLAY:String = "onPlay";
		public static const ON_PAUSE:String = "onPause";
		public static const ON_STOP:String = "onStop";

		
		
		private var _video:Video;
		private var _connection:NetConnection;
        private var _stream:NetStream;
		private var _videoPath:String;
		private var _soundtrans:SoundTransform;
		private var _bufferTime:Number;//缓冲时间	
		private var _duration:Number;//flv总时间
		private var _timer:Timer;
		public function FlvPlayer(playerWidth:Number = 550, playerHeight:Number = 400) 
		{
			_video = new Video(playerWidth, playerHeight);
			_connection = new NetConnection();
			_connection.connect(null);
			_soundtrans = new SoundTransform();
			_stream = new NetStream(_connection);
			_stream.bufferTime = 10;
			_stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_stream.client = this;
			_stream.soundTransform = _soundtrans;
			//_stream.client = new CustomClient();
			_video.attachNetStream(_stream);
			_video.smoothing = true;
			this.addChild(_video);
			_timer = new Timer(100);
			_timer.addEventListener(TimerEvent.TIMER, broadcastMsg);			
		}
		private function netStatusHandler(event:NetStatusEvent):void {
            //trace(event.info.code)
			dispatchEvent(new CustomEvent(ON_STATUS, {code:event.info.code} ));
			switch (event.info.code) {
                case "NetStream.Play.Start":                   
                    break;
                case "NetStream.Play.Stop": 
					stopVideo();
                    break;
            }
        }
		public function onMetaData(info:Object):void {        
			_duration = info.duration;
			trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
		}
		public function onCuePoint(info:Object):void {
			trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
		}
		public function onPlayStatus(info:Object):void {			
		}
		public function onXMPData(info:Object):void {	
			
		}
		
		private function broadcastMsg(e:TimerEvent):void
		{
			
			if (_duration>0)
			{
				dispatchEvent(new CustomEvent(ON_PLAYING, {playTime:_stream.time, allTime:_duration} ));
			}
			if (_stream.bytesLoaded>0 && _stream.bytesLoaded != _stream.bytesTotal )
			{				
				dispatchEvent(new CustomEvent(ON_PROGRESS, {loadedBytes:_stream.bytesLoaded, totalBytes:_stream.bytesTotal} ));	
			}			
		}
		//
		public function set url(src:String):void
		{
			_videoPath = src;
		}
		public function set volume(n:Number):void
		{
			_soundtrans.volume = n;		
			_stream.soundTransform = _soundtrans;
		}
		public function get volume():Number
		{			
			return _soundtrans.volume;
		}
		public function set pan(n:Number):void
		{
			_soundtrans.pan = n;
		}
		public function get pan():Number
		{
			return _soundtrans.pan;
		}
		//
		public function seek(s:Number):void {
			_stream.seek(s)
		}
		public function playVideo():void
		{
			dispatchEvent(new Event(ON_PLAY));
			_timer.start();
			_stream.play(_videoPath);
		}
		public function pauseVideo():void
		{
			dispatchEvent(new Event(ON_PAUSE));
			_stream.togglePause();
		}
		public function stopVideo():void
		{
			dispatchEvent(new Event(ON_STOP));
			_timer.stop();
			//_stream.close();
			//_video.clear();
		}
		public function destroy():void {
			
			_timer.stop();
			_stream.close();
			_video.clear();			
			_connection.close();
			
			_timer = null;
			_stream = null;
			_video = null;
			_connection = null;
		}
		
	}
	
}
/*
class CustomClient {
    public function onMetaData(info:Object):void {        
		trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
    }
    public function onCuePoint(info:Object):void {
        trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
    }
}
*/