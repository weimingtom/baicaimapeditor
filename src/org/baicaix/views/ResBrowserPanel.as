package org.baicaix.views {
	import org.baicaix.events.RangeEvent;

	import org.baicaix.controls.ResSelector;
	import org.baicaix.utils.OffsetUtil;

	public class ResBrowserPanel extends MapBrowserPanel {
		public function ResBrowserPanel() {
			super();	
			_offsetUtil = new OffsetUtil(this);
		}

		override protected function initSelector() : void {
			if(selector != null) {
				selector.removeEventListener(RangeEvent.CLEAR_RANGE, clearRange);
				selector.removeEventListener(RangeEvent.FOCUS_RANGE, focusRange);
			}
			selector = new ResSelector(this, _offsetUtil);
			selector.addEventListener(RangeEvent.CLEAR_RANGE, clearRange);
			selector.addEventListener(RangeEvent.FOCUS_RANGE, focusRange);
		}
	}
}
