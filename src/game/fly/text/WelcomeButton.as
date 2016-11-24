package game.fly.text
{
	import game.fly.manage.MediaSource;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	
	/**
	 * 主界面按钮元素。
	 * 
	 */	
	public class WelcomeButton extends SimpleButton
	{
		/**
		 * 单人
		 */		
		public static const ONE_PLAYER:String = "onePlayer";
		/**
		 * 双人
		 */		
		public static const TWO_PLAYER:String = "twoPlayer";
		/**
		 * 设置
		 */		
		public static const CONFIG:String = "config";
		/**
		 * 帮助
		 */		
		public static const HELP:String = "help";
		
		/**
		 * 创建一个WelcomeButton 对象。
		 * @param type 按钮类型：START，CONFIG，HELP
		 * 
		 */		
		public function WelcomeButton(type:String)
		{
			var upState:Bitmap;
			var overState:Bitmap;
			switch(type)
			{
				case ONE_PLAYER:
					upState = MediaSource.onlyButton1;
					overState = MediaSource.onlyButton2;
					break;
				case TWO_PLAYER:
					upState = MediaSource.doubleButton1;
					overState = MediaSource.doubleButton2;
					break;
				case CONFIG:
					upState = MediaSource.configButton1;
					overState = MediaSource.configButton2;
					break;
				case HELP:
					upState = MediaSource.helpButton1;
					overState = MediaSource.helpButton2;
					break;
			}
			super(upState, overState, overState, upState);
		}
	}
}