package game.fly.display
{
	import game.fly.events.CollisionEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	
	/**
	 * 游戏元素，是具有事件处理和发送的SteeredMobile 对象。
	 * 
	 */	
	public class GameObject extends SteeredMobile
	{
		protected var _group:String;
		
		protected var _type:String;
		
		/**
		 * 创建具有指定位置（position）、速度（velocity）、形状（g） 的GameObject 对象，如果参数g == null则物体使用默认形状。
		 * @param position 位置，默认为(0, 0)
		 * @param velocity 速度，默认为(0, 0)
		 * @param g 形状
		 * 
		 */	
		public function GameObject(position:Vector2D=null, velocity:Vector2D=null, g:Graphics=null)
		{
			super(position, velocity, g);
			cacheAsBitmap = true;
		}
		
		/**
		 * 绘制游戏对象，并进行原点校正。
		 * @param o
		 * 
		 */		
		protected function drawDo(o:DisplayObject):void
		{
			if(o == null)return;
			o.x = (o.width >> 1) * -1;
			o.y = (o.height >> 1) * -1;
			addChild(o);
		}
		
		/**
		 * 当前对象用于改变碰撞后自身状态的方法。 
		 * @param a 碰撞到的对象。
		 * 
		 */		
		protected function collisionDo(a:DisplayObject):void{}
		
		/**
		 * 碰撞动作处理器，由碰撞监视对象调用。
		 * @param a 碰撞目标
		 * 
		 */		
		public function collisionAction(a:DisplayObject):void
		{
			collisionDo(a);
			dispatchEvent(new CollisionEvent(a));
		}
		
		/**
		 * 复位，由工厂调用。
		 * 
		 */		
		public function reset():void
		{
			//复位
		}

		/**
		 * 所属组：友军飞机（P1, P2）、敌军飞机、友军子弹（P1, P2）、敌军子弹，以方便碰撞检测。
		 */
		public function get group():String
		{
			return _group;
		}

		/**
		 * @private
		 */
		public function set group(value:String):void
		{
			_group = value;
		}

		/**
		 * 游戏对象类型。
		 */
		public function get type():String
		{
			return _type;
		}

		/**
		 * @private
		 */
		public function set type(value:String):void
		{
			_type = value;
		}


	}
}