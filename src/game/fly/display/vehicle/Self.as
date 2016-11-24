package game.fly.display.vehicle
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	
	import game.fly.config.Config;
	import game.fly.config.Runtime;
	import game.fly.display.Vector2D;
	import game.fly.display.box.Box;
	import game.fly.display.launcher.Launcher;
	import game.fly.events.ActionEvent;
	import game.fly.manage.MediaSource;
	import game.fly.manage.MunitionFactory;
	import game.fly.manage.MunitionProxy;
	import game.fly.model.SelfTmpl;
	
	/**
	 * 自已人的飞机。
	 * 
	 */	
	public class Self extends Vehicle
	{
		private var runtime:Runtime = Runtime.getInstance();
		/**
		 * 当前友机装备的导弹。
		 */		
		public var gunPro:Launcher;
		
		//显示的模型
		private var m_iconBmp:Bitmap;
		
		/**
		 * 创建一个友军飞机。
		 * 
		 */		
		public function Self()
		{
			super(null, null, null);
			maxSpeed = 20;
			edgeBehavior = CLING;
			gun = MunitionProxy.launcher(MunitionFactory.SIMPLE_GUN);
			cannon = MunitionProxy.launcher(MunitionFactory.LEI_LAUNCHER);
//			gunPro = MunitionProxy.launcher(MunitionFactory.S1_CANNON);
			//打开发射声音
			gun.openSound = true;	
			//关联当前对象到发射 器
			gun.vehicle = this;
			cannon.vehicle = this;
//			gunPro.vehicle = this;
		}
		/**
		 * @private
		 */
		override public function set group(value:String):void
		{
			_group = value;
			gun.group = value;
		}
		/**
		 *  变身
		 */
		public function Henshin(tmpl:SelfTmpl):void{
			if(m_iconBmp != null && m_iconBmp.parent != null)
				m_iconBmp.parent.removeChild(m_iconBmp);
			
			maxSpeed = tmpl.m_nSpeed;
			gun.f = tmpl.m_nwSendTime;
			gun.MaxStrength = tmpl.m_nwMaxStrength;
			
			draw();
		}
		
		/**
		 * 开枪。
		 * 
		 */		
		override public function fireGun():void
		{
			if(gunPro)
				gunPro.fire();
			super.fireGun();
		}
		
		/**
		 * 停止开枪。
		 * 
		 */		
		override public function stopGun():void
		{
			if(gunPro)
				gunPro.stop();
			super.stopGun();
		}
		
		/**
		 * 子弹击中物体后更新状态
		 * 
		 */		
		override protected function collisionDo(a:DisplayObject):void
		{
			sound.play();
			// 现在中弹以后不消失
			if(!(a is Box)){
				if(this.group == MunitionProxy.G_P1){
					runtime.p1Life -= runtime.p1tmpl.m_nCut;
					if(Config.getInstance().life > 0)
						runtime.p1Life = runtime.p1Life <= 0?0:runtime.p1Life;
					if(runtime.p1Life == 0){
						parent.removeChild(this);
					}
				}else if(this.group == MunitionProxy.G_P2){
					runtime.p2Life -= runtime.p2tmpl.m_nCut;
					if(Config.getInstance().life > 0)
						runtime.p2Life = runtime.p2Life <= 0?0:runtime.p2Life;
					if(runtime.p2Life == 0){
						parent.removeChild(this);
					}
				}
			}
		}
		
		override protected function draw():void
		{
			var name:String;
			if(this.group == MunitionProxy.G_P1){
				name = runtime.p1tmpl.m_sName;
			}
			if(this.group == MunitionProxy.G_P2){
				name = runtime.p2tmpl.m_sName;
			}
			name = name == null?runtime.p1tmpl.m_sName:name;
			switch(name)
			{
				case "selfM1":m_iconBmp = MediaSource.selfM1;break;
				case "selfM2":m_iconBmp = MediaSource.selfM2;break;
				case "selfM3":m_iconBmp = MediaSource.selfM3;break;
			}
			drawDo(m_iconBmp);
			if(stage){
				this.moveSpaceMin = new Vector2D(this.width >> 1, this.height >> 1);
				this.moveSpaceMax = new Vector2D(stage.stageWidth - (this.width >> 1), stage.stageHeight - (this.height >> 1));
			}
		}
		
		override public function firePoint(offset:Vector2D = null):Vector2D
		{
			return super.firePoint(new Vector2D(width, height >> 1));
		}
		
		override protected function removeFromStage():void
		{
			if(gunPro)
			{
				gunPro.unload();
			}
			super.removeFromStage();
		}
	}
}