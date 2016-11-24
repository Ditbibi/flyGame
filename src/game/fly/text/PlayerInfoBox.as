package game.fly.text
{
	import game.fly.manage.MediaSource;
	import game.utils.DisplayUtil;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	
	/**
	 * 玩家信息显示框。
	 * 
	 */	
	public class PlayerInfoBox extends Sprite
	{
		private var lifeBox:Sprite;
		private var scoreBox:TextField;
		private var lastLife:int = 0;
		private var lastScore:int = 0;
		
		/**
		 * 玩家信息显示框。
		 * @param n 玩家编号（1，2 ……）
		 * 
		 */		
		public function PlayerInfoBox(n:uint, life:int = 0)
		{
			if(n == 1)
			{
				var name1:Bitmap = MediaSource.p1Name;
				name1.y = 2;
				addChild(name1);
			}
			else if(n == 2)
			{
				var name2:Bitmap = MediaSource.p2Name;
				name2.y = 2;
				addChild(name2);
			}
			
			lifeBox = new Sprite();
			lifeBox.x = 45;
			
			scoreBox = new TextField();
			scoreBox.x = 165;
			scoreBox.y = -5;
			var scoreStyle:StyleSheet = new StyleSheet();
			var styles:Object = new Object();
			styles.fontSize = 22;
			styles.fontFamily = "Verdana, Arial, Helvetica, sans-serif";
			scoreStyle.setStyle(".score", styles);
			scoreBox.styleSheet  = scoreStyle;
			scoreBox.htmlText = "<span class = 'score'>0</span>";
			
			addChild(lifeBox);
			addChild(scoreBox);
			
			updateLife(life);
		}
		
		/**
		 * 更新剩余生命。
		 * @param n
		 * 
		 */		
		public function updateLife(n:int):void
		{
			if(n != lastLife)
			{
				DisplayUtil.clearContainer(lifeBox);
				if(n < 0)
					lifeBox.addChild(MediaSource.unlimite);
				else if(n < 5)
				{
					for(var i:int = 0; i < n; i++)
					{
						var ico:Bitmap = MediaSource.life;
						ico.x = i * 30;
						lifeBox.addChild(ico);
					}
				}
				else
				{
					var text:TextField = new TextField();
					var textStyle:StyleSheet = new StyleSheet();
					var styles:Object = new Object();
					styles.fontSize = 22;
					styles.fontFamily = "Verdana, Arial, Helvetica, sans-serif";
					textStyle.setStyle(".text", styles);
					text.styleSheet  = textStyle;
					text.htmlText = "<span class = 'text'>x" + n + "</span>";
					text.y = -5;
					lifeBox.addChild(text);
				}
				lastLife = n;
			}
		}
		
		/**
		 * 更新积分。
		 * @param s 分值
		 * 
		 */		
		public function updateScore(s:int):void
		{
			if(s != lastScore)
			{
				scoreBox.htmlText = "<span class = 'score'>" + s + "</span>";
				lastScore = s;
			}
		}
	}
}