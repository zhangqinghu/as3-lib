/**
 * ...
 * @author johnzhang
 */
package net.guodong.net 
{
	import flash.display.BitmapData;
	import flash.events.*;	
    import flash.net.*;
	import flash.utils.ByteArray;
	import net.guodong.events.CustomEvent;
	
	import com.adobe.images.*;
	

	public class SavePic extends EventDispatcher
	{
		private var _url:String;
		private var _type:String;
		private var _request:URLRequest;
		private var _loader:URLLoader;
		
		public function SavePic(url:String,type:String="jpg") 
		{
			_url = url;
			_type = type;
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, saveCompleteHandler);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_loader.addEventListener(Event.OPEN, openHandler);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            _loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
		}
		
		//改变url 通常用于外加一些get 参数
		public function set url(s:String):void {
			_url = s;			
		}
		public function savePic(bitMapData:BitmapData, quality:uint = 80):void {
			var encoder:*
			var bytes:ByteArray;
			if (_type == "jpg") {
				encoder = new JPGEncoder(quality);
				bytes = encoder.encode(bitMapData);
			}else if(_type == "png"){
				encoder = new PNGEncoder();
				bytes = PNGEncoder.encode(bitMapData);
			}
			
			
			_request = new URLRequest(_url);
			_request.data = bytes;
			_request.method = URLRequestMethod.POST;			
			_request.contentType = "application/octet-stream";
			
			_loader.load(_request);
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void {			
			dispatchEvent(e);
		}
		private function openHandler(event:Event):void {
            dispatchEvent(event);
        }
        private function progressHandler(event:ProgressEvent):void {
            dispatchEvent(event);
        }
        private function securityErrorHandler(event:SecurityErrorEvent):void {
            dispatchEvent(event);
        }
        private function httpStatusHandler(event:HTTPStatusEvent):void {
            dispatchEvent(event);
        }
		private function saveCompleteHandler(e:Event):void {
			dispatchEvent(new CustomEvent(Event.COMPLETE, {data:_loader.data} ));
			//dispatchEvent(e);
		}
		
		public function destroy():void {
			_request = null;
			_loader.removeEventListener(Event.COMPLETE, saveCompleteHandler);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_loader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			_loader.removeEventListener(Event.OPEN, openHandler);
			_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            _loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			try { 
				_loader.close();
			}catch (e:Error) { 
				
			}finally { 
			
			}
			_loader = null
		}
		
	}

}