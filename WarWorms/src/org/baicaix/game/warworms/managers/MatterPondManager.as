package org.baicaix.game.warworms.managers {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	public class MatterPondManager extends EventDispatcher {

		private static var instance : MatterPondManager;

		private var _caches : Dictionary;
		private var _container : DisplayObjectContainer;

//		public function MatterPondManager(container : DisplayObjectContainer) {
//			this.caches 	= new Dictionary();
//			this.container 	= container;//BattleField.getInstance();
//		}
		
		public function MatterPondManager() {
			this._caches = new Dictionary();
		}

		public function set container(container : DisplayObjectContainer) : void {
			this._container = container;
		}
		
		public static function getInstance() : MatterPondManager {
			if(!instance) {
				instance = new MatterPondManager();
			}
			return instance;
		}

		public function get(clasz : Class) : * {
			var claszCaches : Array = getOrCreateCacheArray(clasz);
            
			var m : *;
			if(claszCaches.length) {
				m = claszCaches.pop();
                
//				var missilePondEvent : MatterPondPondEvent = new MatterPondPondEvent(MatterPondPondEvent.MISSILE_POND_COUNT_CHANGED);
//				missilePondEvent.count = missilesCaches.length;
//                
//				dispatchEvent(missilePondEvent);
			} else {
				m = new clasz();
			}
            addToBattle(m);
            
			return m;
		}

		private function addToBattle(m : DisplayObject) : void {
			if(_container != null && !_container.contains(m)) {
				_container.addChild(m);
			}
		}

		
		public function recycle(clasz : Class, m : DisplayObject) : void {
			var claszCaches : Array = getOrCreateCacheArray(clasz);
            
			removeFromBattle(m);
            
			claszCaches.push(m);
//            
//			var missilePondEvent : MatterPondPondEvent = new MatterPondPondEvent(MatterPondPondEvent.MISSILE_POND_COUNT_CHANGED);
//			missilePondEvent.count = missilesCaches.length;
//                
//			dispatchEvent(missilePondEvent);
		}

		private function removeFromBattle(m : DisplayObject) : void {
			if(_container != null && _container.contains(m)) {
				_container.removeChild(m);
			}
		}

		
		private function getOrCreateCacheArray(clasz : Class) : Array {
			if(!_caches[clasz]) {
				_caches[clasz] = [];
			}
			return _caches[clasz];
		}
		
	}
}