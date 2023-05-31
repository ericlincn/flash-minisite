package utils
{
	import cn.daftlib.utils.JavascriptUtil;
	
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Capabilities;

	public class ShareUtil
	{
		public static function shareTo($targetMedia:String):void
		{
			trace(ShareUtil, "shareTo: "+$targetMedia);
			
			var pageTitle:String=JavascriptUtil.getPageTitle();
			var pageURL:String=JavascriptUtil.getPageURL();
			
			pageTitle=encodeURIComponent(pageTitle);
			pageURL=encodeURIComponent(pageURL);
			
			switch($targetMedia)
			{
				case "sina":
					shareToSina("", pageURL);
					break;
				case "renren":
					shareToRenren("", pageURL);
					break;
				case "kaixin":
					shareToKaixin("", pageURL);
					break;
				case "tencent":
					shareToTencent("", pageURL);
					break;
				case "douban":
					shareToDouban("", pageURL);
					break;
			}
		}
		private static function shareToSina($message:String, $pageURL:String, $picURL:String=""):void
		{
			var screenW:Number=Capabilities.screenResolutionX;
			var screenH:Number=Capabilities.screenResolutionY;
			var f:String='http://v.t.sina.com.cn/share/share.php?';
			var c:String='页面编码gb2312|utf-8默认gb2312';
			var p:String=['url=',$pageURL,'&title=',$message,'&source=','','&sourceUrl=','','&content=',c||'gb2312','&pic=',$picURL].join('');
			ExternalInterface.call("window.open", [f,p].join(''),'Share to sina',['toolbar=0,status=0,resizable=1,width=440,height=430,left=',(screenW-440)/2,',top=',(screenH-430)/2].join(''));
		}
		private static function shareToRenren($message:String, $pageURL:String, $picURL:String=""):void
		{
			var f:String="http://share.renren.com/share/buttonshare/post/4001?";
			var r:URLRequest = new URLRequest(
				f+"url="+$pageURL+"&title="+$message+"&content=&pic="+$picURL);
			navigateToURL( r, "_blank" );
		}
		private static function shareToKaixin($message:String, $pageURL:String, $picURL:String=""):void
		{
			var f:String="http://www.kaixin001.com/~repaste/repaste.php?";
			var p:String=['rurl=',$pageURL,'&rtitle=',$message].join('');
			ExternalInterface.call("window.open", [f,p].join(''),'Share to kaixin');
		}
		private static function shareToTencent($message:String, $pageURL:String, $picURL:String=""):void
		{
			var f:String="http://v.t.qq.com/share/share.php?";
			var r:URLRequest = new URLRequest(
				f+"url="+$pageURL+"&appkey="+"shitface"+"&site="+$pageURL+"&pic="+$picURL+"&title="+$message );
			navigateToURL( r, "_blank" );
		}
		private static function shareToDouban($message:String, $pageURL:String, $picURL:String=""):void
		{
			var f:String="http://www.douban.com/recommend/?";
			ExternalInterface.call("window.open", f+'url='+$pageURL+'& title='+$message, 'Share to douban');
		}
	}
}