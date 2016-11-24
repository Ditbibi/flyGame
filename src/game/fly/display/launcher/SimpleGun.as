package game.fly.display.launcher
{
	import flash.display.DisplayObjectContainer;
	
	import game.fly.config.Runtime;
	import game.fly.display.Mobile;
	import game.fly.display.Vector2D;
	import game.fly.display.bullet.Bullet;
	import game.fly.display.vehicle.Vehicle;
	import game.fly.manage.MediaSource;
	import game.fly.manage.MunitionFactory;
	import game.fly.manage.MunitionProxy;
	import game.fly.model.SelfTmpl;
	
	/**
	 * 最低级的枪。(葫芦娃装载的枪，不允许敌人使用)
	 * <li>射速：120毫秒/次</li>
	 * 
	 */	
	public class SimpleGun extends Launcher
	{
		public function SimpleGun()
		{
			super(MunitionFactory.MINI, MediaSource.shot);
			f = Runtime.getInstance().p1tmpl.m_nwSendTime;
			maxStrength = 6;
		}
		/**
		 * @private
		 */
		override public function set group(value:String):void
		{
			_group = value;
		}
		
		/**
		 * 一次发射一个字弹。
		 * <li>数量：1</li>
		 * 
		 */		
		override protected function fireDo():void
		{
			var selfTmpl:SelfTmpl;
			if(group == MunitionProxy.G_P1){//p1子弹
				selfTmpl = Runtime.getInstance().p1tmpl;
			}
			if(group == MunitionProxy.G_P2){//p2子弹
				selfTmpl = Runtime.getInstance().p2tmpl;
			}
			if(selfTmpl == null)return;
			
			var count:int = strength < maxStrength ? strength : maxStrength;
			for(var i:int = 1; i <= count; i++)
			{
				var offset:Number = (i >> 1) * 0.1;
				var head:int = i % 2 == 0 ? 1 : -1;
				
				//初始化2枚子弹
				var b1:Bullet = MunitionProxy.bullet(selfTmpl.m_sName, vehicle.group);
				//调整位置
				b1.position = new Vector2D(vehicle.x, vehicle.y);
				//调整方向
				b1.direction.angle = vehicle.direction.angle + offset * head;
				//调整速度方向
				b1.velocity.angle = b1.direction.angle;
				//加入发射队列
				pushQueue(b1);
			}
			super.fireDo();
		}
	}
}