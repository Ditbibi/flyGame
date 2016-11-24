package game.fly.display.box
{
	import flash.display.DisplayObject;
	
	import game.fly.config.Config;
	import game.fly.config.Runtime;
	import game.fly.display.vehicle.Self;
	import game.fly.manage.MediaSource;
	import game.fly.manage.MunitionProxy;
	
	/**
	 * 雷箱，增加玩家雷数量。
	 * 
	 */	
	public class LeiBox extends Box
	{
		/**
		 * 碰撞后玩家雷数量加1，并将自己从舞台上移除。
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
					Runtime.getInstance().p1.cannon.capacity++; break;
				case MunitionProxy.G_P2:
					Runtime.getInstance().p2.cannon.capacity++; break;
			}
			if(Runtime.getInstance().p1)
				Runtime.getInstance().p1.cannon.capacity = 
					Runtime.getInstance().p1.cannon.capacity < Config.getInstance().maxLei?
					Runtime.getInstance().p1.cannon.capacity:Config.getInstance().maxLei;
			if(Runtime.getInstance().p2)
				Runtime.getInstance().p2.cannon.capacity = 
					Runtime.getInstance().p2.cannon.capacity < Config.getInstance().maxLei?
					Runtime.getInstance().p2.cannon.capacity:Config.getInstance().maxLei;
		}
		
		override protected function draw():void
		{
			drawDo(MediaSource.lei);
		}
	}
}