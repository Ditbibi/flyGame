package game.fly.display.launcher
{
	import game.fly.display.Vector2D;
	import game.fly.display.bullet.Bullet;
	import game.fly.manage.MediaSource;
	import game.fly.manage.MunitionFactory;
	import game.fly.manage.MunitionProxy;
	
	/**
	 * 敌方基本枪型。
	 * <li>射速：4秒/发</li>
	 * 
	 */	
	public class Simple2Gun extends Launcher
	{
		public function Simple2Gun()
		{
			super(MunitionFactory.B1, MediaSource.shot);
			f = 4000;
		}
		
		/**
		 * 一次发射一个子弹。
		 * <li>数量：1</li>
		 * 
		 */		
		override protected function fireDo():void
		{
			//初始化一枚子弹
			var b:Bullet = MunitionProxy.bullet(bullet, vehicle.group);
			//调整位置
			b.position = new Vector2D(vehicle.x, vehicle.y);
			//调整方向
			b.direction.init(vehicle.direction);
			b.direction = b.direction;
			//调整速度方向
			b.velocity.angle = b.direction.angle;
			//加入发射队列
			pushQueue(b);
			super.fireDo();
		}
	}
}