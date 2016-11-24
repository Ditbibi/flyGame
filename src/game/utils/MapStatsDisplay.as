package game.utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;

	public class MapStatsDisplay extends Sprite
	{
		private const UPDATE_INTERVAL:Number = 0.5;
		
		private var mTextField:TextField;
		
		private var mFrameCount:int = 0;
		private var mTotleTime:Number = 0;
		private var mUpdateTime:int = 0;
		
		private var mFps:Number = 0;
		
		private var mAvgFpsCount:Number = 0;
		private var mAvgFpsAry:Array = [];
		private var mAvgFps:Number = 0;
		
		private var mMemory:Number = 0;
		private var mDrawCount:int = 0;
		private var mLoadSpeed:uint = 0;
		
		public function MapStatsDisplay()
		{
			super();
			
			this.mouseChildren = this.mouseEnabled = false;
			addChild(mTextField = new TextField());
			
			var format:TextFormat = new TextFormat("Verdana", 9, 0xffffff, null, null, null, null, null, null, 0, 0, 0, -1);
			format.letterSpacing = -1;
			mTextField.defaultTextFormat = format;
			mTextField.y = -1;
			mTextField.width = 60;
			mTextField.height = 60;
			
			graphics.clear();
			graphics.beginFill(0);
			graphics.drawRect(0, 0, mTextField.width, mTextField.height);
			graphics.endFill();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
		}
		private function onAddedToStage(evt:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			mFrameCount = 0;
			mUpdateTime = getTimer();
			update();
		}
		private function onRemovedFromStage(evt:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void
		{
			mFrameCount++;
			
			mTotleTime = (getTimer() - mUpdateTime) / 1000;
			if (mTotleTime > UPDATE_INTERVAL)
			{
				update();
				mFrameCount = 0;
				mUpdateTime = getTimer();
			}
		}
		
		/** Updates the displayed values. */
		public function update():void
		{
			mFps = mTotleTime > 0 ? mFrameCount / mTotleTime : 0;
			mMemory = System.totalMemory * 0.000000954; // 1.0 / (1024*1024) to convert to MB
//			mLoadSpeed = ResByteLoader.loadSpeed;
			
			mTextField.text = "FPS: " + mFps.toFixed(mFps < 100 ? 1 : 0) + 
				"\nMEM: " + mMemory.toFixed(mMemory < 100 ? 1 : 0);
//				"\nMOD: " + (MapStarling.isSoftware ? "Soft" : "Hard") + 
//				"\nTEX: " + Texture.m_textureList.length
//				"\nSPD: " + (mLoadSpeed > 1024 ? (int(mLoadSpeed/1024)+"k") : (mLoadSpeed+"b"));  
			
			mAvgFpsCount += mFps;
			mAvgFpsAry.push(mFps);
			if(mAvgFpsAry.length > 10){
				mAvgFpsCount -= mAvgFpsAry.shift();
			}
			mAvgFps = mAvgFpsCount / mAvgFpsAry.length;
		}
	}
}