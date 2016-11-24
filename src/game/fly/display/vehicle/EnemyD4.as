package game.fly.display.vehicle
{
	import game.fly.display.Vector2D;
	import game.fly.manage.MediaSource;
	
	import flash.display.Graphics;
	
	/**
	 * 敌军D4型飞机。
	 * 
	 */	
	public class EnemyD4 extends Vehicle
	{
		public function EnemyD4()
		{
			super(null, new Vector2D(-4, 0), null);
			maxSpeed = 4;
			maxPalstance = 5;
			edgeBehavior = WRAP;
			maxLife = 10;
			reward = 12;
//			gun = MunitionProxy.launcher(MunitionFactory.SIMPLE_2_GUN);
//			gun.vehicle = this;
		}
		
		override protected function draw():void
		{
			drawDo(MediaSource.enemyD4);
		}
		
		/**
		 * 以监视的方式移动。
		 * 
		 */		
		override public function move():void
		{
			wander();
			super.move();
		}
	}
}