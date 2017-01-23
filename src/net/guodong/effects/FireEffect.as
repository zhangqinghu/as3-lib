/**
* 声音火焰效果类
* 2007-8-17
* @author johnzhang
* 
*/
package net.guodong.effects 
{
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Shape;
	import flash.display.Graphics;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.geom.*;


	public class FireEffect extends Sprite {
		private var bArray:ByteArray;
		private var _width:uint;
		private var _height:uint;

		private var square:Shape;
		private var trans:Shape;

		private var stagepic:Bitmap;
		private var bmp:BitmapData;
		private var buffer:BitmapData;


		private var _blur:BlurFilter;
		private var rect:Rectangle;
		
		private var _point:Point;
		private var trans_m:Matrix;
		
		public function FireEffect(w:uint=400,h:uint=500) {
			_width= w;
			_height = h;
			bArray=new ByteArray  ;
			bmp =new BitmapData(w,h,false,0x000000);
			square = new Shape;
			buffer=new BitmapData(w,h,false,0x000000);
			trans =new Shape;
			_blur = new BlurFilter(10,10,2);
			rect = new Rectangle(0,0,w,h);
			_point = new Point(0,0);
			trans_m =new Matrix(1.001,0.002,0.002,0.99,-0.01,-5);

			trans.graphics.beginFill(0x0000000,0.08);
			trans.graphics.drawRoundRect(0,0,2,h,0);
			trans.graphics.endFill();
			stagepic=new Bitmap(bmp);

			addChild(stagepic);
			addEventListener(Event.ENTER_FRAME,drawFire);
		}
		private function drawFire(event:Event) {
			SoundMixer.computeSpectrum(bArray,true,0);
			square.graphics.clear();
			for (var i:int=0; i < 512; i++) {
				var tempc:Number=255 - i << 16 ^ i << 8 ^ 0;
				var tempj:Number=bArray.readFloat() * 150;
				square.graphics.lineStyle(6,tempc,0.3);
				if (i < 255) {
					square.graphics.moveTo(_width/2,_height-50 - i);
					square.graphics.lineTo(_width/2 - tempj,_height-50 - i);
				} else {
					square.graphics.moveTo(_width/2,_height*1.5 - i);
					square.graphics.lineTo(_width/2 + tempj,_height*1.5 - i);
				}
			}
			bmp.draw(trans,null,null,"multiply");
			bmp.draw(square,null,null,"add");
			buffer.draw(bmp);
			buffer.applyFilter(buffer,rect,_point,_blur);
			bmp.draw(buffer,trans_m);
		}
		public function close():void {
			removeEventListener(Event.ENTER_FRAME, drawFire);
			stagepic.bitmapData.dispose();
			while (numChildren > 0) {
				//全部清除
				removeChildAt(0);
			}
		}
	}
}