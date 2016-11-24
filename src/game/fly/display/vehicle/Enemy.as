package game.fly.display.vehicle
{
	import flash.display.Bitmap;
	
	import game.fly.display.Vector2D;
	import game.fly.manage.MediaSource;
	import game.fly.manage.MunitionFactory;
	import game.fly.manage.MunitionProxy;
	import game.fly.model.EnemyTmpl;

	/**
	 * 敌方战机
	 */
	public class Enemy extends Vehicle
	{
		private var _tmpl:EnemyTmpl;
		
		public function Enemy(tmpl:EnemyTmpl)
		{
			_tmpl = tmpl;
			super(null, new Vector2D(-tmpl.m_nMaxSpeed, 0), null);
			maxSpeed = tmpl.m_nMaxSpeed;
			maxPalstance = tmpl.m_nMaxPalstance;
			edgeBehavior = tmpl.m_sBehavior;
			maxLife = tmpl.m_nMaxLif;
			reward = tmpl.m_nReward;
			if(tmpl.m_sGun != null && tmpl.m_sGun.length > 0){
				gun = MunitionProxy.launcher(tmpl.m_sGun);
				gun.vehicle = this;
			}
		}
		override protected function draw():void
		{
			var bitmap:Bitmap;
			switch(_tmpl.m_sName)
			{
				case "enemyD1":bitmap = MediaSource.enemyD1;break;
				case "enemyD2":bitmap = MediaSource.enemyD2;break;
				case "enemyD3":bitmap = MediaSource.enemyD3;break;
				case "enemyD4":bitmap = MediaSource.enemyD4;break;
				case "enemyD5":bitmap = MediaSource.enemyD5;break;
				case "enemyD6":bitmap = MediaSource.enemyD6;break;
				case "enemyD7":bitmap = MediaSource.enemyD7;break;
			}
			drawDo(bitmap);
		}
		
		override public function firePoint(offset:Vector2D = null):Vector2D
		{
			return super.firePoint(new Vector2D(width, height >> 1));
		}
		/**
		 * 以监视的方式移动。
		 * 
		 */		
		override public function move():void
		{
			switch(_tmpl.m_sMove)
			{
				case "common":break;
				case "seek":seek();break;
				case "oversee":oversee();break;
				case "wander":wander();break;
				case "pursue":pursue();break;
				default:break;
			}
			super.move();
		}
	}
}