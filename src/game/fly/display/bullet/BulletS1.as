package game.fly.display.bullet
{
	import game.fly.display.Vector2D;
	import game.fly.manage.MediaSource;
	
	/**
	 * S2型导弹。
	 * <li>伤害：3</li>
	 * <li>速度：变速</li>
	 * <li>方向：直线</li>
	 * 
	 */	
	public class BulletS1 extends Bullet
	{
		public function BulletS1()
		{
			super(null, new Vector2D(2, 0));
			power = 3;
			mass = 2;
			maxForce = 4;
			force = new Vector2D(1, 0);
			maxSpeed = 20;
		}
		
		override protected function draw():void
		{
			drawDo(MediaSource.b3);
		}
		
		override protected function removeFromStage():void
		{
			velocity = new Vector2D(2, 0);
		}
		
		/**
		 * 设置方向，同时更改速度和受力方向。
		 * @param value 朝向。
		 * 
		 */		
		override public function set direction(value:Vector2D):void
		{
			if(value.isZero())
				value.x = 1;
			_direction = value;
			//更新角度
			rotation = _direction.angle2;
			//更新速度和受力方向
			var ang:Number = _direction.angle;
			_velocity.angle = ang;
			force.angle = ang;
		}
	}
}