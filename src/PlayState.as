package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
        [Embed(source="assets/tiles.png")] static public var RTiles:Class;
        [Embed(source="assets/civ.png")] static public var CivTiles:Class;

        static public var CIV_SPEED:Number = 200;
        static public var BOT_SPEED:Number = 400;
        static public var ALIEN_SPEED:Number = 200;

        public var level:FlxTilemap;

        public var liftOff:Boolean;
        public var paused:Boolean;
        public var pauseGroup:FlxGroup;


        public var levelOverlay:FlxGroup;

        public var emitters:FlxGroup;

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

        public var saveLabel:FlxText;
        public var lostLabel:FlxText;

		override public function create():void
		{
            FlxG.mouse.show();

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

            // TODO: add a second tile map here that will sit over the first
            // for decorations. this one will NOT be an automap and it will
            // not partake in collisions

            // GROUPS
            levelOverlay = new FlxGroup();
            add(levelOverlay);

            emitters = new FlxGroup();
            add(emitters);

            civs = new FlxGroup();
            add(civs);

            bots = new FlxGroup();
            add(bots);

            aliens = new FlxGroup();
            add(aliens);

            roomOverlays = new FlxGroup();
            add(roomOverlays);

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

            // PAUSE OVERLAY
            paused = false;
            pauseGroup = new FlxGroup();
            add(pauseGroup); // to add or not to add?

            // UI
            stateLabel = new FlxText(650, 20, 120, "takeoff");
            stateLabel.size = 24;
            add(stateLabel);

            timeRemaining = 10.0;
            timerLabel = new FlxText(650, 60, 120, timeRemaining.toFixed(2));
            timerLabel.size = 24;
            add(timerLabel);

            saveLabel = new FlxText(650, 320, 120, saveCounter.toString() + " saved");
            saveLabel.size = 24;
            add(saveLabel);

            lostLabel = new FlxText(650, 360, 120, lostCounter.toString() + " lost");
            lostLabel.size = 24;
            add(lostLabel);

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

            civ.tag = TagSprite.CIV_WANDERING;

            civ.addAnimation("run", [1, 0, 2, 3], 8, true);
            civ.addAnimation("idle", [0,3], 1.5, true);
            civ.play("run");

            civs.add(civ);
        }

        public function updateCivs(): void {
            for (var i:int = 0; i < civs.length; i++) {
                var civ:TagSprite = civs.members[i];
                if (civ.pathSpeed == 0 || civ.touching) {
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
                        }
                        continue; // we are in the room
                    } else {
                        // get new path
                        var newDestination:FlxPoint = getRoomCenter(getRandomRoom(true));
                        var path:FlxPath = level.findPath(new FlxPoint(civ.x, civ.y), newDestination);
                        civ.followPath(path, CIV_SPEED);
                        civ.tag = TagSprite.CIV_WANDERING;
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
            bot.width = bot.height = 12;
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
                pointerOverlay.makeGraphic(7*16,5*16,0x33338833);
                pointerOverlay.tag = TagSprite.OVERLAY_POINTER;
                roomOverlays.add(pointerOverlay);
                bot.overlay = pointerOverlay;

                bot.solid = false;
            }

            //bot.immovable = (bot.tag == TagSprite.BOT_POINTER);
            bot.play("idle");

            bots.add(bot);
        }

        public function updateBots(): void {
            for (var i:int = 0; i < bots.length; i++) {
                var bot:TagSprite = bots.members[i];
                bot.immovable = false;
                bot.angle = bot.pathAngle;
                if (bot.pathSpeed == 0) {
                    bot.stopFollowingPath(true);
                    bot.velocity.x = bot.velocity.y = 0;
                    //bot.immovable = (bot.tag == TagSprite.BOT_POINTER);
                    bot.angle = 0;
                    if (bot.tag == TagSprite.BOT_POINTER) {
                        bot.angle = FlxU.getAngle(new FlxPoint(bot.x, bot.y),
                            getRoomCenter(getEscapePod()));
                        bot.showOverlay(getRoomCorner(getRoomForPoint(bot.x, bot.y)));
                    }
                    bot.play("idle");
                    if (bot == selected) {
                        target.visible = false;
                    }
                }
            }
            if (selected != null) {
                selector.x = selected.x;
                selector.y = selected.y;
            }
        }

        // ALIENS

        public function placeAlien(pos:FlxPoint=null): void { //return;
            if (pos == null) {
                pos = getRoomCenter(getRandomAlienRoom());
            }
            var alien:FlxSprite = new FlxSprite(pos.x, pos.y);
            alien.loadGraphic(PlayState.CivTiles, true, true, 16, 16);
            alien.width = alien.height = 8;

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
        }

        public function updateAliens(): void {
            for (var i:int = 0; i < aliens.length; i++) {
                var alien:FlxSprite = aliens.members[i];
                if (alien.pathSpeed == 0 || (alien.touching)) {
                    alien.stopFollowingPath(true);
                    alien.velocity.x = alien.velocity.y = 0;
                    // check if in escape pod
                    var curRoom:FlxPoint = getRoomForPoint(alien.x, alien.y);
                    if (curRoom.x == 5 && curRoom.y == 2) {
                        //alien.play("idle");
                        continue; // we are in the room
                    } else {
                        // get new path
                        var newDestination:FlxPoint = getRoomCenter(getEscapePod());
                        if (alien.touching) {
                            newDestination = getRoomCenter(getRandomRoom(true));
                        }
                        var path:FlxPath = level.findPath(new FlxPoint(alien.x, alien.y), newDestination);
                        alien.followPath(path, ALIEN_SPEED);
                    }
                }
                alien.angle = alien.pathAngle;
            }
        }

        // UPDATE

        override public function update():void {
            // lift off occurred
            if (liftOff) {
                super.update();
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
                    var botPos:FlxPoint = new FlxPoint(bot.x, bot.y);

                    if (bot.overlapsPoint(mousePos)
                        || FlxU.getDistance(mousePos, botPos) < 20) {
                        selected = bot;
                        selector.x = bot.x;
                        selector.y = bot.y;
                        selector.visible = true;
                        selectedNewMember = true;
                        break;
                    }
                }
                if (!selectedNewMember && selected != null) {
                    selected.stopFollowingPath(true);
                    var path:FlxPath = level.findPath(new FlxPoint(selected.x, selected.y),
                      mouseTilePos);
                    selected.followPath(path, BOT_SPEED);
                    selected.immovable = false;

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

            // pausing
            if (FlxG.keys.justPressed("SPACE")) {
                paused = !paused;
                if (paused) {
                    stateLabel.text = "paused";
                } else {
                    stateLabel.text = "takeoff"
                }
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
                placeAlien();
            }

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
            timerLabel.text = timeRemaining.toFixed(2);
        }

        public function updatePhysics():void {
            FlxG.overlap(civs,aliens,killCivs);
            FlxG.overlap(civs,roomOverlays,civPowerUp);

            FlxG.collide(level,emitters);
            FlxG.collide(level,civs);
            FlxG.collide(level,bots);
            FlxG.collide(level,aliens);

            FlxG.collide(bots,aliens);
            FlxG.collide(bots,civs);
        }

        public function updateLabels():void {
            lostLabel.text = lostCounter.toString() + " lost";
            saveLabel.text = saveCounter.toString() + " saved";
        }

        public function doGameOver():void {
            liftOff = true;

            FlxG.camera.shake(0.01, 1.5);
            FlxG.camera.fade(0xff883333, 1.5, showResults);

            level.setTile(40, 15, 1); // close the door
        }

        public function showResults():void {
            FlxG.camera.stopFX();
            // add results to the game over group
            var bg:FlxSprite = new FlxSprite(-5,0);
            bg.makeGraphic(768, 496, 0xff883333);
            gameOver.add(bg);

            var title:FlxText = new FlxText(384-240, 100, 480, "GAME OVER");
            title.size = 64;
            title.alignment = "center";
            gameOver.add(title);

            var saveStat:FlxText = new FlxText(384-240, 230, 480, "Civilians Saved: " + saveCounter);
            saveStat.size = 32;
            saveStat.alignment = "center";
            gameOver.add(saveStat);

            var pauseRatio:Number = (timePaused + 0.001) / 10.0;
            var timeStat:FlxText = new FlxText(384-240, 270, 480, "Pause Ratio: " + pauseRatio.toFixed(2));
            timeStat.size = 32;
            timeStat.alignment = "center";
            gameOver.add(timeStat);

            var restart:FlxText = new FlxText(384-240, 400, 480, "Press R to restart.");
            restart.size = 24;
            restart.alignment = "center";
            gameOver.add(restart);
        }

        public function killCivs(civ:FlxSprite,alien:FlxSprite):void
        {
            var killEmit:FlxEmitter = createEmitter(20, 0, 0xff883333, 50);
            killEmit.x = civ.x;
            killEmit.y = civ.y;

            civ.kill();

            lostCounter++;
            updateLabels();
        }

        public function civPowerUp(civ:TagSprite,emitter:TagSprite):void
        {
            if (emitter.tag == TagSprite.OVERLAY_STEAM) {
                killCivs(civ, emitter);
            } else if (emitter.tag == TagSprite.OVERLAY_POINTER && civ.tag != TagSprite.CIV_HEADING_HOME) {
                civ.tag = TagSprite.CIV_HEADING_HOME;
                civ.stopFollowingPath(true);
                civ.velocity.x = civ.velocity.y = 0;
                var newDestination:FlxPoint = getRoomCenter(getEscapePod());
                var path:FlxPath = level.findPath(new FlxPoint(civ.x, civ.y), newDestination);
                civ.followPath(path, CIV_SPEED);
            }
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

        private function createEmitter(numParticles:int, lifespan:Number, color:uint, v:int):FlxEmitter {
            var emitter:FlxEmitter = new FlxEmitter;

            //emitter.frequency = 1; Not sure if this replaces delay or not?
            emitter.gravity = 0;
            emitter.setXSpeed( -v, v);
            emitter.setYSpeed( -v ,v);
            emitter.setRotation( -80, 80);

            for (var i:int = 0; i < numParticles; i++)
            {
                var particle:FlxParticle = new FlxParticle();
                particle.makeGraphic(2, 2, color);
                particle.exists = false;
                emitter.add(particle);
            }

            emitters.add(emitter);
            emitter.start(lifespan == 0, lifespan/6.0);
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
