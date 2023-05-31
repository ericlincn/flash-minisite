package utils
{
	import cn.daftlib.observer.INotification;
	import cn.daftlib.observer.IObserver;
	
	import events.NotificationsConstants;

	public class TrackingManager implements IObserver
	{
		private var __data:Array;
		
		public function TrackingManager($data:Array)
		{
			__data=$data;
		}
		public function handlerNotification($n:INotification):void
		{
			switch($n.name)
			{
				case NotificationsConstants.LINK_CLICK:
					var url:String=$n.body.url;
					var i:uint=__data.length;
					while(i--)
					{
						if(__data[i].l==url)
							TrackingManager.tracking(__data[i].t);
					}
					break;
			}
		}
		public static function tracking($tag:String):void
		{
			
		}
	}
}