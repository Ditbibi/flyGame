package game.fly.display.bullet
{
	import game.fly.display.Vector2D;
	import game.fly.manage.MediaSource;
	
	/**
	 * B1型子弹。
	 * <li>伤害：1</li>
	 * <li>速度：4</li>
	 * <li>方向：直线</li>
	 * 
	 */	
	public class BulletB1 extends Bullet
	{
		public function BulletB1()
		{
			super(null, new Vector2D(4, 0), null);
			power = 1;
			maxSpeed = 4;
		}
		
		override protected function draw():void
		{
			drawDo(MediaSource.b1);
		}
	}
}