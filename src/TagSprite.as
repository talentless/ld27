package
{
    import org.flixel.*;

    public class TagSprite extends FlxSprite
    {
        static public var BOT_DOOR:int = 201;
        static public var BOT_POINTER:int = 202;

        public var tag:int;

        public function TagSprite(X:Number=0,Y:Number=0,SimpleGraphic:Class=null)
        {
            super(X,Y,SimpleGraphic);
        }
    }
}