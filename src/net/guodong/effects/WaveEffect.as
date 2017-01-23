/**
* 声音波形效果类
* 2007-8-17
* @author johnzhang
* 
*/
package net.guodong.effects 
{
	import flash.display.*;
	import flash.events.*;	
	import flash.media.SoundMixer;	
	import flash.utils.ByteArray;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.*;

	
	public class WaveEffect extends Sprite {		
		private var bArray:ByteArray; 
		private var _width:uint;
		private var _height:uint;
		private var _bmp:Bitmap;
		private var _blur:BlurFilter;
		private var _point:Point;
		private var _cm:ColorMatrixFilter;
		private var _count:uint;
		private var _color:uint;
		private var square:Sprite;

		public function WaveEffect(w:uint=300,h:uint=200,fun:uint=1) {
			bArray = new ByteArray();
			_point = new Point(0,0);
			_count = 0;
			_color = getRndColor();
			_width = w;
			_height = h;
			
			_bmp = new Bitmap(new BitmapData(_width,_height,false,0));
			_blur = new BlurFilter(1,1);
			//_cm = new ColorMatrixFilter([0.86,0,0,0,0,0,0.86,0,0,0,0,0,0.86,0,0,0,0,0,0.86,0]);
			_cm = new ColorMatrixFilter([1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.6,0]);
			
			
			square = new Sprite();
			addChild(_bmp);	
			addChild(square);
			
			this.addEventListener(Event.ENTER_FRAME,this["draw"+fun]);
		}
		private function draw1(event:Event) {

			//SoundMixer.computeSpectrum(bArray,true,0);
			SoundMixer.computeSpectrum(bArray,false);
			//true 会导致方法返回的是频谱而不是原始声音波形

			if (_count > 30) {
				_count = 0;
				_color = getRndColor();
			} else {
				_count ++;
			}
			if (_count % 2 == 0) {
				_bmp.bitmapData.applyFilter(_bmp.bitmapData,_bmp.bitmapData.rect,_point,_blur);
			}
			_bmp.bitmapData.applyFilter(_bmp.bitmapData,_bmp.bitmapData.rect,_point,_cm);


			square.graphics.clear();
			square.graphics.lineStyle(0.08,_color);

			for (var i:uint=0; i<128; i++) {
				bArray.position = i*8;
				var offset1:Number = bArray.readFloat();
				bArray.position = i*8+1024;
				var offset2:Number = bArray.readFloat();
				var offset:int = (offset1+offset2)*(_height/2)/2;
				if (i==0) {
					square.graphics.moveTo(i,offset+_height/2);
				} else {
					square.graphics.lineTo(i,offset+_height/2);
				}
			}
			var matrix:Matrix = new Matrix();
			matrix.scale(_width/square.width,1);
			_bmp.bitmapData.draw(square,matrix);
		}
		private function draw2(event:Event) {
			/*
			if (_count > 30) {
				_count = 0;				
			} else {
				_count ++;
			}
			if (_count % 2 == 0) {
				_bmp.bitmapData.applyFilter(_bmp.bitmapData,_bmp.bitmapData.rect,_point,_blur);
			}
			*/
			_bmp.bitmapData.applyFilter(_bmp.bitmapData,_bmp.bitmapData.rect,_point,_cm);
			
			
			square.graphics.clear();
			//将当前声音输出为ByteArray
			SoundMixer.computeSpectrum(bArray,true,0);

			square.graphics.lineStyle(3,0x2AEAEB);
			for (var i:uint=0; i < 256; i=i+5) {
				//在ByteArray中读取一个32位的单精度浮点数(这个是livedoc上写的,实际就是把数据流读取成浮点数)
				var n:Number = bArray.readFloat();
				//这个实际作用是把n扩大一下
				var num:Number = n*360;

				square.graphics.moveTo(0+i,_height);
				//向上画图
				square.graphics.lineTo(0+i,_height-num/2);
			}
			var matrix:Matrix = new Matrix();
			matrix.scale(_width/square.width,1);
			_bmp.bitmapData.draw(square,matrix);
		}
		private function getRndColor():uint {
			return getRndNumber(0,5) * 0x33 * 0xFF0000 + 0xCC00 + getRndNumber(0,5) * 0x33;
		}
		private function getRndNumber(min:uint,max:uint):uint {
			return int(Math.random() * max + 1) + min;
		}
		public function close():void {
			//removeEventListener(Event.ENTER_FRAME,drawFire)
			_bmp.bitmapData.dispose();
			while (numChildren > 0) {
				//全部清除
				removeChildAt(0);
			}
		}
	}
}