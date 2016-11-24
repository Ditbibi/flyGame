package game.fly.manage
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import game.fly.config.Config;
	import game.fly.config.Runtime;
	import game.fly.display.Mobile;
	import game.fly.display.Vector2D;
	import game.fly.display.vehicle.Self;
	import game.fly.display.vehicle.Vehicle;
	import game.fly.model.SelfTmpl;
	import game.fly.text.PlayerInfoBox;
	import game.utils.DisplayUtil;
	import game.utils.KeyBoardStateMgr;
	
	/**
	 * 游戏调度器，负责调度整个游戏执行流程。
	 * 
	 */	
	public class GameDispatcher extends EventDispatcher
	{
		private static var instance:GameDispatcher = new GameDispatcher();		//调度器实例，全局唯一
		
		// 按钮状态判断管理
		private var m_keyStateMgr:KeyBoardStateMgr = new KeyBoardStateMgr();
		
		private var vd:VehicleDispatcher = VehicleDispatcher.getInstance();		//Vehicle 对象调度器
		private var ct:CollisionTest = CollisionTest.getInstance();				//碰撞检测器
		private var config:Config = Config.getInstance();						//配置对象
		private var runtime:Runtime = Runtime.getInstance();					//运行时对象
		private var bgc:BackGroundControl;										//背景控制器
		
		private var infoUpdateTimer:Timer = new Timer(1);	//积分、时间等运行时信息刷新计时器 
		private var lastTime:int;							//最后一次统计游戏运行的时间
		private var infoBox1:PlayerInfoBox;					//玩家1信息栏
		private var infoBox2:PlayerInfoBox;					//玩家2信息栏
		
		/**
		 * 游戏调度器状态：未启动
		 */		
		public static const NONE:String = "none";
		/**
		 * 游戏调度器状态：开始
		 */		
		public static const START:String = "start";	
		/**
		 * 游戏调度器状态：暂停
		 */		
		public static const STOP:String = "stop";
		
		/**
		 * 获得游戏调度器。如果实例为空则创建，否则构造之。
		 * @param stage 舞台对象，如果为空则不会创建调度器 。
		 * @return 调度器
		 * 
		 */		
		public static function getInstance():GameDispatcher
		{
			return instance;
		}
		
		/**
		 * 复位，游戏初始化。
		 * 
		 */		
		public function init():void
		{
			m_keyStateMgr.Clear();
			//初始化运行时数据
			runtime.totalTime = 0;
			runtime.step = 1;
			runtime.status = NONE;
			runtime.p1Score = 0;
			runtime.p2Score = 0;
			runtime.p1Life = config.life;
			if(runtime.player == 2)
				runtime.p2Life = config.life;
			runtime.target = new Vector2D(runtime.stage.stageWidth + 100, runtime.stage.stageHeight >> 1);
			//清空游戏空间
			DisplayUtil.clearContainer(runtime.space);
			//初始化信息面板
			initInfoBox();
			//初始化背景
			if(bgc == null)
			{
				var backBoard:Sprite = new Sprite();
				runtime.space.parent.addChildAt(backBoard, 0);
				bgc = new BackGroundControl(backBoard);
			}
			m_keyStateMgr.Init(runtime.stage, CheckKeyBoardMove);
			m_keyStateMgr.SetCareKey(config.p1Up);
			m_keyStateMgr.SetCareKey(config.p1Down);
			m_keyStateMgr.SetCareKey(config.p1Left);
			m_keyStateMgr.SetCareKey(config.p1Right);
			m_keyStateMgr.SetCareKey(config.p1A);
			m_keyStateMgr.SetCareKey(config.p1B);
			m_keyStateMgr.SetCareKey(config.p1Henshin1);
			m_keyStateMgr.SetCareKey(config.p1Henshin2);
			m_keyStateMgr.SetCareKey(config.p1Henshin3);
			
			m_keyStateMgr.SetCareKey(config.p2Up);
			m_keyStateMgr.SetCareKey(config.p2Down);
			m_keyStateMgr.SetCareKey(config.p2Left);
			m_keyStateMgr.SetCareKey(config.p2Right);
			m_keyStateMgr.SetCareKey(config.p2A);
			m_keyStateMgr.SetCareKey(config.p2B);
			m_keyStateMgr.SetCareKey(config.p2Henshin1);
			m_keyStateMgr.SetCareKey(config.p2Henshin2);
			m_keyStateMgr.SetCareKey(config.p2Henshin3);
		}
		
		/**
		 * 从头开始游戏，也是调度器入口。
		 * 
		 */		
		public function run():void
		{
			init();
			start();
		}
		
		/**
		 * 若已暂停则从暂停状态开始。
		 * 
		 */		
		public function start():void
		{
			var rs:String = runtime.status;
			if(rs == NONE || rs == STOP)
			{
				//开始监听
				var stage:Stage = runtime.stage;
				stage.addEventListener(Event.ENTER_FRAME, move);
				infoUpdateTimer.addEventListener(TimerEvent.TIMER, updateInfo);
				//开始调度
				infoUpdateTimer.start();
				if(rs == NONE)
				{
					ct.run();
					vd.run();
					bgc.run();
				}
				else if(rs == STOP)
				{
					ct.start();
					vd.start();
					bgc.start();
				}
				
				lastTime = getTimer();
				runtime.status = START;
			}
		}
		
		/**
		 * 暂停游戏。
		 * 
		 */		
		public function stop():void
		{
			//暂停调度
			vd.stop();
			ct.stop();
			bgc.stop();
			infoUpdateTimer.stop();
			//删除事件监听器
			var stage:Stage = runtime.stage;
			stage.removeEventListener(Event.ENTER_FRAME, move);
			infoUpdateTimer.removeEventListener(TimerEvent.TIMER, updateInfo);
			
			runtime.status = STOP;
		}
		
		/**
		 * 初始化显示信息。
		 * 
		 */		
		private function initInfoBox():void
		{
			DisplayUtil.clearContainer(runtime.infoSpace);
			if(runtime.player == 1)
			{
				infoBox1 = new PlayerInfoBox(1, config.life);
				infoBox1.x = 10;
				infoBox1.y = 2;
				runtime.infoSpace.addChild(infoBox1);
			}
			else if(runtime.player == 2)
			{
				infoBox1 = new PlayerInfoBox(1, config.life);
				infoBox2 = new PlayerInfoBox(2, config.life);
				infoBox1.x = 10;
				infoBox1.y = 2;
				infoBox2.x = 400;
				infoBox2.y = 2;
				runtime.infoSpace.addChild(infoBox1);
				runtime.infoSpace.addChild(infoBox2);
			}
		}
		
		/**
		 * 更新显示数据。
		 * @param e
		 * 
		 */		
		private function updateInfo(e:TimerEvent):void
		{
			//更新游戏 运行总时间
			var currentTime:int = getTimer();
			runtime.totalTime += currentTime - lastTime;
			lastTime = currentTime;
			
			//更新显示信息
			if(infoBox1)
			{
				infoBox1.updateLife(runtime.p1Life);
				infoBox1.updateScore(runtime.p1Score);
			}
			if(infoBox2)
			{
				infoBox2.updateLife(runtime.p2Life);
				infoBox2.updateScore(runtime.p2Score);
			}
		}
		
		/**
		 * 移动舞台上的对象。
		 * @param e Event
		 * 
		 */		
		private function move(e:Event):void
		{
			var space:Sprite = runtime.space;
			for(var i:int = space.numChildren - 1; i >= 0; i--)
			{
				var o:DisplayObject = space.getChildAt(i);
				if(o is Mobile)
					(o as Mobile).move();
			}
		}
		/**
		 * 按键
		 */
		private function CheckKeyBoardMove():void{
			// 获得xy坐标的移动方向
			var p1:Self = runtime.p1 as Self;				//玩家1
			var hDelta:int = (m_keyStateMgr.GetKeyState(config.p1Left)?-1:0) + (m_keyStateMgr.GetKeyState(config.p1Right)?1:0);
			var vDelta:int = (m_keyStateMgr.GetKeyState(config.p1Up)?-1:0) + (m_keyStateMgr.GetKeyState(config.p1Down)?1:0);
			if(null != runtime.stage.focus){
				hDelta = 0;
				vDelta = 0;
			}
			var a:Boolean = m_keyStateMgr.GetKeyState(config.p1A);//枪
			var b:Boolean = m_keyStateMgr.GetKeyState(config.p1B);//炮
			if(p1){
				a?p1.fireGun():p1.stopGun();
				b?p1.fireCannon():p1.stopCannon();
				//判断变身
				var selfNameA:String = null;
				selfNameA = m_keyStateMgr.GetKeyState(config.p1Henshin1)?Config.SelfM1:selfNameA;
				selfNameA = m_keyStateMgr.GetKeyState(config.p1Henshin2)?Config.SelfM2:selfNameA;
				selfNameA = m_keyStateMgr.GetKeyState(config.p1Henshin3)?Config.SelfM3:selfNameA;
				if(selfNameA != null && selfNameA != runtime.p1tmpl.m_sName){//确定变身了
					runtime.p1tmpl = config.selfTmplList[selfNameA];
					p1.Henshin(runtime.p1tmpl);
				}
				
				p1.velocity.x = runtime.p1tmpl.m_nSpeed * hDelta;
				p1.velocity.y = runtime.p1tmpl.m_nSpeed * vDelta;
			}
			
			
			
			var p2:Self = runtime.p2 as Self;				//玩家2
			hDelta = (m_keyStateMgr.GetKeyState(config.p2Left)?-1:0) + (m_keyStateMgr.GetKeyState(config.p2Right)?1:0);
			vDelta = (m_keyStateMgr.GetKeyState(config.p2Up)?-1:0) + (m_keyStateMgr.GetKeyState(config.p2Down)?1:0);
			if(null != runtime.stage.focus){
				hDelta = 0;
				vDelta = 0;
			}
			a = m_keyStateMgr.GetKeyState(config.p2A);
			b = m_keyStateMgr.GetKeyState(config.p2B);
			if(p2){

				a?p2.fireGun():p2.stopGun();
				b?p2.fireCannon():p2.stopCannon();
				//判断变身
				var selfNameB:String = null;
				selfNameB = m_keyStateMgr.GetKeyState(config.p2Henshin1)?Config.SelfM1:selfNameB;
				selfNameB = m_keyStateMgr.GetKeyState(config.p2Henshin2)?Config.SelfM2:selfNameB;
				selfNameB = m_keyStateMgr.GetKeyState(config.p2Henshin3)?Config.SelfM3:selfNameB;
				if(selfNameB != null && selfNameB != runtime.p2tmpl.m_sName){//确定变身了
					runtime.p2tmpl = config.selfTmplList[selfNameB];
					p2.Henshin(runtime.p2tmpl);
				}
				
				p2.velocity.x = runtime.p2tmpl.m_nSpeed * hDelta;
				p2.velocity.y = runtime.p2tmpl.m_nSpeed * vDelta;
			}
		}
		
	}
}