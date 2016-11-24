package game.fly.display
{
	import game.fly.events.OverflowEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * 基本运动体类，包含物体基本特性。
	 * 
	 */	
	public class Mobile extends Sprite
	{
		protected var _edgeBehavior:String = REMOVE;//经过边缘时的运动方式
		protected var _maxSpeed:Number = 10;		//最大速率
		protected var _maxPalstance:Number = 5;		//最大角速率，以角度值表示
		protected var _position:Vector2D;			//位置
		protected var _direction:Vector2D;			//方向
		protected var _velocity:Vector2D;			//速度
		protected var _palstance:Vector2D;			//角速度，以角度值表示
		protected var _moveSpaceMin:Vector2D;		//运动范围最小点
		protected var _moveSpaceMax:Vector2D;		//运动范围最大点
		
		/**
		 * 运动到边缘时移到对侧
		 */		
		public static const WRAP:String = "wrap";
		/**
		 * 运动到边缘时反弹
		 */		
		public static const BOUNCE:String = "bounce";
		/**
		 * 运动到边缘时贴在边缘
		 */		
		public static const CLING:String = "cling";
		/**
		 * 运动到边缘时从显示列表中移除
		 */		
		public static const REMOVE:String = "remove";
		/**
		 * 不作处理（默认），将触发OverflowEvent 事件
		 */		
		public static const NONE:String = "none";
		
		/**
		 * 创建具有指定位置（position）、速度（velocity）、形状（g） 的Mobile 对象，如果参数g == null则物体使用默认形状。
		 * @param position 位置，默认为(0, 0)
		 * @param velocity 速度，默认为(0, 0)
		 * @param g 形状
		 * 
		 */			
		public function Mobile(position:Vector2D = null, velocity:Vector2D = null, g:Graphics = null)
		{
			//初始化速度
			if(velocity == null)
				_velocity = new Vector2D();
			else
				_velocity = velocity;
			_velocity.truncate(maxSpeed);
			
			//初始化位置
			if(position == null)
				_position = new Vector2D();
			else
				_position = position;
			x = _position.x;
			y = _position.y;
			
			//初始化方向、角速度、活动范围
			direction = new Vector2D(1, 0);
			palstance = new Vector2D();
			
			//绘制形状
			if(g == null)
				draw();
			else
				graphics.copyFrom(g);
			
			//注册事件
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		/**
		 * 绘制当前物体形状。
		 * 
		 */		
		protected function draw():void
		{
			graphics.clear();
			graphics.beginFill(0x000000);
			graphics.drawCircle(0, 0, 5);
			graphics.endFill();
		}
		
		/**
		 * 移动当前对象及其子对象。
		 * 
		 */		
		public function move():void
		{
			//更新位置
			_velocity.truncate(maxSpeed);
			_position.incrementBy(_velocity);
			
			//角速度不为0则更新方向
			if(_palstance.x != 0)
			{
				_palstance.truncate(maxPalstance);
				_direction.angle2 += _palstance.x;
			}
			
			//检查运动空间
			if(moveSpaceMin == null)
				moveSpaceMin = new Vector2D(0, 0);
			if(moveSpaceMax == null && stage)
				moveSpaceMax = new Vector2D(stage.stageWidth, stage.stageHeight);
			if(moveSpaceMin && moveSpaceMax)
				switch(_edgeBehavior)
				{
					case REMOVE:
						remove(); break;
					case WRAP:
						warp(); break;
					case BOUNCE:
						bounce(); break;
					case CLING:
						cling(); break;
				}
			
			//移动
			x = _position.x;
			y = _position.y;
			
			//转向
			rotation = _direction.angle2;
			
			//移动子对象
			for(var i:int = numChildren - 1; i >=0; i--)
			{
				var child:DisplayObject = getChildAt(i);
				if(child is Mobile)
					(child as Mobile).move();
			}
			sendEvent();
		}
		
		/**
		 * 穿越边界移动到允许移动范围的对立边。
		 * 
		 */		
		private function warp():void
		{
			if(_position.x >= moveSpaceMax.x)
				_position.x = moveSpaceMin.x;
			else if(_position.x <= moveSpaceMin.x)
				_position.x = moveSpaceMax.x;
			if(_position.y >= moveSpaceMax.y)
				_position.y = moveSpaceMin.y;
			else if(_position.y <= moveSpaceMin.y)
				_position.y = moveSpaceMax.y;
		}
		
		/**
		 * 到达允许移动范围边界时反弹移动。
		 * 
		 */		
		private function bounce():void
		{
			if(_position.x >= moveSpaceMax.x)
			{
				_position.x = moveSpaceMax.x;
				_velocity.x *= -1;
			}
			else if(_position.x <= moveSpaceMin.x)
			{
				_position.x = moveSpaceMin.x;
				_velocity.x *= -1;
			}
			if(_position.y >= moveSpaceMax.y)
			{
				_position.y = moveSpaceMax.y;
				_velocity.y *= -1;
			}
			else if(_position.y <= moveSpaceMin.y)
			{
				_position.y = moveSpaceMin.y;
				_velocity.y *= -1;
			}
		}
		
		/**
		 * 帖在边界上。
		 * 
		 */		
		private function cling():void
		{
			if(_position.x >= moveSpaceMax.x)
				_position.x = moveSpaceMax.x;
			else if(_position.x <= moveSpaceMin.x)
				_position.x = moveSpaceMin.x;
			if(_position.y >= moveSpaceMax.y)
				_position.y = moveSpaceMax.y;
			else if(_position.y <= moveSpaceMin.y)
				_position.y = moveSpaceMin.y;
		}
		
		/**
		 * 从显示列表中移除当前对象。
		 * 
		 */		
		private function remove():void
		{
			if(_position.x >= moveSpaceMax.x + width
				|| _position.x <= moveSpaceMin.x - width
				|| _position.y >= moveSpaceMax.y + height
				|| _position.y <= moveSpaceMin.y - height
				&& parent)
				parent.removeChild(this);
		}
		
		/**
		 * 超越允许范围时发送OverflowEvent事件。
		 * @param s 允许范围
		 * 
		 */		
		protected function sendEvent():void
		{
			if(stage)
			{
				var typeX:String;
				var typeY:String;
				if(_position.x > stage.stageWidth)
					typeX = OverflowEvent.RIGHT;
				else if(_position.x < 0)
					typeX = OverflowEvent.LEFT;
				if(_position.y > stage.stageHeight)
					typeY = OverflowEvent.BOTTOM;
				else if(_position.y < 0)
					typeY = OverflowEvent.TOP;
				if(typeX)
					dispatchEvent(new OverflowEvent(typeX));
				if(typeY)
					dispatchEvent(new OverflowEvent(typeY));
				if(typeX || typeY)
					dispatchEvent(new OverflowEvent(OverflowEvent.OVERFLOW));
			}
		}
		
		/**
		 * 当从舞台上移除该对象时的事件响应方法。
		 * @param e
		 * 
		 */		
		private function onRemoveFromStage(e:Event):void
		{
			removeFromStage();
		}
		
		/**
		 * 当从舞台上移除该对象时的动作，用于子类扩展。
		 * 
		 */		
		protected function removeFromStage():void{}
		
		/**
		 * 经过边缘时的运动方式。
		 * @return 
		 * 
		 */		
		public function get edgeBehavior():String
		{
			return _edgeBehavior;
		}
		
		public function set edgeBehavior(value:String):void
		{
			_edgeBehavior = value;
		}
		
		/**
		 * 最大速率。
		 * @return 
		 * 
		 */		
		public function get maxSpeed():Number
		{
			return _maxSpeed;
		}
		
		public function set maxSpeed(value:Number):void
		{
			if(value < 0)
				_maxSpeed = 0;
			else
				_maxSpeed = value;
			_velocity.truncate(maxSpeed);
		}
		
		/**
		 * 位置。
		 * @return 
		 * 
		 */		
		public function get position():Vector2D
		{
			return _position;
		}
		
		public function set position(value:Vector2D):void
		{
			_position = value;
			//更新位置
			x = _position.x;
			y = _position.y;
		}
		
		/**
		 * 速度。
		 * @return 
		 * 
		 */		
		public function get velocity():Vector2D
		{
			return _velocity;
		}
		
		public function set velocity(value:Vector2D):void
		{
			value.truncate(maxSpeed);
			_velocity = value;
		}
		
		/**
		 * 活动范围最小点 。
		 * @return 
		 * 
		 */		
		public function get moveSpaceMin():Vector2D
		{
			return _moveSpaceMin;
		}
		
		public function set moveSpaceMin(value:Vector2D):void
		{
			_moveSpaceMin = value;
		}
		
		/**
		 * 活动范围最大点。
		 * @return 
		 * 
		 */		
		public function get moveSpaceMax():Vector2D
		{
			return _moveSpaceMax;
		}
		
		public function set moveSpaceMax(value:Vector2D):void
		{
			_moveSpaceMax = value;
		}
		
		/**
		 * 物体朝向。
		 * @return 
		 * 
		 */		
		public function get direction():Vector2D
		{
			return _direction;
		}
		
		public function set direction(value:Vector2D):void
		{
			if(value.isZero())
				value.x = 1;
			_direction = value;
			//更新角度
			rotation = _direction.angle2;
		}
		
		/**
		 * 最大角速率。
		 * @return 
		 * 
		 */		
		public function get maxPalstance():Number
		{
			return _maxPalstance;
		}
		
		public function set maxPalstance(value:Number):void
		{
			value < 0 ? 0 : value;
			_maxPalstance = value;
		}
		
		/**
		 * 角速度，以Vector2D 对象x 属性表示角度大小，正/负 表示 顺/逆 时针。
		 * @return 
		 * 
		 */		
		public function get palstance():Vector2D
		{
			return _palstance;
		}
		
		public function set palstance(value:Vector2D):void
		{
			value.y = 0;
			_palstance = value;
		}
	}
}