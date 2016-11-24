package game.fly.events
{
	import flash.events.Event;
	
	/**
	 * 溢出容器边缘的事件。从不同方向溢出对应相关的事件，如：上、下、左、右。
	 * 
	 */	
	public class OverflowEvent extends Event
	{
		/**
		 * 溢出
		 */		
		public static const OVERFLOW:String = "overflow";
		/**
		 * 从左边溢出
		 */		
		public static const LEFT:String = "leftOverflow";
		/**
		 * 从右边溢出
		 */		
		public static const RIGHT:String = "rightOverflow";
		/**
		 * 从上边溢出
		 */		
		public static const TOP:String = "topOverflow";
		/**
		 * 从下边溢出
		 */		
		public static const BOTTOM:String = "bottomOverflow";
		
		public function OverflowEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}