package org.baicaix.units {	import flash.utils.Dictionary;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	//import ragame.sgame.Command;


	/**
	 * TODO:[tamt]擴展使支持一個按鍵可以注冊多個事件。
	 * TODO:[tamt]当前使用主键和附键的策略. 弃用这个方法, 改用其它方法.采用主键和附加键存在的一个缺陷:如果A键和Ctrl+A键都有注册的话, 在清除A快捷键绑定时会清除掉Ctrl+A快捷绑定
	 * @author ghdu
	 */
	public class KeyboardManager extends EventDispatcher {
		private static var _instance : KeyboardManager;
		private static var _keyActionList : Dictionary;
		private static var _downKeyList : Array = [];
		private var keyStateList : Array;
		private var inited : Boolean = false;
		private var stage : Stage;
		private static var _isUseful : Boolean = true;

		//private static var keyDownCode : uint = 0;
		//要禁用的键盘事件的类型//聊天框  暂进只禁用聊天的，其它比如设置快捷键功能以后再做
		//public static const CHAT_INPUTTEXT : uint  = 0; 
		public static function getInstance() : KeyboardManager {
			if(_instance == null) _instance = new KeyboardManager(new SingletonEnforcer());
			return _instance;
		}

		public function KeyboardManager(singletonEnforcer : SingletonEnforcer) {
			if(singletonEnforcer == null) throw new Error("KeyboardManager is a singleton class, use getInstance() instead");
			keyStateList = new Array();
			_keyActionList = new Dictionary();
		}

		public function init(_stage : Stage) : void {
			if(!inited) {
				inited = true;
				stage = _stage;
				stage.addEventListener(KeyboardEvent.KEY_DOWN, __onKeyDown, false, 0, true);
				stage.addEventListener(KeyboardEvent.KEY_UP, __onKeyUp, false, 0, true);
				stage.addEventListener(Event.DEACTIVATE, __deactived, false, 0, true);
				
				stage.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
				stage.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0);
			}
		}

		private function onMouseUp(evt : MouseEvent) : void {
			if(evt.target is TextField) {
				var tf : TextField = evt.target as TextField;
				if(tf.type == TextFieldType.INPUT) {
					//修正输入法状态下产生vk键bug
					_downKeyList = [];
					keyStateList.forEach(function(element : * , index : int, arr : Array):void {
						arr[index] = false;
					});
					useful = false;
				} 
				/*else {
					useful = true;
					if(stage.focus is TextField) {
						var t : TextField = stage.focus as TextField;
						if(t.type == TextFieldType.INPUT) {
							stage.focus = stage;
						}
					}
				}*/
			} else {
				if(stage.focus is TextField) {
					var t : TextField = stage.focus as TextField;
					if(t.type == TextFieldType.INPUT) {
						if(t.selectionEndIndex == t.caretIndex) {
							//stage.focus = stage;
						} else {
							return;
						}
					}
				} else {
					//stage.focus = stage;
				}
				useful = true;
			}
		}

		private function onFocusIn(evt : FocusEvent = null) : void {
			if(evt.target is TextField) {
				var tf : TextField = evt.target as TextField;
				if(tf.type == TextFieldType.INPUT) {
					//修正输入法状态下产生vk键bug
					_downKeyList = [];
					keyStateList.forEach(function(element : *, index : int, arr : Array):void {
						arr[index] = false;
					});
					useful = false;
				} else {
					useful = true;
				}
			} else {
				useful = true;
			}
		}

		private function onFocusOut(evt : FocusEvent = null) : void {
			if(evt.target is TextField) {
				var tf : TextField = evt.target as TextField;
				if(tf.type == TextFieldType.INPUT) {
					useful = true;
					//修正输入法状态下产生vk键bug
					_downKeyList = [];
					keyStateList.forEach(function(element : *, index : int, arr : Array):void {
						arr[index] = false;
					});
				}
			}
		}

		public function isKeyDown(keyCode : uint) : Boolean {
			return keyStateList[keyCode];
		}

		public static function isDown(keyCode : uint) : Boolean {
			return getInstance().isKeyDown(keyCode);
		}

		/**
		 * 注册一个键盘动作
		 * @param keyCode				键值
		 * @param keyDownAction			按下时执行的函数
		 * @param keyUpAction			释放时执行的函数
		 * @param extKey				附加键, 如键:shift, ctrl, alt(Windows only), 默认为无(0).
		 */
		public static function registerKeyCommand(keyCode : uint,keyDownCmd : Command = null,keyUpCmd : Command = null, extKeys : Array = null) : void {
			_keyActionList[keyCode] = new KeyCmd(keyCode, keyDownCmd, keyUpCmd, extKeys);
		}

		public static function unregisterKeyCommand(keyCode : uint, keyDownCmd : Command = null, keyUpCmd : Command = null, extKeys : Array = null) : void {
			delete _keyActionList[keyCode];
		}

		/**
		 * 当前一个keycode只能注册一组command，所以［暂时］清除一个Keycode就会清除对对应所有的Command
		 */
		public static function clearKeyCommand(keyCode : uint,keyDownCmd : Command = null,keyUpCmd : Command = null) : void {
			delete _keyActionList[keyCode];
		}

		//dof
		public function set useful(isUseful : Boolean) : void {
			_isUseful = isUseful;
		}

		private function __onKeyDown(e : KeyboardEvent) : void {
			
			var keyCode : uint = e.keyCode;
			if(_downKeyList.indexOf(keyCode) < 0)_downKeyList.push(keyCode);
			//			if(keyCode == Keyboard.ENTER)
			//			{
			//				useful = true;
			//			}
			if(_isUseful) {
				if(!keyStateList[keyCode]) keyStateList[keyCode] = true;
			
				var keyCmd : KeyCmd = _keyActionList[keyCode];
				if(keyCmd != null && keyCmd.dCmd != null ) {
					//trace('[KeyboardManager]', keyCmd.key);
					var extKeys : Array = keyCmd.extKeys; 
					if( extKeys == null) {
						//trace('[KeyboardManager]extKeys is null');
						//						if(_downKeyList.length == 1){
						keyCmd.dCmd.excute();
//						}
					} else {
						//trace('[KeyboardManager]extKeys is not null');
						//trace(extKeys.every(checkDown));
						if(extKeys.every(checkDown))keyCmd.dCmd.excute();
					}
				}
			}
		}

		private static function checkDown(element : uint, index : int, arr : Array) : Boolean {
			return KeyboardManager.isDown(element);
		}

		private function __onKeyUp(e : KeyboardEvent) : void {
			
			var keyCode : uint = e.keyCode;
			//			if(keyCode == Keyboard.ENTER)
			//			{
			//				useful = true;
			//			}
			if(_isUseful) {
				if(keyStateList[keyCode]) keyStateList[keyCode] = false;
				
				var keyCmd : KeyCmd = _keyActionList[keyCode];
				if(keyCmd != null && keyCmd.uCmd != null ) {
					//trace('[KeyboardManager]', keyCmd.key, 'up');
					var extKeys : Array = keyCmd.extKeys; 
					if( extKeys == null) {
						//trace('[KeyboardManager]extKeys is null', _downKeyList);
						//						if(_downKeyList.length == 1){
						keyCmd.uCmd.excute();
//						}
					} else {
						//trace('[KeyboardManager]extKeys is not null');
						if(extKeys.every(checkDown))keyCmd.uCmd.excute();
					}
				}
			}
			
			var t : int = _downKeyList.indexOf(keyCode);
			if(t >= 0)_downKeyList.splice(t, 1);
		}

		private function __deactived(e : Event) : void {
			keyStateList.splice(0);
		}
	}
}

import org.baicaix.units.Command;

class SingletonEnforcer {
}

class KeyCmd {

	public var key : uint;
	public var dCmd : Command;
	public var uCmd : Command;
	public var extKeys : Array;

	public function KeyCmd(key : uint, dCmd : Command, uCmd : Command, extKeys : Array = null) : void {
		this.key = key;
		this.dCmd = dCmd;
		this.uCmd = uCmd;
		this.extKeys = extKeys;
	}
}