package core
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import cn.daftlib.observer.INotification;
	import cn.daftlib.observer.IObserver;
	
	import events.NotificationsConstants;
	
	import ui.LoadingManager;
	
	import core.vo.Section;
	
	public class SectionContainer extends Sprite implements IObserver
	{
		private var __sectionClassMap:Dictionary=new Dictionary();
		private var __currentSectionData:Section;
		private var __currentResourceArr:Array;
		private var __currentSection:BasicSection;
		
		public function SectionContainer()
		{
			super();
		}
		
		public function handlerNotification($notification:INotification):void
		{
			switch($notification.name)
			{
				case NotificationsConstants.SECTION_UPDATE:
					var sectionData:Section=$notification.body.data;
					updateSection(sectionData);
					break;
			}
		}
		public function registerSectionClass($className:String, $class:Class):void
		{
			__sectionClassMap[$className]=$class;
		}
		private function updateSection($section:Section):void
		{
			if(__sectionClassMap[$section.className] == undefined) return;
			
			__currentSectionData=$section;
			/*if(__currentSection)
				__currentSection.removeEventListeners();*/
			
			if(__currentSectionData.resourceArr==null)
			{
				__currentResourceArr=null;
				removeCurrentAndAddNewSection();
				
				return;
			}
			else if(__currentSectionData.resourceArr.length<1)
			{
				__currentResourceArr=null;
				removeCurrentAndAddNewSection();
				
				return;
			}
			
			LoadingManager.clear();
			
			var resourceArr:Array=__currentSectionData.resourceArr;
			if(resourceArr.length>0)
			{
				var i:uint=0;
				while(i<__currentSectionData.resourceArr.length)
				{
					var resourceURL:String=__currentSectionData.resourceArr[i];
					LoadingManager.loader.add(resourceURL);
					
					i++;
				}
				
				LoadingManager.loader.addEventListener(Event.COMPLETE, resourceCompleteHandler);
				LoadingManager.loader.start();
			}
		}
		private function resourceCompleteHandler(e:Event):void
		{
			__currentResourceArr=[];
			
			var i:uint=0;
			while(i<__currentSectionData.resourceArr.length)
			{
				var resourceURL:String=__currentSectionData.resourceArr[i];
				var contentInstance:*=LoadingManager.loader.get(resourceURL);
				__currentResourceArr.push(contentInstance);
				
				i++;
			}
			
			LoadingManager.clear();
			
			removeCurrentAndAddNewSection();
		}
		private function removeCurrentAndAddNewSection():void
		{
			if(__currentSection)
			{
				__currentSection.mouseChildren=false;
				__currentSection.mouseEnabled=false;
				__currentSection.removeEventListeners();
				__currentSection.addEventListener(BasicSection.TRANSITION_OUT_COMPLETE, currentSectionTransitionOutComplete);
				__currentSection.transitionOut();
				//__currentSection=null;
			}
			else
				addNewSection();
		}
		private function currentSectionTransitionOutComplete(e:Event):void
		{
			var currentSection:BasicSection=e.target as BasicSection;
			currentSection.destroy();
			
			addNewSection();
		}
		private function addNewSection():void
		{
			var SectionClass:Class=__sectionClassMap[__currentSectionData.className];
			
			__currentSection=new SectionClass( { section:__currentSectionData, resource:__currentResourceArr } );
			__currentSection.transitionIn();
			
			this.addChild(__currentSection);
			//trace(this.numChildren, __currentSectionData.title);
		}
	}
}