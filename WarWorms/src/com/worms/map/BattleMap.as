package com.worms.map {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class BattleMap extends Sprite {

//		[Embed(source="assets/bg.png")]

		private var BGClass : Class;

		public function BattleMap() {
			super();
            
			instance = this;
			addChild(getBitmapa());
		}

		private var _bitmap : Bitmap;

		private function getBitmapa() : Bitmap {
			if(!_bitmap) {
				_bitmap = new Bitmap(getBitmapData());
			}
			return _bitmap;
		}

		/**
		 * 返回一个背景的Clone
		 */
		private function getBitmapData() : BitmapData {
			var backgruond:BitmapData = BitmapData(new BGClass());//(new TestMapBitmapData(0,0));
			var transparentB:BitmapData = new BitmapData(backgruond.width,backgruond.height,true,0);
            transparentB.copyPixels(backgruond,backgruond.rect,new Point(0,0));
            return transparentB;
		}
        
        private static var instance:BattleMap;
        
        public static function getInstance():BattleMap {
            return instance;
        }
        
        public static function getCurrentBitmapData():BitmapData {
            return instance.getBitmapa().bitmapData;
        }
        
        public static function getHitFirstPoint():Point {
            var p:Point = new Point(0,0);
            p = instance.localToGlobal(p);
            return p;
        }
        
        /**
         * 擦除
         */
        public function explosion(globalPoint:Point,power:Number):void {
            if(!globalPoint || power <= 0) return;
            
            var localPoint:Point = this.globalToLocal(globalPoint);
            
            var earseShape:Shape = new Shape();    
            earseShape.graphics.beginFill(0xFFFFFF);
            
            var perturbedpowerRadius:Number = power + Math.random()*4 -2;// -2 - 2扰动
            earseShape.graphics.drawCircle(localPoint.x,localPoint.y,perturbedpowerRadius);
            earseShape.graphics.endFill();
            
            var bitmapdata:BitmapData = getCurrentBitmapData();
            bitmapdata.draw(earseShape,null,null,BlendMode.ERASE);
            
            earseShape.graphics.clear();
        }
	}
}