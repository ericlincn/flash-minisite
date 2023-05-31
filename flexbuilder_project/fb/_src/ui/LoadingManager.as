package ui
{
	import flash.display.Sprite;
	
	import cn.daftlib.events.LoadEvent;
	import cn.daftlib.layout.AutoFit;
	import cn.daftlib.load.MultiLoader;
	import cn.daftlib.ui.components.SimpleLoading;

	public class LoadingManager
	{
		private static var __loader:MultiLoader;
		private static var __appContainer:Sprite;
		private static var __loading:SimpleLoading;
		
		public static function init($appContainer:Sprite):void
		{
			__appContainer=$appContainer;
			
			__loader=new MultiLoader();
			__loader.addEventListener(LoadEvent.START, loadStartHandler);
			__loader.addEventListener(LoadEvent.PROGRESS, loadProgressHandler);
			
			__loading=new SimpleLoading();
			__loading.color=0x222222;
			__loading.visible=false;
			AutoFit.register(__loading, AutoFit.CENTER);
		}
		public static function get loader():MultiLoader
		{
			return __loader;
		}
		public static function clear():void
		{
			__loader.clear();
			__loading.visible=false;
		}
		private static function loadStartHandler(e:LoadEvent):void
		{
			__loading.visible=true;
			__loading.progress="0%";
			__appContainer.addChild(__loading);
		}
		private static function loadProgressHandler(e:LoadEvent):void
		{
			var percent:Number=Math.floor(e.percent*100);
			__loading.progress=percent+"%";
			
			if(percent>99)
				__loading.visible=false;
		}
	}
}