package game.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * DisplayObject对象工具类。
	 */	
	public class DisplayUtil
	{
		/**
		 * 清空显示列表。
		 * @param c DisplayObjectContainer容器
		 * 
		 */		
		public static function clearContainer(c:DisplayObjectContainer, f:Function = null):void
		{
			if(c)
			{
				for(var i:int = c.numChildren - 1; i >= 0; i--)
				{
					var o:DisplayObject = c.removeChildAt(i);
					if(f != null)
						f(o);
				}
			}
		}
	}
}