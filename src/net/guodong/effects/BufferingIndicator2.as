/**
 * 加载样式
 */
package  net.guodong.effects 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;	
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	public class BufferingIndicator2 extends MovieClip
	{
		
		private var _rectWidth:Number = 10;
		private var _rectHeight:Number = 60;
		private var _rectArr:Array;
		private var _rectColor:Number;
		private var _rectAlpha:Number;

		private var _container:Sprite;
		
		
		public function BufferingIndicator2(color:Number=0xCCCCCC,alpha:Number=0.5) 
		{
			_rectColor = color;
			_rectAlpha = alpha;
			_rectArr = new Array();
			
			_container = new Sprite();
			_container.x = -1 * (_rectWidth * 5) / 2 - _rectWidth/2;
			//_container.y = -1* _rectHeight / 2;
			
			
			this.addChild(_container);
			
			for(var i:int=0;i<5;i++){
				var rectShape:Shape =  drawRect();
				rectShape.x  = i * (_rectWidth+(_rectWidth/2));				
				_container.addChild(rectShape);				
				_rectArr.push(rectShape);				
				rectShape.scaleY = 0.3;				
				TweenMax.to(rectShape,.5 ,{delay:i*0.1, scaleY:1, yoyo:true,repeat:-1, ease:Quad.easeIn});
			}			
		}
		
		
		public function destroy():void {
			_container.removeChildren();
			this.removeChild(_container);
			this.parent.removeChild(this);
		}
		
		
		
		
		private function drawRect():Shape{
			var square:Shape = new Shape();
			square.graphics.beginFill(_rectColor, _rectAlpha);
			square.graphics.drawRect(-1*_rectWidth/2, -1*_rectHeight/2, _rectWidth, _rectHeight);
			return square;
		}
		
		
		
	}

}