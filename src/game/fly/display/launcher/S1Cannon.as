package game.fly.display.launcher
{
	import game.fly.display.Vector2D;
	import game.fly.display.bullet.Bullet;
	import game.fly.manage.MediaSource;
	import game.fly.manage.MunitionFactory;
	import game.fly.manage.MunitionProxy;
	
	import flash.media.Sound;
	
	/**
	 * 加速弹。
	 * <li>射速：7发/1秒</li>
	 * 
	 */	
	public class S1Cannon extends Launcher
	{
		public function S1Cannon()
		{
			super(MunitionFactory.S1, MediaSource.shot);
			f = 1000;
			maxStrength = 7;
		}
		
		/**
		 * 一次发射7个子弹。
		 * <li>数量：7</li>
		 * 
		 */		
		override protected function fireDo():void
		{
			var count:int = strength < maxStrength ? strength : maxStrength;
			for(var i:int = 1; i <= count; i++)
			{
				var offset:int = (i >> 1) * 30;
				var head:int = i % 2 == 0 ? 1 : -1;
				
				//初始化子弹
				var b1:Bullet = MunitionProxy.bullet(bullet, vehicle.group);
				//调整位置
				var vx:Number = vehicle.x;
				var vy:Number = vehicle.y;
				b1.position = new Vector2D(vx, vy + head * offset);
				//调整方向
				b1.direction.init(vehicle.direction);
				b1.direction = b1.direction;
				//加入发射队列
				pushQueue(b1);
			}
			super.fireDo();
		}
	}
}