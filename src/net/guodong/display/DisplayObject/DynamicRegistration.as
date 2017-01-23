/**
* as3动态改变注册点，由as2版本改过来的....
* @author qinghu
* @version 0.1
*/
package net.guodong.display.DisplayObject{
	import flash.display.*;
	import flash.geom.Point;
	//动态设置注册点
	public class DynamicRegistration extends MovieClip {
		//
		private var regp:Point;
		private var target:MovieClip;
		//
		function DynamicRegistration(tar:MovieClip) {
			target=tar;
			trace(target.name,"被初始化");
		}
		//改边注册点
		public function setRegistration(x:Number,y:Number):void {
			regp=new Point(x,y);
		}
		//===========================================
		public function get x2():Number {
			var a:Point=target.parent.globalToLocal(target.localToGlobal(regp));
			return a.x;
		}
		public function set x2(value:Number):void {
			var a:Point=target.parent.globalToLocal(target.localToGlobal(regp));
			target.x += value - a.x;
		}
		public function get y2():Number {
			var a:Point=target.parent.globalToLocal(target.localToGlobal(regp));
			return a.y;

		}
		public function set y2(value:Number):void {
			var a:Point=target.parent.globalToLocal(target.localToGlobal(regp));
			target.y += value - a.y;
		}
		public function get scaleX2():Number {
			return target.scaleX;
		}
		public function set scaleX2(n:Number):void {
			/*
			var a:Point = target.parent.globalToLocal(target.localToGlobal(regp));
			//先处理完，再弥补坐标....
			target.scaleX = n;
			var b:Point = target.parent.globalToLocal(target.localToGlobal(regp));
			target.x -= b.x - a.x;
			target.y -= b.y - a.y;
			*/
			setPropRel("scaleX",n);
		}
		public function get scaleY2():Number {
			return target.scaleY;
		}
		public function set scaleY2(n:Number):void {
			setPropRel("scaleY",n);
		}
		public function get rotation2():Number {
			return target.rotation;
		}
		public function set rotation2(n:Number):void {
			setPropRel("rotation",n);
		}
		private function get mouseX2():Number {
			return target.mouseX - regp.x;
		}
		private function get mouseY2():Number {
			return target.mouseY - regp.y;
		}
		//设置属性的公用函数
		private function setPropRel(property:String,amount:Number):void {
			var a:Point=target.parent.globalToLocal(target.localToGlobal(regp));
			//先处理完，再弥补坐标....
			target[property]=amount;
			var b:Point=target.parent.globalToLocal(target.localToGlobal(regp));
			target.x-= b.x - a.x;
			target.y-= b.y - a.y;
		}
	}
}