package views {
	import events.RangeEvent;

	import org.baicaix.elephant.OffsetUtil;
	import org.baicaix.elephant.ResSelector;

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
