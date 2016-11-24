package game.fly.manage
{
	import game.fly.config.Runtime;
	import game.fly.display.GameObject;
	import game.fly.display.Vector2D;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	/**
	 * 碰撞检测。
	 * 
	 */	
	public class CollisionTest
	{
		private static var instance:CollisionTest = new CollisionTest();
		
		private var runtime:Runtime = Runtime.getInstance();	//运行时对象
		private var delay:uint = 15;							//碰撞检测时间间隔
		private var timer:Timer = new Timer(delay);				//检测定时器
		private var status:String = NONE;						//状态
		
//		private var bitmapData:BitmapData = new BitmapData(100, 100, true, 1);
		private var point1:Point = new Point();
		private var point2:Point = new Point();
		
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
		 * 获得CollisionTest 对象实例。
		 * @return 
		 * 
		 */		
		public static function getInstance():CollisionTest
		{
			return instance;
		}
		
		/**
		 * 初始化。
		 * 
		 */		
		public function init():void
		{
			timer.removeEventListener(TimerEvent.TIMER, test);
			status = NONE;
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
		 * 开始检测。
		 * 
		 */		
		public function start():void
		{
			if(status == NONE)
			{
				timer.addEventListener(TimerEvent.TIMER, test);
				timer.start();
			}
			else if(status == STOP)
				timer.start();
			status = START;
		}
		
		/**
		 * 暂停检测。
		 * 
		 */		
		public function stop():void
		{
			timer.stop();
			status = STOP;
		}
		
		/**
		 * 检测方法。
		 * @param e
		 * 
		 */		
		public function test(e:TimerEvent):void
		{
			//测试p1与敌军子弹、敌机、资源箱的碰撞
			if(runtime.p1)
			{
				oneToMore(runtime.p1, runtime.enemyBullets.vector);
				oneToMore(runtime.p1, runtime.enemyVehicles.vector);
				oneToMore(runtime.p1, runtime.boxs.vector);
			}
			//测试p2与敌军子弹、敌机、资源箱的碰撞
			if(runtime.p2)
			{
				oneToMore(runtime.p2, runtime.enemyBullets.vector);
				oneToMore(runtime.p2, runtime.enemyVehicles.vector);
				oneToMore(runtime.p2, runtime.boxs.vector);
			}
			//测试p1子弹与敌机的碰撞
			moreToMore(runtime.p1Bullets.vector, runtime.enemyVehicles.vector);
			//测试p2子弹与敌机的碰撞
			moreToMore(runtime.p2Bullets.vector, runtime.enemyVehicles.vector);
			
			//测试p1子弹与敌机子弹的碰撞
			moreToMore(runtime.p1Bullets.vector, runtime.enemyBullets.vector);
			//测试p2子弹与敌机子弹的碰撞
			moreToMore(runtime.p2Bullets.vector, runtime.enemyBullets.vector);
		}
		
		/**
		 * 多对多碰撞检测。
		 * @param vector1 多
		 * @param vector2 多
		 * 
		 */		
		private function moreToMore(vector1:Vector.<GameObject>, vector2:Vector.<GameObject>):void
		{
			var callback:Function = function(item:GameObject, index:int, array:Vector.<GameObject>):void
			{
				oneToMore(item, vector2);
			};
			try
			{
				vector1.forEach(callback);
			}
			catch(e:Error){}
		}
		
		/**
		 * 一对多碰撞检测。
		 * @param a 一
		 * @param vector 多
		 * 
		 */		
		public function oneToMore(a:GameObject, vector:Vector.<GameObject>):void
		{
			var callback:Function = function(item:GameObject, index:int, array:Vector.<GameObject>):void
			{
				oneToOne(a, item);
			};
			try
			{
				vector.forEach(callback);
			}
			catch(e:Error){}
		}
		
		/**
		 * 一对一碰撞检测。
		 * @param a 一
		 * @param b 一
		 * 
		 */		
		public function oneToOne(a:GameObject, b:GameObject):void
		{
			var aw:Number = a.width;
			var ah:Number = a.height;
			var bw:Number = b.width;
			var bh:Number = b.height;
			var haw:Number = aw >> 1;
			var hah:Number = ah >> 1;
			var hbw:Number = bw >> 1;
			var hbh:Number = bh >> 1;
			
			var abx:Number = a.x - b.x;
			var aby:Number = a.y - b.y;
			var abw:Number = aw + bw;
			var abh:Number = ah + bh;
			abx = abx > 0 ? abx : abx * -1;
			aby = aby > 0 ? aby : aby * -1;
			if(abx > abw || aby > abh)
				return;
			point1.x = a.x - haw;
			point1.y = a.y - hah;
			point2.x = b.x - hbw;
			point2.y = b.y - hbh;
			
			var bd1:BitmapData = (a.getChildAt(0) as Bitmap).bitmapData;
			var bd2:BitmapData = (b.getChildAt(0) as Bitmap).bitmapData;
			if(bd1.hitTest(point1, 255, bd2, point2, 255))
			{
				a.collisionAction(b);
				b.collisionAction(a);
			}
			
//			var bd1:BitmapData = new BitmapData(aw, ah, true, 1);
//			var bd2:BitmapData = new BitmapData(bw, bh, true, 1);
//			var mx1:Matrix = new Matrix(1, 0, 0, 1, 0, 0);
//			var mx2:Matrix = new Matrix(1, 0, 0, 1, 0, 0);
//			mx1.rotate(a.direction.angle);
//			mx2.rotate(b.direction.angle);
//			mx1.translate(haw, hah);
//			mx2.translate(hbw, hbh);
//			bd1.draw(a, mx1);
//			bd2.draw(b, mx2);
//			if(bd1.hitTest(point1, 255, bd2, point2, 255))
//			{
//				a.collisionAction(b);
//				b.collisionAction(a);
//			}
//			bd1.dispose();
//			bd2.dispose();
		}
	}
}