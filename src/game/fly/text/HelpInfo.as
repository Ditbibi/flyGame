package game.fly.text
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	
	/**
	 * 帮助信息。
	 * 
	 */	
	public class HelpInfo extends Sprite
	{
		private var _returnBn:SimpleButton;
		
		public function HelpInfo()
		{
			makeText();
			makeButton();
		}
		
		/**
		 * 返回按钮。
		 * @return 
		 * 
		 */		
		public function get returnBn():SimpleButton
		{
			return _returnBn;
		}
		
		/**
		 * 创建帮助文本。
		 * 
		 */		
		private function makeText():void
		{
			var s:String = "<span class='body'>";
			s += "<b>操作说明</b><br>";
			s += "大娃：力大无穷<br>";
			s += "二娃：迅如闪电，还能吃特殊道具<br>";
			s += "三娃：刀枪不入<br>";
			s += "玩家一：<br>";
			s += "上：W<br>";
			s += "下：S<br>";
			s += "左：A<br>";
			s += "右：D<br>";
			s += "枪：j<br>";
			s += "炮：k<br>";
			s += "大娃变身：u<br>";
			s += "二娃变身：i<br>";
			s += "三娃变身：o<br>";
			s += "<br>";
			s += "以上为默认值，可以在\"设置\"里修改。<br>";
			s += "</span>";
			
			var r:String = "<span class='body'>";
			r += "<b>操作说明</b><br>";
			r += "大娃：力大无穷<br>";
			r += "二娃：迅如闪电，还能吃特殊道具<br>";
			r += "三娃：刀枪不入<br>";
			r += "玩家二：<br>";
			r += "上：方向键'上'<br>";
			r += "下：方向键'下'<br>";
			r += "左：方向键'左'<br>";
			r += "右：方向键'右'<br>";
			r += "枪：没设<br>";
			r += "炮：没设<br>";
			r += "大娃变身：没设<br>";
			r += "二娃变身：没设<br>";
			r += "三娃变身：没设<br>";
			r += "<br>";
			r += "以上为默认值，可以在\"设置\"里修改。<br>";
			r += "</span>";
			
			var body:Object = new Object();
			var bodyStyleSheet:StyleSheet = new StyleSheet();
			body.fontSize = 14;
			body.fontFamily = "Verdana, Arial, Helvetica, sans-serif";
			body.leading = 5;
			bodyStyleSheet.setStyle(".body", body);
			
			var text:TextField = new TextField();
			text.multiline = true;
			text.width = 600;
			text.height = 400;
			text.styleSheet = bodyStyleSheet;
			text.htmlText = s;
			addChild(text);
			
			text = new TextField();
			text.x = 307;
			text.multiline = true;
			text.width = 600;
			text.height = 400;
			text.styleSheet = bodyStyleSheet;
			text.htmlText = r;
			addChild(text);
		}
		
		/**
		 * 创建返回按钮。
		 * 
		 */		
		private function makeButton():void
		{
			_returnBn= new FormButton(FormButton.RETURN_);
			_returnBn.x = 220;
			_returnBn.y = 400;
			
			addChild(_returnBn);
		}
	}
}