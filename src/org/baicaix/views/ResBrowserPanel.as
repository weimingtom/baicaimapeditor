package org.baicaix.views {
	import org.baicaix.modules.beans.Map;
	import org.baicaix.single.Editor;
	import org.baicaix.single.ResSelector;
	import org.baicaix.single.display.Shower;
	import org.baicaix.single.events.CellEvent;
	import org.baicaix.single.resource.ResourceImgLoader;

	public class ResBrowserPanel extends AbsBrowserPanel {
		public function ResBrowserPanel() {
			super();	
//			_offsetUtil = new OffsetUtil(this);
		}
		
		override public function set map(map : Map) : void {
//        	_map = map;
        	_totalRange.width = map.width * 32;
			_totalRange.height = map.height * 32; 
			
			//FIXME obj 管理有问题
			var editor : Editor = Editor.getInstance();
			var shower : Shower = new Shower(ResourceImgLoader.getInstance(), _totalRange.width, _totalRange.height, ResSelector);	
			shower.register(editor);		
			_browser = shower.browser;
			shower.loadMap(map, width, height);
			
			_totalRange.addChild(_browser);
			
			_browser.refresh(new CellEvent("", {}));
		}

//		override protected function initSelector() : void {
//			if(selector != null) {
//				selector.removeEventListener(RangeEvent.CLEAR_RANGE, clearRange);
//				selector.removeEventListener(RangeEvent.FOCUS_RANGE, focusRange);
//			}
//			selector = new ResSelector(this, _offsetUtil);
//			selector.addEventListener(RangeEvent.CLEAR_RANGE, clearRange);
//			selector.addEventListener(RangeEvent.FOCUS_RANGE, focusRange);
//		}
	}
}
