package
{
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.display.Graphics;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    
    import game.fly.config.Config;
    import game.fly.config.ConfigManager;
    import game.fly.config.Runtime;
    import game.fly.events.ActionEvent;
    import game.fly.manage.GameDispatcher;
    import game.fly.manage.MediaSource;
    import game.fly.manage.VehicleDispatcher;
    import game.fly.text.FormButton;
    import game.fly.text.HelpInfo;
    import game.fly.text.PauseButton;
    import game.fly.text.WelcomeButton;
    import game.utils.MySound;
    
//    [SWF(width=700, height=500, frameRate=45, backgroundColor=0x000000)]
    [SWF(width=1280, height=700, frameRate=45, backgroundColor=0x000000)]
    public class fly extends Sprite
    {
        private var runtime:Runtime = Runtime.getInstance();				    //运行时
        private var config:Config = Config.getInstance();					    //配置项
        private var gd:GameDispatcher = GameDispatcher.getInstance();		    //游戏调度器
        private var vd:VehicleDispatcher = VehicleDispatcher.getInstance();	//飞机调度器
        private var stag:Stage;					                            //舞台
        private var gameSpace:Sprite;			                                //游戏容器	
        private var configSpace:Sprite;			                            //配置面板	
        private var helpSpace:Sprite;			                                //帮助面板
        private var pauseSpace:Sprite;			                                //暂停面板
        private var gameOverSpace:Sprite;		                                //gameOver面板
        
        public function fly()
        {
            stage.scaleMode = StageScaleMode.EXACT_FIT;
//            stage.scaleMode = StageScaleMode.NO_BORDER;
//            stage.scaleMode = StageScaleMode.NO_SCALE;
            init();
        }
        
        /**
         * 初始化Flash环境
         * 
         */		
        private function init():void
        {
            //关联舞台
            runtime.stage = stage;
            stag = stage;
            //游戏模式
            runtime.mode = config.mode;
            //初始化游戏容器
            initGameSpace();
            //初始化配置面板
            initConfigSpace();
            //初始化帮助面板
            initHelpSpace();
            //初始化暂停面板
            initPauseSpace();
            //初始化gameOver面板
            initGameOverSpace();
            //初始化主菜单
            initMain();
            //添加gameOver事件监听
            var gameOverAction:Function = function(e:ActionEvent):void
            {
                stag.setChildIndex(gameOverSpace, stag.numChildren - 1);
            };
            vd.addEventListener(ActionEvent.GAME_OVER, gameOverAction);
            //添加ESC事件监听
            var escAction:Function = function(e:KeyboardEvent):void
            {
                if(e.keyCode != 27)
                    return;
                var o:DisplayObject = stag.getChildAt(stag.numChildren - 1);
                if(o == gameSpace)
                {
                    gd.stop();
                    stag.setChildIndex(pauseSpace, stag.numChildren - 1);
                }else if(o == configSpace){
                    stag.setChildIndex(o, 0);
					ConfigManager.Focus_Allow = false;
				}else if(o == helpSpace){
                    stag.setChildIndex(o, 0);
				}
            };
            stag.addEventListener(KeyboardEvent.KEY_UP, escAction);
			
			stage.addEventListener(Event.RESIZE, onResize);
			onResize(null);
			
			var tmpSnd:MySound = new MySound();
			tmpSnd.setSound("music.mp3", 0, 0);
			tmpSnd.play();
        }
		/**
		 * @brief：处理居中
		 */
		private function onResize(evt:Event):void{
			if(stage == null)return;
//			this.scrollRect = new Rectangle(0,0,stage.stageWidth, stage.stageHeight);
//			graphics.clear();
//			graphics.beginFill(0);
//			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
//			graphics.endFill();
//			gameSpace.x = stage.stageWidth/2 - 700/2;
//			gameSpace.y = stage.stageHeight/2 - 500/2;
		}
        
        /**
         * 初始化游戏空间。
         * 
         */		
        private function initGameSpace():void
        {
            gameSpace = new Sprite();
            var g:Graphics = gameSpace.graphics;
            g.beginFill(0xEBEEF5);
            g.lineTo(stag.stageWidth, 0);
            g.lineTo(stag.stageWidth, stag.stageHeight);
            g.lineTo(0, stag.stageHeight);
            g.endFill();
            
            var space:Sprite = new Sprite();
            runtime.space = space;
            gameSpace.addChildAt(space, 0);
            
            var infoSapce:Sprite = new Sprite();
            runtime.infoSpace = infoSapce;
            gameSpace.addChild(infoSapce);
            
            stag.addChildAt(gameSpace, 0);
			
//			gameSpace.addChild( new MapStatsDisplay());
        }
        
        /**
         * 初始化配置面板。
         * 
         */		
        private function initConfigSpace():void
        {
            var space:Sprite = new Sprite();
            var g:Graphics = space.graphics;
            drawBack(space.graphics);
            
            configSpace = space;
            runtime.confgSpace = space;
            stag.addChildAt(space, 0);
            
            //添加配置表单
            var cm:ConfigManager = new ConfigManager();
            configSpace.addChild(cm.getForm());
			
			ConfigManager.Focus_Allow = false;
            
            //注册返回按钮单击事件
            var returnBn:FormButton = new FormButton(FormButton.RETURN_);
            returnBn.x = 520;
            returnBn.y = 400;
            var clickAction:Function = function(e:MouseEvent):void
            {
                stag.setChildIndex(configSpace, 0);
				ConfigManager.Focus_Allow = false;
            }
            returnBn.addEventListener(MouseEvent.CLICK, clickAction);
            configSpace.addChild(returnBn);
        }
        
        /**
         * 初始化暂停面板。
         * 
         */		
        private function initPauseSpace():void
        {
            //绘制背景
            var space:Sprite = new Sprite();
            drawBack(space.graphics, 0x222222, 0.8);
            pauseSpace = space;
            stag.addChildAt(space, 0);
            
            //创建按钮
            var returnGameBn:PauseButton = new PauseButton(PauseButton.RETURN_GAME);
            var gameConfigBn:PauseButton = new PauseButton(PauseButton.GAME_CONFIG);
            var returnMainBn:PauseButton = new PauseButton(PauseButton.RETURN_MAIN);
            var lookHelpBn:PauseButton = new PauseButton(PauseButton.LOOK_HELP);
            returnGameBn.x = (stag.stageWidth - returnGameBn.width) / 2;
            gameConfigBn.x = (stag.stageWidth - gameConfigBn.width) / 2;
            returnMainBn.x = (stag.stageWidth - returnMainBn.width) / 2;
            lookHelpBn.x = (stag.stageWidth - lookHelpBn.width) / 2;
            returnGameBn.y = stag.stageHeight / 2 - 76;
            gameConfigBn.y = stag.stageHeight / 2 - 38;
            returnMainBn.y = stag.stageHeight / 2;
            lookHelpBn.y = stag.stageHeight / 2 + 38;
            
            space.addChild(returnGameBn);
            space.addChild(gameConfigBn);
            space.addChild(returnMainBn);
            space.addChild(lookHelpBn);
            
            //注册事件
            var _this:DisplayObject = this;
            var rgAction:Function = function(e:MouseEvent):void
            {
                stag.setChildIndex(gameSpace, stag.numChildren - 1);
                gd.start();
            }
            var gcAction:Function = function(e:MouseEvent):void
            {
				ConfigManager.Focus_Allow = true;
                stag.setChildIndex(configSpace, stag.numChildren - 1);
            }
            var rmAction:Function = function(e:MouseEvent):void
            {
                stag.setChildIndex(_this, stag.numChildren - 1);
            }
            var lhAction:Function = function(e:MouseEvent):void
            {
                stag.setChildIndex(helpSpace, stag.numChildren - 1);
            }
            returnGameBn.addEventListener(MouseEvent.CLICK, rgAction);
            gameConfigBn.addEventListener(MouseEvent.CLICK, gcAction);
            returnMainBn.addEventListener(MouseEvent.CLICK, rmAction);
            lookHelpBn.addEventListener(MouseEvent.CLICK, lhAction);
        }
        
        /**
         * 初始化游戏结束面板。
         * 
         */		
        private function initGameOverSpace():void
        {
            var space:Sprite = new Sprite();
            drawBack(space.graphics, 0x222222, 0.8);
            gameOverSpace = space;
            stag.addChildAt(space, 0);
            
            //创建按钮
            var gameOver:Bitmap = MediaSource.gameOver;
            var returnMainBn:PauseButton = new PauseButton(PauseButton.RETURN_MAIN);
            gameOver.x = (stag.stageWidth - gameOver.width) / 2;
            returnMainBn.x = (stag.stageWidth - returnMainBn.width) / 2;
            gameOver.y = 200;
            returnMainBn.y = stag.stageHeight / 2;
            space.addChild(gameOver);
            space.addChild(returnMainBn);
            
            //注册事件
            var _this:DisplayObject = this;
            var rmAction:Function = function(e:MouseEvent):void
            {
                stag.setChildIndex(_this, stag.numChildren - 1);
            }
            returnMainBn.addEventListener(MouseEvent.CLICK, rmAction);
        }
        
        /**
         * 初始化帮助面板。
         * 
         */		
        private function initHelpSpace():void
        {
            var space:Sprite = new Sprite();
            drawBack(space.graphics);
            helpSpace = space;
            stag.addChildAt(space, 0);
            
            var info:HelpInfo = new HelpInfo();
            info.x = 300;
            info.y = 20;
            helpSpace.addChild(info);
            //注册返回按钮单击事件
            var clickAction:Function = function(e:MouseEvent):void
            {
                stag.setChildIndex(helpSpace, 0);
            }
            info.returnBn.addEventListener(MouseEvent.CLICK, clickAction);
        }
        
        /**
         * 初始化主菜单。
         * 
         */		
        private function initMain():void
        {
            var onePlayerBn:WelcomeButton = new WelcomeButton(WelcomeButton.ONE_PLAYER);
            var twoPlayerBn:WelcomeButton = new WelcomeButton(WelcomeButton.TWO_PLAYER);
            var configBn:WelcomeButton = new WelcomeButton(WelcomeButton.CONFIG);
            var helpBn:WelcomeButton = new WelcomeButton(WelcomeButton.HELP);
            onePlayerBn.x = 925;
            twoPlayerBn.x = onePlayerBn.x;
            configBn.x = onePlayerBn.x;
            helpBn.x = onePlayerBn.x;
            onePlayerBn.y = 232;
            twoPlayerBn.y = 270;
            configBn.y = 308;
            helpBn.y = 346;
            
            addChildAt(MediaSource.main, 0);
            addChild(onePlayerBn);
            addChild(twoPlayerBn);
            addChild(configBn);
            addChild(helpBn);
            
            //注册事件
            var startAction1:Function = function(e:MouseEvent):void
            {
                runtime.player = 1;
                stag.setChildIndex(gameSpace, stag.numChildren - 1);
                gd.run();
            }
            var startAction2:Function = function(e:MouseEvent):void
            {
                runtime.player = 2;
                stag.setChildIndex(gameSpace, stag.numChildren - 1);
                gd.run();
            }
            var configAction:Function = function(e:MouseEvent):void
            {
				ConfigManager.Focus_Allow = true;
                stag.setChildIndex(configSpace, stag.numChildren - 1);
            }
            var helpAction:Function = function(e:MouseEvent):void
            {
                stag.setChildIndex(helpSpace, stag.numChildren - 1);
            }
            onePlayerBn.addEventListener(MouseEvent.CLICK, startAction1);
            twoPlayerBn.addEventListener(MouseEvent.CLICK, startAction2);
            configBn.addEventListener(MouseEvent.CLICK, configAction);
            helpBn.addEventListener(MouseEvent.CLICK, helpAction);
        }
        
        /**
         * 画半透明黑色背景。
         * @param g Graphics对象
         * 
         */		
        private function drawBack(g:Graphics, color:uint = 0xFFFFFF, alpha:Number = 1.0):void
        {
            g.beginFill(color, alpha);
            g.lineTo(stag.stageWidth, 0);
            g.lineTo(stag.stageWidth, stag.stageHeight);
            g.lineTo(0, stag.stageHeight);
            g.endFill();
        }
    }
}