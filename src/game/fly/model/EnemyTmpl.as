package game.fly.model
{
	public class EnemyTmpl
	{
		public var m_sName:String;	//主键名字
		public var m_sMove:String;	//移动方式  SteeredMobile有注释
		public var m_nTarget:int;	//目标  0没有目标  1玩家
		public var m_nMaxSpeed:int;	//最大速率
		public var m_nMaxPalstance:int;	//最大角速率
		public var m_nMaxLif:int;	//最大生命值
		public var m_nReward:int;	//摧毁获得的奖金
		public var m_sBehavior:String;	//行为 	Mobile里有定义
		public var m_sGun:String;	//装备的武器(空为未装备武器 simple2Gun:最低级的枪 seekS2Cannon:二连发跟踪弹 s1Cannon:五连发加速弹  simplePro2Gun:十连散弹)
		public var m_sIcon:String;	//图标
		
		public function ReadXml(enemyXml:XML):EnemyTmpl
		{
			m_sName = enemyXml.attribute("name");
			m_sMove = enemyXml.attribute("move");
			m_nTarget = enemyXml.attribute("target");
			m_nMaxSpeed = enemyXml.attribute("maxSpeed");
			m_nMaxPalstance = enemyXml.attribute("maxPalstance");
			m_nMaxLif = enemyXml.attribute("maxLif");
			m_nReward = enemyXml.attribute("reward");
			m_sBehavior = enemyXml.attribute("behavior");
			m_sGun = enemyXml.attribute("gun");
			m_sIcon = enemyXml.attribute("icon");
			return this;
		}
	}
}