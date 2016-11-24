package game.fly.display.box
{
	import flash.display.DisplayObject;
	
	import game.fly.config.Config;
	import game.fly.config.Runtime;
	import game.fly.display.vehicle.Self;
	import game.fly.manage.MediaSource;
	import game.fly.manage.MunitionProxy;
	
	/**
	 * 生命箱，获得后可增加一条生命值。
	 */	
	public class LifeBox extends Box
	{
		/**
		 * 碰撞后根据碰撞对象标识给对应玩家生命加1，并将自己从舞台上移除。
		 * @param a 碰撞对象
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
			
			switch(o.group)
			{
				case MunitionProxy.G_P1:
					Runtime.getInstance().p1Life+= Config.getInstance().addLife; break;
				case MunitionProxy.G_P2:
					Runtime.getInstance().p2Life+= Config.getInstance().addLife; break;
			}
		}
		
		override protected function draw():void
		{
			drawDo(MediaSource.lifeBox);
		}
	}
}