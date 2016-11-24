package game.fly.manage
{
	import flash.events.Event;
	
	import game.fly.config.Runtime;
	import game.fly.display.GameObject;
	import game.fly.display.box.Box;
	import game.fly.display.bullet.Bullet;
	import game.fly.display.bullet.MiniBullet;
	import game.fly.display.launcher.Launcher;
	import game.fly.display.vehicle.Self;
	import game.fly.display.vehicle.Vehicle;
	import game.fly.model.EnemyTmpl;
	
	/**
	 * 军火代理商。
	 * 
	 */	
	public class MunitionProxy
	{
		private static var runtime:Runtime = Runtime.getInstance();	//运行时
		
		/**
		 * 玩家1。
		 */		
		public static const G_P1:String = "p1";
		/**
		 * 玩家2。
		 */		
		public static const G_P2:String = "p2";
		/**
		 * 敌军飞机。
		 */		
		public static const G_ENEMY:String = "enemy";
		
		/**
		 * 获取战车。
		 * @param type 战车类型
		 * @param group 对象分组
		 * @return Vehicle对象
		 * 
		 */		
		public static function vehicle(type:Object, group:String = G_ENEMY):Vehicle
		{
			var v:Vehicle;
			if(group == G_ENEMY){//请求敌军战车
				v = MunitionFactory.vehicle((type as EnemyTmpl).m_sName,type as EnemyTmpl);
			}else{//请求自己战车
				v = MunitionFactory.vehicle(type as String);
			}
			if(v.gun)v.gun.startTimer();
			v.group = group;
			v.addEventListener(Event.ADDED_TO_STAGE, register);
			return v;
		}
		
		/**
		 * 获取弹药。
		 * @param type 弹药类型
		 * @param group 对象分组
		 * @return Bullet对象
		 * 
		 */		
		public static function bullet(type:String, group:String):Bullet
		{
			var b:Bullet = MunitionFactory.bullet(type);
			b.group = group;
			b.addEventListener(Event.ADDED_TO_STAGE, register);
			return b;
		}
		
		/**
		 * 获取资源箱。
		 * @param type 资源箱类型
		 * @param group 对象分组
		 * @return Box对象
		 * 
		 */		
		public static function box(type:String, group:String = null):Box
		{
			var b:Box = MunitionFactory.box(type);
			b.group = group;
			b.addEventListener(Event.ADDED_TO_STAGE, register);
			return b;
		}
		
		/**
		 * 获取发射器。
		 * @param type 发射器类型
		 * @param group 对象分组
		 * @return Launcher对象
		 * 
		 */		
		public static function launcher(type:String, group:String = null):Launcher
		{
			var l:Launcher = MunitionFactory.launcher(type);
			l.group = group;
			return l;
		}
		
		/**
		 * 登记到运行时。
		 * @param e
		 * 
		 */		
		private static function register(e:Event):void
		{
			var o:GameObject = e.target as GameObject;
			if(o is Bullet)
			{
				switch(o.group)
				{
					case G_ENEMY:
						runtime.enemyBullets.add(o); break;
					case G_P1:
						runtime.p1Bullets.add(o); break;
					case G_P2:
						runtime.p2Bullets.add(o); break;
				}	
			}
			else if(o is Vehicle)
			{
				switch(o.group)
				{
					case G_ENEMY:
						runtime.enemyVehicles.add(o); break;
					case G_P1:
						runtime.p1 = o as Self; break;
					case G_P2:
						runtime.p2 = o as Self; break;
				}
			}
			else if(o is Box)
			{
				runtime.boxs.add(o);
			}
			o.removeEventListener(Event.ADDED_TO_STAGE, register);
			o.addEventListener(Event.REMOVED_FROM_STAGE, unRegister, false, 11);
		}
		
		/**
		 * 取消登记。
		 * @param e
		 * 
		 */		
		private static function unRegister(e:Event):void
		{
			var o:GameObject = e.target as GameObject;
			if(o is Bullet)
			{
				switch(o.group)
				{
					case G_ENEMY:
						runtime.enemyBullets.remove(o); break;
					case G_P1:
						runtime.p1Bullets.remove(o); break;
					case G_P2:
						runtime.p2Bullets.remove(o); break;
				}	
			}
			else if(o is Vehicle)
			{
				switch(o.group)
				{
					case G_ENEMY:
						runtime.enemyVehicles.remove(o); break;
					case G_P1:
						runtime.p1 = null; break;
					case G_P2:
						runtime.p2 = null; break;
				}
			}
			else if(o is Box)
			{
				runtime.boxs.remove(o);
			}
			o.removeEventListener(Event.REMOVED_FROM_STAGE, register);
		}
	}
}