package game.fly.display.launcher
{
	import game.fly.config.Runtime;
	import game.fly.display.Vector2D;
	import game.fly.display.bullet.Bullet;
	import game.fly.manage.MediaSource;
	import game.fly.manage.MunitionFactory;
	import game.fly.manage.MunitionProxy;
	
	/**
	 * 追踪弹。
	 * <li>射速：2发/0.5秒</li>
	 * 
	 */	
	public class SeekS2Cannon extends Launcher
	{
		public function SeekS2Cannon()
		{
			super(MunitionFactory.S2, MediaSource.shot);
			f = 500;
			maxStrength = 4;
		}
		
		/**
		 * 一次发射3个子弹。
		 * <li>数量：3</li>
		 * 
		 */		
		override protected function fireDo():void
		{
			var count:int = strength < maxStrength ? strength : maxStrength;
			for(var i:int = 0; i < count; i++)
			{
				//初始化子弹
				var b1:Bullet = MunitionProxy.bullet(bullet, vehicle.group);
				b1.targets = Runtime.getInstance().enemyVehicles.vector;
				b1.target = Runtime.getInstance().target;
				//调整位置
				b1.position = new Vector2D(vehicle.x, vehicle.y);
				//调整方向
				b1.direction.init(vehicle.direction);
				b1.direction = b1.direction;
				//调整速度方向
				b1.velocity.angle = b1.direction.angle;
				//加入发射队列
				pushQueue(b1);
			}
			super.fireDo();
		}
	}
}