package game.fly.model
{
	public class RuleTmpl
	{
		public var m_nTime:int;	//每隔多久时间生成 单位 毫秒
		public var m_nStartTime:int;	//运行多久之后才开放派发事件单位 毫秒
		public var m_sName:String;	//生成的敌军
		public var m_nFromX:int;	//起始范围点(包括)
		public var m_nToX:int;	//截至范围点(不包括)
		public var m_nFromY:int;
		public var m_nToY:int;
		
		public function ReadBaseXml(data:XML):void
		{
			m_nTime = data.attribute("time") * 1000;
			m_nStartTime = data.attribute("starttime") * 1000;
			m_sName = data.attribute("name");
			m_nFromX = data.attribute("fromx");
			m_nToX = data.attribute("tox");
			m_nFromY = data.attribute("fromy");
			m_nToY = data.attribute("toy");
		}
	}
}