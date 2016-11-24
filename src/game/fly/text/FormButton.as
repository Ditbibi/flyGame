package game.fly.text
{
	import game.fly.manage.MediaSource;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	
	/**
	 * 面板其它按钮。
	 * 
	 */	
	public class FormButton extends SimpleButton
	{
		/**
		 * 返回
		 */		
		public static const RETURN_:String = "return";
		
		public function FormButton(type:String)
		{
			var upState:Bitmap;
			var overState:Bitmap;
			switch(type)
			{
				case RETURN_:
					upState = MediaSource.returnOutButton;
					overState = MediaSource.returnInButton;
					break;
			}
			super(upState, overState, overState, upState);
		}
	}
}