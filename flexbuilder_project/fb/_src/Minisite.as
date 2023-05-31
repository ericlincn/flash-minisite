package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import cn.daftlib.layout.AutoFit;
	import cn.daftlib.utils.FlashVarUtil;
	import cn.daftlib.utils.StageReference;
	
	import conf.Globe;
	
	import ui.LoadingManager;
	
	[SWF(backgroundColor="#ffffff", frameRate="60")]
	public class Minisite extends Sprite
	{
		public function Minisite()
		{
			super();
			
			StageReference.initialize(this, initialize, true, true);
		}
		private function initialize():void
		{
			AutoFit.initialize(StageReference.stage);
			getFlashVars();
			initLoader();
		}
		private function getFlashVars():void
		{
			if(FlashVarUtil.hasKey("swfpath"))
				Globe.BASE_PATH=FlashVarUtil.getValue("swfpath");
		}
		private function initLoader():void
		{
			LoadingManager.init(this);
			LoadingManager.loader.addEventListener(Event.COMPLETE, loadCompleteHandler);
			LoadingManager.loader.add(Globe.MAIN_APP_URL);
			LoadingManager.loader.start();
		}
		private function loadCompleteHandler(e:Event):void
		{
			var main:DisplayObject=LoadingManager.loader.getDisplayObject(Globe.MAIN_APP_URL);
			this.addChildAt(main, 0);
			LoadingManager.clear();
		}
	}
}