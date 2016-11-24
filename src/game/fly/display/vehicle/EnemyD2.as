package game.fly.display.vehicle
{
	import game.fly.display.Vector2D;
	import game.fly.manage.MediaSource;
	import game.fly.manage.MunitionFactory;
	import game.fly.manage.MunitionProxy;
	
	/**
	 * D2型敌机。
	 * 
	 */	
	public class EnemyD2 extends Vehicle
	{
		public function EnemyD2()
		{
			super(null, new Vector2D(-3, 0), null);
			maxSpeed = 3;
			maxPalstance = 10;
			edgeBehavior = REMOVE;
			maxLife = 2;
			reward = 3;
			gun = MunitionProxy.launcher(MunitionFactory.SIMPLE_2_GUN);
			gun.vehicle = this;
		}
		
		override protected function draw():void
		{
			drawDo(MediaSource.enemyD2);
		}
		
		override public function firePoint(offset:Vector2D = null):Vector2D
		{
			return super.firePoint(new Vector2D(width, height >> 1));
		}
	}
}