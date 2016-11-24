package game.fly.model
{
	public class SelfTmpl
	{
		public var m_sName:String;	//主键名字(跟资源进行了绑定，不能随意修改)
		public var m_nSpeed:int;	//葫芦娃的移动速度
		public var m_nCut:int;	//被击中减少的血量 
		public var m_nwPower:int;	//葫芦娃所使用武器的威力
		public var m_nwSpeed:int;	//葫芦娃所使用武器的速度
		public var m_nwMaxStrength:int;	//葫芦娃所使用武器的单次最多发射子弹数
		public var m_nwSendTime:int;	//葫芦娃所使用武器的射速  单位毫秒 ?毫秒/次
		public var m_nPenetrate:int;	//葫芦娃所使用武器的是否能够穿透
		
		public function ReadXml(data:XML):SelfTmpl
		{
			m_sName = data.attribute("name");
			m_nSpeed = data.attribute("speed");
			m_nCut = data.attribute("cut");
			m_nwPower = data.attribute("wPower");
			m_nwSpeed = data.attribute("wSpeed");
			m_nwMaxStrength = data.attribute("wMaxStrength");
			m_nwSendTime = data.attribute("wSendTime");
			m_nPenetrate = data.attribute("wPenetrate");
			return this;
		}
	}
}