package game.fly.display.launcher
{
	import flash.media.Sound;
	
	import game.fly.config.Config;
	import game.fly.config.Runtime;
	import game.fly.display.Vector2D;
	import game.fly.display.bullet.Bullet;
	import game.fly.events.ActionEvent;
	import game.fly.manage.MediaSource;
	import game.fly.manage.MunitionFactory;
	import game.fly.manage.MunitionProxy;
	
	/**
	 * 雷发射器。
	 * 
	 */	
	public class LeLauncher extends Launcher
	{
		public function LeLauncher()
		{
			super(MunitionFactory.LE, MediaSource.le, true);
			_capacity = Config.getInstance().maxLei;
		}
		
		override public function init():void
		{
			_capacity = Config.getInstance().maxLei;
		}
		
		override public function fire():void
		{
			if(container == null)
				container = vehicle.parent;
			if(container)
			{
				var b:Bullet = MunitionProxy.bullet(bullet, vehicle.group);
				b.position = new Vector2D(0, Runtime.getInstance().stage.stageHeight >> 1);
				pushQueue(b);
				fireDo();
			}
		}
		
		override public function unload():void
		{
			vehicle = null;
			container = null;
			//发送卸载事件
			dispatchEvent(new ActionEvent(ActionEvent.LAUNCHER_UNLOAD));
		}
	}
}