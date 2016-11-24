package game.fly.display.launcher
{
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	import game.fly.display.GameObject;
	import game.fly.display.bullet.Bullet;
	import game.fly.display.vehicle.Vehicle;
	import game.fly.events.ActionEvent;
	
	/**
	 * 弹药发射器。
	 * 
	 */	
	public class Launcher extends GameObject
	{
		private var timer:Timer;
		
		protected var _capacity:int = -1;					//剩余弹药量，若为负数表示无上限
		protected var _bullet:String;						//子弹类型
		protected var _queue:Vector.<Bullet> = new Vector.<Bullet>();	//发射队列
		protected var _vehicle:Vehicle;						//被装载到的对象
		protected var _container:DisplayObjectContainer;	//发射容器 
		private var _f:uint = 1000;						//发射频率，指定多长时间发射一次，单位：毫秒
		protected var _initCapacity:int = -1;				//初始载弹量，若为负数表示无上限
		protected var _maxCapacity:int = -1;				//最大载弹量，若为负数表示无上限
		protected var _status:String = NONE;				//开火状态
		protected var _sound:Sound;							//发射的声音
		protected var _openSound:Boolean;					//是否开启声音
		protected var maxStrength:uint = 1;					//单次最多发射子弹数
		
		public var strength:uint = 1;						//单次发射子弹数
		
		/**
		 * 状态：开火中
		 */			
		public static const START:String = "start";
		/**
		 * 状态：暂停开火
		 */		
		public static const STOP:String = "stop";
		/**
		 * 状态：未开火
		 */		
		public static const NONE:String = "none";
		
		/**
		 * 制造一个发射器。
		 * @param b 发射弹药类型
		 * @param sound 发射声音
		 * @param openSound 是否打开声音
		 * 
		 */		
		public function Launcher(b:String, sound:Sound = null, openSound:Boolean = false)
		{
			_bullet = b;
			_sound = sound;
			_openSound = openSound;
			
			startTimer();
		}
		/**
		 * 定一个计时器
		 */
		public function startTimer():void{
			if(timer != null)return;
			timer = new Timer(f);
			timer.addEventListener(TimerEvent.TIMER, fireFunction);
		}
		
		/**
		 * 初始化发射器。
		 * 
		 */		
		public function init():void
		{
			//卸载计数器
			if(timer)
			{
				timer.removeEventListener(TimerEvent.TIMER, fireFunction);
				timer = null;
			}
			strength = 1;
			status = NONE;
			
		}
		
		/**
		 * 如果vehicle和container属性不为空则开火。
		 * 
		 */		
		public function fire():void
		{
			if(vehicle)
			{
				if(container == null)
					container = vehicle.parent;
				if(container)
				{
					
//					if(status == NONE)
//					{
//						if(capacity != 0)
//						{
//							timer = new Timer(f);
//							timer.addEventListener(TimerEvent.TIMER, fireFunction);
//							timer.start();
//						}
//					}
//					else if(status == STOP)
//					{
//						timer.start();
//					}
					if(timer)
					{
						if(!timer.running){
							fireDo();
							timer.start();
						}
						status = START;
					}
				}
			}
			
		}
		
		/**
		 * 开火方法。
		 * @param e
		 * 
		 */		
		private function fireFunction(e:TimerEvent):void
		{
			fireDo();
		}
		
		/**
		 * 单次开火动作，将发射队列中子弹依次放入DisplayObjectContainer 对象。
		 * 
		 */	
		protected function fireDo():void
		{
			if(capacity != 0)
			{
				//发声音
				if(openSound && sound)
					sound.play();
				//发子弹
				while(!isEmptyQueue())
				{
					container.addChild(shiftQueue());
				}
			}
			if(capacity > 0)
				_capacity--;
		}
		
		/**
		 * 添加子弹到发射队列。
		 * @param a 子弹
		 * @return 
		 * 
		 */		
		protected function pushQueue(a:Bullet):uint
		{
			return queue.push(a);
		}
		
		/**
		 * 从发射队列中取出子弹，并将其移除。
		 * @return 队列中第一个子弹
		 * 
		 */		
		protected function shiftQueue():Bullet
		{
			var q:Bullet = queue.pop();
			return q;
		}
		
		/**
		 * 清空发射队列。
		 * 
		 */		
		protected function clearQueue():void
		{
			_queue = new Vector.<Bullet>();
		}
		
		/**
		 * 判断发射队列是否为空。
		 * @return 是/否
		 * 
		 */		
		protected function isEmptyQueue():Boolean
		{
			return queue.length == 0;
		}
		
		/**
		 * 卸载发射器。
		 * 
		 */		
		public function unload():void
		{
			init();
			vehicle = null;
			container = null;
			//发送卸载事件
			dispatchEvent(new ActionEvent(ActionEvent.LAUNCHER_UNLOAD));
		}
		
		/**
		 * 暂停开火。
		 * 
		 */		
		public function stop():void
		{
			if(timer)
			{
				timer.stop();
				status = STOP;
			}
		}
		
		/**
		 * 添加弹药。
		 * @param a 弹药数
		 * 
		 */		
		public function add(a:int):void
		{
			if(maxCapacity > 0)
			{
				var tmp:int = _capacity + a;
				_capacity = tmp < maxCapacity ? tmp : maxCapacity;
			}
			else if(maxCapacity < 0)
				_capacity += a;
		}
		
		/**
		 * 发射器装备的子弹类型。
		 * @return 
		 * 
		 */		
		public function get bullet():String
		{
			return _bullet;
		}
		
		/**
		 * 被装载到的对象。
		 * @return 
		 * 
		 */		
		public function get vehicle():Vehicle
		{
			return _vehicle;
		}
		
		public function set vehicle(value:Vehicle):void
		{
			_vehicle = value;
		}
		
		/**
		 * 发射频率，指定多长时间发射一次，单位：毫秒，默认1000。
		 * @return 
		 * 
		 */		
		public function get f():uint
		{
			return _f;
		}
		public function set f(time:uint):void{
			_f = time;
			if(timer != null){
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, fireFunction);
				timer = null;
			}
			startTimer();
		}
		
		/**
		 * 载弹量，默认-1。
		 * @return 
		 * 
		 */		
		public function get capacity():int
		{
			return _capacity;
		}
		
		public function set capacity(value:int):void
		{
			_capacity = value;
		}
		
		/**
		 * 最大载弹量，若为负数表示无上限，默认-1。
		 * @return 
		 * 
		 */		
		public function get maxCapacity():int
		{
			return _maxCapacity;
		}
		
		/**
		 * 开火状态。
		 * @return 
		 * 
		 */		
		public function get status():String
		{
			return _status;
		}
		
		public function set status(value:String):void
		{
			_status = value;
		}
		
		/**
		 * 发射容器 ，即弹药物体应放入的DisplayObjectContainer 对象。
		 * @return 
		 * 
		 */		
		public function get container():DisplayObjectContainer
		{
			return _container;
		}
		
		public function set container(value:DisplayObjectContainer):void
		{
			_container = value;
		}
		
		/**
		 * 发射队列，发射器将从此队列中依次取出子弹进行发射。
		 * @return 
		 * 
		 */		
		public function get queue():Vector.<Bullet>
		{
			return _queue;
		}
		
		/**
		 * 初始载弹量，负数表示无上限。
		 * @return 
		 * 
		 */		
		public function get initCapacity():int
		{
			return _initCapacity;
		}
		
		public function set initCapacity(value:int):void
		{
			if(maxCapacity < 0)
				_initCapacity = value;
			else
				_initCapacity = value < maxCapacity ? value : maxCapacity;
			_capacity = _initCapacity;
		}
		
		public function set MaxStrength(strength:int):void{
			maxStrength = strength;
		}
		/**
		 * 发射的声音。
		 * @return 
		 * 
		 */		
		public function get sound():Sound
		{
			return _sound;
		}
		
		/**
		 * 是否开启声音，默认关闭。
		 * @return 
		 * 
		 */		
		public function get openSound():Boolean
		{
			return _openSound;
		}
		
		public function set openSound(value:Boolean):void
		{
			_openSound = value;
		}
		
		
	}
}