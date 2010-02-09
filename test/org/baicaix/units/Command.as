package org.baicaix.units {

	/**
	 * 命令, 存储函数及函数需要的参数.
	 * @author tamt
	 */
	public class Command {
		
		private var _this:*;
		private var _fun:Function;
		private var _args:Array;
		
		/**
		 * 命令, 存储函数及函数需要的参数.
		 * @param thisObject			fun函数体内使用的this的值
		 * @param fun					执行命令时将调用的函数
		 * @param ...args				指定执行命令时将调用的函数的参数
		 */
		public function Command(thisObject:*, fun:Function, ...args):void{
			_this = thisObject;
			_fun = fun;
			_args = args;
		}
		
		/**
		 * 执行这个命令
		 */
		public function excute():void{
			_fun.apply(_this, _args);
		}
		
		/**
		 * 注销这个命令
		 */
		public function deconstruct():void{
			_this = null;
			_fun = null;
			_args = null;
		}
		
		public function toString():String{
			return String(_fun);
		}
		
	}
}
