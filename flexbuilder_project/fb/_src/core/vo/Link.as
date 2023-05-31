package core.vo
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import cn.daftlib.observer.NotificationsCenter;
	
	import events.NotificationsConstants;

	public class Link
	{
		public static const SELF:String="_self";
		public static const BLANK:String="_blank";
		public static const DOWNLOAD:String="download";
		public static const DEEPLINK:String="deeplink";
		
		private var __type:String;
		private var __url:String;
		
		public function Link($url:String, $type:String)
		{
			__url=$url;
			__type=$type;
		}
		public function get type():String
		{
			return __type;
		}
		public function get url():String
		{
			return __url;
		}
		public function go():void
		{
			switch(__type)
			{
				case DOWNLOAD:
					navigateToURL(new URLRequest(__url));
					NotificationsCenter.sendNotification(NotificationsConstants.LINK_CLICK, {url:__url});
					break;
				case DEEPLINK:
					NotificationsCenter.sendNotification(NotificationsConstants.LINK_CLICK, {url:__url});
					break;
				default:
					navigateToURL(new URLRequest(__url), __type);
					NotificationsCenter.sendNotification(NotificationsConstants.LINK_CLICK, {url:__url});
					break;
			}
		}
		public function toString():String
		{
			return "url:"+__url+" type:"+__type;
		}
	}
}