package game.fly.manage
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.utils.ByteArray;

	/**
	 * 位图、声音等媒体文件管理器。
	 * 
	 */	
	public class MediaSource
	{
		//=============================配置文件=================================//
		[Embed(source="img/flyConfig.xml", mimeType="application/octet-stream")]
		private static var FlyConfig:Class;
		
		/**
		 * 配置文件的数据
		 */	
		public static function get flyXml():ByteArray
		{
			return new FlyConfig();
		}
		
		//===============================飞机===================================//
		[Embed(source="img/selfM1.png")]
		private static var SelfM1:Class;
		[Embed(source="img/selfM2.png")]
		private static var SelfM2:Class;
		[Embed(source="img/selfM3.png")]
		private static var SelfM3:Class;
		
		[Embed(source="img/enemyD1.png")]
		private static var EnemyD1:Class;
		[Embed(source="img/enemyD2.png")]
		private static var EnemyD2:Class;
		[Embed(source="img/enemyD3.png")]
		private static var EnemyD3:Class;
		[Embed(source="img/enemyD4.png")]
		private static var EnemyD4:Class;
		[Embed(source="img/enemyD5.png")]
		private static var EnemyD5:Class;
		[Embed(source="img/enemyD6.png")]
		private static var EnemyD6:Class;
		[Embed(source="img/enemyD7.png")]
		private static var EnemyD7:Class;
		
		/**
		 * 大娃
		 */	
		public static function get selfM1():Bitmap
		{
			return new SelfM1();
		}
		/**
		 * 二娃
		 */	
		public static function get selfM2():Bitmap
		{
			return new SelfM2();
		}
		/**
		 * 三娃
		 */	
		public static function get selfM3():Bitmap
		{
			return new SelfM3();
		}
		/**
		 * d1敌机。
		 */		
		public static function get enemyD1():Bitmap
		{
			return new EnemyD1();
		}
		/**
		 * d2敌机。
		 */		
		public static function get enemyD2():Bitmap
		{
			return new EnemyD2();
		}
		/**
		 * d3敌机。
		 */		
		public static function get enemyD3():Bitmap
		{
			return new EnemyD3();
		}
		/**
		 * d4敌机。
		 */		
		public static function get enemyD4():Bitmap
		{
			return new EnemyD4();
		}
		/**
		 * d5敌机。
		 */		
		public static function get enemyD5():Bitmap
		{
			return new EnemyD5();
		}
		/**
		 * d6敌机。
		 */		
		public static function get enemyD6():Bitmap
		{
			return new EnemyD6();
		}
		/**
		 * d7敌机。
		 */		
		public static function get enemyD7():Bitmap
		{
			return new EnemyD7();
		}
		
		//==============================资源箱===================================//
		[Embed(source="img/lifeBox.png")]
		private static var LifeBox:Class;
		
		[Embed(source="img/lei.png")]
		private static var Lei:Class;
		
		[Embed(source="img/a.png")]
		private static var A:Class;
		
		[Embed(source="img/b.png")]
		private static var B:Class;
		
		[Embed(source="img/c.png")]
		private static var C:Class;
		
		[Embed(source="img/d.png")]
		private static var D:Class;
		
		[Embed(source="img/e.png")]
		private static var E:Class;
		
		/**
		 * 生命箱。
		 */		
		public static function get lifeBox():Bitmap
		{
			return new LifeBox();
		}
		/**
		 * 雷。
		 */		
		public static function get lei():Bitmap
		{
			return new Lei();
		}
		/**
		 * A箱。
		 */		
		public static function get a():Bitmap
		{
			return new A();
		}
		/**
		 * B箱。
		 */		
		public static function get b():Bitmap
		{
			return new B();
		}
		/**
		 * C箱。
		 */		
		public static function get c():Bitmap
		{
			return new C();
		}
		/**
		 * D箱。
		 */		
		public static function get d():Bitmap
		{
			return new D();
		}
		/**
		 * E箱。
		 */		
		public static function get e():Bitmap
		{
			return new E();
		}
		
		//===============================子弹===================================//
		[Embed(source="img/l.png")]
		private static var L:Class;
		[Embed(source="img/b1.png")]
		private static var B1:Class;
		[Embed(source="img/b3.png")]
		private static var B3:Class;
		[Embed(source="img/s2.png")]
		private static var S2:Class;
		
		//葫芦娃的独有子弹
		[Embed(source="img/selfM1_b.png")]
		private static var SelfM1_b:Class;
		[Embed(source="img/selfM2_b.png")]
		private static var SelfM2_b:Class;
		[Embed(source="img/selfM3_b.png")]
		private static var SelfM3_b:Class;
		
		/**
		 * 雷。
		 */		
		public static function get l():Bitmap
		{
			return new L();
		}
		/**
		 * b1子弹。
		 */		
		public static function get b1():Bitmap
		{
			return new B1();
		}
		/**
		 * b3子弹。
		 */		
		public static function get b3():Bitmap
		{
			return new B3();
		}
		/**
		 * s2导弹。
		 */		
		public static function get s2():Bitmap
		{
			return new S2();
		}
		/**
		 * 大娃子弹
		 */
		public static function get selfM1_b():Bitmap
		{
			return new SelfM1_b();
		}
		/**
		 * 二娃子弹
		 */
		public static function get selfM2_b():Bitmap
		{
			return new SelfM2_b();
		}
		/**
		 * 三娃子弹
		 */
		public static function get selfM3_b():Bitmap
		{
			return new SelfM3_b();
		}
		//===============================声音===================================//	
//		[Embed(source="sound/music.mp3")]
//		private static var Music:Class;
		
		[Embed(source="sound/le.mp3")]
		private static var Le:Class;
		
		[Embed(source="sound/shot.mp3")]
		private static var Shot:Class;
		
		[Embed(source="sound/dead.mp3")]
		private static var Dead:Class;
		
		[Embed(source="sound/eatBox.mp3")]
		private static var EatBox:Class;
		
		/**
		 * 放背景音乐。
		 */	
//		public static function get music():Sound
//		{
//			return new Music();
//		}
		
		/**
		 * 放雷的声音。
		 */	
		public static function get le():Sound
		{
			return new Le();
		}
		/**
		 * 普通子弹发射声音。
		 */	
		public static function get shot():Sound
		{
			return new Shot();
		}
		/**
		 * 飞机被击毁的声音。
		 */	
		public static function get dead():Sound
		{
			return new Dead();
		}
		/**
		 * 吃到资源箱时的声音。
		 */	
		public static function get eatBox():Sound
		{
			return new EatBox();
		}
		
		//===============================元素===================================//
		[Embed(source="img/main.jpg")]
		private static var Main:Class;
		
		[Embed(source="img/onlyButton1.png")]
		private static var OnlyButton1:Class;
		
		[Embed(source="img/onlyButton2.png")]
		private static var OnlyButton2:Class;
		
		[Embed(source="img/doubleButton1.png")]
		private static var DoubleButton1:Class;
		
		[Embed(source="img/doubleButton2.png")]
		private static var DoubleButton2:Class;
		
		[Embed(source="img/configButton1.png")]
		private static var ConfigButton1:Class;
		
		[Embed(source="img/configButton2.png")]
		private static var ConfigButton2:Class;
		
		[Embed(source="img/helpButton1.png")]
		private static var HelpButton1:Class;
		
		[Embed(source="img/helpButton2.png")]
		private static var HelpButton2:Class;
		
		[Embed(source="img/back1_1.jpg")]
		private static var Back11:Class;
		
		[Embed(source="img/back1_2.jpg")]
		private static var Back12:Class;
		
//		[Embed(source="img/back2_1.jpg")]
//		private static var Back21:Class;
//		
//		[Embed(source="img/back2_2.jpg")]
//		private static var Back22:Class;
		
		[Embed(source="img/life.png")]
		private static var Life:Class;
		
		[Embed(source="img/unlimite.png")]
		private static var Unlimite:Class;
		
		[Embed(source="img/p1Name.png")]
		private static var P1Name:Class;
		
		[Embed(source="img/p2Name.png")]
		private static var P2Name:Class;
		
		[Embed(source="img/returnOutButton.png")]
		private static var ReturnOutButton:Class;
		
		[Embed(source="img/returnInButton.png")]
		private static var ReturnInButton:Class;
		
		[Embed(source="img/returnGameOutButton.png")]
		private static var ReturnGameOutButton:Class;
		
		[Embed(source="img/returnGameInButton.png")]
		private static var ReturnGameInButton:Class;
		
		[Embed(source="img/returnMainOutButton.png")]
		private static var ReturnMainOutButton:Class;
		
		[Embed(source="img/returnMainInButton.png")]
		private static var ReturnMainInButton:Class;
		
		[Embed(source="img/lookHelpOutButton.png")]
		private static var LookHelpOutButton:Class;
		
		[Embed(source="img/lookHelpInButton.png")]
		private static var LookHelpInButton:Class;
		
		[Embed(source="img/configOutButton.png")]
		private static var ConfigOutButton:Class;
		
		[Embed(source="img/configInButton.png")]
		private static var ConfigInButton:Class;
		
		[Embed(source="img/gameOver.png")]
		private static var GameOver:Class;
		
//		[Embed(source="img/shield.swf")]
//		private static var Shield:Class;
		
		/**
		 * 欢迎界面。
		 */	
		public static function get main():Bitmap
		{
			return new Main();
		}
		/**
		 * 单人模式按钮1。
		 */	
		public static function get onlyButton1():Bitmap
		{
			return new OnlyButton1();
		}
		/**
		 * 单人模式按钮1。
		 */	
		public static function get onlyButton2():Bitmap
		{
			return new OnlyButton2();
		}
		/**
		 * 双人模式按钮1。
		 */	
		public static function get doubleButton1():Bitmap
		{
			return new DoubleButton1();
		}
		/**
		 * 双人模式按钮1。
		 */	
		public static function get doubleButton2():Bitmap
		{
			return new DoubleButton2();
		}
		/**
		 * 设置按钮1。
		 */	
		public static function get configButton1():Bitmap
		{
			return new ConfigButton1();
		}
		/**
		 * 设置按钮2。
		 */	
		public static function get configButton2():Bitmap
		{
			return new ConfigButton2();
		}
		/**
		 * 帮助按钮1。
		 */	
		public static function get helpButton1():Bitmap
		{
			return new HelpButton1();
		}
		/**
		 * 帮助按钮2。
		 */	
		public static function get helpButton2():Bitmap
		{
			return new HelpButton2();
		}
		/**
		 * 背景近景1。
		 */	
		public static function get back11():Bitmap
		{
			return new Back11();
		}
		/**
		 * 背景近景2。
		 */	
		public static function get back12():Bitmap
		{
			return new Back12();
		}
//		/**
//		 * 背景远景1。
//		 */	
//		public static function get back21():Bitmap
//		{
//			return new Back21();
//		}
//		/**
//		 * 背景远景2。
//		 */	
//		public static function get back22():Bitmap
//		{
//			return new Back22();
//		}
		/**
		 * 玩家生命图标。
		 */	
		public static function get life():Bitmap
		{
			return new Life();
		}
		/**
		 * 无限生命图标。
		 */	
		public static function get unlimite():Bitmap
		{
			return new Unlimite();
		}
		/**
		 * 玩家1显示名。
		 */	
		public static function get p1Name():Bitmap
		{
			return new P1Name();
		}
		/**
		 * 玩家2显示名。
		 */	
		public static function get p2Name():Bitmap
		{
			return new P2Name();
		}
		/**
		 * 返回按钮未按下。
		 */	
		public static function get returnOutButton():Bitmap
		{
			return new ReturnOutButton();
		}
		/**
		 * 返回按钮按下。
		 */	
		public static function get returnInButton():Bitmap
		{
			return new ReturnInButton();
		}
		/**
		 * 继续游戏按钮未按下。
		 */	
		public static function get returnGameOutButton():Bitmap
		{
			return new ReturnGameOutButton();
		}
		/**
		 * 继续游戏按钮按下。
		 */	
		public static function get returnGameInButton():Bitmap
		{
			return new ReturnGameInButton();
		}
		/**
		 * 返回菜单按钮未按下。
		 */	
		public static function get returnMainOutButton():Bitmap
		{
			return new ReturnMainOutButton();
		}
		/**
		 * 返回菜单按钮按下。
		 */	
		public static function get returnMainInButton():Bitmap
		{
			return new ReturnMainInButton();
		}
		/**
		 * 查看帮助按钮未按下。
		 */	
		public static function get lookHelpOutButton():Bitmap
		{
			return new LookHelpOutButton();
		}
		/**
		 * 查看帮助按钮按下。
		 */	
		public static function get lookHelpInButton():Bitmap
		{
			return new LookHelpInButton();
		}
		/**
		 * 游戏设置按钮未按下。
		 */	
		public static function get configOutButton():Bitmap
		{
			return new ConfigOutButton();
		}
		/**
		 * 游戏设置按钮按下。
		 */	
		public static function get configInButton():Bitmap
		{
			return new ConfigInButton();
		}
		/**
		 * Game Over。
		 */	
		public static function get gameOver():Bitmap
		{
			return new GameOver();
		}
//		/**
//		 * 玩家的保护盾
//		 */	
//		public static function get shield():MovieClip
//		{
//			return new Shield();
//		}
		
	}
}