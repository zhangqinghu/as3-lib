/**
* 2008-11-3
* 最后更新2013-7-4
* @author johnzhang
*/
package net.guodong.display.Bitmap
{
	import flash.display.*;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;

	public class BitmapDataManage
	{
		
		function BitmapDataManage()
		{
			
		}
		
		/**
		 * 截图显示对象 获取 BitmapData
		 * @param	target
		 * @param	width
		 * @param	height
		 * @return
		 */
		public static function getBitmapData(display:DisplayObject, width:Number,height:Number):BitmapData {
			var bmpData:BitmapData = new BitmapData(width, height,true, 0);
			bmpData.draw(display);
			return bmpData;
		}
		
		/**
		 * 这方式截取的不要的地方都是透明
		 * @param	target
		 * @param	w
		 * @param	h
		 * @param	rec
		 * @return
		 */
		public static function getBitmapData2(display:DisplayObject,w:Number, h:Number, rec:Rectangle):BitmapData {
			var bmpData:BitmapData = new BitmapData(w, h,true, 0);
			bmpData.draw(display,null, null, null, rec);
			return bmpData;
		}
		
		
		
		/**
		* 用Matrix来移动图像，并截取图像,不留透明不要的区域
		* @param sourceBmp　源图像
		* @param x　源图像的x点
		* @param y　源图像的y点
		* @param w　要画的宽
	    * @param h　要画的高
	    * @return
	    */
		public static function drawBmp(sourceBmp:BitmapData, x:Number, y:Number, w:Number, h:Number):BitmapData {
			var newBmp:BitmapData = new BitmapData(w, h, true, 0);
			newBmp.draw(sourceBmp, new Matrix(1, 0, 0, 1, -x, -y));
			return newBmp;
		}
		
		
		
		/**
		 * 获取等比缩放值
		 * @param	display     需要被缩放的对象
		 * @param	newWidth    目标宽度  当值为0时就固定高度来计算
		 * @param	newHeight   目标高度  当值为0时就用固定宽度来计算
		 * @return  返回缩放值   0-1
		 */
		public static function getDisplayScaleToSize(display:DisplayObject, newWidth:Number, newHeight:Number=0):Number{
			var w:Number = display.width;
			var h:Number = display.height;
			var scaleFactor:Number = 0;
			if (newWidth > newHeight) {
				scaleFactor = newWidth/w;
			} else {
				scaleFactor = newHeight/h;
			}
			return scaleFactor;
		}
		
		
		
		/**
		 * 根据显示对象 指定大小 返回 BitmapData（缩略图，非等比缩放）
		 * @param	display      需要截屏的显示对象
		 * @param	width        目标宽度
		 * @param	height       目标高度
		 * @return  BitmapData
		 */
		public static  function getBitmapDataBySize(display:DisplayObject,width:Number,height:Number):BitmapData{
			var bmd:BitmapData = new BitmapData(display.width,display.height);
			bmd.draw(display);
			var bmp:Bitmap = new Bitmap(bmd);
			bmp.smoothing = true;
			//
			var scaleW:Number = width / display.width;
			var scaleH:Number = height / display.height;	
			var myMatrix:Matrix = new Matrix();
			myMatrix.scale(scaleW,scaleH);
			//
			var bmd_result:BitmapData = new BitmapData(display.width*scaleW,display.height*scaleH);
			bmd_result.draw(bmp,myMatrix,null,null,null,true);
			return bmd_result;
		}
		
	}
	
}