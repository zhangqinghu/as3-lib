/**
 * ...
 * @author johnzhang
 */
package net.guodong.net 
{
	import flash.events.*;
	import flash.net.Socket;
	import flash.net.ObjectEncoding;
	import flash.system.Security;
	import flash.utils.ByteArray;
	import net.guodong.events.CustomEvent;

	public class BaseSocket extends EventDispatcher 
	{
		private var _host:String;
		private var _port:uint;
		private var _socket:Socket;
		
		function BaseSocket(host:String, port:uint){
			this._host = host;
			this._port = port;
			this._socket = new Socket();
			//this._socket.objectEncoding=ObjectEncoding.AMF3;
			Security.loadPolicyFile("xmlsocket://" + this.host + ":" + this.port);
			this._socket.addEventListener(Event.CONNECT, handler);
			this._socket.addEventListener(Event.CLOSE, handler);
			this._socket.addEventListener(IOErrorEvent.IO_ERROR, handler);
			this._socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handler);
			this._socket.addEventListener(ProgressEvent.SOCKET_DATA, handler);
		}
		public function get host():String {
			return _host;
		}

		public function get port():uint {
			return _port;
		}

		public function get connected():Boolean {
			return this._socket.connected;
		}

		public function connect():void {
			this._socket.connect(host, port);
		}

		public function close():void {
			this._socket.close();
		}
		
		public function sendMessage(str:String=""):void {
			if (! this.connected||str=="") {
				return;
			}
			var message:ByteArray = new ByteArray();
			//写入数据，使用writeUTFBytes以utf8格式传数据，避免中文乱码
			message.writeUTFBytes(str + String.fromCharCode(10));//10是\n 13是\r
			//写入socket的缓冲区
			this._socket.writeBytes(message);
			//调用flush方法发送信息
			this._socket.flush();
		}

		private function received():void {
			trace("接受服务器信息:" + this._socket.bytesAvailable + " byte(s) of data:");			
			var msg:String = "";
			while(this._socket.bytesAvailable){
				//强制使用utf8格式，避免中文乱码
				msg += this._socket.readMultiByte(this._socket.bytesAvailable,"utf-8");
			}
			trace(msg);
			dispatchEvent(new CustomEvent(ProgressEvent.SOCKET_DATA, {data:msg} ));	
		}
		//=======================================================================================================
		private function handler(e:Event):void {
			switch (e.type) {
				case Event.CLOSE :
					dispatchEvent(e);
					break;
				case Event.CONNECT :
					dispatchEvent(e);
					break;
				case IOErrorEvent.IO_ERROR :
					dispatchEvent(e);
					break;
				case SecurityErrorEvent.SECURITY_ERROR :					
					dispatchEvent(e);
					break;
				case ProgressEvent.SOCKET_DATA :
					this.received();
					break;
			}
		}
		
		public function destroy():void {
			close();
			this._socket.removeEventListener(Event.CONNECT, handler);
			this._socket.removeEventListener(Event.CLOSE, handler);
			this._socket.removeEventListener(IOErrorEvent.IO_ERROR, handler);
			this._socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handler);
			this._socket.removeEventListener(ProgressEvent.SOCKET_DATA, handler);
		}
	}

}