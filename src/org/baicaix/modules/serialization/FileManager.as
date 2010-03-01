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
package org.baicaix.modules.serialization {
	import org.baicaix.events.ResLoadEvent;
	import org.baicaix.modules.beans.Reslist;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.*;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;

	/**
	 * @author dengyang
	 */
	public class FileManager extends Sprite {
		
		//当前打开的文件 1 map 2 导入的外部res
		private var _fileStream : FileStream;
//		private var _currentFile : File;
		public var onOpen : Function;
		public var onSave : Function;
		
//		private var _fileName : String;
//		private var _content : *;
		
		private var _reslist : Reslist;
		private var _reslistFile : File;
		private var _reslistFileStream : FileStream;

		public function FileManager() {
			_fileStream = new FileStream();
			
			_reslist = new Reslist();
			_reslistFile = new File(File.applicationDirectory.nativePath + "/assets/Reslist.xml");
			_reslistFileStream = new FileStream();
			readReslist();
		}

		private function readReslist() : void {
			if(_reslistFile.exists) {
				_reslistFileStream.open(_reslistFile, FileMode.READ);
				var resStr : String = _reslistFileStream.readUTFBytes(_reslistFileStream.bytesAvailable);
				_reslist.read(new XML(resStr));
				_reslistFileStream.close();
			}
		}
		
		private function saveReslist() : void {
			_reslistFileStream.open(_reslistFile, FileMode.WRITE);
			_reslistFileStream.writeUTFBytes(_reslist.toXML().toString());
			_reslistFileStream.close();
		}

		public function openImgFile() : void {
			var file : File = File.applicationDirectory;
			file.browseForOpen("请选择要打开的文件", [new FileFilter("Image Resource", "*.jpeg;*.jpg;*.gif;*.png")]);//打开文件选择器
			file.addEventListener(Event.SELECT, openSelectHandle);   //监听文件选择事件
		}
		
		public function openMapFile() : void {
			var file : File = File.applicationDirectory;
			file.browseForOpen("请选择要打开的文件", [new FileFilter("Map", "*.map")]);//打开文件选择器
			file.addEventListener(Event.SELECT, openSelectHandle);   //监听文件选择事件
		}

		//将打开文件内容写入文本框
		private function openSelectHandle(e : Event = null) : void {
			var file : File = e.target as File;
			var bytes : ByteArray = readFile(file);
	        importRes(bytes);
		}	

		private function readFile(file : File) : ByteArray {
			var stream : FileStream = new FileStream;
			stream.open(file, FileMode.READ);
			var bytes : ByteArray = new ByteArray;
			stream.readBytes(bytes, 0, stream.bytesAvailable);
			stream.close();
			return bytes;
		}
		
		private function importRes(bytes : ByteArray) : void {
			var loader : Loader = new Loader;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
			loader.loadBytes(bytes);
            
			function imageLoaded(event : Event) : void {
				event.target.removeEventListener(Event.COMPLETE, imageLoaded);
				var bitmap : Bitmap = Bitmap(event.target.loader.content);
				onOpen(bitmap);
				
				var id : String = String(getTimer());
				var saveFile : File = new File(File.applicationDirectory.nativePath + "/assets/" + id + ".png");
				var imgFileStream : FileStream = new FileStream();
				imgFileStream.open(saveFile, FileMode.WRITE); 
				var pngBytes : ByteArray = PNGEncoder.encode(bitmap.bitmapData);
				imgFileStream.writeBytes(pngBytes);
				imgFileStream.close();
				//更新Reslist
				_reslist.add(id, "name"+id);
				saveReslist();
				//资源管理器重新 open 新的资源
				dispatchEvent(new ResLoadEvent(ResLoadEvent.LOAD_RES_IMG));
				dispatchEvent(new ResLoadEvent(ResLoadEvent.LOAD_RES_DATA));
			}
		}
//		
//		private function openMapSelectHandle(bytes : ByteArray) : void {
//			var txt : String = bytes.readUTFBytes(bytes.bytesAvailable);
//			content = txt; //只读方式打开文件，将内容放到TextArea
//		}
//
//		//打开文件选择器
//		public function saveFileTo(event : Event) : void {
//			var file : File = File.applicationDirectory; //默认为文档文件夹
//			file.browseForSave("请选择保存路径");  //打开文件夹选择器
//			file.addEventListener(Event.SELECT, fileSaveHandle);  //监听文件夹选择事件
//		}
//
//		//用文本框内容创建文件
//		private function fileSaveHandle(e : Event) : void {
//			_currentFile = e.target as File;
//			saveFile(e);
//		}
//
//		private static const REGEX_SUBFIX : RegExp = new RegExp('[/\\\\]\\w+?\\.(\\w+?)$');
//
//		//用文本框内容更新文件
//		public function saveFile(event : Event) : void {
//			var saveFile : File = _currentFile;
//			if(_fileName != null) {
//				var targetURL : String = _currentFile.nativePath.replace(REGEX_SUBFIX, "/" + _fileName);
//				saveFile = new File(targetURL);
//				_fileName = null;
//			}
//			_fileStream.open(saveFile, FileMode.WRITE); //Write方式打开
//			_fileStream.writeUTFBytes(content);  //将内容写入文件
//			_fileStream.close();
//		}
//
//		public function get content() : * {
//			return _content;
//		}
//
//		public function set content(cont : *) : void {
//			_content = cont;
//		}
//
//		public function set fileName(name : String) : void {
//			this._fileName = name;
//		}
	}
}
