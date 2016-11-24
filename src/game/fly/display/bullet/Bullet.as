package game.fly.display.bullet
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	
	import game.fly.display.GameObject;
	import game.fly.display.Vector2D;
	
	/**
	 * 子弹。
	 * 
	 */	
	public class Bullet extends GameObject
	{	
		protected var _power:uint = 0;				//子弹能量
		protected var _penetrate:Boolean = false;	//是否能穿透
		
		public var targets:Vector.<GameObject>;			//多个目标
		
		/**
		 * 创建具有指定位置（position）、速度（velocity）、形状（g） 的Bullet 对象，如果参数g == null则物体使用默认形状。
		 * @param position 位置，默认为(0, 0)
		 * @param velocity 速度，默认为(0, 0)
		 * @param g 形状
		 * 
		 */	
		public function Bullet(position:Vector2D=null, velocity:Vector2D=null, g:Graphics=null)
		{
			super(position, velocity, g);
		}
		
		/**
		 * 子弹击中物体后更新状态
		 * 
		 */		
		override protected function collisionDo(a:DisplayObject):void
		{
			if(a is Bullet){//是子弹
				if(a is Le){//是雷
					parent.removeChild(this);
				}
				return;
			}
			//如果子弹不能穿透则消亡（从父容器中移除）
			if(!penetrate && parent)
			{
				parent.removeChild(this);
			}
		}
		
		/**
		 * 基本子弹形状，底为4高为5的等腰三角形。
		 * 
		 */	
		override protected function draw():void
		{
			graphics.clear();
			graphics.beginFill(0xAA3300);
			graphics.lineTo(5, 2);
			graphics.lineTo(0, 4);
			graphics.lineTo(0, 0);
			graphics.endFill();
		}

		/**
		 * 子弹杀伤力，默认为0。
		 * @return 
		 * 
		 */		
		public function get power():uint
		{
			return _power;
		}

		public function set power(value:uint):void
		{
			_power = value;
		}

		/**
		 * 穿透性。true表示击中目标后能继续飞行，false（默认）表示击中一次即销毁。
		 * @return 
		 * 
		 */		
		public function get penetrate():Boolean
		{
			return _penetrate;
		}

		public function set penetrate(value:Boolean):void
		{
			_penetrate = value;
		}
	}
}