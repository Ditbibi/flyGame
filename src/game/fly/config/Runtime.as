package game.fly.config
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import game.fly.display.Vector2D;
	import game.fly.display.bullet.Bullet;
	import game.fly.display.vehicle.Vehicle;
	import game.fly.manage.GameDispatcher;
	import game.fly.manage.Store;
	import game.fly.model.SelfTmpl;

	/**
	 * 运行时对象，falsh运行期数据。
	 * 
	 */	
	public class Runtime
	{
		private static const instance:Runtime = new Runtime();
		
		/**
		 * 舞台对象。
		 */		
		public var stage:Stage;
		/**
		 * 游戏容器。
		 */		
		public var space:Sprite;
		/**
		 * 游戏信息显示面板。
		 */		
		public var infoSpace:Sprite;
		/**
		 * 配置容器。
		 */		
		public var confgSpace:Sprite;
		/**
		 * 统一目标坐标，用于跟踪弹，是x大于舞台宽的一个点。
		 */		
		public var target:Vector2D;
		/**
		 * 运行总时间。
		 */		
		public var totalTime:int = 0;
		/**
		 * 游戏模式。
		 */		
		public var mode:String;
		/**
		 * 表示当前处于第几关卡。
		 */		
		public var step:uint;
		/**
		 * 运行状态。
		 */		
		public var status:String;
		/**
		 * 玩家数。
		 */		
		public var player:uint = 1;
		/**
		 * 玩家1积分。
		 */		
		public var p1Score:uint = 0;
		/**
		 * 玩家2积分。
		 */		
		public var p2Score:uint = 0;
		/**
		 * 玩家1剩余生命。
		 */		
		public var p1Life:int = 0;
		/**
		 * 玩家2剩余生命。
		 */		
		public var p2Life:int = 0;
		/**
		 * 一号友机，1P。
		 */		
		public var p1:Vehicle;
		public var p1tmpl:SelfTmpl;
		/**
		 * 二号友机，2P。
		 */		
		public var p2:Vehicle;
		public var p2tmpl:SelfTmpl;
		/**
		 * P1子弹。
		 */		
		public var p1Bullets:Store = new Store();
		/**
		 * P2子弹。
		 */		
		public var p2Bullets:Store = new Store();
		/**
		 * 敌军子弹。
		 */		
		public var enemyBullets:Store = new Store();
		/**
		 * 敌军飞机。
		 */		
		public var enemyVehicles:Store = new Store();
		/**
		 * 资源箱。
		 */		
		public var boxs:Store = new Store();
		
		
		
		/**
		 * 返回运行时对象。
		 * @return 运行时对象
		 * 
		 */		
		public static function getInstance():Runtime
		{
			return instance;
		}
	}
}