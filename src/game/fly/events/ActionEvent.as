package game.fly.events
{
	import flash.events.Event;
	
	/**
	 * 动作事件。
	 * 
	 */	
	public class ActionEvent extends Event
	{
		/**
		 * 游戏结束。
		 */		
		public static const GAME_OVER:String = "gameOver";
		
		/**
		 * 发射器被卸载。
		 */		
		public static const LAUNCHER_UNLOAD:String = "launcherUnload";
		
		public function ActionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}