package view
{
	import flash.display.Sprite;
	
	import cn.daftlib.observer.INotification;
	import cn.daftlib.observer.IObserver;
	
	import conf.Globe;
	
	import core.vo.Section;
	
	import events.NotificationsConstants;
	
	import ui.components.Navigation;
	
	public class ViewUI extends Sprite implements IObserver
	{
		private var __navi:Navigation;
		
		public function ViewUI()
		{
			super();
			
			init();
		}
		
		public function handlerNotification($notification:INotification):void
		{
			switch($notification.name)
			{
				case NotificationsConstants.SECTION_UPDATE:
					var sectionData:Section=$notification.body.data;
					__navi.updateNavi(sectionData.link);
					break;
			}
		}
		private function init():void
		{
			initNavigation();
		}
		private function initNavigation():void
		{
			__navi=new Navigation(Globe.SECTIONS_ARR);
			this.addChild(__navi);
		}
	}
}