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

        public var tag:int;
        public var emitter:FlxEmitter;
        public var overlay:TagSprite;

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
    }
}