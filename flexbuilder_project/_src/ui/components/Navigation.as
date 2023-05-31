package ui.components
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import cn.daftlib.data.Linking;
	import cn.daftlib.layout.AutoFit;
	import cn.daftlib.ui.components.LableButton;
	
	import core.vo.Link;
	import core.vo.Section;
	
	public class Navigation extends Sprite
	{
		private var __data:Array;
		
		public function Navigation($data:Array)
		{
			super();
			
			__data=$data;
			initNavi();
			AutoFit.register(this, AutoFit.BOTTOM_CENTER, new Point(-(150+1)*__data.length*.5, -100));
		}
		private function initNavi():void
		{
			var i:uint=0;
			while(i<__data.length)
			{
				var s:Section=__data[i];
				var btn:LableButton=new LableButton();
				btn.text=s.title;
				btn.width=150;
				btn.x=(btn.width+1)*i;
				btn.addEventListener(MouseEvent.CLICK, naviClick);
				this.addChild(btn);
				
				Linking.link(btn, s.link);
				
				i++;
			}
		}
		private function naviClick(e:MouseEvent):void
		{
			var btn:LableButton=e.target as LableButton;
			var link:Link=Linking.getObjectByKey(btn) as Link;
			link.go();
		}
		public function updateNavi($clickedLink:Link):void
		{
			var i:int=this.numChildren;
			while(i--)
			{
				var btn:LableButton=this.getChildAt(i) as LableButton;
				var link:Link=Linking.getObjectByKey(btn) as Link;
				
				if($clickedLink.url==link.url)
				{
					btn.selected=true;
					btn.mouseEnabled=false;
				}
				else
				{
					btn.selected=false;
					btn.mouseEnabled=true;
				}
			}
		}
	}
}