package game.utils
{
	/**
	 * 基本工具类。
	 * 
	 */	
	public class Util
	{
		/**
		 * 在指定区间随机生成整数，该数大小从form（包括）到to（不包括）。
		 * @param from 下限
		 * @param to 上限
		 * @return 随机整数
		 * 
		 */		
		public static function random(from:int, to:int):int
		{
			return Math.random() * (to - from) + from;
		}
		
		/**
		 * 弧度转角度。
		 * @param a 弧度值
		 * @return 角度值
		 * 
		 */		
		public static function toAngle(a:Number):Number
		{
			return a / MathConstant.PI_180;
		}
		
		/**
		 * 角度转弧度。
		 * @param a 角度值
		 * @return 弧度值
		 * 
		 */		
		public static function toRadian(a:Number):Number
		{
			return a * MathConstant.PI_180;
		}
	}
}