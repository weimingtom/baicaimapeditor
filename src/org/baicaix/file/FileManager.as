/**
 * @file ReadFilesExample.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-2-4
 * @updatedate 2010-2-4
 */   
package org.baicaix.file {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.*;
	import flash.net.FileFilter;

	/**
	 * @author dengyang
	 */
	public class FileManager extends Sprite {
		
		private var _fileStream:FileStream;
		private var _currentFile : File;
		private var _fileName : String;
		private var _content : *;
		public var onOpen : Function;
		public var onSave : Function;
	
		public function FileManager() {
			_fileStream = new FileStream();
		}

		public function openFile(event : Event):void{
			var file:File = File.documentsDirectory;
			var openFileFilter: FileFilter = new FileFilter("Resource", "*.jpeg;*.jpg;*.gif;*.png");
			//new FileFilter("Images", "*.jpeg;*.jpg;*.gif;*.png");  //过滤文件
			//new FileFilter("Text/XML", "*.map");
	        file.browseForOpen("请选择要打开的文件",[openFileFilter, new FileFilter("Map", "*.txt")]); //打开文件选择器
	        file.addEventListener(Event.SELECT, openSelectHandle);   //监听文件选择事件
		}
		
		//将打开文件内容写入文本框
		private function openSelectHandle(e:Event):void{
			//var currentFile : File = e.target as File;
			_currentFile = e.target as File;
			
			onOpen(_currentFile.url);
//			_fileStream.open(_currentFile, FileMode.READ);
//			var txt : String = fileStream.readUTFBytes(fileStream.bytesAvailable);
//			content = txt; //只读方式打开文件，将内容放到TextArea
//			fileStream.open(_currentFile,FileMode.WRITE); //以Write方式重新打开文件，这样我们就可以更新它

//			var loader : Loader = new Loader();
//			var request : URLRequest = new URLRequest(_currentFile.url);
//			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
//			loader.load(request);
		}
		
		//打开文件选择器
		public function saveFileTo(event : Event):void{
			var file:File = File.documentsDirectory; //默认为文档文件夹
			file.browseForSave("请选择保存路径");  //打开文件夹选择器
			file.addEventListener(Event.SELECT, fileSaveHandle)  //监听文件夹选择事件
		}
		
		//用文本框内容创建文件
		private function fileSaveHandle(e:Event):void{
			_currentFile = e.target as File;//new File(e.target.nativePath).resolvePath("saveFileDemo.xml"); //创建名为saveFileDemo.xml的文件
			saveFile(e);
		}
		
		private static const REGEX_SUBFIX : RegExp = new RegExp('[/\\\\]\\w+?\\.(\\w+?)$');
		//用文本框内容更新文件
		public function saveFile(event : Event):void{
			var saveFile : File = _currentFile;
			if(_fileName != null) {
				var targetURL : String = _currentFile.nativePath.replace(REGEX_SUBFIX, "/"+_fileName);
				saveFile = new File(targetURL);
				_fileName = null;
			}
			_fileStream.open(saveFile, FileMode.WRITE); //Write方式打开
			_fileStream.writeUTFBytes(content);  //将内容写入文件
			_fileStream.close();
		}
		
		public function get content() : * {
			return _content;
		}
		
		public function set content(cont : *) : void {
			_content = cont;
		}

		public function set fileName(name : String) : void {
			this._fileName = name;
		}
	}
}
