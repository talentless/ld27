package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
        [Embed(source="assets/tiles.png")] static public var RTiles:Class;
        [Embed(source="assets/decorations.png")] static public var DecorationTiles:Class;
        [Embed(source="assets/civ.png")] static public var CivTiles:Class;

        [Embed(source="assets/music.mp3")] public var BGMusic:Class;

        [Embed(source="assets/explosion.mp3")] public var SFX_EXPLOSION:Class;
        [Embed(source="assets/pause.mp3")] public var SFX_PAUSE:Class;
        [Embed(source="assets/saved.mp3")] public var SFX_SAVED:Class;
        [Embed(source="assets/activated.mp3")] public var SFX_ACTIVATED:Class;
        [Embed(source="assets/blocked.mp3")] public var SFX_BLOCKED:Class;
        [Embed(source="assets/aaa.mp3")] public var SFX_DEAD:Class;

        [Embed(source="assets/1.mp3")] public var SFX_1:Class;
        [Embed(source="assets/2.mp3")] public var SFX_2:Class;
        [Embed(source="assets/3.mp3")] public var SFX_3:Class;
        [Embed(source="assets/4.mp3")] public var SFX_4:Class;
        [Embed(source="assets/5.mp3")] public var SFX_5:Class;
        [Embed(source="assets/6.mp3")] public var SFX_6:Class;
        [Embed(source="assets/7.mp3")] public var SFX_7:Class;
        [Embed(source="assets/8.mp3")] public var SFX_8:Class;
        [Embed(source="assets/9.mp3")] public var SFX_9:Class;
        [Embed(source="assets/10.mp3")] public var SFX_10:Class;
        [Embed(source="assets/takeoff.mp3")] public var SFX_TAKEOFF:Class;

        public var countdownSFXs:Array;

        static public var CIV_SPEED:Number = 150;
        static public var BOT_SPEED:Number = 300;
        static public var ALIEN_SPEED:Number = 150;

        public var level:FlxTilemap;
        public var levelDecorations:FlxTilemap;

        public var launchPrep:Boolean;
        public var liftOff:Boolean;
        public var paused:Boolean;
        public var pauseGroup:FlxGroup;


        public var levelOverlay:FlxGroup;

        public var emitters:FlxGroup;

        public var troopHighlights:FlxGroup;

        public var civs:FlxGroup;
        public var bots:FlxGroup;
        public var aliens:FlxGroup;

        public var roomOverlays:FlxGroup;

        public var gameOver:FlxGroup;

        public var target:FlxSprite;
        public var selector:FlxSprite;
        public var selected:TagSprite;

        public var stateLabel:FlxText;

        public var timePaused:Number;
        public var timeRemaining:Number;
        public var timerLabel:FlxText;

        public var saveCounter:int;
        public var lostCounter:int;
        public var aliensOnPod:int;

        public var saveLabel:FlxText;
        public var lostLabel:FlxText;

        public var muteLabel:FlxText;

		override public function create():void
		{
            FlxG.mouse.show();

            countdownSFXs = new Array(
                SFX_9,
                SFX_8,
                SFX_7,
                SFX_6,
                SFX_5,
                SFX_4,
                SFX_3,
                SFX_2,
                SFX_1,
                SFX_TAKEOFF
                );

            // LEVEL
            FlxG.bgColor = 0xff1c1b1c;

            var data:Array = new Array(
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1,q(),1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0,q(),0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,q(),0, 0, 0, 0, 0, 0, 0,q(),0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1,q(),1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1,q(),1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1,
                1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1,q(),1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1,q(),1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0,q(),0, 0, 0, 0, 0, 0, 0,q(),0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,q(),0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1,q(),1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
                );
            level = new FlxTilemap();
            level.loadMap(FlxTilemap.arrayToCSV(data,48),PlayState.RTiles,0,0,FlxTilemap.AUTO);
            add(level);

            // a second tile map here that will sit over the first
            // for decorations. this one will NOT be an automap and it will
            // not partake in collisions
            var decorationData:Array = new Array(
                22, 17, 17, 17, 17, 17, 17, 17, 22, 17, 17, 17, 17, 17, 17, 17, 22, 17, 17, 17, 17, 17, 17, 17, 22, 17, 17, 17, 17, 17, 17, 17, 22, 17, 17, 17, 17, 17, 17, 17, 22, 2, 1, 8, 1, 1, 1, 1,
                0, 18, 18, 18, 0, 0, 0, 0, 0, 28, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 18, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 1, 1, 1, 1,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 0, 2, 1, 8, 1, 1, 8, 1,
                0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 21, 0, 2, 1, 1, 1, 1, 1, 1,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 2, 1, 1, 1, 1, 1, 1,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 27, 28, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 1, 1, 1, 8,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 8, 1, 1, 1,
                0, 27, 28, 27, 28, 27, 28, 27, 0, 28, 0, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27, 28, 0, 0, 0, 27, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 1, 1, 1, 1,
                0, 27, 28, 28, 27, 27, 28, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 1, 1, 8, 1,
                0, 27, 28, 27, 28, 27, 28, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 8, 1, 1, 1, 1,
                0, 27, 28, 27, 27, 28, 28, 28, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 1, 1, 1, 1,
                0, 27, 28, 27, 28, 27, 28, 27, 0, 29, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27, 27, 0, 0, 0, 28, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 1, 1, 1, 1,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22, 15, 4, 4, 4, 4, 4, 6,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 3,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 10, 11, 3,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 26, 0, 0, 0, 0, 0,  12, 3,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 0, 0, 0, 0, 10, 13, 3,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23, 3,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22, 14, 5, 5, 5, 5, 5, 7,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 1, 1, 1, 1,
                0, 29, 0, 0, 0, 0, 0, 0, 0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 1, 1, 1, 1,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 1, 1, 1, 1,
                0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 8, 1, 1, 1, 1,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 1, 1, 1, 1,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 1, 1, 1, 1,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 28, 27, 27, 27, 28, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 1, 1, 1, 1,
                0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 28, 28, 28, 28, 28, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 0, 2, 1, 1, 1, 8, 1, 1,
                0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27, 27, 28, 27, 27, 28, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 0, 2, 1, 1, 1, 1, 1, 1,
                0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 27, 28, 28, 27, 27, 27, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 21, 0, 2, 1, 1, 1, 1, 1, 8,
                0, 18, 0, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 28, 28, 28, 28, 28, 27, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 8, 1, 1, 1,
                22, 0, 0, 0, 0, 0, 0, 0, 22, 16, 16, 16, 16, 16, 16, 16, 22, 0, 0, 0, 0, 0, 0, 0, 22, 16, 16, 16, 16, 16, 16, 16, 22, 0, 0, 0, 0, 0, 0, 0, 22, 2, 1, 1, 1, 1, 1, 1
                );
            levelDecorations = new FlxTilemap();
            levelDecorations.loadMap(FlxTilemap.arrayToCSV(decorationData,48),PlayState.DecorationTiles,16,16,NaN);
            add(levelDecorations);

            // GROUPS
            levelOverlay = new FlxGroup();
            add(levelOverlay);

            roomOverlays = new FlxGroup();
            add(roomOverlays);

            troopHighlights = new FlxGroup();
            add(troopHighlights);

            emitters = new FlxGroup();
            add(emitters);

            civs = new FlxGroup();
            add(civs);

            bots = new FlxGroup();
            add(bots);

            aliens = new FlxGroup();
            add(aliens);

            // ADD ACTUAL UNITS
            // we will want to change this to a card drawing system so we do
            // not place things in the same room.
            // we have 25 rooms available, we will only use 20 of them
            // distribution:
            //    - 5 civs
            //    - 3 doors bots
            //    - 2 pointer bots
            //    - 1 steam/laser bot
            //    - 1 alien (more spawn every second)
            //    - 8 empty rooms
            var cards:Array = new Array(
                TagSprite.CARD_ALIEN,
                TagSprite.CARD_BOT_POINTER,
                TagSprite.CARD_BOT_POINTER,
                TagSprite.CARD_BOT_DOOR,
                TagSprite.CARD_BOT_DOOR,
                TagSprite.CARD_CIV,
                TagSprite.CARD_CIV,
                TagSprite.CARD_CIV,
                TagSprite.CARD_CIV,
                TagSprite.CARD_CIV,
                TagSprite.CARD_EMPTY,
                TagSprite.CARD_EMPTY,
                TagSprite.CARD_EMPTY,
                TagSprite.CARD_EMPTY,
                TagSprite.CARD_EMPTY,
                TagSprite.CARD_EMPTY,
                TagSprite.CARD_EMPTY,
                TagSprite.CARD_EMPTY,
                TagSprite.CARD_EMPTY
                );
            placeCards(cards);
            placeBot(TagSprite.BOT_DOOR, getRoomCenter(new FlxPoint(4, 4)));

            // PAUSE OVERLAY
            paused = false;
            pauseGroup = new FlxGroup();
            add(pauseGroup); // to add or not to add?

            // UI
            stateLabel = new FlxText(670, 20, 120, "takeoff");
            stateLabel.size = 20;
            add(stateLabel);

            timeRemaining = 10.0;
            timePaused = 0;
            timerLabel = new FlxText(670, 60, 120, timeRemaining.toFixed(2));
            timerLabel.size = 20;
            add(timerLabel);

            saveLabel = new FlxText(670, 320, 120, saveCounter.toString() + " saved");
            saveLabel.size = 20;
            add(saveLabel);

            lostLabel = new FlxText(670, 360, 120, lostCounter.toString() + " lost");
            lostLabel.size = 20;
            add(lostLabel);

            muteLabel = new FlxText(670, FlxG.height-40, 120, "(m)usic");
            muteLabel.size = 16;
            add(muteLabel);
            var restartLabel:FlxText = new FlxText(670, FlxG.height-60, 120, "(r)estart");
            restartLabel.size = 16;
            add(restartLabel);

            target = new FlxSprite(4*16, 4*16);
            target.makeGraphic(16,16,0xff00ff00);
            target.loadGraphic(PlayState.CivTiles, true, true, 16, 16);
            target.frame = 4;
            target.visible = false;
            add(target);

            selector = new FlxSprite(4*16, 4*16);
            selector.makeGraphic(16,16,0xff00ff00);
            selector.loadGraphic(PlayState.CivTiles, true, true, 16, 16);
            selector.frame = 5;
            selector.visible = false;
            add(selector);

            // do not add
            gameOver = new FlxGroup();

            // music
            FlxG.playMusic(BGMusic,1);
            FlxG.music.pause();
            FlxG.play(SFX_10, 1);
        }

        // GENERATE UNITS

        public function placeCards(cards:Array):void {
            var shuffled:Array = FlxU.shuffle(cards, 4*cards.length);
            for (var i:int = 0; i < cards.length; i++) {
                var roomPos:FlxPoint = getRoomCenter(new FlxPoint(i % 4, i % 5));
                var card:int = shuffled[i];
                generateFromCard(card, roomPos);
            }
        }
        public function generateFromCard(card:int, pos:FlxPoint):void {
            if (card == TagSprite.CARD_CIV) {
                placeCiv(pos);
            } else if (card == TagSprite.CARD_BOT_DOOR) {
                placeBot(TagSprite.BOT_DOOR, pos);
            } else if (card == TagSprite.CARD_BOT_POINTER) {
                placeBot(TagSprite.BOT_POINTER, pos);
            } else if (card == TagSprite.CARD_ALIEN) {
                placeAlien(pos);
            }
        }

        // CIVILIANS

        public function placeCiv(pos:FlxPoint=null): void {
            if (pos == null) {
                pos = getRoomCenter(getRandomRoom(false));
            }
            var civ:TagSprite = new TagSprite(pos.x, pos.y);
            civ.loadGraphic(PlayState.CivTiles, true, true, 16, 16);
            civ.width = civ.height = 8;
            civ.offset = new FlxPoint(4,4);

            civ.tag = TagSprite.CIV_WANDERING;

            civ.addAnimation("run", [1, 0, 2, 3], 8, true);
            civ.addAnimation("idle", [0,3], 1.5, true);
            civ.play("run");

            civs.add(civ);
        }

        public function updateCivs(): void {
            for (var i:int = 0; i < civs.length; i++) {
                var civ:TagSprite = civs.members[i];
                civ.decTimer();
                if (civ.pathSpeed == 0 || (civ.touching && civ.timer == 0)) {
                    civ.stopFollowingPath(true);
                    civ.velocity.x = civ.velocity.y = 0;
                    // check if in escape pod
                    var curRoom:FlxPoint = getRoomForPoint(civ.x, civ.y);
                    if (curRoom.x == 5 && curRoom.y == 2) {
                        if (civ.tag == TagSprite.CIV_HOME) {
                            civ.play("idle");
                        } else {
                            civ.tag = TagSprite.CIV_HOME;

                            var finalDestination:FlxPoint = getRoomCorner(getEscapePod());
                            finalDestination.x += 16 + 24 * (saveCounter % 3);
                            finalDestination.y += 8 + (3 * 16 + 8) * (saveCounter % 2);

                            var restingPath:FlxPath = level.findPath(new FlxPoint(civ.x, civ.y), finalDestination);
                            civ.followPath(restingPath, CIV_SPEED);

                            saveCounter++;
                            updateLabels();
                            FlxG.play(SFX_SAVED, 1);
                        }
                        continue; // we are in the room
                    } else {
                        // get new path
                        var newDestination:FlxPoint = getRoomCenter(getRandomRoom(true));
                        var path:FlxPath = level.findPath(new FlxPoint(civ.x+4, civ.y+4), newDestination);
                        civ.followPath(path, CIV_SPEED);
                        civ.tag = TagSprite.CIV_WANDERING;
                        civ.timer = 10;
                    }
                }
                civ.angle = civ.pathAngle;
            }
        }

        // BOTS

        public function placeBot(tag:int, pos:FlxPoint=null): void {
            if (pos == null) {
                pos = getRoomCenter(getRandomRoom(false));
            }
            var bot:TagSprite = new TagSprite(pos.x, pos.y);
            bot.loadGraphic(PlayState.CivTiles, true, true, 16, 16);
            bot.width = bot.height = 10;
            bot.offset = new FlxPoint(3,3);
            bot.tag = tag;

            if (tag == TagSprite.BOT_DOOR) {
                bot.tag = TagSprite.BOT_DOOR;
                bot.addAnimation("run", [10, 11], 8, true);
                bot.addAnimation("idle", [8, 9], 1.5, true);
            } else if (tag == TagSprite.BOT_POINTER) {
                bot.addAnimation("run", [6, 7], 1.5, true);
                bot.addAnimation("idle", [6, 7], 8, true);
                bot.angle = FlxU.getAngle(new FlxPoint(bot.x, bot.y),
                    getRoomCenter(getEscapePod()));
                // setup room overlay
                var pointerOverlay:TagSprite = new TagSprite(pos.x-16*3, pos.y-16*2);
                pointerOverlay.makeGraphic(7*16,5*16,0x338EB05F);
                pointerOverlay.tag = TagSprite.OVERLAY_POINTER;
                roomOverlays.add(pointerOverlay);
                bot.overlay = pointerOverlay;

                bot.solid = false;
            }

            bot.immovable = (bot.tag == TagSprite.BOT_DOOR);
            bot.play("idle");

            bots.add(bot);
        }

        public function updateBots(): void {
            for (var i:int = 0; i < bots.length; i++) {
                var bot:TagSprite = bots.members[i];
                if (!bot.alive) { continue; }
                bot.immovable = false;
                bot.angle = bot.pathAngle;
                bot.decTimer();
                //bot.solid = bot.timer == 0;
                var botPos:FlxPoint = new FlxPoint(bot.x, bot.y);
                if (bot.pathSpeed == 0) {
                    bot.velocity.x = bot.velocity.y = 0;
                    if (bot.path != null) {
                        bot.x = bot.path.tail().x-5;
                        bot.y = bot.path.tail().y-5;
                    }
                    bot.stopFollowingPath(true);
                    bot.angle = 0;
                    if (bot.tag == TagSprite.BOT_POINTER) {
                        bot.angle = FlxU.getAngle(new FlxPoint(bot.x, bot.y),
                            getRoomCenter(getEscapePod()));
                        if (!bot.overlay.alive) {
                           FlxG.play(SFX_ACTIVATED, 1);
                        }
                        var curRoom:FlxPoint = getRoomForPoint(bot.x, bot.y);
                        bot.showOverlay(getRoomCorner(curRoom));

                        if (curRoom.x == getEscapePod().x && curRoom.y == getEscapePod().y) {
                            var effect:FlxEmitter = createEmitter(180, 0, 0xffaaaaaa, 200);
                            effect.x = bot.x;
                            effect.y = bot.y;

                            bot.overlay.tag = TagSprite.OVERLAY_STEAM;
                            bot.kill();

                            FlxG.overlap(civs,roomOverlays,civPowerUp);
                            FlxG.overlap(aliens,roomOverlays,killAliens);

                            bot.hideOverlay();
                            if (bot == selected) {
                                selector.visible = false;
                                target.visible = false;
                                selected = null;
                            }
                            continue;
                        }
                    } else {
                        if (bot.path != null && FlxU.getDistance(botPos, bot.path.tail()) < 16) {
                            bot.immovable = true;
                        }
                    }
                    bot.play("idle");
                    if (bot == selected) {
                        target.visible = false;
                    }
                }
            }
            if (selected != null) {
                selector.x = selected.x-3;
                selector.y = selected.y-3;
            }
        }

        // ALIENS

        public function placeAlien(pos:FlxPoint=null): void { //return;
            if (pos == null) {
                pos = getRoomCenter(getRandomAlienRoom());
            }
            var alien:TagSprite = new TagSprite(pos.x, pos.y);
            alien.loadGraphic(PlayState.CivTiles, true, true, 16, 16);
            alien.width = alien.height = 8;
            alien.offset = new FlxPoint(4,4);
            alien.timer = 0;

            alien.addAnimation("run", [13, 14], 8, true);
            //alien.addAnimation("idle", [0,3], 1.5, true);
            alien.play("run");

            aliens.add(alien);

            // target
            var newDestination:FlxPoint = getRoomCenter(getEscapePod());
            var path:FlxPath = level.findPath(new FlxPoint(alien.x, alien.y), newDestination);
            alien.followPath(path, ALIEN_SPEED);

            var effect:FlxEmitter = createEmitter(20, 0, 0xffffaaaa, 200);
            effect.x = pos.x;
            effect.y = pos.y;

            var hole:FlxSprite = new FlxSprite(pos.x, pos.y);
            hole.loadGraphic(PlayState.CivTiles, true, true, 16, 16);
            hole.frame = 15;
            levelOverlay.add(hole);

            FlxG.camera.shake(0.01, 0.5);
            FlxG.camera.flash(0xffff9999, 0.5);

            FlxG.play(SFX_EXPLOSION,1);
        }

        public function updateAliens(): void {
            for (var i:int = 0; i < aliens.length; i++) {
                var alien:TagSprite = aliens.members[i];
                alien.decTimer();
                if (alien.pathSpeed == 0 || (alien.touching && alien.timer == 0)) {
                    alien.stopFollowingPath(true);
                    alien.velocity.x = alien.velocity.y = 0;
                    // check if in escape pod
                    var curRoom:FlxPoint = getRoomForPoint(alien.x, alien.y);
                    if (curRoom.x == 5 && curRoom.y == 2) {
                        //alien.play("idle");
                        if (alien.tag == TagSprite.CIV_HOME) {
                            //civ.play("idle");
                        } else {
                            alien.tag = TagSprite.CIV_HOME;

                            var finalDestination:FlxPoint = getRoomCorner(getEscapePod());
                            finalDestination.x += 16 + 24 * (aliensOnPod % 3);
                            finalDestination.y += 8 + (3 * 16 + 8) * (aliensOnPod % 2);

                            var restingPath:FlxPath = level.findPath(new FlxPoint(alien.x, alien.y), finalDestination);
                            alien.followPath(restingPath, ALIEN_SPEED);
                            aliensOnPod++;
                        }
                        continue; // we are in the room
                    } else {
                        // get new path
                        var newDestination:FlxPoint = getRoomCenter(getEscapePod());
                        if (alien.touching) {
                            newDestination = getRoomCenter(getRandomRoom(true));
                        }
                        var path:FlxPath = level.findPath(new FlxPoint(alien.x+4, alien.y+4), newDestination);
                        alien.followPath(path, ALIEN_SPEED);
                        alien.timer = 10;
                        FlxG.play(SFX_BLOCKED, 1);
                    }
                }
                alien.angle = alien.pathAngle;
            }
        }

        // UPDATE

        override public function update():void {
            // ebrake
            if (FlxG.elapsed > 0.05) { return; } // in theory on a super slow machine these could cause total and utter catestrophic failure.
            // lift off occurred
            if (liftOff) {
                if (FlxG.keys.justPressed("R")) {
                    FlxG.resetState();
                }
                gameOver.update(); // only update // draw this when paused
                return;
            }
            // controls always occur
            var mousePos:FlxPoint = new FlxPoint(FlxG.mouse.x, FlxG.mouse.y);
            var mouseTilePos:FlxPoint = nearestTileCenter(FlxG.mouse.x, FlxG.mouse.y);
            if(FlxG.mouse.justPressed()) {
                var selectedNewMember:Boolean = false;
                for (var i:int = 0; i < bots.length; i++) {
                    var bot:TagSprite = bots.members[i];
                    if (!bot.alive) { continue; }
                    var botPos:FlxPoint = new FlxPoint(bot.x, bot.y);

                    if (bot.overlapsPoint(mousePos)
                        || FlxU.getDistance(mousePos, botPos) < 20) {
                        if (selected == bot) { break; } // don't select yourself
                        selected = bot;
                        selector.x = bot.x-3;
                        selector.y = bot.y-3;
                        selector.visible = true;
                        selectedNewMember = true;
                        target.visible = false;
                        if (selected.path && selected.pathSpeed > 0) {
                            target.visible = true;
                            target.x = selected.path.tail().x - 4;
                            target.y = selected.path.tail().y - 8;
                        }
                        break;
                    }
                }
                if (!selectedNewMember && selected != null) {
                    selected.stopFollowingPath(true);
                    var targetPos:FlxPoint = new FlxPoint(mouseTilePos.x+4, mouseTilePos.y+8);
                    var path:FlxPath = level.findPath(new FlxPoint(selected.x+4, selected.y+4),
                      targetPos);
                    selected.followPath(path, BOT_SPEED);
                    selected.immovable = false;
                    selected.timer = 2;

                    selected.play("run");

                    if (selected.tag == TagSprite.BOT_POINTER) {
                        selected.hideOverlay();
                    }

                    target.x = mouseTilePos.x - 4;
                    target.y = mouseTilePos.y;
                    target.visible = true;
                }
            }

            // reseting
            if (FlxG.keys.justPressed("R")) {
                FlxG.resetState();
            }

            if (FlxG.keys.justPressed("M")) {
                FlxG.music.volume = FlxG.music.volume == 0 ? 1 : 0;
            }

            // pausing
            if (FlxG.keys.justPressed("SPACE")) {
                paused = !paused;
                if (paused) {
                    stateLabel.text = "paused";
                    FlxG.music.resume();
                    showPauseOverlays();
                } else {
                    stateLabel.text = "takeoff";
                    FlxG.music.pause();
                    hidePauseOverlays();
                }
                FlxG.play(SFX_PAUSE, 1);
            }
            if (paused) {
                timePaused += FlxG.elapsed;
                return pauseGroup.update();
            }

            // pre
            updateCivs();
            updateBots();
            updateAliens();

            if (10-timeRemaining > aliens.length) {
                FlxG.play(countdownSFXs[aliens.length-1], 1);
                placeAlien();
            }

            updateCollisions();
            super.update();

            // post
            updatePhysics();

            // the end
            timeRemaining -= FlxG.elapsed;
            if (timeRemaining < 0) {
                timeRemaining = 0;
                if (!liftOff) {
                    doGameOver();
                }
            }

            if (timeRemaining < 1.5 && !launchPrep) {
                launchPrep = true;
                var epPos:FlxPoint = getRoomCorner(getEscapePod());
                var leftEngine:FlxEmitter = createEmitter(100, 0.6, 0xffffcc99, 150, 3, 0.01);
                leftEngine.x = epPos.x+8;
                leftEngine.y = epPos.y-8;
                add(emitters.remove(leftEngine, true));
                var rightEngine:FlxEmitter = createEmitter(100, 0.6, 0xffffcc99, 150, 3, 0.01);
                rightEngine.x = epPos.x+8;
                rightEngine.y = epPos.y+16*5+8;
                add(emitters.remove(rightEngine, true));
            }
            timerLabel.text = timeRemaining.toFixed(2);
        }

        public function updatePhysics():void {
            FlxG.overlap(civs,aliens,killCivs);
            FlxG.overlap(civs,roomOverlays,civPowerUp);
            updateCollisions();
        }

        public function updateCollisions():void {
            FlxG.collide(level,emitters);
            FlxG.collide(level,civs);
            //FlxG.collide(level,bots);
            FlxG.collide(level,bots, FlxObject.separateX);
            FlxG.collide(level,bots, FlxObject.separateY);
            FlxG.collide(level,aliens);

            FlxG.collide(bots,aliens, FlxObject.separateX);
            FlxG.collide(bots,aliens, FlxObject.separateY);
            FlxG.collide(bots,civs, FlxObject.separateX);
            FlxG.collide(bots,civs, FlxObject.separateY);
        }

        public function updateLabels():void {
            lostLabel.text = lostCounter.toString() + " lost";
            saveLabel.text = saveCounter.toString() + " saved";
        }

        public function doGameOver():void {
            liftOff = true;

            FlxG.camera.shake(0.01, 1.5);
            FlxG.camera.fade(0xff89313F, 1.5, showResults);

            level.setTile(40, 15, 1); // close the door

            FlxG.play(SFX_TAKEOFF, 1);
        }

        public function showPauseOverlays(): void {
            for (var a:int = 0; a < aliens.length; a++) {
                var alien:TagSprite = aliens.members[a];
                if (!alien.alive) { continue; }

                var alienHighlight:TagSprite = new TagSprite(alien.x-5, alien.y-5 );
                alienHighlight.makeGraphic(alien.width + 10, alien.height + 10, 0x5589313F);
                alienHighlight.slowFlicker = true;
                troopHighlights.add(alienHighlight);
            }
            for (var c:int = 0; c < civs.length; c++) {
                var civ:TagSprite = civs.members[c];
                if (!civ.alive) { continue; }

                var civHighlight:TagSprite = new TagSprite(civ.x-5, civ.y-5 );
                civHighlight.makeGraphic(civ.width + 10, civ.height + 10, 0x55E0B580);
                civHighlight.slowFlicker = true;
                troopHighlights.add(civHighlight);
            }
            for (var b:int = 0; b < bots.length; b++) {
                var bot:TagSprite = bots.members[b];
                if (!bot.alive) { continue; }

                var botHighlight:TagSprite = new TagSprite(bot.x-8, bot.y-8 );
                botHighlight.makeGraphic(bot.width + 16, bot.height + 16, 0x558EB05F);
                botHighlight.slowFlicker = true;
                troopHighlights.add(botHighlight);
            }

            var roomPos:FlxPoint = getRoomCorner(getEscapePod());
            var podHighlight:TagSprite = new TagSprite(roomPos.x, roomPos.y);
            podHighlight.makeGraphic(6 * 16, 5 * 16, 0x558EB05F);
            podHighlight.slowFlicker = true;
            troopHighlights.add(podHighlight);
        }
        public function hidePauseOverlays(): void {
            troopHighlights.kill();
            troopHighlights.clear();
            troopHighlights.revive();
        }

        public function showResults():void {
            FlxG.camera.stopFX();
            // add results to the game over group
            var bg:FlxSprite = new FlxSprite(-5,0);
            bg.makeGraphic(768+5, 496, 0xff89313F);
            gameOver.add(bg);

            var aliensOnBoard:int = 0;
            for (var i:int = 0; i < aliens.length; i++) {
                var alien:FlxObject = aliens.members[i];
                var roomPos:FlxPoint = getRoomForPoint(alien.x, alien.y);
                if (roomPos.x == 5 && roomPos.y == 2 && alien.alive) {
                    aliensOnBoard++;
                }
            }
            saveCounter = 0; // get a fresh count due to death chaos
            for (var c:int = 0; c < civs.length; c++) {
                var civ:FlxObject = civs.members[c];
                var cRoomPos:FlxPoint = getRoomForPoint(civ.x, civ.y);
                if (cRoomPos.x == 5 && cRoomPos.y == 2 && civ.alive) {
                    saveCounter++;
                }
            }

            if (aliensOnBoard > 0) {
                var alienStats:FlxText = new FlxText(384-240, 140, 480, "You let ALIENS on board. The escape pod eventually crashes to Earth and results in human extinction. No score for you. You suck!");
                alienStats.size = 32;
                alienStats.alignment = "center";
                gameOver.add(alienStats);

                lostCounter += saveCounter;
                saveCounter = 0;
            } else {
                if (saveCounter == 0 && lostCounter < 5) {
                    var zeroSaves:FlxText = new FlxText(384-240, 140, 480, "You saved no one AND left us behind!?");
                    zeroSaves.size = 32;
                    zeroSaves.alignment = "center";
                    gameOver.add(zeroSaves);
                } else if (saveCounter == 0) {
                    var allDead:FlxText = new FlxText(384-240, 140, 480, "They did look awfully hungry. Thanks!");
                    allDead.size = 32;
                    allDead.alignment = "center";
                    gameOver.add(allDead);
                } else if (saveCounter < 5) {
                    var youTried:FlxText = new FlxText(384-240, 140, 480, "At least pretend to try.");
                    youTried.size = 32;
                    youTried.alignment = "center";
                    gameOver.add(youTried);
                }

                var saveStat:FlxText = new FlxText(384-240, 220, 480, "Civilians Saved: " + saveCounter);
                saveStat.size = 32;
                saveStat.alignment = "center";
                gameOver.add(saveStat);

                var leftBehind:FlxText = new FlxText(384-240, 260, 480, "Civilians Left Behind: " + (5 - saveCounter - lostCounter));
                leftBehind.size = 32;
                leftBehind.alignment = "center";
                gameOver.add(leftBehind);

                var pauseRatio:Number = (timePaused + 0.001) / 10.0;
                var timeStat:FlxText = new FlxText(384-240, 310, 480, "Paused For: " + timePaused.toFixed(2) + "s");
                timeStat.size = 32;
                timeStat.alignment = "center";
                gameOver.add(timeStat);
            }
            var restart:FlxText = new FlxText(384-240, FlxG.height-40, 480, "Press R to restart.");
            restart.size = 24;
            restart.alignment = "center";
            gameOver.add(restart);

            var titleString:String = "GAME OVER";
            if (aliensOnBoard == 0 && saveCounter == 5) {
                if (timePaused > 5) {
                    titleString = "SLOW WIN!";
                } else if (timePaused == 0) {
                    titleString = "F#%K YEAH!"
                } else {
                    titleString = "REALZ WIN!";
                }
            }
            var title:FlxText = new FlxText(384-240, 50, 480, titleString);
            title.size = 64;
            title.alignment = "center";
            gameOver.add(title);
        }

        public function killCivs(civ:FlxSprite,alien:FlxSprite):void
        {
            var killEmit:FlxEmitter = createEmitter(20, 0, 0xff883333, 50);
            killEmit.x = civ.x;
            killEmit.y = civ.y;

            civ.kill();

            lostCounter++;
            updateLabels();

            FlxG.play(SFX_DEAD,1);
        }

        public function civPowerUp(civ:TagSprite,emitter:TagSprite):void
        {
            if (emitter.tag == TagSprite.OVERLAY_STEAM) {
                killCivs(civ, emitter);
            } else if (emitter.tag == TagSprite.OVERLAY_POINTER && civ.tag != TagSprite.CIV_HEADING_HOME && civ.timer == 0) {
                civ.tag = TagSprite.CIV_HEADING_HOME;
                civ.stopFollowingPath(true);
                civ.velocity.x = civ.velocity.y = 0;
                var newDestination:FlxPoint = getRoomCenter(getEscapePod());
                var path:FlxPath = level.findPath(new FlxPoint(civ.x, civ.y), newDestination);
                civ.followPath(path, CIV_SPEED);
                civ.timer = 10;
            }
        }

        public function killAliens(alien:TagSprite,emitter:TagSprite):void
        {
            var killEmit:FlxEmitter = createEmitter(20, 0, 0xff883333, 50);
            killEmit.x = alien.x;
            killEmit.y = alien.y;

            alien.kill();
        }

        // UTILITY FUNCTIONS (rooms are 8x6 need to make these contants)

        public function getEscapePod():FlxPoint {
            return new FlxPoint(5, 2);
        }
        public function getRandomRoom(includePod:Boolean):FlxPoint {
            var r:Number = FlxG.random() * 100;
            if (r > 90 && includePod) {
                return getEscapePod();
            }
            return new FlxPoint((int)(FlxG.random() * 5), (int)(FlxG.random() * 4));
        }

        public function getRandomAlienRoom():FlxPoint {
            // anywhere but the last column
            return new FlxPoint((int)(FlxG.random() * 4), (int)(FlxG.random() * 4));
        }

        public function getRoomCenter(roomPos:FlxPoint):FlxPoint {
            return new FlxPoint(toRaw(roomPos.x * 8 + 4) + 0, toRaw(roomPos.y * 6 + 3) + 0);
        }

        public function getRoomCorner(roomPos:FlxPoint):FlxPoint {
            return new FlxPoint(toRaw(roomPos.x * 8 + 1) + 0, toRaw(roomPos.y * 6 + 1) + 0);
        }

        public function getRoomForPoint(x:int, y:int):FlxPoint {
            return new FlxPoint( Math.floor(toTile(x) / 8), Math.floor(toTile(y) / 6));
        }

        public function toTile(x:int):int {
            return x / 16;
        }
        public function toRaw(x:int):int {
            return x * 16;
        }

        public function nearestTileCenter(x:int, y:int):FlxPoint {
            return new FlxPoint( Math.floor(toTile(x)) * 16 + 4, Math.floor(toTile(y)) * 16 + 0);
        }

        public function q():int {
            return (FlxG.random() > 0.3) ? 1 : 0;
        }

        // EFFECTS

        private function createEmitter(numParticles:int, lifespan:Number, color:uint, v:int, size:int=2, frequency:Number=0.1):FlxEmitter {
            var emitter:FlxEmitter = new FlxEmitter;

            //emitter.frequency = 1; Not sure if this replaces delay or not?
            emitter.gravity = 0;
            emitter.setXSpeed( -v, v);
            emitter.setYSpeed( -v ,v);
            emitter.setRotation( -80, 80);

            for (var i:int = 0; i < numParticles; i++)
            {
                var particle:FlxParticle = new FlxParticle();
                particle.makeGraphic(size, size, color);
                particle.exists = false;
                emitter.add(particle);
            }

            emitters.add(emitter);
            emitter.start(lifespan == 0, lifespan/6.0, frequency=frequency);
            emitter.lifespan = lifespan;
            return emitter;
        }

        override public function draw():void {
            super.draw();
            if (liftOff) {
                gameOver.draw();
            }
            // DEBUG
            //To draw path
            for (var i:int = 0; i < aliens.length; i++) {
                var d:FlxObject = aliens.members[i];
                if (d.path != null)
                {
                    //d.path.drawDebug();
                }
            }
        }
    }

}
