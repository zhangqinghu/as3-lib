/**
 * 
var urlvar:URLVariables = new URLVariables();
urlvar.num = Math.round(Math.random() * 9999);
urlvar.sync = sync;
var request:URLRequest=new URLRequest("");
request.data = urlvar;		
MultipleFileUploader.upload(loader,request,[jpgFile1,jpgFile2,pngFile],["1.jpg","2.jpg","3.png"],["jpgFile1","jpgFile2","pngFile"]);
 * 
 */

package net.guodong.net.upload {
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class MultipleFileUploader extends EventDispatcher {

		public function MultipleFileUploader() {
		}

		public static const boundaryLength:int = 0x12;
		
		
		
		/**
		 * 模拟表单上传多个文件
		 * @param	loader
		 * @param	request
		 * @param	files        ByteArray文件 的数组
		 * @param	filesName    本地文件名数组
		 * @param	fileData     表单名数组
		 */
		public static function upload(loader:URLLoader,request:URLRequest,files:Array,filesName:Array,fileData:Array):void {
			//var req:URLRequest = packRequest(request, files, fileNames,fieldNames, contentTypes);
			
			
			// generate boundary
			var i:int
			var tmp:String;
			var boundary:ByteArray = new ByteArray();
			boundary.endian = Endian.BIG_ENDIAN;
			boundary.writeShort(0x2d2d);
			for (i = 0; i < boundaryLength-2; i++) {
				boundary.writeByte(int(97 + Math.random() * 26));
			}
			boundary.position = 0;

			// prepare new request
			var req:URLRequest = new URLRequest(request.url);
			req.contentType = 'multipart/form-data; boundary=' +
			boundary.readUTFBytes(boundaryLength);
			req.method = URLRequestMethod.POST;

			// prepare post data
			var postData:ByteArray = new ByteArray();
			postData.endian = Endian.BIG_ENDIAN;

			// write parameters
			var pars:URLVariables = request.data as URLVariables;
			
				for (var par:String in pars) {
					// -- + boundary
					postData.writeShort(0x2d2d);
					postData.writeBytes(boundary);

					// line break
					postData.writeShort(0x0d0a);

					// content disposition
					tmp = 'Content-Disposition: form-data; name="' + par + '"';
					postData.writeUTFBytes(tmp);

					// 2 line breaks
					postData.writeInt(0x0d0a0d0a);

					// parameter
					postData.writeUTFBytes(pars[par]);

					// line break
					postData.writeShort(0x0d0a);
				}
			

			// write files
			for (i = 0; i < files.length; ++i) {
				// -- + boundary
				postData.writeShort(0x2d2d);
				postData.writeBytes(boundary);

				// line break
				postData.writeShort(0x0d0a);

				// content disposition
				//var fieldName:String = "FileData"+i;
				//var fieldName:String = "file"+i;
				var fieldName:String = fileData[i];
				
				
				//if (fieldNames && fieldNames[i]) fieldName = fieldNames[i];
				tmp = 'Content-Disposition: form-data; name="' + fieldName + '"; filename="';
				postData.writeUTFBytes(tmp);

				// file name
				var fileName:String = filesName[i]
				
				//if (fileNames && fileNames[i]) fileName = fileNames[i];
				postData.writeUTFBytes(fileName);

				// missing "
				postData.writeByte(0x22);

				// line break
				postData.writeShort(0x0d0a);

				// content type
				
				tmp = 'Content-Type: application/octet-stream';

				postData.writeUTFBytes(tmp);

				// 2 line breaks
				postData.writeInt(0x0d0a0d0a);

				// file data
				var file:ByteArray = files[i];
				postData.writeBytes(file);

				// line break
				postData.writeShort(0x0d0a);
			}
			// end of writting files
/*
			// -- + boundary
			postData.writeShort(0x2d2d);
			postData.writeBytes(boundary);

			// line break
			postData.writeShort(0x0d0a);

			// upload field
			tmp = 'Content-Disposition: form-data; name="Upload"';
			postData.writeUTFBytes(tmp);

			// 2 line breaks
			postData.writeInt(0x0d0a0d0a);

			// submit
			tmp = 'Submit Query';
			postData.writeUTFBytes(tmp);

			// line break
			postData.writeShort(0x0d0a);
*/
			// -- + boundary + --
			postData.writeShort(0x2d2d);
			postData.writeBytes(boundary);
			postData.writeShort(0x2d2d);

			// line break
			postData.writeShort(0x0d0a);

			req.data = postData;
			loader.load(req);
		}

		
	}
}