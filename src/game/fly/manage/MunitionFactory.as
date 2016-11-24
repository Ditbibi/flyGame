package game.fly.manage
{
	import flash.events.Event;
	
	import game.fly.config.Runtime;
	import game.fly.display.box.Box;
	import game.fly.display.box.LeiBox;
	import game.fly.display.box.LifeBox;
	import game.fly.display.box.S1Box;
	import game.fly.display.box.S2Box;
	import game.fly.display.box.SimpleBox;
	import game.fly.display.bullet.Bullet;
	import game.fly.display.bullet.BulletB1;
	import game.fly.display.bullet.BulletS1;
	import game.fly.display.bullet.BulletS2;
	import game.fly.display.bullet.Le;
	import game.fly.display.bullet.MiniBullet;
	import game.fly.display.launcher.Launcher;
	import game.fly.display.launcher.LeLauncher;
	import game.fly.display.launcher.S1Cannon;
	import game.fly.display.launcher.SeekS2Cannon;
	import game.fly.display.launcher.Simple2Gun;
	import game.fly.display.launcher.SimpleGun;
	import game.fly.display.launcher.SimplePro2Gun;
	import game.fly.display.vehicle.Enemy;
	import game.fly.display.vehicle.EnemyD2;
	import game.fly.display.vehicle.EnemyD3;
	import game.fly.display.vehicle.EnemyD4;
	import game.fly.display.vehicle.EnemyD6;
	import game.fly.display.vehicle.Self;
	import game.fly.display.vehicle.Vehicle;
	import game.fly.events.ActionEvent;
	import game.fly.model.EnemyTmpl;

	/**
	 * 兵工厂，提供所有的飞机、发射器、子弹等军用物资。同时也负责军火的回收和存储（cache）。
	 * 
	 */	
	public class MunitionFactory
	{
		private static var runtime:Runtime = Runtime.getInstance();	//运行时
		
		private static var vehicleStores:Object = {};		//机械仓库 群
		private static var launcherStores:Object = {};		//枪、炮仓库群
		private static var bulletStores:Object = {};		//子弹仓库群
		private static var boxStores:Object = {};			//资源箱仓库群
		
		//==================================飞机型号===============================//
		/**
		 * 友军飞机 - Self。
		 */		
		public static const SELF:String = "self";
		
		//================================发射器型号===============================//
		/**
		 * 雷发射器 - leLauncher。
		 */		
		public static const LEI_LAUNCHER:String = "leiLauncher";
		/**
		 * 最低级的枪 - simpleGun。
		 */		
		public static const SIMPLE_GUN:String = "simpleGun";
		/**
		 * 敌用最低级的枪 - simple2Gun。
		 */		
		public static const SIMPLE_2_GUN:String = "simple2Gun";
		/**
		 * 二连发跟踪弹发射器 - SeekS2Cannon。
		 */		
		public static const SEEK_S2_CANNON:String = "seekS2Cannon";
		/**
		 * 五连发加速弹发射器 - S1Cannon。
		 */		
		public static const S1_CANNON:String = "s1Cannon";
		/**
		 * 十连散弹发射器 - SimplePro2Gun。
		 */		
		public static const SIMPLE_PRO_2_GUN:String = "simplePro2Gun";
		
		//==================================弹药型号===============================//
		/**
		 * 雷，恐怖的武器，闻者伤心见者掉泪  - Le。
		 */		
		public static const LE:String = "le";
		/**
		 * 迷你弹，一种低级的子弹 - MiniBullet。
		 */		
		public static const MINI:String = "mini";
		/**
		 * B1弹，敌用低级的子弹 - BulletB1。
		 */		
		public static const B1:String = "bulletB1";
		/**
		 * S2跟踪弹 - BulletS2。
		 */		
		public static const S2:String = "bulletS2";
		/**
		 * S1加速弹 - BulletS1。
		 */		
		public static const S1:String = "bulletS1";
		
		//================================资源箱型号===============================//
		/**
		 * 生命箱 - LifeBox。
		 */		
		public static const LIFE_BOX:String = "lifeBox";
		/**
		 * 雷箱 - LeiBox。
		 */		
		public static const LEI_BOX:String = "leiBox";
		/**
		 * 普通子弹箱 - SImpleBox。
		 */		
		public static const SIMPLE_BOX:String = "simpleBox";
		/**
		 * S2箱 - S2Box。
		 */		
		public static const S2_BOX:String = "s2Box";
		/**
		 * S1箱 - S1Box。
		 */		
		public static const S1_BOX:String = "s1Box";
		
		public function MunitionFactory(){}
		
		/**
		 * 获取战车。
		 * @param type 战车类型
		 * @return Vehicle对象
		 * 
		 */		
		public static function vehicle(type:String,tmpl:EnemyTmpl = null):Vehicle
		{
			var store:Store = vehicleStores[type];
			if(store == null || store.isEmpty())
			{
				var v:Vehicle = makeVehicle(type,tmpl);
				v.type = type;
				v.addEventListener(Event.REMOVED_FROM_STAGE, recoverVehicle);
				return v;
			}
			else
				return store.get() as Vehicle;
		}
		
		/**
		 * 获取发射器。
		 * @param type 发射器类型
		 * @return Launcher对象
		 * 
		 */		
		public static function launcher(type:String):Launcher
		{
			var store:Store = launcherStores[type];
			if(store == null || store.isEmpty())
			{
				var l:Launcher = makeLauncher(type);
				l.type = type;
				l.addEventListener(ActionEvent.LAUNCHER_UNLOAD, recoverLauncher);
				return l;
			}
			else
				return store.get() as Launcher;
		}
		
		/**
		 * 获取弹药。
		 * @param type 弹药类型
		 * @return Bullet对象
		 * 
		 */		
		public static function bullet(type:String):Bullet
		{
			var store:Store = bulletStores[type];
			if(store == null || store.isEmpty())
			{
				var b:Bullet = makeBullet(type);
				b.type = type;
				b.addEventListener(Event.REMOVED_FROM_STAGE, recoverBullet);
				return b;
			}
			else
				return store.get() as Bullet;
		}
		
		/**
		 * 获取资源箱。
		 * @param type 资源类型
		 * @return Box对象
		 * 
		 */		
		public static function box(type:String):Box
		{
			var store:Store = boxStores[type];
			if(store == null || store.isEmpty())
			{
				var b:Box = makeBox(type);
				b.type = type;
				b.addEventListener(Event.REMOVED_FROM_STAGE, recoverBox);
				return b;
			}
			else
				return store.get() as Box;
		}
		
		/**
		 * 回收机动体。
		 * @param e
		 * 
		 */		
		private static function recoverVehicle(e:Event):void
		{
			var b:Vehicle = e.target as Vehicle;
			var type:String = b.type;
			if(vehicleStores[type] == null)
				vehicleStores[type] = new Store();
			var store:Store = vehicleStores[type];
			store.add(b);
		}
		
		/**
		 * 回收发射器。
		 * @param e
		 * 
		 */		
		private static function recoverLauncher(e:Event):void
		{
			var b:Launcher = e.target as Launcher;
			var type:String = b.type;
			if(launcherStores[type] == null)
				launcherStores[type] = new Store();
			var store:Store = launcherStores[type];
			store.add(b);
		}
		
		/**
		 * 回收子弹。
		 * @param e
		 * 
		 */		
		private static function recoverBullet(e:Event):void
		{
			var b:Bullet = e.target as Bullet;
			var type:String = b.type;
			if(bulletStores[type] == null)
				bulletStores[type] = new Store();
			var store:Store = bulletStores[type];
			store.add(b);
		}
		
		/**
		 * 回收资源箱。
		 * @param e
		 * 
		 */		
		private static function recoverBox(e:Event):void
		{
			var b:Box = e.target as Box;
			var type:String = b.type;
			if(boxStores[type] == null)
				boxStores[type] = new Store();
			var store:Store = boxStores[type];
			store.add(b);
		}
		
		/**
		 * 制造机动体。
		 * @param type 类型
		 * @return Vehicle对象
		 * 
		 */		
		private static function makeVehicle(type:String,tmpl:EnemyTmpl = null):Vehicle
		{
			if(type == SELF){
				return new Self();
			}
			return new Enemy(tmpl);
//			switch(type)
//			{
//				case SELF:
//					return new Self();
//				case D2:
//					return new EnemyD2();
//				case D3:
//					return new EnemyD3();
//				case D4:
//					return new EnemyD4();
//				case D6:
//					return new EnemyD6();
//				default:
//					return null;
//			}
		}
		
		/**
		 * 制造发射器。
		 * @param type 类型
		 * @return Launcher对象
		 * 
		 */		
		private static function makeLauncher(type:String):Launcher
		{
			switch(type)
			{
				case LEI_LAUNCHER:
					return new LeLauncher();
				case SIMPLE_GUN:
					return new SimpleGun();
				case SIMPLE_2_GUN:
					return new Simple2Gun();
				case SEEK_S2_CANNON:
					return new SeekS2Cannon();
				case S1_CANNON:
					return new S1Cannon();
				case SIMPLE_PRO_2_GUN:
					return new SimplePro2Gun();
				default:
					return null;
			}
		}
		
		/**
		 * 制造弹药。
		 * @param type 类型
		 * @return Bullet对象
		 * 
		 */		
		private static function makeBullet(type:String):Bullet
		{
			switch(type)
			{
				case LE:
					return new Le();
//				case MINI:
//					return new MiniBullet();
				case B1:
					return new BulletB1();
				case S2:
					return new BulletS2();
				case S1:
					return new BulletS1();
				default:
					return new MiniBullet(type);
			}
		}
		
		/**
		 * 制造资源箱。
		 * @param type 类型
		 * @return Box对象
		 * 
		 */		
		private static function makeBox(type:String):Box
		{
			switch(type)
			{
				case LIFE_BOX:
					return new LifeBox();
				case LEI_BOX:
					return new LeiBox();
				case SIMPLE_BOX:
					return new SimpleBox();
				case S2_BOX:
					return new S2Box();
				case S1_BOX:
					return new S1Box();
				default:
					return null;
			}
		}
	}
}