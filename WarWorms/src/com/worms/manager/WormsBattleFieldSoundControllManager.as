package com.worms.manager {
	import flash.media.Sound;

	public class WormsBattleFieldSoundControllManager {

		private static var instance : WormsBattleFieldSoundControllManager;

		public static function getInstance() : WormsBattleFieldSoundControllManager {
			if(!instance) {
				instance = new WormsBattleFieldSoundControllManager();
			}
			return instance;
		}

		public function playMissileFireSound() : void {
			getMissileFireSound().play();
		}

		private var _missileFireSound : Sound;

		private function getMissileFireSound() : Sound {
			if(!_missileFireSound) {
//				_missileFireSound = Sound(new MissileFireSoundCls());
			}
			return _missileFireSound;
		}
	}
}