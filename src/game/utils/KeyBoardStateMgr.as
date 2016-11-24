package game.utils
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;

	/**
	 * @brief：键盘按键信息管理
	 * 主要是键盘按下后，会一直收到按下的键盘事件，太烦了
	 */
	public class KeyBoardStateMgr
	{
		// 监听的场景
		private var m_listenStage:Stage;
		// 变化后的回调函数
		private var m_changeFunc:Function;
		// 关注的键信息
		private var m_keyList:Dictionary = new Dictionary;
		
		/**
		 * @brief：初始化函数
		 * @param：stage 监听的场景
		 */	
		public function Init(stage:Stage, changeFunc:Function):void{
			m_listenStage = stage;
			m_changeFunc = changeFunc;
			
			// 监听消息
			m_listenStage.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown);
			m_listenStage.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp);
			
//			m_listenStage.addEventListener(Event.ACTIVATE, OutFocusAction);
//			m_listenStage.addEventListener(FocusEvent.FOCUS_OUT, OutFocusAction);
		}
		/**
		 * 失去焦点事件
		 */
		private function OutFocusAction(evt:Event):void{
			for each(var key:uint in m_keyList){
				m_keyList[key] = false;
			}
			if(null != m_changeFunc){
				m_changeFunc();
			}
		}
		
		/**
		 * @brief：清理函数
		 */		
		public function Clear():void{
			m_keyList = new Dictionary;
			if(null != m_listenStage){
				m_listenStage.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown);
				m_listenStage.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp);
				m_listenStage = null;
			}
		}
		
		/**
		 * @brief：设置关注的键值
		 * @param：keyCode 键值
		 */		
		public function SetCareKey(keyCode:int):void{
			if(null == m_keyList[keyCode]){
				m_keyList[keyCode] = false;
			}
		}
		
		/**
		 * @brief：获得按键状态
		 * @param：keyCode 键值
		 * @return 返回按键是否按下
		 */		
		public function GetKeyState(keyCode:int):Boolean{
			return m_keyList[keyCode];
		}
		
		/**
		 * @brief：键盘按钮按下 
		 * @param：evt 键盘事件
		 */		
		private function OnKeyDown(evt:KeyboardEvent):void{
			var sta:Object = m_keyList[evt.keyCode];
			if(null != sta && sta != true){
				m_keyList[evt.keyCode] = true;
				if(null != m_changeFunc){
					m_changeFunc();
				}
			}
		}
		
		/**
		 * @brief：键盘按钮放开
		 * @param：evt 键盘事件
		 */		
		private function OnKeyUp(evt:KeyboardEvent):void{
			var sta:Object = m_keyList[evt.keyCode];
			if(null != sta && sta != false){
				m_keyList[evt.keyCode] = false;
				if(null != m_changeFunc){
					m_changeFunc();
				}
			}
		}
	}
}