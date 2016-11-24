package game.fly.display.bullet
{
	import game.fly.display.GameObject;
	import game.fly.display.Mobile;
	import game.fly.display.Vector2D;
	import game.fly.manage.MediaSource;
	import game.utils.Util;
	
	/**
	 * S2型导弹。
	 * <li>伤害：3</li>
	 * <li>速度：5</li>
	 * <li>方向：跟踪</li>
	 * 
	 */	
	public class BulletS2 extends Bullet
	{
		public function BulletS2()
		{
			super(null, new Vector2D(10, 0));
			power = 3;
			maxSpeed = 10;
			maxPalstance = 5;
		}
		
		override protected function draw():void
		{
			drawDo(MediaSource.s2);
		}
		
		override public function move():void
		{
			if((targetObj == null || targetObj.stage == null) && targets)
			{
				targetObj = null;
				var num:int = Util.random(0, targets.length);
				for each(var o:GameObject in targets)
				{
					if(num == 0)
					{
						targetObj = o;
						break;
					}
					num--;
				}
			}
			seek();
			//pursue();
			if(!force.isZero())
				force.angle = velocity.angle;
			super.move();
		}
	}
}