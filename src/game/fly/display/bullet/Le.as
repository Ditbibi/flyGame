package game.fly.display.bullet
{
	import game.fly.display.Vector2D;
	import game.fly.manage.MediaSource;
	
	/**
	 * 雷，具有相当强大的能量。
	 * <li>伤害：10</li>
	 * <li>速度：10</li>
	 * <li>方向：从左到右</li>
	 * 
	 */	
	public class Le extends Bullet
	{
		public function Le()
		{
			super(new Vector2D(0, 0), new Vector2D(10, 0));
			maxSpeed = 10;
			power = 1000;
			penetrate = true;
		}
		
		override protected function draw():void
		{
			drawDo(MediaSource.l);
		}
		
		override protected function removeFromStage():void
		{
			position = new Vector2D(0, 0);
		}
	}
}