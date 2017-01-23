package net.guodong.math{
	public class vector {
		public var x:Number;
		public var y:Number;


		//赋予坐标值
		public function vector(x:Number,y:Number) {
			this.x=x;
			this.y=y;
		}
		//转为字符输出
		public function toStr():String {
			var rx:Number=Math.round(this.x * 1000) / 1000;
			var ry:Number=Math.round(this.y * 1000) / 1000;
			return ("[" + rx + ", " + ry + "]");
		}
		//重设坐标值
		public function reset(x:Number,y:Number) {
			this.x=x;
			this.y=y;
		}
		//克隆向量
		public function getClone():vector {
			return new vector(this.x,this.y);
		}
		//比较向量
		public function equals(v):Boolean {
			return (this.x == v.x && this.y == v.y);
		}
		//向量加法
		public function plus(v) {
			this.x+= v.x;
			this.y+= v.y;
		}
		//向量加法，返回值，不改变当前对象
		public function plusNew(v) {
			return new vector(this.x + v.x,this.y + v.y);
		}
		//向量减法
		public function minus(v) {
			this.x-= v.x;
			this.y-= v.y;
		}
		//向量减法，返回值，不改变当前对象
		public function minusNew(v) {
			return new vector(this.x - v.x,this.y - v.y);
		}
		//向量求逆
		public function negate() {
			this.x=- this.x;
			this.y=- this.y;
		}
		//向量求逆，返回值，不改变当前对象
		public function negateNew(v) {
			return new vector(- this.x,- this.y);
		}
		//向量缩放
		public function scale(s) {
			this.x*= s;
			this.y*= s;
		}
		//向量求逆，返回值，不改变当前对象
		public function scaleNew(s) {
			return new vector(this.x * s,this.y * s);
		}
		//向量长度,经典的勾股定理
		public function getLength() {
			return Math.sqrt(this.x * this.x + this.y * this.y);
		}
		//给定长度，修改vector对象的大小
		public function setLength(len) {
			var r=this.getLength();
			if (r) {
				this.scale(len / r);
			} else {
				this.x=len;
			}
		}
		//向量角度
		public function getAngle() {
			return atan2D(this.y,this.x);
		}
		//直接算角度的方法
		public function atan2D(y,x) {
			var angle=Math.atan2(- y,x) * 180 / Math.PI;
			angle*= -1;
			return chaToFlashAngle(angle);
		}
		//将笛卡尔坐标转成FLASH坐标的方法
		public function chaToFlashAngle(angle) {
			angle%= 360;
			if (angle < 0) {
				return angle + 360;
			} else {
				return angle;
			}
		}
		//保持角度，改造长度
		public function setAngle(angle) {
			var r=this.getLength();
			this.x=r * cosD(angle);
			this.y=r * sinD(angle);
		}
		//向量旋转
		public function rotate(angle) {
			var ca=cosD(angle);
			var sa=sinD(angle);

			with (this) {
				var rx=x * ca - y * sa;
				var ry=x * sa + y * ca;
				x=rx;
				y=ry;
			}
		}
		//向量旋转，返回值，不改变当前对象
		public function rotateNew(angle) {
			var v=new vector(this.x,this.y);
			v.rotate(angle);
			return v;
		}
		//点积
		public function dot(v) {
			return (this.x * v.x + this.y * v.y);
		}
		//法向量，刚体碰撞的基础公式
		public function getNormal() {
			return new vector(- this.y,this.x);
		}
		//垂直验证
		public function isPerpTo(v) {
			return (this.dot(v) == 0);
		}
		//向量的夹角
		public function angleBetween(v) {
			var dp=this.dot(v);
			var cosAngle=dp / this.getLength() * v.getLength();
			return acosD(cosAngle);
		}
		//改造SIN方法
		public function sinD(angle) {
			return Math.sin(angle * Math.PI / 180);
		}
		//改造COS方法
		public function cosD(angle) {
			return Math.cos(angle * Math.PI / 180);
		}
		//改造反余弦acos方法
		public function acosD(angle) {
			return Math.acos(angle) * 180 / Math.PI;
		}
	}
}