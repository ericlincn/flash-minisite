package core
{
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	
	import flash.utils.Dictionary;
	
	import cn.daftlib.observer.INotification;
	import cn.daftlib.observer.IObserver;
	import cn.daftlib.observer.NotificationsCenter;
	
	import events.NotificationsConstants;
	
	import core.vo.Link;
	import core.vo.Section;

	public class DeeplinkManager implements IObserver
	{
		private var __baseTitle:String;
		private var __defaultDeepLink:String;
		private var __sectionMap:Dictionary=new Dictionary();
		
		// For the same section checking
		private var __currentFirstLevelDeeplink:String=null;
		// Safe lock for setSWFAddress() --> handleSWFAddressChange() delay
		private var __lock:Boolean=false;
		// For public getter
		private static var __priorFirstLevelDeeplink:String=null;
		
		public function DeeplinkManager($data:Array, $defaultDeepLink:String)
		{
			__defaultDeepLink=$defaultDeepLink;
			
			var i:uint=$data.length;
			while(i--)
			{
				var s:Section=$data[i];
				var link:Link=s.link;
				
				if(link.type==Link.DEEPLINK)
				{
					__sectionMap[link.url]=s;
				}
			}
			
			SWFAddress.addEventListener(SWFAddressEvent.INIT, initSWFAddress);
		}
		public function handlerNotification($n:INotification):void
		{
			switch($n.name)
			{
				case NotificationsConstants.LINK_CLICK:
					var url:String=$n.body.url;
					if(__sectionMap[url]) setSWFAddress(url);
					break;
			}
		}
		
		private function initSWFAddress(e:SWFAddressEvent):void
		{
			__baseTitle=SWFAddress.getTitle();
			
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, handleSWFAddressChange);
			
			if(SWFAddress.getPathNames().length<1)
				setSWFAddress(__defaultDeepLink);
		}
		private function setSWFAddress($deeplink:String):void
		{
			if(__lock==true) return;
			
			var firstLevel:String=$deeplink.split("/")[1];
			var firstLink:String="/"+firstLevel;
			
			if(__currentFirstLevelDeeplink==firstLink)
				return;
			
			__lock=true;
			
			SWFAddress.setValue($deeplink);
		}
		private function handleSWFAddressChange(e:SWFAddressEvent):void
		{
			__lock=false;
			
			var deeplink:String=e.value;
			var firstLevel:String=e.pathNames[0];
			var firstLink:String="/"+firstLevel;
			
			if(!__sectionMap[firstLink])
				return;
			
			var title:String=__sectionMap[firstLink].title;
			SWFAddress.setTitle(__baseTitle+" - "+title);
			
			__priorFirstLevelDeeplink=__currentFirstLevelDeeplink;
			__currentFirstLevelDeeplink=firstLink;
			
			var sectionData:Section=__sectionMap[firstLink];
			sectionData.priorFirstLevelDeeplink=__priorFirstLevelDeeplink;
			NotificationsCenter.sendNotification(NotificationsConstants.SECTION_UPDATE, {data:sectionData});
		}
	}
}