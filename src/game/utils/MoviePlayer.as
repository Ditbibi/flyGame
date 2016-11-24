package game.utils
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.utils.getTimer;

	/**
	 * @brief: 动画播放类
	 */
	public class MoviePlayer extends Sprite{
		// 当前正在播放的动画
		private var m_mcCurrent:MovieClip;
		
		// 资源导出类名
		private var m_sClsName:String;
		public function get movieClassName():String{
			return m_sClsName;
		}
		private static var m_updateTime:int;		
		private var m_curUpdateTime:int;
		// 动画播放帧率
		private var m_nFarmeRate:int = 25;
		// 循环帧
		private var m_nFrameLoopStart:int;
		private var m_nFrameLoopEnd:int;
		// 回调函数
		private var m_endFunc:Function;
		
		// ----------------- 播放动画相关 -------------------
		// 上一帧的时间
		private var m_nLastFrameTime:int = 0;
		// 当前播放到哪一帧
		private var m_nCurrentFrame:Number;
		public function get currentFrame():Number{
			return m_nCurrentFrame;
		}
		public function set currentFrame(val:Number):void{
			m_nCurrentFrame = val;
		}
		// 当前次数
		private var m_nTimes:int = 0;
		public function get times():int{
			return m_nTimes;
		}
		public function set times(val:int):void{
			m_nTimes = val;
		}
		// 停顿时间
		private var m_nPauseTime:int;
		// 播放结束后是否删除
		private var m_endClear:Boolean;
		
		public function MoviePlayer(endClear:Boolean = true)
		{
			m_endClear = endClear;
			mouseChildren = mouseEnabled = false;
		}
		/**
		 * @brief：清理函数  
		 */
		private function OnClear():void{
			if(null != m_mcCurrent){
				this.removeEventListener(Event.ENTER_FRAME, OnFrame);
				removeChild(m_mcCurrent);
				m_mcCurrent.stop();
				m_mcCurrent = null;
			}
		}
		
		/**
		 * @brief: 设置创建动画 
		 * @param: movie
		 * @param：clsName 动画名称
		 * @param：playTimes -1 无限播放 0不播放，外部控制 >0 播放次数
		 * @param：endHandler playTimes>0 播放完成后的回调
		 */
		public function SetMovie(movie:MovieClip,clsName:String, playTimes:int = -1, func:Function = null):void{
			m_sClsName = clsName;
			m_nTimes = playTimes;
			m_endFunc = func;
			// 获取资源
			OnClear();
			// 下载资源
			if(null != m_sClsName && m_sClsName.length > 0){
				if(!ApplicationDomain.currentDomain.hasDefinition(m_sClsName)){
					
				}else{
					var cls:Class = ApplicationDomain.currentDomain.getDefinition(clsName) as Class;
					if(cls != null){
						m_mcCurrent = new cls() as MovieClip;
					}
				}
			}else{
			}
			m_mcCurrent = m_mcCurrent == null?movie:m_mcCurrent;
			addChild(m_mcCurrent);
			// 设置不接受鼠标事件
			m_mcCurrent.mouseChildren = m_mcCurrent.mouseEnabled = false;
			if(0 != m_nTimes){// < 表示不用播放，由外部控制
				// 获取一下开始时间
				m_nLastFrameTime = getTimer();
				m_nCurrentFrame = 1;
				this.addEventListener(Event.ENTER_FRAME, OnFrame);
				// 开始播放
				m_mcCurrent.gotoAndStop(m_nCurrentFrame);
			}
		}
		/**
		 * @brief: 设置动画侦速率
		 * */
		private function OnFrame(evt:Event):void{
			if(0 == m_nTimes){
				return;
			}
			// 判断循环的初始位置，
			var loopAmt:int = m_nFrameLoopEnd - m_nFrameLoopStart;
			var loopStart:int = m_nFrameLoopStart;
			if(loopAmt < 0 || m_nFrameLoopStart < 1 || m_nFrameLoopEnd > m_mcCurrent.totalFrames){
				loopAmt = m_mcCurrent.totalFrames;
				loopStart = 1;
			}
			
			var curTime:int = getTimer();
			if(curTime > m_updateTime){
				m_updateTime += 50;
			}
			if(m_curUpdateTime >= m_updateTime){
				return;
			}
			
			var daltaTime:int = curTime - m_nLastFrameTime;
			m_nLastFrameTime = curTime;
			// 时间递增
			m_nCurrentFrame += Number( daltaTime * m_nFarmeRate / 1000);
			// 记录当前时间
			if(0 == loopAmt){
				m_nCurrentFrame = 0;
				if(m_nTimes != -1 && m_nTimes != 0){
					m_nTimes = 0;
				}
			}else if(m_nCurrentFrame >= loopAmt){
				m_nCurrentFrame -= loopAmt;
				m_nTimes += m_nTimes == -1 ? 0 : -1;
			}
			// 判断是否需要停止
			if(0 == m_nTimes){
				if(m_endClear){
					OnClear();
				}
				if(null != m_endFunc){
					m_endFunc();
				}
				return;
			}
			//  设置播放到某一帧
			var curF:int = (loopAmt > 0 ? (int(m_nCurrentFrame) % loopAmt) : 0) + loopStart;
			m_mcCurrent.gotoAndStop(curF);
			m_curUpdateTime = m_updateTime;
			
		}
	}
}