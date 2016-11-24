package game.fly.display
{
	import game.utils.Util;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	
	/**
	 * <p>智能移动物体，具有高级移动特性。</p>
	 * (common)
	 * <li>监视（oversee)：角色试图将朝向某个指定点或另一个角色。</li>
	 * <li>寻找（seek)：角色试图移动到某个指定点。该点可以是一个固定点或是移动目标，例如另一个角色。</li>
	 * <li>漫游（wander）：随机但又平滑真实的移动。</li>
	 * <li>追赶（pursue）：寻找行为的改进版，加入了对目标的速度的计算。不只寻找目标当前所在的点，而要预先判断目标要去哪里并向此点移动。显然，这个行为只应用在移动目标，因为固定点是没有速度的。</li>
	 * <li>躲避（flee）：和寻找行为完全相反。角色尽可能向避开指定点的方向移动。同样，这个点即可是固定的也可是运动的。</li>
	 * <li>到达（arrive）: 和寻找行为相同，只是角色足够接近目标点时速度会降下来，就像缓动运动最终停在目标点一样。</li>
	 * <li>逃离（evade）：与追赶完全相反。角色预先根据对方的速度判断到达的点，然后尽可能地远离该点。</li>
	 * <li>物体躲避（object avoidance）：角色可以察觉在其运动路径上的物体并转向躲避它们。</li>
	 * <li>路径跟随（path following）：角色尽量保持在指定路径上，但这是在持续的物理和其它行为干扰下实现的。</li><br/>
	 * <br/>
	 * 
	 * 除了这些行为以外，还有复杂的复合行为，如我们熟知的集群（flocking）模拟相似角色的群组行为，基本上是应用其它三种简单行为创造出来的：
	 * <li>分离（separation）：集群中的每个角色试图与他的邻居保持一定距离。</li>
	 * <li>凝聚（cohesion）：每个角色试图不要离他的邻居太远。</li>
	 * <li>队列（alignment）：每个角色试图与他的邻居保持相同的转向。</li>
	 * 
	 * 
	 */	
	public class SteeredMobile extends Mobile
	{
		private var wanderTime:uint = 1;					//漫游时长标记
		private var wanderAngle:Number = 0.04;				//漫游弧度
		
		protected var mass:Number = 1;						//质量
		protected var maxForce:Number = 1;					//最大力量
		protected var force:Vector2D = new Vector2D();		//受力
		
		/**
		 * 目标坐标。
		 */		
		public var target:Vector2D;
		/**
		 * 目标对象。
		 */		
		public var targetObj:Mobile;
		
		/**
		 * 创建具有指定位置（position）、速度（velocity）、形状（g） 的SteeredMobile 对象，如果参数g == null则物体使用默认形状。
		 * @param position 位置，默认为(0, 0)
		 * @param velocity 速度，默认为(0, 0)
		 * @param g 形状
		 * 
		 */	
		public function SteeredMobile(position:Vector2D=null, velocity:Vector2D=null, g:Graphics=null)
		{
			super(position, velocity, g);
		}
		
		override public function move():void
		{
			if(!force.isZero())
			{
				//计算加速度
				var a:Vector2D = force.clone();
				a.scaleBy(1 / mass);
				//更新速度 
				_velocity.incrementBy(a);
			}
			super.move();
		}
		
		/**
		 * 监视目标：角色试图将朝向某个指定点或另一个角色。
		 * 
		 */		
		protected function oversee():void
		{
			var targetVector:Vector2D;
			if(targetObj)
				targetVector = new Vector2D(targetObj.x, targetObj.y);
			else if(target)
				targetVector = target;
			else
				return;
			//计算当前对象到目标的矢量。
			var tmp:Vector2D = targetVector.subtract(position);
			//计算当前对象方向与目标的夹角弧度。
			var angle:Number = Vector2D.angleBetween(direction, tmp);
			//计算可转动的弧度。
			var rota:Number;
			if(angle < 0)
			{
				var r:Number = Util.toRadian(maxPalstance) * -1;
				rota = r > angle ? r : angle;
			}
			else
			{
				var a:Number = Util.toRadian(maxPalstance);
				rota = a < angle ? a : angle;
			}
			//改变方向
			direction.angle += rota;
		}
		
		/**
		 * 寻找：角色试图移动到某个指定点。该点可以是一个固定点或是移动目标，例如另一个角色。
		 * 
		 */		
		protected function seek():void
		{
			oversee();
			velocity.angle = direction.angle;
		}
		
		/**
		 * 追赶：寻找行为的改进版，加入了对目标的速度的计算。不只寻找目标当前所在的点，而要预先判断目标要去哪里并向此点移动。
		 * 
		 */		
		protected function pursue():void
		{
			if(targetObj && !velocity.isZero())
			{
				//目标位置，速度
				var tp:Vector2D = targetObj.position.clone();
				var tv:Vector2D = targetObj.velocity.clone();
				//预估到达时间周期
				var l:Number = Vector2D.distance(position, tp);
				var t:Number = l / velocity.length;
				//估计在此时间内目标移动到的位置
				if(t > 100)
				{
					t = 10;
				}
				tv.scaleBy(t);
				tp.incrementBy(tv);
				
				
				//计算当前对象到目标的矢量。
				var tmp:Vector2D = tp.subtract(position);
				//计算当前对象方向与目标的夹角弧度。
				var angle:Number = Vector2D.angleBetween(direction, tmp);
				//计算可转动的弧度。
				var rota:Number;
				if(angle < 0)
				{
					var r:Number = Util.toRadian(maxPalstance) * -1;
					rota = r > angle ? r : angle;
				}
				else
				{
					var a:Number = Util.toRadian(maxPalstance);
					rota = a < angle ? a : angle;
				}
				//改变方向
				direction.angle += rota;
				//改变速度方向
				velocity.angle = direction.angle;
			}
		}
		
		/**
		 * 漫游：随机但又平滑真实的移动。
		 * 
		 */		
		protected function wander():void
		{
			velocity.angle += wanderAngle;
			if(--wanderTime == 0)
			{
				wanderTime = Util.random(100, 500);
				wanderAngle = (Util.random(0, 20) - 10 )/ 200;
			}
		}
	}
}