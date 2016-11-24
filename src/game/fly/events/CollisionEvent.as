package game.fly.events
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * 碰撞事件。collisionTarget保存了碰撞目标的引用。
	 * 
	 */	
	public class CollisionEvent extends Event
	{
		protected var _collisionTarget:Object;	//碰撞目标
		
		/**
		 * 发生碰撞
		 */		
		public static const COLLISION:String = "collision";
		
		/**
		 * 创建一个CollisionEvent 碰撞事件对象。
		 * @param collisionTarget 碰撞目标
		 * @param bubbles 确定 Event 对象是否参与事件流的冒泡阶段。默认值为 false。
		 * @param cancelable 确定是否可以取消 Event 对象。默认值为 false。
		 * 
		 */		
		public function CollisionEvent(collisionTarget:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(COLLISION, bubbles, cancelable);
			_collisionTarget = collisionTarget;
		}

		/**
		 * 碰撞目标
		 * @return
		 * 
		 */		
		public function get collisionTarget():Object
		{
			return _collisionTarget;
		}
	}
}