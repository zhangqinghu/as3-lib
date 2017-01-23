/**
 * 2010-11-10
 * @author johnzhang
 */
/*
_cf = new CameraFace(640, 480);
if (_cf.available) {
	var bmd:BitmapData = _cf.getBitmapData();				
	_cf.destroy();
	_cf = null;				
}else {
	Alert.showAlert("摄像头不可用");
}

*/
package net.guodong.media
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.Camera;
	import flash.events.StatusEvent;
	import flash.events.ActivityEvent;
	import flash.media.Video;
	

	public class CameraFace extends Sprite
	{
		private var _camera:Camera;
		private var _available:Boolean;
		private var _video:Video
		public function CameraFace(width:int=640,height:int=480) 
		{
			_available = false;
			_camera = Camera.getCamera();
			if (_camera != null) {
				_available = true;
				_camera.setQuality(0, 100);
				_camera.setMode(width, height, 30);
				_camera.addEventListener(StatusEvent.STATUS,statusHandler);
				_camera.addEventListener(ActivityEvent.ACTIVITY,activityHandler);

				_video = new Video(width, height);
				_video.smoothing = true;
				_video.attachCamera(_camera);
				_video.scaleX = -1;
				_video.x =  width;
				this.addChild(_video);
			} else {
				trace("摄像头不能使用");
			}
		}
		/**
		 * 是否可用
		 */
		public function get available():Boolean {
			return _available;
		}
		/**
		 * 获取BitmapData
		 * @return
		 */
		public function getBitmapData():BitmapData {
			var bmd:BitmapData = new BitmapData(this.width, this.height);
			bmd.draw(this);
			return bmd.clone();
		}
		/**
		 * 摧毁
		 */
		public function destroy():void {
			if (_camera != null) {
				_camera = Camera.getCamera(null);
				_video.attachCamera(null);
				
				this.removeChild(_video);
				_video.clear()
				_video = null;
				
				_camera.removeEventListener(StatusEvent.STATUS,statusHandler);
				_camera.removeEventListener(ActivityEvent.ACTIVITY, activityHandler);
				_camera = null;
			}
		}
		
		
		
		
		
		
		//===============================================================
		private function statusHandler(evt:StatusEvent):void {
			if (_camera.muted) {
				trace("不能使用");
				_available = false;
			}
		}
		private function activityHandler(evt:ActivityEvent):void {
			if (evt.activating) {
				//"检测开始";
			} else {
				//"检测停止";
			}
		}
		
		
		
	}

}