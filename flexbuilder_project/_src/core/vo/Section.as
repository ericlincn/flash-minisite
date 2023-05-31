package core.vo
{
	public class Section
	{
		public var priorFirstLevelDeeplink:String=null;
		
		private var __title:String;
		private var __link:Link;
		
		private var __className:String;
		private var __resourceArr:Array;
		
		public function Section($title:String, $link:Link, $className:String, $resourceArr:Array)
		{
			__title=$title;
			__link=$link;
			__className=$className;
			
			__resourceArr=$resourceArr;
		}
		public function get title():String
		{
			return __title;
		}
		public function get link():Link
		{
			return __link;
		}
		public function get className():String
		{
			return __className;
		}
		public function get resourceArr():Array
		{
			return __resourceArr;
		}
	}
}