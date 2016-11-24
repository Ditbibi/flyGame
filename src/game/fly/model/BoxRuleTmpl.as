package game.fly.model
{
	public class BoxRuleTmpl extends RuleTmpl
	{
		public function ReadXml(data:XML):BoxRuleTmpl
		{
			this.ReadBaseXml(data);
			return this;
		}
	}
}