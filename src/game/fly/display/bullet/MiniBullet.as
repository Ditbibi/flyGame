package game.fly.display.bullet
{
	import flash.display.Bitmap;
	
	import game.fly.config.Config;
	import game.fly.config.Runtime;
	import game.fly.display.Vector2D;
	import game.fly.manage.MediaSource;
	import game.fly.manage.MunitionProxy;
	import game.fly.model.SelfTmpl;
	
	/**
	 * 小子弹，威力较小
	 * <li>伤害：1</li>
	 * <li>速度：10</li>
	 * <li>方向：直线</li>
	 * 
	 */	
	public class MiniBullet extends Bullet
	{
		private var m_sGroup:String;
		
		public function MiniBullet(typeB:String)
		{
			type = typeB;
			var selfTmpl:SelfTmpl = Config.getInstance().selfTmplList[type];
			super(null, new Vector2D(selfTmpl.m_nwSpeed, 0), null);
			
		}
		override protected function draw():void
		{
			var bitmap:Bitmap;
			var selfTmpl:SelfTmpl = Config.getInstance().selfTmplList[type];
			switch(selfTmpl.m_sName)
			{
				case "selfM1":bitmap = MediaSource.selfM1_b;break;
				case "selfM2":bitmap = MediaSource.selfM2_b;break;
				case "selfM3":bitmap = MediaSource.selfM3_b;break;
			}
			
			power = selfTmpl.m_nwPower;
			maxSpeed = selfTmpl.m_nwSpeed;
			_penetrate = selfTmpl.m_nPenetrate == 1;
			
			drawDo(bitmap);
		}
	}
}