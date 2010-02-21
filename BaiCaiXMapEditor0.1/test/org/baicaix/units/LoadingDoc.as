/**
 * @file aaa.as
 * @link poplaryy@gmail.com
 * @author dengyang
 * @playerversion flash player 9+
 * @asversion 3.0
 * @version 0.1
 * @builddate  2010-1-25
 * @updatedate 2010-1-25
 */   
package org.baicaix.units {
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;

	/**
	 * @author dengyang
	 */
    public class LoadingDoc extends Sprite {
        public var _imageData:BitmapData;    //图片
        public var _loader:Loader;    //装载
//        private var _rate:TextField;    //进度显示
        public function LoadingDoc() {
            init();
//            _rate.text = '开始下载';
//            _rate.autoSize = 'center';
//            _rate.textColor = 0x000000;
//            _rate.x = (stage.stageWidth - _rate.width)/2;
//            _rate.y = (stage.stageHeight - _rate.height)/2;
//            this.addChild(_rate);
//            sendRequest('images/flower.jpg');
        }
        //初始化
        private function init() : void {
//            _imageData = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0xFFFFFFFF);
            _loader = new Loader();
//            _rate = new TextField();
        }
        //发送请求
        public function sendRequest(p_url:String) : void {
            var m_request : URLRequest = new URLRequest(p_url);
            _loader.load(m_request);
//            _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
//            _loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
        }
        //事件，下载完毕
//        private function onComplete(e:Event) : void {
////            _imageData.draw(_loader, new Matrix(stage.stageWidth/_loader.width, 0, 0, stage.stageHeight/_loader.height, 0, 0));
//			_imageData = Bitmap(_loader.content).bitmapData;
////            var m_image:Bitmap = new Bitmap(_imageData);
////            this.removeChild(_rate);
////            this.addChild(m_image);
//        }
//        //事件，下载中
//        private function onProgress(e:Event) : void {
//            var m_info:LoaderInfo = e.target as LoaderInfo;
//            var m_percent:uint = (m_info.bytesLoaded/m_info.bytesTotal)*100;
////            _rate.text = '已经下载'+m_percent.toString()+'%';
//        }
    }
} 
