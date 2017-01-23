

/**
 * 拖动图片处理类
 * @author johnzhang
 */

package net.guodong.ui
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray; 

	public class PreviewPic extends MovieClip
	{
		private var _loader:Loader;
		private var _target:MovieClip;
		private var _mouseOffsetPoint:Point;
		private var _picOffsetPoint:Point;
		private var _stage:Stage;
		private var _isCenter:Boolean;
		
		public static const PIC_LOAD_COMPLETE:String = "pic_load_complete";
		
		/**
		 * 
		 * @param	target   容器
		 * @param	myStage  场景
		 * @param   isDrag   是否允许拖动 
		 * @param   isCenter 载入图片是否居中与容器
		 */
		public function PreviewPic(target:MovieClip,myStage:Stage,isDrag:Boolean=true, isCenter:Boolean=false) 
		{
			_target = target;
			_stage = myStage;
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener (Event.COMPLETE, onPicLoadComplete);
			
			
			if (isDrag) {
				_target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
				_target.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
				_target.buttonMode = true;
				_target.useHandCursor = true
			}
			
			_isCenter = isCenter;
		}
		
		/**
		 * 通过byte 加载图片
		 * @param	byte 图片的ByteArray数据
		 */
		public function loadPicByBytes(byte:ByteArray):void {
			_loader.loadBytes(byte);			
		}
		
		/**
		 * 通过url 加载图片
		 * @param	src
		 */
		public function loadPicByUrl(src:String):void {
			var lc:LoaderContext = new LoaderContext(true); 
			_loader.load(new URLRequest(src), lc);			
		}		
		/**
		 * 通过 Bitmap 直接塞入图片
		 * @param	bim
		 */
		public function loadPicByBitmap(bmp:Bitmap):void {
			unload();
			if (_isCenter) {
				bmp.x = -1 * bmp.width/2;
				bmp.y = -1 * bmp.height / 2;
			}
			_target.addChild(bmp);
			
			this.dispatchEvent(new Event(PreviewPic.PIC_LOAD_COMPLETE));
			
			//防止是跨域的造成错误 所以放最后
			if(bmp != null){
				bmp.smoothing = true;
			}
		}
		/**
		 * 清除载入的图片
		 */
		public function unload():void {			
			_target.removeChildren();
		}
		/**
		 * 销毁
		 */
		public function destroy():void {
			unload();
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onPicLoadComplete);
			_loader = null;
			
			_target.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			_target.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
		}
		
		
		
		//==================================================================
		private function onPicLoadComplete(e:Event):void {	
			unload();
			
			var bmp:Bitmap = e.target.content;
			if (_isCenter) {
				bmp.x = -1 * bmp.width/2;
				bmp.y = -1 * bmp.height / 2;
			}
			
			_target.addChild(bmp);
			
			this.dispatchEvent(new Event(PreviewPic.PIC_LOAD_COMPLETE));
			
			//防止是跨域的造成错误 所以放最后
			if(bmp != null){
				bmp.smoothing = true;
			}
		}
		
		private function onMouseDownHandler(e:MouseEvent):void {
			_mouseOffsetPoint = new Point(this.mouseX, this.mouseY)
			_picOffsetPoint = new Point(_target.x,_target.y)
			this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			//trace(_stage)
		}
		private function onMouseUpHandler(e:MouseEvent):void {
			_stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		private function onEnterFrameHandler(e:Event):void {
			var p2:Point = new Point(this.mouseX, this.mouseY);
			var d:Point = p2.subtract(_mouseOffsetPoint);
			var n:Point = d.add(_picOffsetPoint);
			
			_target.x = n.x;
			_target.y = n.y;
			//trace(e)
		}
	}

}