package game.fly.model
{
	/**
	 * 生成规则
	 */
	public class EnemyRuleTmpl extends RuleTmpl
	{
		public var m_nDirection:int;	//目标朝向
		
		public function ReadXml(data:XML):EnemyRuleTmpl
		{
			this.ReadBaseXml(data);
			m_nDirection = data.attribute("direction");
			return this;
		}
	}
}