package game.fly.display.box
{
	import flash.display.DisplayObject;
	
	import game.fly.config.Config;
	import game.fly.config.Runtime;
	import game.fly.display.launcher.Launcher;
	import game.fly.display.launcher.SimpleGun;
	import game.fly.display.vehicle.Self;
	import game.fly.manage.MediaSource;
	import game.fly.manage.MunitionFactory;
	import game.fly.manage.MunitionProxy;
	
	/**
	 * 基本子弹资源箱。
	 * 
	 */	
	public class SimpleBox extends Box
	{
		/**
		 * 将碰撞目标gun换为SimpleGun，并根据当前开火状态确定是否开火。
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
			
			var oldGun:Launcher = o.gun;
			if(oldGun is SimpleGun)
				oldGun.strength++;
			else
			{
				var newGun:Launcher = MunitionProxy.launcher(MunitionFactory.SEEK_S2_CANNON);
				newGun.vehicle = o;
				o.gun = newGun;
				if(oldGun)
				{
					if(oldGun.status == Launcher.START)
						newGun.fire();
					oldGun.unload();
				}
			}
		}
		
		override protected function draw():void
		{
			drawDo(MediaSource.a);
		}
	}
}