package net.guodong.ui
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextFormat;


	public class PageNav extends MovieClip
	{
		
		public static var PAGE_CHANGE:String = "page_change";
		
		
		private var _currentPage:Number; //当前页	
		private var _totalPage:Number; //记录总页数
		private var _pageSize:Number;//分页类 显示页数
		private var _colorNormalFormat:TextFormat;
		private var _colorHighlightFormat:TextFormat;
		private var btnArr:Array;
		
		//是否显示首页和末页
		private var _isShowFirstAndEndBtn:Boolean;
		private var _prevBtn:PageBtn;
		private var _nextBtn:PageBtn;
		private var _firstBtn:PageBtn;
		private var _endBtn:PageBtn;
		
		//数字按钮起点坐标
		private var _numBtnZeroX:int;
		
		public function PageNav() 
		{
			btnArr = new Array();
			_currentPage = 1;			
			_colorNormalFormat = new TextFormat();
			_colorNormalFormat.color = 0x33CCFF;
			//
			_colorHighlightFormat = new TextFormat();
			_colorHighlightFormat.color = 0xFF9900;
			
			_numBtnZeroX = 0;
		}
		/**
		 * 设置正常颜色
		 */
		public function set normalColor(color:Number):void {
			_colorNormalFormat.color = color;
		}
		/**
		 * 设置高亮颜色
		 */
		public function set highlightColor(color:Number):void {
			_colorHighlightFormat.color = color;
		}
		
		/**
		 * 构建翻页组件
		 * @param	size        			要显示多少数字按钮
		 * @param	totalPage   			总页数
		 * @param	isShowFirstAndEndBtn    是否显示首页和末页按钮
		 */
		public function init(size:Number, totalPage:Number, isShowFirstAndEndBtn:Boolean = false):void {	
			_currentPage = 1;
			_totalPage = totalPage;		
			_pageSize = size;
			_isShowFirstAndEndBtn = isShowFirstAndEndBtn;
			buidBtn();
			updateBtnPosition();
			
		}
		public function removeBtn():void {
			for (var i:int = 0; i < btnArr.length;i++ ) {
				var pageBtn:PageBtn = btnArr[i] as PageBtn;
				pageBtn.removeEventListener(MouseEvent.CLICK, numBtnClickHandle);
				this.removeChild(pageBtn)
			}
			btnArr = [];
			if (this.contains(_prevBtn)) {
				this.removeChild(_firstBtn);
				this.removeChild(_endBtn);
				this.removeChild(_prevBtn);
				this.removeChild(_nextBtn);
				
				_firstBtn.removeEventListener(MouseEvent.CLICK, btnHandler);
				_endBtn.removeEventListener(MouseEvent.CLICK, btnHandler);
				_prevBtn.removeEventListener(MouseEvent.CLICK, btnHandler);
				_nextBtn.removeEventListener(MouseEvent.CLICK, btnHandler);
			}
		}
		public function destroy():void{
			removeBtn();
			this.parent.removeChild(this);
		}
		/**
		 * 构建翻页数字按钮
		 */
		private function buidBtn():void {
			_firstBtn = new PageBtn("首页");
			_endBtn = new PageBtn("末页");
			_prevBtn = new PageBtn("上一页");
			_nextBtn = new PageBtn("下一页");
			
			_firstBtn.txt.setTextFormat(_colorNormalFormat);
			_endBtn.txt.setTextFormat(_colorNormalFormat);
			_prevBtn.txt.setTextFormat(_colorNormalFormat);
			_nextBtn.txt.setTextFormat(_colorNormalFormat);	
			
			this.addChild(_firstBtn);
			this.addChild(_endBtn);
			this.addChild(_prevBtn);
			this.addChild(_nextBtn);
			//
			_firstBtn.addEventListener(MouseEvent.CLICK, btnHandler,false,0,true);
			_endBtn.addEventListener(MouseEvent.CLICK, btnHandler,false,0,true);
			_prevBtn.addEventListener(MouseEvent.CLICK, btnHandler,false,0,true);
			_nextBtn.addEventListener(MouseEvent.CLICK, btnHandler,false,0,true);
			
			
			for (var i:Number = 1; i <= _pageSize; i++ ) {
				var pageBtn:PageBtn = new PageBtn();							
				pageBtn.name = "PageNum" + i.toString();
				pageBtn.txt.text = i.toString();
				pageBtn.txt.setTextFormat(_colorNormalFormat);	
				pageBtn.addEventListener(MouseEvent.CLICK, numBtnClickHandle,false,0,true);
				btnArr.push(pageBtn);
				this.addChild(pageBtn);
			}
			
			
		}
		
		/**
		 * 更新所有按钮位置
		 */
		private function updateBtnPosition():void {
			var nextBtnPosition:Number = 0;
			if (_isShowFirstAndEndBtn) {
				_firstBtn.visible  = _endBtn.visible = true;
				_prevBtn.x = _firstBtn.x + _firstBtn.width + 5;
				_numBtnZeroX = _prevBtn.x + _prevBtn.width + 5;
			}else {
				_firstBtn.visible = _endBtn.visible = false;
				_prevBtn.x = 0;
				_numBtnZeroX = _prevBtn.width + 5;
			}
				
			for (var i:Number = 0; i <btnArr.length; i++ ) {
				var pageBtn:PageBtn = btnArr[i] as PageBtn;	
				if (i == 0) {
					pageBtn.x = _numBtnZeroX;
				}else {					
					pageBtn.x = nextBtnPosition;					
				}
				if(pageBtn.visible){
					nextBtnPosition = pageBtn.x + pageBtn.width + 10;
				}
				
			}
			
			_nextBtn.x = nextBtnPosition;
			nextBtnPosition = _nextBtn.x + _nextBtn.width + 10;
			_endBtn.x = nextBtnPosition;
			
		}
		
		/**
		 * 解析按钮
		 */
		public function parse():void {			
			this.dispatchEvent(new DataEvent(PAGE_CHANGE,false,false,_currentPage.toString() ));
			//
			var rows:Number = Math.ceil(_currentPage / _pageSize);
			var pageEnd:Number = rows * _pageSize;
			//
			var offset:Number = _pageSize
			for (var i:Number = 1; i <= _pageSize; i++ ) {
				offset--;
				var pageBtn:MovieClip = this.getChildByName("PageNum" + i) as MovieClip;
				
				var btnNum:Number = pageEnd - offset;
				pageBtn.txt.text = btnNum;
				
				//如果是当前数字。不让点
				if (btnNum == _currentPage) {
					pageBtn.txt.setTextFormat(_colorHighlightFormat);					
					pageBtn.mouseEnabled = false;
				}else {
					pageBtn.txt.setTextFormat(_colorNormalFormat);	
					pageBtn.mouseEnabled = true;
				}
				//超出范围 不显示
				if (btnNum>_totalPage) {
					pageBtn.visible = false;
				}else {
					pageBtn.visible = true;
				}
			}
			
			updateBtnPosition();
		}	
		public function goto(p:int):void {
			_currentPage = p
			parse();
		}
		private function prevPage():void {
			if (_currentPage > 1) {
				_currentPage--;
			}
			parse();
		}
		private function nextPage():void {		
			if (_currentPage<_totalPage) {
				_currentPage++;
			}
			parse();		
		}
		//=================================================================
		private function btnHandler(e:MouseEvent):void {			
			if (e.currentTarget == _prevBtn) {
				prevPage();
			}else if(e.currentTarget == _nextBtn) {
				nextPage();
			}else if(e.currentTarget == _firstBtn){
				_currentPage = 1
				parse();
			}else if(e.currentTarget == _endBtn){
				_currentPage = _totalPage
				parse();
			}
		}
		private function numBtnClickHandle(e:MouseEvent): void {
			var pid:Number = parseInt(e.currentTarget.txt.text);
			_currentPage = pid;
			parse();		
		}
		
	}
	
	

}







import flash.display.*;
import flash.text.*;

internal class PageBtn extends MovieClip {
	
	public var txt:TextField;
	public function PageBtn(msg:String = "") {
		txt = new TextField();
		txt.selectable = false;
		txt.autoSize = TextFieldAutoSize.LEFT;
		txt.text = msg;
		this.addChild(txt);
		this.mouseChildren = false;
		this.buttonMode = true;
	}
}