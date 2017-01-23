/**
 * 
 * 
 * 
var localImg:LoalFileSelector = new LoalFileSelector(["*.jpg","*.jpeg"]);
localImg.addEventListener(Event.COMPLETE , onCompleteHandler)
localImg.addEventListener(Event.SELECT,onSelectHandler);

function onClickHandler(e:MouseEvent):void{	
	localImg.browse();
}

function onSelectHandler(e:Event):void{	
	trace(localImg.fileName);
	trace(localImg.fileSize);
}

function onCompleteHandler(e:Event):void{	
	var loader:Loader = new Loader();
	loader.loadBytes(localImg.fileData)
	this.addChild(loader);	
}


 * @author johnzhang
 */
package  net.guodong.net
{
	import flash.events.*;	
    import flash.net.*;
	import flash.utils.ByteArray;
	

	public class LoalFileSelector  extends EventDispatcher
	{
		private var _file:FileReference;
		private var _imageFilter:FileFilter;
		private var _isUpload:Boolean;
		
		
		public function LoalFileSelector(fileTypeArr:Array) 
		{
			_isUpload = false;
			var type:String = fileTypeArr.join(";");
			//_imageFilter = new FileFilter("Image Files (*.jpg, *.jpeg)", "*.jpg; *.jpeg;");
			_imageFilter = new FileFilter("File(" + fileTypeArr.join(",") +  ")", type);
			
			_file = new FileReference();
			configureListeners(_file);
		}
		private function configureListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);    
			dispatcher.addEventListener(Event.CANCEL, cancelHandler);        
            dispatcher.addEventListener(Event.SELECT, selectHandler);
		}
		/**
		 * 浏览图片
		 */
		public function browse():void {
			_file.browse(new Array(_imageFilter));
		}
		public function get isUpload():Boolean {
			return _isUpload;
		}
		public function get fileData():ByteArray {
			return _file.data;
		}
		public function get fileSize():Number {
			return _file.size;
		}
		public function get fileName():String {
			return _file.name;
		}
		public function reset():void {
			_isUpload = false;
		}
		//==================================================================================================		
		private function selectHandler(event:Event):void {
			var file:FileReference = FileReference(event.target);	
			file.load();
			_isUpload = true;
			this.dispatchEvent(event);
		}
		private function cancelHandler(event:Event):void {
			this.dispatchEvent(event);
		}
		private function completeHandler(e:Event):void {
			//var file:FileReference = FileReference(e.target);
			//_preview.loadPic(file.data)
			this.dispatchEvent(e);
		}		
	}

}