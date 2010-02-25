package views {
	import org.baicaix.elephant.OffsetUtil;

	public class ResBrowserPanel extends MapBrowserPanel {
		public function ResBrowserPanel() {
			super();	
			_offsetUtil = new OffsetUtil(this);
		}
	}
}
