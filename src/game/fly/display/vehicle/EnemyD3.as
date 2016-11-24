package game.fly.display.vehicle
{
	import game.fly.config.Runtime;
	import game.fly.display.Vector2D;
	import game.fly.manage.MediaSource;
	import game.fly.manage.MunitionFactory;
	import game.fly.manage.MunitionProxy;
	
	/**
	 * D3型敌机。
	 * 
	 */	
	public class EnemyD3 extends Vehicle
	{
		public function EnemyD3()
		{
			super(null, new Vector2D(-2, 0), null);
			maxSpeed = 2;
			maxPalstance = 10;
			edgeBehavior = REMOVE;
			maxLife = 16;
			reward = 20;
			gun = MunitionProxy.launcher(MunitionFactory.SIMPLE_2_GUN);
			gun.vehicle = this;
		}
		
		override protected function draw():void
		{
			drawDo(MediaSource.enemyD3);
		}
		
		/**
		 * 以监视的方式移动。
		 * 
		 */		
		override public function move():void
		{
			seek();
			super.move();
		}
	}
}