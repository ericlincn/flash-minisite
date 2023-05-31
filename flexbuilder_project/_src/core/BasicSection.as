package core
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import cn.daftlib.display.DaftSprite;
	import cn.daftlib.transitions.TweenManager;
	
	import core.vo.Section;
	
	[Event(name="transitionInComplete", type="core.BasicSection")]
	[Event(name="transitionOutComplete", type="core.BasicSection")]
	
	public class BasicSection extends DaftSprite
	{
		public static const TRANSITION_IN_COMPLETE:String="transitionInComplete";
		public static const TRANSITION_OUT_COMPLETE:String="transitionOutComplete";
		
		protected var __sectionData:Section;
		protected var __resourceArr:Array;
		protected var __skin:DisplayObject;
		
		/**
		 * 构造函数完成后得到四个 protected 成员：
		 * __sectionData，该栏目的数据，类型为 vo.Section
		 * __sectionData.priorFirstLevelDeeplink，前一个栏目的深链接，类型为 String
		 * __resourceArr，读取后的资源数组，可能由多种数据类型组成
		 * __skin，读取后的主swf资源，类型为 DisplayObject，也就是 __resourceArr[0]
		 */		
		public function BasicSection($data:Object)
		{
			super();
			
			__sectionData=$data.section;
			__resourceArr=$data.resource;
			
			if(__resourceArr)
			{
				__skin=__resourceArr[0];
				this.addChild(__skin);
			}
		}
		
		/**
		 * destroy 方法，仅可由 view.ViewSection 调用
		 * 复写时请保留 super.destroy();
		 * 
		 * 会从舞台移除自身，并移除自身所有侦听，但不会移除子对象身上的侦听
		 */
		override public function destroy():void
		{
			TweenManager.removeTweenForTarget(this);
			
			super.destroy();
		}
		
		/**
		 * transitionIn 方法是该类实例化后 第一个会执行的方法，仅可由 view.ViewSection 调用，
		 * 用来定义一些进场动画以及业务逻辑的初始化
		 * 可随意复写，复写时不用包含 super.transitionIn();
		 * 但是在 transitionIn 动画过程结束后，需要手动调用 transitionInComplete();
		 */	
		public function transitionIn():void
		{
			TweenManager.from(this, .7, {alpha:0, onComplete:transitionInComplete});
		}
		
		/**
		 * transitionOut 方法用来定义出场动画，仅可由 view.ViewSection 调用
		 * 可随意复写，复写时不用包含 super.transitionOut();
		 * 但是在 transitionOut 动画过程结束后，需要手动调用 transitionOutComplete();
		 */	
		public function transitionOut():void
		{
			TweenManager.to(this, .3, {alpha:0, onComplete:transitionOutComplete});
		}
		protected function transitionInComplete():void
		{
			this.dispatchEvent(new Event(TRANSITION_IN_COMPLETE));
		}
		protected function transitionOutComplete():void
		{
			this.dispatchEvent(new Event(TRANSITION_OUT_COMPLETE));
		}
	}
}