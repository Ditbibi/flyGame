package game.fly.display
{
	import game.utils.MathConstant;
	
	import flash.geom.Vector3D;
	
	/**
	 * 二维向量，用于表示：速度、力、加速度、位置等。 
	 * 
	 */	
	public class Vector2D
	{
		public var x:Number;		//x坐标
		public var y:Number;		//y坐标
		
		public function Vector2D(x:Number = 0, y:Number = 0)
		{
			this.x = x;
			this.y = y;
		}
		
		/**
		 * 返回两个矢量之间的弧度的角度。返回的角度是第一个 Vector2D 对象旋转到与第二个 Vector2D 对象对齐的位置时所形成的最小弧度。
		 * @param a 对象1
		 * @param b 对象2
		 * @return 夹角弧度
		 * 
		 */		
		public static function angleBetween(a:Vector2D, b:Vector2D):Number
		{
			var aa:Number = Math.atan2(a.y, a.x);
			var ba:Number = Math.atan2(b.y, b.x);
			if(aa < 0)
				aa += MathConstant.PI2;
			if(ba < 0)
				ba += MathConstant.PI2;
			var t:Number = ba - aa;
			var ang:Number = t > 0 ? t : t * -1;
			if(ang > Math.PI)
				t = ang - MathConstant.PI2;
			return t;
		}
		
		/**
		 * 返回两个 Vector2D 对象之间的距离。
		 * @param a 对象1
		 * @param b 对象2
		 * @return 距离
		 * 
		 */		
		public static function distance(a:Vector2D, b:Vector2D):Number
		{
			var m:Number = a.x - b.x;
			var n:Number = a.y - b.y;
			return Math.sqrt(m * m + n * n);
		}
		
		/**
		 * 使用指定的Vector2D 对象的x, y属性初始化当前Vector2D 对象。
		 * @param a 指定对象
		 * 
		 */		
		public function init(a:Vector2D):void
		{
			this.x = a.x;
			this.y = a.y;
		}
		
		/**
		 * 限制当前向量长度
		 * @param a 最大长度
		 * 
		 */		
		public function truncate(a:Number):void
		{
			length = a < length ? a : length;
		}
		
		/**
		 * 校正当前Vector2D 对象x, y属性最大值不能超过给定Vector2D 对象的x, y属性。
		 * @param a 给定对象
		 * 
		 */		
		public function regulate(a:Vector2D):void
		{
			x = a.x < x ? a.x : x;
			y = a.y < y ? a.y : y;
		}
		
		/**
		 * 计算当前Vector2D 对象到指定Vector2D 对象间的距离。
		 * @param a 指定对象
		 * @return 距离
		 * 
		 */		
		public function distanceTo(a:Vector2D):Number
		{
			return distance(this, a);
		}
		
		/**
		 * 将当前对象设置为其逆对象。
		 * 
		 */		
		public function negate():void
		{
			x *= -1;
			y *= -1;
		}
		
		/**
		 * 返回新的Vector2D 对象，它是当前对象与指定Vector2D 对象相加的结果。
		 * @param a 指定对象
		 * @return 
		 * 
		 */		
		public function add(a:Vector2D):Vector2D
		{
			var v:Vector2D = this.clone();
			v.x += a.x;
			v.y += a.y;
			return v;
		}
		
		/**
		 * 返回新的Vector2D 对象，它是当前对象减去指定Vector2D 对象的结果。
		 * @param a 指定对象
		 * @return 
		 * 
		 */		
		public function subtract(a:Vector2D):Vector2D
		{
			var v:Vector2D = this.clone();
			v.x -= a.x;
			v.y -= a.y;
			return v;
		}
		
		/**
		 * 按照指定的 Vector2D 对象的 x、y 元素的值递增当前 Vector2D 对象的 x、y 元素的值。 
		 * @param a 指定对象
		 * 
		 */		
		public function incrementBy(a:Vector2D):void
		{
			x += a.x;
			y += a.y;
		}
		
		/**
		 * 按照指定的 Vector2D 对象的 x、y 元素的值递减当前 Vector2D 对象的 x、y 元素的值。 
		 * @param a 指定对象
		 * 
		 */		
		public function decrementBy(a:Vector2D):void
		{
			x -= a.x;
			y -= a.y;
		}
		
		/**
		 * 按标量（大小）绽放当前Vector2D 对象。
		 * @param s 缩放比
		 * 
		 */		
		public function scaleBy(s:Number):void
		{
			x *= s;
			y *= s;
		}
		
		/**
		 * 返回一个新 Vector2D 对象，它是与当前 Vector2D 对象完全相同的副本。
		 * @return 新的Vector2D对象
		 * 
		 */		
		public function clone():Vector2D
		{
			return new Vector2D(x, y);
		}
		
		/**
		 * 判断当前向量是否在坐标原点上。
		 * @return 是/否
		 * 
		 */		
		public function isZero():Boolean
		{
			return x == 0 && y == 0;
		}
		
		/**
		 * 将当前向量移至坐标原点。
		 * 
		 */		
		public function zero():void
		{
			x = 0;
			y = 0;
		}
		
		/**
		 * 判断是不是单位向量。
		 * @return 是/否
		 * 
		 */		
		public function isNormalize():Boolean
		{
			return length == 1;
		}
		
		/**
		 * 通过将二个坐标元素（x、y）除以矢量的长度将 Vector2D 对象转换为单位矢量。
		 * <li>(x = 0, y = 0) -> (1, 0)</li>
		 * @return 转换前矢量的长度
		 * 
		 */		
		public function normalize():Number
		{
			var l:Number = length;
			if(l == 0)
				x = 1;
			else
			{
				x /= l;
				y /= l;
			}
			return l;
		}
		
		/**
		 * 返回当前矢量与x轴正方向上按逆针方向测量的角度值。
		 * <li>(x = 0, y = 0) -> 0</li>
		 * @return 角度
		 * 
		 */		
		public function get angle2():Number
		{
			return angle / MathConstant.PI_180;
		}
		
		public function set angle2(value:Number):void
		{
			angle = value * MathConstant.PI_180;
		}
		
		/**
		 * 返回当前矢量与x轴正方向上按逆针方向测量的角度弧度值。
		 * <li>(x = 0, y = 0) -> 0</li>
		 * @return 弧度值
		 * 
		 */		
		public function get angle():Number
		{
			return Math.atan2(y, x);
		}
		
		public function set angle(value:Number):void
		{
			var l:Number = length;
			x = Math.cos(value) * l;
			y = Math.sin(value) * l;
		}
		
		/**
		 * 返回当前矢量长度。
		 * @return 长度
		 * 
		 */		
		public function get length():Number
		{
			return Math.sqrt(x * x + y * y);
		}
		
		public function set length(value:Number):void
		{
			var a:Number = angle;
			x = Math.cos(a) * value;
			y = Math.sin(a) * value;
		}
		
		/**
		 * 通过将当前 Vector2D 对象的 x、y 元素与指定的 Vector2D 对象的 x、y 元素进行比较，确定这两个对象是否相等。
		 * @param a 指定对象
		 * @return 是/否
		 * 
		 */		
		public function equals(a:Vector2D):Boolean
		{
			if(a && a.x == x && a.y == y)
				return true;
			return false;
		}
		
		/**
		 * 返回当前 Vector2D 对象的字符串表示形式。
		 * @return 
		 * 
		 */		
		public function toString():String
		{
			return "[Vector2D(x:" + x + ", y:" + y + ")]"
		}
	}
}