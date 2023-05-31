package ui.sections
{
	import flash.events.MouseEvent;
	
	import cn.daftlib.transitions.TweenManager;
	import cn.daftlib.ui.components.LableButton;
	import cn.daftlib.ui.components.TextLable;
	import cn.daftlib.utils.NumberUtil;
	
	import core.BasicSection;
	import core.vo.Link;
	
	public class SectionSample extends BasicSection
	{
		public function SectionSample($data:Object)
		{
			super($data);
			
			trace(__sectionData, __sectionData.priorFirstLevelDeeplink, __resourceArr, __skin);
		}
		override public function transitionIn():void
		{
			var lable:TextLable=new TextLable();
			if(__resourceArr)
			{
				lable.text=__sectionData.title;
				lable.color=0xFFFFFF;
			}
			else
			{
				lable.text=__sectionData.title+" (no resource)";
				lable.color=0x222222;
			}
			lable.x=30;
			lable.y=20;
			this.addChild(lable);
			
			var btn:LableButton=new LableButton();
			btn.color=0x222222;
			btn.text="goto 1950's";
			btn.x=255;
			btn.y=10;
			this.addChild(btn);
			
			this.mouseChildren=true;
			btn.addEventListener(MouseEvent.CLICK, mouseClickHandler);
			
			TweenManager.from(this, .5, {alpha:0, x:NumberUtil.randomInRange(-200, 200), y:NumberUtil.randomInRange(-200, 200), 
				onComplete:transitionInComplete});
		}
		private function mouseClickHandler(e:MouseEvent):void
		{
			var link:Link=new Link("/1950", Link.DEEPLINK);
			link.go();
		}
	}
}