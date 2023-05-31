package core
{
	import flash.display.InteractiveObject;
	import flash.utils.Dictionary;
	
	import cn.daftlib.events.RightClickMenuEvent;
	import cn.daftlib.ui.RightClickMenu;
	
	import core.vo.Link;
	import core.vo.Section;

	public class RightClickManager
	{
		private static var __smsMap:Dictionary=new Dictionary();
		
		public static function initialize($target:InteractiveObject, $data:Array):void
		{
			var i:uint=0;
			while(i<$data.length)
			{
				var s:Section=$data[i];
				RightClickMenu.addMenuItemForTarget($target, s.title, s.link.url);
				__smsMap[s.link.url]=s.link;
				
				i++;
			}
			
			RightClickMenu.addEventListener(RightClickMenuEvent.MENU_ITEM_SELECT, onItemSelect);
		}
		private static function onItemSelect(e:RightClickMenuEvent):void
		{
			var link:Link=__smsMap[e.message];
			link.go();
		}
	}
}