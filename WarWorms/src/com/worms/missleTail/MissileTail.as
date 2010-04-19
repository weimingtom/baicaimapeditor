package com.worms.missleTail {
    import com.worms.manager.MatterPondManager;
    
    import flash.display.Sprite;
    import flash.events.Event;
    
    public class MissileTail extends Sprite {
        public static const MISSILE_TAIL_AlPHA_DOWN_SPEED:Number = 0.18;
        public static const MISSILE_TAIL_SCALE_UP_SPEED:Number = 1;
        
        public function MissileTail() {
            mouseEnabled = false;
            mouseChildren = false;
        }
        
        public function startEffect(x:Number,y:Number):void {
            
            this.x = x;
            this.y = y;
            
            this.alpha = 1;
            this.rotation = Math.random()*360;
            
            this.scaleX = this.scaleY = getRandomScale();
            
            this.addEventListener(Event.ENTER_FRAME,enterframeHandler);
        }
        
        //导弹尾部只有6个像素 2-5
        private function getRandomScale():Number {
            return Math.random()*3 + 2;
        }
        
        public function endEffect():void {
            this.removeEventListener(Event.ENTER_FRAME,enterframeHandler);
            MatterPondManager.getInstance().recycleMissileTail(this);
        }
        
        private function enterframeHandler(e:Event):void {
            this.scaleX += MISSILE_TAIL_SCALE_UP_SPEED;
            this.scaleY += MISSILE_TAIL_SCALE_UP_SPEED;
            
            this.alpha -= MISSILE_TAIL_AlPHA_DOWN_SPEED;
            
            if(this.alpha <= 0) {
                endEffect();
            }
        }
    }
}