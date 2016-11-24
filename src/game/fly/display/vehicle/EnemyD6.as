package game.fly.display.vehicle
{
	import game.fly.display.Vector2D;
	import game.fly.manage.MediaSource;
	import game.fly.manage.MunitionFactory;
	import game.fly.manage.MunitionProxy;
	
	import flash.display.Graphics;
	
	/**
	 * D6型敌机。
	 * 
	 */	
	public class EnemyD6 extends Vehicle
	{
		public function EnemyD6(position:Vector2D=null, velocity:Vector2D=null, g:Graphics=null)
		{
			super(null, new Vector2D(-0.5, 0), null);
			maxSpeed = 1;
			maxPalstance = 1;
			edgeBehavior = REMOVE;
			maxLife = 200;
			reward = 220;
			gun = MunitionProxy.launcher(MunitionFactory.SIMPLE_PRO_2_GUN);
			gun.vehicle = this;
		}
		
		override protected function draw():void
		{
			drawDo(MediaSource.enemyD6);
		}
		
		/**
		 * 以监视的方式移动。
		 * 
		 */		
		override public function move():void
		{
			oversee();
			super.move();
		}
	}
}