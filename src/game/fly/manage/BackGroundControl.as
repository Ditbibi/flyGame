package game.fly.manage
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import game.fly.config.Config;
	import game.utils.DisplayUtil;

	/**
	 * 背景控制。
	 * 
	 */	
	public class BackGroundControl
	{
		private var back11:Bitmap = MediaSource.back11;
		private var back12:Bitmap = MediaSource.back12;
//		private var back21:Bitmap = MediaSource.back21;
//		private var back22:Bitmap = MediaSource.back22;
		
		private var v1:int = 2;
		private var v2:int = 1;
		private var board:Sprite;
		private var status:String = STOP;
		
		public var START:String = "start";
		public var STOP:String = "stop";
		
		public function BackGroundControl(board:Sprite)
		{
			this.board = board;
//			board.addChild(back21);
//			board.addChild(back22);
			board.addChild(back11);
			board.addChild(back12);
		}
		
		/**
		 * 初始化。
		 * 
		 */		
		public function init():void
		{
			stop();
			
//			back11.y = Config.Hight - back11.height;
//			back12.y = Config.Hight - back12.height;
//			back21.y = Config.Hight - back21.height;
//			back22.y = Config.Hight - back22.height;
			
			back11.x = 0;
//			back12.x = Config.Width;
			back12.x = back11.width;
//			back21.x = 0;
//			back22.x = Config.Width;
//			back22.x = back21.width;
		}
		
		/**
		 * 入口，开始。
		 * 
		 */		
		public function run():void
		{
			init();
			start();
		}
		
		/**
		 * 开始。
		 * 
		 */		
		public function start():void
		{
			if(status == STOP)
			{
				board.addEventListener(Event.ENTER_FRAME, move);
				status = START;
			}
		}
		
		/**
		 * 暂停。
		 * 
		 */		
		public function stop():void
		{
			if(status == START)
			{
				board.removeEventListener(Event.ENTER_FRAME, move);
				status = STOP;
			}
		}
		
		/**
		 * 移动。
		 * 
		 */		
		private function move(e:Event):void
		{
//			back11.x = (back11.x - Config.Width - v1) % (2 * Config.Width) + Config.Width;
//			back12.x = (back12.x - Config.Width - v1) % (2 * Config.Width) + Config.Width;
//			back21.x = (back21.x - Config.Width - v2) % (2 * Config.Width) + Config.Width;
//			back22.x = (back22.x - Config.Width - v2) % (2 * Config.Width) + Config.Width;
			back11.x = (back11.x - back11.width - v1) % (2 * back11.width) + back11.width;
			back12.x = (back12.x - back11.width - v1) % (2 * back11.width) + back11.width;
//			back21.x = (back21.x - back11.width - v2) % (2 * back11.width) + back11.width;
//			back22.x = (back22.x - back11.width - v2) % (2 * back11.width) + back11.width;
		}
	}
}