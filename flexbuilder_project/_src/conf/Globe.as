package conf
{
	import core.vo.Link;
	import core.vo.Section;

	public class Globe
	{
		// path related
		private static var __basePath:String="";
		public static function set BASE_PATH($path:String):void
		{
			__basePath=$path;
		}
		public static function get MAIN_APP_URL():String
		{
			return __basePath+"mainapplication.swf";
		}
		
		// section related
		public static const DEFAULT_SECTION_LINK:String="/home";
		
		public static const SECTIONS_ARR:Array=[
			new Section("home",		new Link("/home", Link.DEEPLINK),	"SectionSample",	null),
			new Section("1930's",	new Link("/1930", Link.DEEPLINK),	"SectionSample",	["stuff/test.swf"]),
			new Section("products",	new Link("products.html", Link.BLANK),	null,	null),
			new Section("1950's",	new Link("/1950", Link.DEEPLINK),	"SectionSample",	["stuff/test.swf"]),
			new Section("1960's",	new Link("/1960", Link.DEEPLINK),	"SectionSample",	["stuff/test.swf"]),
			new Section("1970's",	new Link("/1970", Link.DEEPLINK),	"SectionSample",	[])
		];
		
		public static const TRACKING_MAP:Array=[
			/*{l:"/home", 		t:"pv-bu836"},
			{l:"/1930", 		t:"pv-bu509"},
			{l:"/products", 	t:"pv-bu632"}*/
		];
	}
}