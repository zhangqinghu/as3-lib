/**
 * ...
 * @author johnzhang
 */
package net.guodong.utils 
{
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import flash.display.BitmapData;
	import com.adobe.images.*;
		
	public class SaveFile 
	{		
		private var _fileRef:FileReference;
		
		public function SaveFile() 
		{
			_fileRef = new FileReference();
		}
		
		/**
		 * 把ByteArray保存为文件
		 * @param	_b
		 * @param	defaultFileName
		 */
		public function saveFile(_b:ByteArray,defaultFileName:String=null):void
        {
            _fileRef.save(_b, defaultFileName);
            _b.clear();
        }
		
		
		/**
		 * 把bmd保存为jpg
		 * @param	bmd        BitmapData
		 * @param	quality    品质
		 * @param	fileName   文件名
		 */
		public function saveJpg(bmd:BitmapData, quality:uint = 80, fileName:String = "result.jpg"):void {
			var encoder:JPGEncoder = new JPGEncoder(quality);
			var bytes:ByteArray = encoder.encode(bmd);
			
			this.saveFile(bytes,fileName)
		}
		
		/**
		 * 把bmd保存为png
		 * @param	bmd         BitmapData
		 * @param	fileName    文件名
		 */
		public function savePng(bmd:BitmapData, fileName:String = "result.png"):void {
			var encoder:PNGEncoder =  new PNGEncoder();
			var bytes:ByteArray = PNGEncoder.encode(bmd);
			
			this.saveFile(bytes, fileName);
		}
	}

}