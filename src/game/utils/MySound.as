package game.utils
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	public class MySound
	{
		private var snd:Sound;
		private var channel:SoundChannel = new SoundChannel();
		private var soundTransform:SoundTransform = new SoundTransform;
		
		private var timer:Timer;
		private var loops:int;
		public var url:String;
		private var interval:int;
		
		private var m_volumeTimer:Timer;
		private var m_volumeLoad:Number;
		
		public function MySound()
		{
		}
		public var StopFunc:Function;
		
		private var m_volumeLoudTime:int;
		
		public function setSound( url:String, interval:int, volumeLoudTime:int):void{
			this.url = url;
			this.interval = interval;
			m_volumeLoudTime = volumeLoudTime;
			stop();
			if( snd != null){
				try{
					snd.close();
				}catch(e:Error){
					trace("sound error " + e.getStackTrace());
				}
				snd.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			}
			snd = new Sound;
			snd.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			snd.load( new URLRequest(url));			
		}
		public function play( loops:int = 0):void{
			this.loops = loops;
			if( channel != null){
				channel.removeEventListener(Event.SOUND_COMPLETE, onPlaybackComplete);
			}
			
			if( url == null) return ;
			try{
				channel = snd.play();
				
				if(timer != null && timer.running){
					timer.stop();
				}
				if( channel != null){
					channel.addEventListener(Event.SOUND_COMPLETE, onPlaybackComplete);
					if(m_volumeLoudTime > 0){
						soundTransform.volume = 0;
						channel.soundTransform = soundTransform;
						m_volumeLoad = 10 / m_volumeLoudTime;
						if(m_volumeTimer != null){
							m_volumeTimer.stop();
							m_volumeTimer.removeEventListener(TimerEvent.TIMER, OnVolumeTimer);
						}
						m_volumeTimer = new Timer(10);
						m_volumeTimer.addEventListener(TimerEvent.TIMER, OnVolumeTimer);
						m_volumeTimer.start();
					}else{
						soundTransform.volume = 1;
						channel.soundTransform = soundTransform;
						
					}
				}
			}catch(e:Error){
				trace("sound error " + e.getStackTrace());
			}
		}
		public function stop():void{
			if(timer != null && timer.running){
				timer.stop();
				timer.removeEventListener( TimerEvent.TIMER, OnTimer);
			}
			if( channel != null){
				channel.stop();
			}
		}
		private function onPlaybackComplete(event:Event):void {
			if(loops != 0){
				loops--;
				timer = new Timer( interval, 1);
				timer.addEventListener( TimerEvent.TIMER, OnTimer);
				timer.start();
			}else if( StopFunc != null){
				StopFunc();
			}
		}
		private function OnTimer( event:TimerEvent):void{
			timer.stop();
			if( channel != null){
				channel.removeEventListener(Event.SOUND_COMPLETE, onPlaybackComplete);
			}
			channel = snd.play();
			if( channel != null){
				channel.addEventListener(Event.SOUND_COMPLETE, onPlaybackComplete);
				if(m_volumeLoudTime > 0){
					soundTransform.volume = 0;
					channel.soundTransform = soundTransform;
					m_volumeLoad = 10 / m_volumeLoudTime;
					if(m_volumeTimer != null){
						m_volumeTimer.stop();
						m_volumeTimer.removeEventListener(TimerEvent.TIMER, OnVolumeTimer);
					}
					m_volumeTimer = new Timer(10);
					m_volumeTimer.addEventListener(TimerEvent.TIMER, OnVolumeTimer);
					m_volumeTimer.start();
				}else{
					soundTransform.volume = 1;
					channel.soundTransform = soundTransform;
					
				}
			}
		} 
		private function errorHandler(errorEvent:IOErrorEvent):void {
			trace( "The sound could not be loaded: " + errorEvent.text);
			//			PopUtil.PopErrorInfo("<font color='#ffffff'>音乐文件" + this.url + "不存在</font>");
		}
		
		private function OnVolumeTimer(evt:TimerEvent):void{
			if(channel != null){
				soundTransform.volume += m_volumeLoad;
				if(soundTransform.volume >= 1){
					soundTransform.volume = 1;
					channel.soundTransform = soundTransform;
					m_volumeTimer.stop();
					m_volumeTimer.removeEventListener(TimerEvent.TIMER, OnVolumeTimer);
				}else{
					channel.soundTransform = soundTransform;
				}
			}
		}
	}
}