package game.fly.config
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	
	import game.fly.manage.MediaSource;
	import game.fly.text.FormTextInput;
	import game.utils.KeyCodeMap;

	/**
	 * 配置管理器。
	 * 
	 */	
	public class ConfigManager
	{
		//是否允许得到焦点数据
		public static var Focus_Allow:Boolean = false;
		
		private var config:Config = Config.getInstance();
		
		private var form:Sprite;
		private var x1:int = 100 + 210;
		private var x2:int = 400 + 210;
		private var y:int = 30;
		private var blank:int = 50;
		
		private var atts:Array = [
			"上：", 
			"下：",
			"左：",
			"右：",
			"枪：",
			"炮：",
			"大娃：",
			"二娃：",
			"三娃："
		];
		private var keys:Array = [
			"up", 
			"down",
			"left",
			"right",
			"a",
			"b",
			"1",
			"2",
			"3"
		];
		
		/**
		 * 构建配置表单并返回。
		 * @return 
		 * 
		 */		
		public function getForm():Sprite
		{
			form = new Sprite();
			
			var p1Ico:Bitmap = MediaSource.p1Name;
			var p2Ico:Bitmap = MediaSource.p2Name;
			p1Ico.x = x1;
			p2Ico.x = x2;
			p1Ico.y = y;
			p2Ico.y = y;
			form.addChild(p1Ico);
			form.addChild(p2Ico);
			
			makeP1Form();
			makeP2Form();
			return form;
		}
		
		/**
		 * 创建p1配置表单。
		 * 
		 */		
		private function makeP1Form():void
		{
			var mark:int = 1;
			for(var o:String in atts)
			{
				var input:FormTextInput = new FormTextInput(atts[o], "p1_" + keys[o], 1);
				input.x = x1;
				input.y = y + mark * blank;
				mark++;
				input.inputFilder.addEventListener(FocusEvent.FOCUS_IN, inFocusAction);
				form.addChild(input);
			}
		}
		
		/**
		 * 创建p2配置表单。
		 * 
		 */		
		private function makeP2Form():void
		{
			var mark:int = 1;
			for(var o:String in atts)
			{
				var input:FormTextInput = new FormTextInput(atts[o], "p2_" + keys[o], 1);
				input.x = x2;
				input.y = y + mark * blank;
				mark++;
				input.inputFilder.addEventListener(FocusEvent.FOCUS_IN, inFocusAction);
				form.addChild(input);
			}
		}
		
		/**
		 * 得到焦点事件。
		 * @param e
		 * 
		 */		
		private function inFocusAction(e:FocusEvent):void
		{
			if(!Focus_Allow)return;
			var o:TextField = e.target as TextField;
			o.removeEventListener(FocusEvent.FOCUS_IN, inFocusAction);
			o.addEventListener(KeyboardEvent.KEY_UP, keyUpAction);
			o.addEventListener(FocusEvent.FOCUS_OUT, outFocusAction);
		}
		
		/**
		 * 失去焦点事件。
		 * @param e
		 * 
		 */		
		private function outFocusAction(e:FocusEvent):void
		{
			var o:TextField = e.currentTarget as TextField;
			o.removeEventListener(KeyboardEvent.KEY_UP, keyUpAction);
			o.removeEventListener(FocusEvent.FOCUS_OUT, outFocusAction);
			o.addEventListener(FocusEvent.FOCUS_IN, inFocusAction);
		}
		
		/**
		 * 按键弹起事件。
		 * @param e
		 * 
		 */	
		private function keyUpAction(e:KeyboardEvent):void
		{
			var o:TextField = e.currentTarget as TextField;
			var p:FormTextInput = o.parent as FormTextInput;
			var keyCode:uint = e.keyCode;
			switch(p.mark)
			{
				case "p1_up":
					config.p1Up = keyCode; break;
				case "p1_down":
					config.p1Down = keyCode; break;
				case "p1_left":
					config.p1Left = keyCode; break;
				case "p1_right":
					config.p1Right = keyCode; break;
				case "p1_a":
					config.p1A = keyCode; break;
				case "p1_b":
					config.p1B = keyCode; break;
				case "p1_1":
					config.p1Henshin1 = keyCode; break;
				case "p1_2":
					config.p1Henshin2 = keyCode; break;
				case "p1_3":
					config.p1Henshin3 = keyCode; break;
				case "p2_up":
					config.p2Up = keyCode; break;
				case "p2_down":
					config.p2Down = keyCode; break;
				case "p2_left":
					config.p2Left = keyCode; break;
				case "p2_right":
					config.p2Right = keyCode; break;
				case "p2_a":
					config.p2A = keyCode; break;
				case "p2_b":
					config.p2B = keyCode; break;
				case "p2_1":
					config.p2Henshin1 = keyCode; break;
				case "p2_2":
					config.p2Henshin2 = keyCode; break;
				case "p2_3":
					config.p2Henshin3 = keyCode; break;
			}
			o.text = KeyCodeMap.get(e.keyCode);
			e.stopPropagation();
		}
	}
}