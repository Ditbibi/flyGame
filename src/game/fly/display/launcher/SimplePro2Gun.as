package game.fly.display.launcher
{
	import game.fly.display.Vector2D;
	import game.fly.display.bullet.Bullet;
	import game.fly.manage.MediaSource;
	import game.fly.manage.MunitionFactory;
	import game.fly.manage.MunitionProxy;
	
	import flash.media.Sound;
	
	/**
	 * 敌方小Boss枪型。
	 * <li>射速：5秒/10发</li>
	 * 
	 */	
	public class SimplePro2Gun extends Launcher
	{
		public function SimplePro2Gun()
		{
			super(MunitionFactory.B1, MediaSource.shot);
			f = 5000;
		}
		
		/**
		 * 一次发射10个子弹。
		 * <li>数量：10</li>
		 * 
		 */		
		override protected function fireDo():void
		{
			//初始化10枚子弹
			var b1:Bullet = MunitionProxy.bullet(bullet, vehicle.group);
			var b2:Bullet = MunitionProxy.bullet(bullet, vehicle.group);
			var b3:Bullet = MunitionProxy.bullet(bullet, vehicle.group);
			var b4:Bullet = MunitionProxy.bullet(bullet, vehicle.group);
			var b5:Bullet = MunitionProxy.bullet(bullet, vehicle.group);
			var b6:Bullet = MunitionProxy.bullet(bullet, vehicle.group);
			var b7:Bullet = MunitionProxy.bullet(bullet, vehicle.group);
			var b8:Bullet = MunitionProxy.bullet(bullet, vehicle.group);
			var b9:Bullet = MunitionProxy.bullet(bullet, vehicle.group);
			var b10:Bullet = MunitionProxy.bullet(bullet, vehicle.group);
			//调整位置
			b1.position = new Vector2D(vehicle.x, vehicle.y);
			b2.position = new Vector2D(vehicle.x, vehicle.y);
			b3.position = new Vector2D(vehicle.x, vehicle.y);
			b4.position = new Vector2D(vehicle.x, vehicle.y);
			b5.position = new Vector2D(vehicle.x, vehicle.y);
			b6.position = new Vector2D(vehicle.x, vehicle.y);
			b7.position = new Vector2D(vehicle.x, vehicle.y);
			b8.position = new Vector2D(vehicle.x, vehicle.y);
			b9.position = new Vector2D(vehicle.x, vehicle.y);
			b10.position = new Vector2D(vehicle.x, vehicle.y);
			//调整速度方向
			b1.velocity.angle = vehicle.direction.angle - 0.4;
			b2.velocity.angle = vehicle.direction.angle - 0.3;
			b3.velocity.angle = vehicle.direction.angle - 0.2;
			b4.velocity.angle = vehicle.direction.angle - 0.1;
			b5.velocity.angle = vehicle.direction.angle;
			b6.velocity.angle = vehicle.direction.angle + 0.1;
			b7.velocity.angle = vehicle.direction.angle + 0.2;
			b8.velocity.angle = vehicle.direction.angle + 0.3;
			b9.velocity.angle = vehicle.direction.angle + 0.4;
			b10.velocity.angle = vehicle.direction.angle + 0.5;
			//加入发射队列
			pushQueue(b1);
			pushQueue(b2);
			pushQueue(b3);
			pushQueue(b4);
			pushQueue(b5);
			pushQueue(b6);
			pushQueue(b7);
			pushQueue(b8);
			pushQueue(b9);
			pushQueue(b10);
			
			super.fireDo();
		}
	}
}