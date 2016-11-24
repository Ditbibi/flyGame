package game.fly.config
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import game.fly.manage.MediaSource;
	import game.fly.model.BoxRuleTmpl;
	import game.fly.model.EnemyRuleTmpl;
	import game.fly.model.EnemyTmpl;
	import game.fly.model.SelfTmpl;

	/**
	 * 游戏配置。
	 * 
	 */	
	public class Config
	{
		/**
		 * 获取config的实例
		 */
		public static function getInstance():Config
		{
			if(instance == null)
				instance = new Config();
			return instance;
		}
		
		
		private static var instance:Config;
		
		/**
		 * 葫芦娃模版数据
		 */
		public var selfTmplList:Dictionary = null;
		/**
		 * 敌军模版数据
		 */
		public var enemyTmplList:Dictionary = null;
		/**
		 * 敌军生成规则
		 */
		public var enemyRuleTmplAry:Array = null;
		/**
		 * 资源生成规则
		 */
		public var boxRuleAry:Array = null;
		
		
		public function Config(){
			if(instance != null)
				throw new Error("Error:not allow new config");
			
			selfTmplList = new Dictionary();
			enemyTmplList = new Dictionary();
			enemyRuleTmplAry = new Array();
			boxRuleAry = new Array();
			Init();
		}
		public function Init():void{
			OnXmlComplete(null);
//			var loader:URLLoader = new URLLoader(new URLRequest("flyConfig.xml"));
//			loader.dataFormat = URLLoaderDataFormat.TEXT;
//			loader.addEventListener(Event.COMPLETE,OnXmlComplete);
//			loader.addEventListener(IOErrorEvent.IO_ERROR,ErrorHandler);
			
//			var byteDataXml:ByteArray = MediaSource.flyXml;  
//			var data:XML = XML(byteDataXml.readUTFBytes(byteDataXml.bytesAvailable));
//			for each(var configXml:XML in data.child("config")){
//				life = configXml.attribute("life");
//				addLife = configXml.attribute("addlife");
//				maxLei = configXml.attribute("maxlei");
//				eatBoxName = configXml.attribute("eatboxname");
//			}
//			for each(var selfXml:XML in data.child("self")){
//				var selftmpl:SelfTmpl = new SelfTmpl().ReadXml(selfXml);
//				if(Runtime.getInstance().p1tmpl == null) Runtime.getInstance().p1tmpl = selftmpl;
//				if(Runtime.getInstance().p2tmpl == null) Runtime.getInstance().p2tmpl = selftmpl;
//				selfTmplList[selftmpl.m_sName] = selftmpl;
//			}
//			for each(var enemyXml:XML in data.child("enemy")){
//				var enemytmpl:EnemyTmpl = new EnemyTmpl().ReadXml(enemyXml);
//				enemyTmplList[enemytmpl.m_sName] = enemytmpl;
//			}
//			for each(var ruleXml:XML in data.child("enemyrule")){
//				var ruleTmpl:EnemyRuleTmpl = new EnemyRuleTmpl().ReadXml(ruleXml);
//				enemyRuleTmplAry.push(ruleTmpl);
//			}
//			for each(var boxruleXml:XML in data.child("boxrule")){
//				var boxRuletmpl:BoxRuleTmpl = new BoxRuleTmpl().ReadXml(boxruleXml);
//				boxRuleAry.push(boxRuletmpl);
//			}
		}
		/**
		 * xml下载完成
		 */
		private function OnXmlComplete(evt:Event):void{
//			var loader:URLLoader = URLLoader(evt.target);
//			loader.removeEventListener(Event.COMPLETE,OnXmlComplete);
//			loader.removeEventListener(IOErrorEvent.IO_ERROR,ErrorHandler);
//			var data:XML = XML(loader.data);
			var data:XML = XML(MediaSource.flyXml);
			for each(var configXml:XML in data.child("config")){
				life = configXml.attribute("life");
				addLife = configXml.attribute("addlife");
				maxLei = configXml.attribute("maxlei");
				eatBoxName = configXml.attribute("eatboxname");
			}
			for each(var selfXml:XML in data.child("self")){
				var selftmpl:SelfTmpl = new SelfTmpl().ReadXml(selfXml);
				if(Runtime.getInstance().p1tmpl == null) Runtime.getInstance().p1tmpl = selftmpl;
				if(Runtime.getInstance().p2tmpl == null) Runtime.getInstance().p2tmpl = selftmpl;
				selfTmplList[selftmpl.m_sName] = selftmpl;
			}
			for each(var enemyXml:XML in data.child("enemy")){
				var enemytmpl:EnemyTmpl = new EnemyTmpl().ReadXml(enemyXml);
				enemyTmplList[enemytmpl.m_sName] = enemytmpl;
			}
			for each(var ruleXml:XML in data.child("enemyrule")){
				var ruleTmpl:EnemyRuleTmpl = new EnemyRuleTmpl().ReadXml(ruleXml);
				enemyRuleTmplAry.push(ruleTmpl);
			}
			for each(var boxruleXml:XML in data.child("boxrule")){
				var boxRuletmpl:BoxRuleTmpl = new BoxRuleTmpl().ReadXml(boxruleXml);
				boxRuleAry.push(boxRuletmpl);
			}
		}
		/**
		 * 下载失败
		 */
		private function ErrorHandler(errorEvent:IOErrorEvent):void{
			trace( "The xml could not be loaded: " + errorEvent.text);
		}
		
		/**
		 * 宽
		 */
		public static const Width:int = 1280;
		/**
		 * 高
		 */
		public static const Hight:int = 700;
		
		/**
		 * 计分模式，不分关。
		 */		
		public static const SCORING:String = "scoring";
		/**
		 * 闯关模式。
		 */		
		public static const PART:String = "part";
		
		public var p1Up:uint = 87;// 玩家1：上（默认“w”）
		public var p1Down:uint = 83;//玩家1：下（默认方向键“s”）。
		public var p1Left:uint = 65;//玩家1：左（默认方向键“a”）。
		public var p1Right:uint = 68;//玩家1：右（默认方向键“d”）。
		public var p1A:uint = 74;//玩家1：枪（默认“j”）。
		public var p1B:uint = 75;//玩家1：炮（默认“k”）。
		public var p1Henshin1:uint = 85;//玩家1：大娃变身（默认“u”）
		public var p1Henshin2:uint = 73;//玩家1：二娃变身（默认“i”）
		public var p1Henshin3:uint = 79;//玩家1：三娃变身（默认“o”）
		
		
		public var p2Up:uint = 38;//玩家2：上（默认方向键“上”）。
		public var p2Down:uint = 40;//玩家2：下（默认“下”）。
		public var p2Left:uint = 37;//玩家2：左（默认“左”）。
		public var p2Right:uint = 39;//玩家2：右（默认“右”）。
		public var p2A:uint = 49;//玩家2：枪（默认“大键盘1”）。
		public var p2B:uint = 50;//玩家2：炮（默认“大键盘2”）。
		public var p2Henshin1:uint = 85;//玩家2：大娃变身（默认“u”）
		public var p2Henshin2:uint = 73;//玩家2：二娃变身（默认“i”）
		public var p2Henshin3:uint = 79;//玩家2：三娃变身（默认“o”）
		
		/**
		 * 玩家生命数。
		 */		
		public var life:int = 100;
		
		/**
		 * 玩家回血增加的生命数
		 */
		public var addLife:int = 5;
		/**
		 * 携带的最大雷量
		 */
		public var maxLei:int = 10;
		/**
		 * 可以吃道具的葫芦娃名字
		 */
		public var eatBoxName:String;
		
		/**
		 * 游戏模式，默认SCORING（计分模式）
		 */		
		public var mode:String = SCORING;
		
		/**
		 * 大娃名字
		 */
		public static const SelfM1:String = "selfM1";
		/**
		 * 二娃名字
		 */
		public static const SelfM2:String = "selfM2";
		/**
		 * 三娃名字
		 */
		public static const SelfM3:String = "selfM3";
		
	}
}