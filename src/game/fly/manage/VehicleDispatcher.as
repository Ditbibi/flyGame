package game.fly.manage
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	
	import game.fly.config.Config;
	import game.fly.config.Runtime;
	import game.fly.display.GameObject;
	import game.fly.display.Vector2D;
	import game.fly.display.box.Box;
	import game.fly.display.vehicle.Vehicle;
	import game.fly.events.ActionEvent;
	import game.fly.model.BoxRuleTmpl;
	import game.fly.model.EnemyRuleTmpl;
	import game.fly.model.EnemyTmpl;
	import game.fly.model.RuleTmpl;
	import game.utils.Util;
	
	/**
	 * Vehicle 对象调度，负责根据当前游戏进度投放游戏角色到战场上。
	 * 
	 */	
	public class VehicleDispatcher extends EventDispatcher
	{
		private static var instance:VehicleDispatcher = new VehicleDispatcher();	//全局唯一实例
		
		private var runtime:Runtime = Runtime.getInstance();		//运行时

		private var config:Config = Config.getInstance();		
		
		private var timer:Timer;				//计时器，定时检测显示列表，并投放飞机
		private var delay:uint = 1000;			//检测时间间隔
		private var status:String = NONE;		//调度器当前状态
		private var enemyCount:int;				//当前存活的敌军数
		
		/**
		 * 机动体调度器状态：未启动
		 */		
		public static const NONE:String = "none";
		/**
		 * 机动体调度器状态：开始
		 */		
		public static const START:String = "start";	
		/**
		 * 机动体调度器状态：暂停
		 */		
		public static const STOP:String = "stop";
		
		/**
		 * 返回VehicleDispatcher单例。
		 * @return 
		 * 
		 */		
		public static function getInstance():VehicleDispatcher
		{
			return instance;
		}
		
		public function init():void
		{
			if(timer)
			{
				timer.removeEventListener(TimerEvent.TIMER, dispatch);
				timer = null;
			}
			status = NONE;
			enemyCount = 0;
		}
		
		/**
		 * 入口。
		 * 
		 */		
		public function run():void
		{
			init();
			start();
		}
		
		/**
		 * 开始调度。 
		 * 
		 */		
		public function start():void
		{
			if(status == NONE)
			{
				//添加玩家
				if(runtime.player == 1)
					sendP1();
				else if(runtime.player == 2)
				{
					sendP1();
					sendP2();
				}
				//开始轮循显示敌机
				timer = new Timer(delay);
				timer.addEventListener(TimerEvent.TIMER, dispatch);
				timer.start();
			}
			else if(status == STOP)
			{
				for each(var v:Vehicle in runtime.enemyVehicles.vector)
				{
					v.fireGun();
					v.fireCannon();
				}
				timer.start();
			}
			status = START;
		}
		
		/**
		 * 暂停调度。
		 * 
		 */		
		public function stop():void
		{
			for each(var v:Vehicle in runtime.enemyVehicles.vector)
			{
				v.stopGun();
				v.stopCannon();
			}
			timer.stop();
			status = STOP;
		}
		
		/**
		 * 添加玩家1
		 * @return P1
		 * 
		 */		
		public function sendP1():void
		{
			if(runtime.p1Life != 0)
			{
				var stage:Stage = runtime.stage;
				var p:Vehicle = MunitionProxy.vehicle(MunitionFactory.SELF, MunitionProxy.G_P1);
				p.velocity = new Vector2D();
				p.position = new Vector2D(p.width >> 1, (stage.stageHeight - p.height) >> 1);
				p.direction = new Vector2D(1, 0);
				p.moveSpaceMin = new Vector2D(p.width >> 1, p.height >> 1);
				p.moveSpaceMax = new Vector2D(stage.stageWidth - (p.width >> 1), stage.stageHeight - (p.height >> 1));
				p.addEventListener(Event.REMOVED_FROM_STAGE, onSelfRemove, false, 10);		//高优先级
//				runtime.p1Life--;
				runtime.space.addChild(p);
			}
		}
		
		/**
		 * 添加玩家2
		 * @return P2
		 * 
		 */		
		public function sendP2():void
		{
			if(runtime.p2Life != 0)
			{
				var stage:Stage = runtime.stage;
				var p:Vehicle = MunitionProxy.vehicle(MunitionFactory.SELF, MunitionProxy.G_P2);
				p.velocity = new Vector2D();
				p.position = new Vector2D(0, ((stage.stageHeight - p.height) >> 1) - 30);
				p.direction = new Vector2D(1, 0);
				p.moveSpaceMin = new Vector2D(p.width >> 1, p.height >> 1);
				p.moveSpaceMax = new Vector2D(stage.stageWidth - (p.width >> 1), stage.stageHeight - (p.height >> 1));
				p.addEventListener(Event.REMOVED_FROM_STAGE, onSelfRemove, false, 10);
//				runtime.p2Life--;
				runtime.space.addChild(p);
			}
		}
		
		/**
		 * 调度方法。
		 * @param e
		 * 
		 */		
		private function dispatch(e:TimerEvent):void
		{
			var totalTime:int = runtime.totalTime;
			for each(var rule:EnemyRuleTmpl in config.enemyRuleTmplAry){
				if(totalTime < rule.m_nStartTime)continue;
				if((totalTime ) % rule.m_nTime > rule.m_nTime - 1000){
					var tmpl:EnemyTmpl = config.enemyTmplList[rule.m_sName];
					if(tmpl == null)continue;
					var v:Vehicle = MunitionProxy.vehicle(tmpl);
					if(1 == tmpl.m_nTarget)
						v.targetObj = runtime.p1;
					v = setEnemyAttribute(v,rule) as Vehicle;
					displayEnemy(v);
				}
			}
			for each(var boxRuleTmpl:BoxRuleTmpl in config.boxRuleAry){
				if(totalTime < boxRuleTmpl.m_nStartTime)continue;
				if((totalTime ) % boxRuleTmpl.m_nTime > boxRuleTmpl.m_nTime - 1000){
					var box:Box = MunitionProxy.box(boxRuleTmpl.m_sName);
					box = setEnemyAttribute(box,boxRuleTmpl) as Box;
					runtime.space.addChild(box);
				}
			}
			
//			if(enemyCount < 5)
//			{
//				var v:Vehicle = MunitionProxy.vehicle(MunitionFactory.D2);
//				v.targetObj = runtime.p1;
//				displayEnemy(setEnemyAttribute(v));
//			}
//			if(totalTime % 5000 > 4000)
//			{
//				for(var i:int = Util.random(2, 4); i > 0; i--)
//				{
//					var o:Vehicle = MunitionProxy.vehicle(MunitionFactory.D3);
//					var num:int = Util.random(0, runtime.player);
//					if(num == 0)
//						o.targetObj = runtime.p1;
//					else if(num == 1)
//						o.targetObj = runtime.p2;
//					displayEnemy(setEnemyAttribute(o));
//				}
//			}
//			if(totalTime % 6000 > 5000)
//			{
//				for(var j:int = Util.random(1, 5); j > 0; j--)
//					displayEnemy(setEnemyAttribute(MunitionProxy.vehicle(MunitionFactory.D4)));
//			}
//			if(totalTime % 8000 > 7000)
//			{
//				displayEnemy(setEnemyAttribute(MunitionProxy.vehicle(MunitionFactory.D6)));
//			}
		}
		
		/**
		 * 设置敌机属性。
		 * @param v
		 * @return 
		 * 
		 */		
		private function setEnemyAttribute(v:GameObject,rule:RuleTmpl):GameObject
		{
			var stageW:int = runtime.stage.stageWidth;
			var stageH:int = runtime.stage.stageHeight;
//			var halfH:int = stageH >> 1;
//			v.position = new Vector2D(stageW, halfH + Util.random(halfH * -1, halfH));
//			v.direction = new Vector2D(-1, 0);
			var posx:int = Util.random(rule.m_nFromX,rule.m_nToX);
			var posY:int = Util.random(rule.m_nFromY,rule.m_nToY);
			v.position = new Vector2D(posx, posY);
			if(rule as EnemyRuleTmpl)
				v.direction = new Vector2D((rule as EnemyRuleTmpl).m_nDirection, 0);
			return v;
		}
		
		/**
		 * 添加敌军Vehicle 对象到显示空间，在新机动体创建后调用。
		 * @param v 敌军
		 * 
		 */		
		private function displayEnemy(v:Vehicle):void
		{
			v.addEventListener(Event.ADDED_TO_STAGE, onEnemyAdded);
			runtime.space.addChild(v);
			v.fireGun();
			v.fireCannon();
		}
		
		/**
		 * 机动体显示在stage上事件处理方法。
		 * @param e
		 * 
		 */		
		private function onEnemyAdded(e:Event):void
		{
			enemyCount++;
			var v:Vehicle = e.target as Vehicle;
			v.removeEventListener(Event.ADDED_TO_STAGE, onEnemyAdded);
			v.addEventListener(Event.REMOVED_FROM_STAGE, onEnemyRemove);
		}
		
		/**
		 * 机动体从stage上移除事件处理方法。
		 * @param e
		 * 
		 */		
		private function onEnemyRemove(e:Event):void
		{
			enemyCount--;
			var v:Vehicle = e.target as Vehicle;
			v.removeEventListener(Event.REMOVED_FROM_STAGE, onEnemyRemove);
		}
		
		private function onSelfRemove(e:Event):void
		{
			var o:Vehicle = e.target as Vehicle;
			o.removeEventListener(Event.REMOVED_FROM_STAGE, onSelfRemove);
			
			//玩家生命为0时发送game over事件
			if(runtime.p1Life == 0 && runtime.p2Life == 0)
			{
				dispatchEvent(new ActionEvent(ActionEvent.GAME_OVER));
			}
			
			if(runtime.status != GameDispatcher.NONE)
			{
				if(o.group == MunitionProxy.G_P1)
					sendP1();
				else if(o.group == MunitionProxy.G_P2)
					sendP2();
			}
		}
	}
}