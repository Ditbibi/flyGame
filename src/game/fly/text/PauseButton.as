package game.fly.text
{
	import game.fly.manage.MediaSource;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	
	/**
	 * 暂停面板按钮。
	 * 
	 */	
	public final class PauseButton extends SimpleButton
	{
		/**
		 * 返回游戏 
		 */		
		public static const RETURN_GAME:String = "returnGame";
		/**
		 * 游戏设置
		 */		
		public static const GAME_CONFIG:String = "gameConfig";
		/**
		 * 回主菜单
		 */		
		public static const RETURN_MAIN:String = "returnMain";
		/**
		 * 查看 帮助
		 */		
		public static const LOOK_HELP:String = "lookHelp";
		
		/**
		 * 创建暂停面板按钮。
		 * @param type 按钮类型：RETURN_GAME，RETURN_MAIN，LOOK_HELP
		 * 
		 */		
		public function PauseButton(type:String)
		{
			var upState:Bitmap;
			var overState:Bitmap;
			switch(type)
			{
				case RETURN_GAME:
					upState = MediaSource.returnGameOutButton;
					overState = MediaSource.returnGameInButton;
					break;
				case GAME_CONFIG:
					upState = MediaSource.configOutButton;
					overState = MediaSource.configInButton;
					break;
				case RETURN_MAIN:
					upState = MediaSource.returnMainOutButton;
					overState = MediaSource.returnMainInButton;
					break;
				case LOOK_HELP:
					upState = MediaSource.lookHelpOutButton;
					overState = MediaSource.lookHelpInButton;
					break;
			}
			super(upState, overState, overState, upState);
		}
	}
}