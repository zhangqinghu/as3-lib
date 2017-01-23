package net.guodong.display.DisplayObject
{
    import flash.display.*;


    public class BaseShape {
       

        public function BaseShape() {
          
        }
		
		
		/**
		 * 画圆形
		 * @param	size          直径
		 * @param	bgColor       填充色
		 * @param	borderSize    边粗细
		 * @param	borderColor   边颜色
		 * @return
		 */
        public static function drawCircle(size:Number, bgColor:Number,borderSize:Number=0, borderColor:Number=0xFFFFFF):Shape {
            var child:Shape = new Shape();
            var halfSize:uint = Math.round(size/2);
            child.graphics.beginFill(bgColor);
            child.graphics.lineStyle(borderSize, borderColor);
            child.graphics.drawCircle(halfSize, halfSize, halfSize);
            child.graphics.endFill();
            return child;
        }
		
		
		
		/**
		 * 画圆角矩形
		 * @param	bgColor        填充色
		 * @param	width          宽度
		 * @param	height         高度
		 * @param	cornerRadius   用于绘制圆角的椭圆的宽度
		 * @param	borderSize     边粗细
		 * @param	borderColor    边颜色
		 */
        public static function drawRoundRect(bgColor:Number,width:Number,height:Number,cornerRadius:Number, borderSize:Number=0, borderColor:Number=0xFFFFFF):Shape {
            var child:Shape = new Shape();
            child.graphics.beginFill(bgColor);
            child.graphics.lineStyle(borderSize, borderColor);
            child.graphics.drawRoundRect(0, 0, width, height, cornerRadius);
            child.graphics.endFill();
            return child;
        }

		
		/**
		 * 画矩形
		 * @param	bgColor     填充色
		 * @param	width       宽度
		 * @param	height      高度
		 * @param	borderSize  边粗细
		 * @param	borderColor 边颜色
		 * @return
		 */
        public static function drawRect(bgColor:Number,width:Number,height:Number,borderSize:Number=0, borderColor:Number=0xFFFFFF):Shape {
            var child:Shape = new Shape();
            child.graphics.beginFill(bgColor);
			child.graphics.lineStyle(borderSize, borderColor);
            child.graphics.drawRect(0, 0, width, height);
            child.graphics.endFill();
            return child;
        }
    }
}