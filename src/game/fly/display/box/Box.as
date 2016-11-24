package game.fly.display.box
{
	import game.fly.display.GameObject;
	import game.fly.display.Vector2D;
	import game.fly.manage.MediaSource;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	/**
	 * 物资箱。
	 * 
	 */	
	public class Box extends GameObject
	{
		private var timer:Timer;				//停留在舞台时间计时器
		
		protected var delay:Number = 20000;		//在舞台上的停留时间
		protected var _sound:Sound;				//碰撞后的声音
		
		/**
		 * 创建具有指定位置（position）、速度（velocity）、形状（g） 的Box 对象，如果参数g == null则物体使用默认形状。
		 * @param position 位置，默认为(0, 0)
		 * @param g 形状
		 * 
		 */		
		public function Box(position:Vector2D=null, g:Graphics=null)
		{
			super(position, new Vector2D(-5, 0), g);
//			edgeBehavior = BOUNCE;
			edgeBehavior = REMOVE;
			_sound = MediaSource.eatBox;
			addEventListener(Event.ADDED_TO_STAGE, addedStageAction);
		}
		
		/**
		 * 定时移除事件处理。
		 * @param e
		 * 
		 */		
		private function removeAction(e:TimerEvent):void
		{
			parent.removeChild(this);
		}
		
		/**
		 * 添加到舞台事件处理。
		 * @param e
		 * 
		 */		
		private function addedStageAction(e:Event):void
		{
			timer = new Timer(delay, 1);
			addEventListener(Event.REMOVED_FROM_STAGE, removeStageAction);
			timer.addEventListener(TimerEvent.TIMER, removeAction);
			timer.start();
		}
		
		/**
		 * 移出舞台事件处理。
		 * @param e
		 * 
		 */		
		private function removeStageAction(e:Event):void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, removeAction);
			removeEventListener(Event.REMOVED_FROM_STAGE, removeStageAction);
			timer = null;
		}
		
		override protected function collisionDo(a:DisplayObject):void
		{
			sound.play();
			parent.removeChild(this);
		}
		
		override public function move():void
		{
//			wander();
			super.move();
		}

		/**
		 * 碰撞后的声音。
		 * @return 
		 * 
		 */		
		public function get sound():Sound
		{
			return _sound;
		}
	}
}