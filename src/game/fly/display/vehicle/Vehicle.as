package game.fly.display.vehicle
{
	import game.fly.config.Runtime;
	import game.fly.display.GameObject;
	import game.fly.display.Vector2D;
	import game.fly.display.box.Box;
	import game.fly.display.bullet.Bullet;
	import game.fly.display.launcher.Launcher;
	import game.fly.manage.MediaSource;
	import game.fly.manage.MunitionFactory;
	import game.fly.manage.MunitionProxy;
	import game.utils.Util;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.media.Sound;
	
	/**
	 * 普通机动体（飞机、坦克等），具有机动体的基本特性。
	 */	
	public class Vehicle extends GameObject
	{
		protected var _sound:Sound;							//发射的声音
		
		protected var _maxLife:int = 1;
		/**
		 * 生命。
		 */		
		public var life:int = 1;
		/**
		 * 奖金，若为敌方机动体则指被击毁后能得的积分。
		 */		
		public var reward:int = 0;
		/**
		 * 当前机动体装备的枪。
		 */		
		public var gun:Launcher;
		/**
		 * 当前机动体装备的炮。
		 */		
		public var cannon:Launcher;
		
		/**
		 * 创建具有指定位置（position）、速度（velocity）、形状（g） 的Vehicle 对象，如果参数g == null则物体使用默认形状。
		 * @param position 位置，默认为(0, 0)
		 * @param velocity 速度，默认为(0, 0)
		 * @param g 形状
		 * 
		 */	
		public function Vehicle(position:Vector2D=null, velocity:Vector2D=null, g:Graphics=null)
		{
			super(position, velocity, g);
			_sound = MediaSource.dead;
		}
		
		/**
		 * 开枪。
		 * 
		 */		
		public function fireGun():void
		{
			if(gun)
				gun.fire();
		}
		
		/**
		 * 停止开枪。
		 * 
		 */		
		public function stopGun():void
		{
			if(gun)
				gun.stop();
		}
		
		/**
		 * 开炮。
		 * 
		 */		
		public function fireCannon():void
		{
			if(cannon)
				cannon.fire();
		}
		
		/**
		 * 停止开炮。
		 * 
		 */		
		public function stopCannon():void
		{
			if(cannon)
				cannon.stop();
		}
		
		/**
		 * 子弹击中物体后更新状态。
		 * @param a 碰撞到的飞机或子弹
		 * 
		 */			
		override protected function collisionDo(a:DisplayObject):void
		{
			if(a is Vehicle)
			{
				sound.play();
//				randomMakeBox();
				parent.removeChild(this);
			}
			else if(a is Bullet)
			{
				var b:Bullet = a as Bullet;
				if(life <= b.power)
				{
					sound.play();
					switch(b.group)
					{
						case MunitionProxy.G_P1:
							Runtime.getInstance().p1Score += reward;
							break;
						case MunitionProxy.G_P2:
							Runtime.getInstance().p2Score += reward;
							break;
					}
//					randomMakeBox();
					parent.removeChild(this);
					life = maxLife;
				}
				else
					life -= b.power;
			}
		}
		
		/**
		 * 随机爆出资源箱。
		 * @param space 资源箱投放地。
		 * 
		 */		
		private function randomMakeBox():void
		{
			var num:int = Util.random(0, 2);
			if(num % 2 > 0)
			{
				var box:Box;
				var boxNum:int = Util.random(0, 5);
				switch(boxNum)
				{
					case 0:
						box = MunitionProxy.box(MunitionFactory.LIFE_BOX);
						break;
					case 1:
						box = MunitionProxy.box(MunitionFactory.S2_BOX);
						break;
					case 2:
						box = MunitionProxy.box(MunitionFactory.S1_BOX);
						break;
					case 3:
						box = MunitionProxy.box(MunitionFactory.LEI_BOX);
						break;
					case 4:
						box = MunitionProxy.box(MunitionFactory.SIMPLE_BOX);
						break;
				}
				box.position = position.clone();
				parent.addChild(box);
			}
		}
		
		/**
		 * 获得发射点坐标。
		 * @param offset 发射点在当前对象坐标系中的位置
		 * @return 
		 * 
		 */		
		public function firePoint(offset:Vector2D = null):Vector2D
		{
			if(offset == null || offset.isZero())
				return new Vector2D(x, y);
			else
			{
				offset.angle += direction.angle;
				return position.add(offset);
			}
		}
		
		override protected function removeFromStage():void
		{
			if(gun)
				gun.init();
			if(cannon)
				cannon.init();
		}

		/**
		 * 爆炸的声音。
		 * @return 
		 * 
		 */		
		public function get sound():Sound
		{
			return _sound;
		}

		/**
		 * 最大生命。
		 */
		public function get maxLife():int
		{
			return _maxLife;
		}

		/**
		 * @private
		 */
		public function set maxLife(value:int):void
		{
			_maxLife = value;
			life = value;
		}

	}
}