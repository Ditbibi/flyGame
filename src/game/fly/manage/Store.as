package game.fly.manage
{
	import game.fly.display.GameObject;
	
	import flash.display.DisplayObject;

	/**
	 * 物体缓存，用于军火库，回收的对象将存于此以提高军火补给速度。
	 * 
	 */	
	public class Store
	{
		private var c:Vector.<GameObject>;		//存放数组
		
		/**
		 * 创建缓存。
		 * 
		 */		
		public function Store()
		{
			c = new Vector.<GameObject>();
		}
		
		/**
		 * 是否为空。
		 * @return 是/否
		 * 
		 */		
		public function isEmpty():Boolean
		{
			return c.length == 0;
		}
		
		/**
		 * 当前元素个数。
		 * @return 个数
		 * 
		 */		
		public function size():uint
		{
			return c.length;
		}
		
		/**
		 * 取出元素。
		 * @return Object对象
		 * 
		 */		
		public function get():GameObject
		{
			return c.pop();
		}
		
		/**
		 * 插入元素。
		 * @param a Object对象
		 * 
		 */		
		public function add(a:GameObject):uint
		{
			return c.unshift(a);
//			return c.push(a);
		}
		
		/**
		 * 删除指定元素。
		 * @param o Object对象
		 * 
		 */		
		public function remove(o:GameObject):void
		{
			var index:int = c.indexOf(o);
			if(index >= 0)
				c.splice(index, 1);
		}
		
		/**
		 * 清空缓存。
		 * 
		 */		
		public function clear():void
		{
			c = new Vector.<GameObject>();
		}
		
		/**
		 * 返回当前对象的Vector数组。
		 * @return 
		 * 
		 */		
		public function get vector():Vector.<GameObject>
		{
			return c;
		}
	}
}