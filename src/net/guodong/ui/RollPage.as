

/*
RollPage($pageMc:Sprite,$vars:Object,$aix:String=”x”)

$pageMc:Sprite ：把所有内容都放在这个容器中，如多个图片或者各分页内容

$vars:Object ：这个对象会接收五个参数

	$vars["totalNum"]：总内容个数，比如总共多少张图片
	$vars["pageNum"]：设定每而或每屏显示多少个内容，比如每页显示几张图片
	$vars["childPad"]：设置每个内容之间的间隔距离
	$vars["childWidth"]：设置每个内容的高度
	$vars["childHeight"]：设置每个内容的宽度
	$vars["isSingle"]：是否单个滚动

$aix:String ：设置为垂直还是水平翻滚


*/



package net.guodong.ui {
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import com.greensock.TweenLite;

	/**
	 * @author robin
	 */
	public class RollPage {
		private var pageMc:Sprite;
		private var vars:Object;
		private var aix:String;
		private var pageNum:uint=1;

		private var childNum:uint;
		private var pageChild:uint;
		private var spanLength:uint;
		private var childWidth:uint;
		private var childHeight:uint;
		private var childPad:uint;
		private var _isSingle:Boolean;
		
		private var _totalPage:int;
		private var _initialPoint:Point;

		public function RollPage($pageMc:Sprite,$vars:Object,$aix:String="x") {
			pageMc=$pageMc;
			vars=$vars;
			aix=$aix;

			childNum=$vars["totalNum"];
			pageChild=$vars["pageNum"];
			childPad=$vars["childPad"];

			childWidth=$vars["childWidth"];
			childHeight=$vars["childHeight"];
			
			_isSingle = $vars["isSingle"];
			
			if(_isSingle){
				//一个一个滚，总数量 - 每屏显示多少个+1
				_totalPage = childNum-pageChild +1
			}else{
				//一屏一屏滚，总数量/每屏幕
				_totalPage = Math.ceil(childNum/pageChild);
			}
			
			//记录初始坐标
			_initialPoint = new Point(pageMc.x, pageMc.y);
			

			var mask:Sprite;
			if ($aix=="x") {
				spanLength = (childWidth+childPad)*pageChild;
				mask=makeArea(spanLength,childHeight);
			} else if ($aix == "y") {
				spanLength = (childHeight+childPad)*pageChild;
				mask=makeArea(childWidth,spanLength);
			}

			var pageParent:Sprite=pageMc.parent as Sprite;

			pageParent.addChild(mask);
			mask.x=pageMc.x;
			mask.y=pageMc.y;
			pageMc.mask=mask;
			//
		}

		public function toRoll($pageNum:uint):void {
			if ($pageNum<=0) { 				
				trace("firepage"); 			
			} else if ($pageNum > _totalPage) {
				trace("endpage");
			} else {
				if (aix=="x") {
					if(_isSingle){
						//x * 每个宽度+间隔
						TweenLite.to(pageMc,.5,{x:-($pageNum-1)*(childWidth+childPad) + _initialPoint.x});
					}else{
						TweenLite.to(pageMc,.5,{x:-($pageNum-1)*spanLength + _initialPoint.x});
					}
				} else if (aix == "y") {
					if(_isSingle){
						//x * 每个高度+间隔
						TweenLite.to(pageMc,.5,{y:-($pageNum-1)*(childHeight+childPad) + _initialPoint.y});
					}else{
						TweenLite.to(pageMc,.5,{y:-($pageNum-1)*spanLength + _initialPoint.y });
					}
					
				}
				pageNum=$pageNum;
			}

		}

		public function set page(num:uint):void {
			this.pageNum=num;
		}
		public function get page():uint {
			return this.pageNum;
		}
		private function makeArea(w:uint,h:uint,alpha:Number= 0.5):Sprite {
			var area:Sprite=new Sprite  ;
			area.alpha=alpha;
			area.graphics.beginFill(0x000000,1);
			area.graphics.drawRect(0,0,w,h);
			area.graphics.endFill();
			return area;
		}
		
		public function toString():String{
			return "RollPage 滚动处理类"
		}
		
	}
}
