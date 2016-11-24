package game.fly.text
{
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	/**
	 * 表单文本输入框。
	 * 
	 */	
	public class FormTextInput extends Sprite
	{
		private var _name:String;
		private var _value:String;
		private var _mark:String;
		private var _inputFilder:TextField;
		
		/**
		 * 
		 * @param name 名字
		 * @param value 框内初始值
		 * @param mark 标记
		 * 
		 */		
		public function FormTextInput(name:String, mark:String = "", max:int = -1, value:String = "")
		{
			_name = name;
			_value = value;
			_mark = mark;
			makeName();
			makInput(max);
		}
		
		/**
		 * 名字。
		 * 
		 */		
		private function makeName():void
		{
			var text:TextField = new TextField();
			var styleSheet:StyleSheet = new StyleSheet();
			var style:Object = new Object();
			style.fontSize = 16;
			style.fontFamily = "Verdana, Arial, Helvetica, sans-serif";
			styleSheet.setStyle(".name", style);
			text.styleSheet  = styleSheet;
			text.htmlText = "<span class='name'>" + _name + "</span>";
			addChild(text);
		}
		
		/**
		 * 输入框。
		 * 
		 */	
		private function makInput(max:int):void
		{
			var box:TextField = new TextField();
			if(max > 0)
				box.maxChars = max;
			box.multiline = false;
			box.type = TextFieldType.INPUT;
			box.width = 100;
			box.height = 24;
			box.border = true;
			box.x = 40;
			
			var format:TextFormat = new TextFormat();
			format.size = 16;
			format.font = "Verdana, Arial, Helvetica, sans-serif";
			box.defaultTextFormat = format;
			
			_inputFilder = box;
			addChild(box);
		}

		/**
		 * 名称。
		 * @return 
		 * 
		 */		
		public function get name_():String
		{
			return _name;
		}

		/**
		 * 值。
		 * @return 
		 * 
		 */		
		public function get value():String
		{
			return _value;
		}

		public function set value(value:String):void
		{
			_value = value;
		}

		/**
		 * 标记。
		 * @return 
		 * 
		 */		
		public function get mark():String
		{
			return _mark;
		}

		/**
		 * 文本输入框。
		 * @return 
		 * 
		 */		
		public function get inputFilder():TextField
		{
			return _inputFilder;
		}

	}
}