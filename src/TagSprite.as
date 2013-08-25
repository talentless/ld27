package
{
    import org.flixel.*;

    public class TagSprite extends FlxSprite
    {
        static public var BOT_DOOR:int = 201;
        static public var BOT_POINTER:int = 202;

        static public var CIV_HEADING_HOME:int = 101;
        static public var CIV_WANDERING:int = 102;
        static public var CIV_HOME:int = 103;

        static public var OVERLAY_POINTER:int = 301;
        static public var OVERLAY_STEAM:int = 302;

        static public var CARD_EMPTY:int = 901;
        static public var CARD_CIV:int = 902;
        static public var CARD_BOT_DOOR:int = 903;
        static public var CARD_BOT_POINTER:int = 904;
        static public var CARD_ALIEN:int = 905;

        public var tag:int;
        public var emitter:FlxEmitter;
        public var overlay:TagSprite;
        public var timer:int;

        private var _slowFlicker:int = 0;
        public var slowFlicker:Boolean = false;

        public function TagSprite(X:Number=0,Y:Number=0,SimpleGraphic:Class=null)
        {
            super(X,Y,SimpleGraphic);
        }

        public function hideOverlay():void {
            if (overlay != null) {
                overlay.kill();
            }
        }
        public function showOverlay(pos:FlxPoint):void {
            if (overlay != null) {
                overlay.revive();
                overlay.x = pos.x;
                overlay.y = pos.y;
            }
        }

        public function decTimer():void {
            timer -= 1;
            if (timer < 0) { timer = 0; }
        }

        override public function draw():void
        {
            if (tag == OVERLAY_POINTER || slowFlicker) {
                var r:int = slowFlicker ? 24 : 6;
                _slowFlicker = (_slowFlicker + 1) % r;
                if(_slowFlicker > r/2)
                {
                    return;
                }
            }
            super.draw();
        }
    }
}