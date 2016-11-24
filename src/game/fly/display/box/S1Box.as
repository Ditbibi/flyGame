package game.fly.display.box
{
	import flash.display.DisplayObject;
	
	import game.fly.config.Config;
	import game.fly.config.Runtime;
	import game.fly.display.launcher.Launcher;
	import game.fly.display.launcher.S1Cannon;
	import game.fly.display.vehicle.Self;
	import game.fly.manage.MediaSource;
	import game.fly.manage.MunitionFactory;
	import game.fly.manage.MunitionProxy;
	
	/**
	 * S1Cannon发射器资源箱。
	 * 
	 */	
	public class S1Box extends Box
	{
		/**
		 * 将碰撞目标gunPro换为S1Cannon，并根据当前开火状态确定是否开火。
		 * @param a
		 * 
		 */		
		override protected function collisionDo(a:DisplayObject):void
		{
			var o:Self = a as Self;
			if(o.group == MunitionProxy.G_P1){
				if(Runtime.getInstance().p1tmpl.m_sName != Config.getInstance().eatBoxName)
					return;
			}else if(o.group == MunitionProxy.G_P2){
				if(Runtime.getInstance().p2tmpl.m_sName != Config.getInstance().eatBoxName)
					return;
			}
			
			super.collisionDo(a);
			
			var oldGunPro:Launcher = o.gunPro;
			if(oldGunPro is S1Cannon)
				oldGunPro.strength++;
			else
			{
				var oldGun:Launcher = o.gun;
				var newGun:Launcher = MunitionProxy.launcher(MunitionFactory.S1_CANNON);
				newGun.vehicle = o;
				newGun.startTimer();
				o.gunPro = newGun;
				if(oldGun)
				{
					if(oldGun.status == Launcher.START)
						newGun.fire();
					oldGunPro.unload();
				}
			}
		}
		
		override protected function draw():void
		{
			drawDo(MediaSource.c);
		}
	}
}