package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import cn.daftlib.layout.AutoFit;
	import cn.daftlib.observer.NotificationsCenter;
	
	import conf.Globe;
	
	import core.DeeplinkManager;
	import core.RightClickManager;
	import core.SectionContainer;
	
	import events.NotificationsConstants;
	
	import ui.sections.SectionSample;
	
	import utils.TrackingManager;
	
	import view.ViewUI;
	
	public class MainApplication extends Sprite
	{
		private var __vu:ViewUI;
		
		private var __sc:SectionContainer;
		
		public function MainApplication()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddStage);
		}
		private function onAddStage(e:Event):void
		{
			trace(this, "初始化");
			
			initViews();
			initNotifications();
			
			RightClickManager.initialize(this, Globe.SECTIONS_ARR);
		}
		private function initViews():void
		{
			__vu=new ViewUI();
			
			__sc=new SectionContainer();
			AutoFit.register(__sc, AutoFit.CENTER, new Point(-250, -200), 500, 400);
			__sc.registerSectionClass("SectionSample", SectionSample);
			
			this.addChild(__sc);
			this.addChild(__vu);
		}
		private function initNotifications():void
		{
			var tracking:TrackingManager=new TrackingManager(Globe.TRACKING_MAP);
			var deepLink:DeeplinkManager=new DeeplinkManager(Globe.SECTIONS_ARR, Globe.DEFAULT_SECTION_LINK);
			
			NotificationsCenter.register(NotificationsConstants.LINK_CLICK, tracking);
			NotificationsCenter.register(NotificationsConstants.LINK_CLICK, deepLink);
			
			NotificationsCenter.register(NotificationsConstants.SECTION_UPDATE, __sc);
			NotificationsCenter.register(NotificationsConstants.SECTION_UPDATE, __vu);
		}
	}
}