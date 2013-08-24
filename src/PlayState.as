package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
        [Embed(source="assets/tiles.png")] static public var RTiles:Class;
        [Embed(source="assets/civ.png")] static public var CivTiles:Class;

        static public var CIV_SPEED:Number = 200;
        static public var BOT_SPEED:Number = 400;
        static public var ALIEN_SPEED:Number = 150;

        public var level:FlxTilemap;

        public var paused:Boolean;
        public var pauseGroup:FlxGroup;

        public var civs:FlxGroup;
        public var bots:FlxGroup;
        public var aliens:FlxGroup;


        public var target:FlxSprite;
        public var selector:FlxSprite;
        public var selected:FlxSprite;

        public var stateLabel:FlxText;

        public var timeRemaining:Number;
        public var timerLabel:FlxText;

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
                1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1,
                1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
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

            // GROUPS
            civs = new FlxGroup();
            add(civs);
            for (var civ:int = 0; civ < 5; civ++) {
                placeCiv();
            }

            bots = new FlxGroup();
            add(bots);
            for (var bot:int = 0; bot < 3; bot++) {
                placeBot();
            }

            aliens = new FlxGroup();
            add(aliens);
            placeAlien();

            // PAUSE OVERLAY
            paused = false;
            pauseGroup = new FlxGroup();
            add(pauseGroup); // to add or not to add?

            // UI
            stateLabel = new FlxText(650, 20, 120, "running");
            stateLabel.size = 24;
            add(stateLabel);

            timeRemaining = 10.0;
            timerLabel = new FlxText(650, 60, 120, timeRemaining.toFixed(2));
            timerLabel.size = 24;
            add(timerLabel);

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
        }

        // CIVILIANS

        public function placeCiv(): void {
            var pos:FlxPoint = getRoomCenter(getRandomRoom(false));
            var civ:FlxSprite = new FlxSprite(pos.x, pos.y);
            civ.loadGraphic(PlayState.CivTiles, true, true, 16, 16);
            civ.width = civ.height = 8;

            civ.addAnimation("run", [1, 0, 2, 3], 8, true);
            civ.addAnimation("idle", [0,3], 1.5, true);
            civ.play("run");

            civs.add(civ);
        }

        public function updateCivs(): void {
            for (var i:int = 0; i < civs.length; i++) {
                var civ:FlxSprite = civs.members[i];
                if (civ.pathSpeed == 0 || civ.touching) {
                    civ.stopFollowingPath(true);
                    civ.velocity.x = civ.velocity.y = 0;
                    // check if in escape pod
                    var curRoom:FlxPoint = getRoomForPoint(civ.x, civ.y);
                    if (curRoom.x == 5 && curRoom.y == 2) {
                        civ.play("idle");
                        continue; // we are in the room
                    } else {
                        // get new path
                        var newDestination:FlxPoint = getRoomCenter(getRandomRoom(true));
                        var path:FlxPath = level.findPath(new FlxPoint(civ.x, civ.y), newDestination);
                        civ.followPath(path, CIV_SPEED);
                    }
                }
                civ.angle = civ.pathAngle;
            }
        }

        // BOTS

        public function placeBot(): void {
            var pos:FlxPoint = getRoomCenter(getRandomRoom(false));
            var bot:FlxSprite = new FlxSprite(pos.x, pos.y);
            bot.loadGraphic(PlayState.CivTiles, true, true, 16, 16);
            bot.width = bot.height = 12;
            bot.immovable = true;
            bot.addAnimation("run", [10, 11], 8, true);
            bot.addAnimation("idle", [8, 9], 1.5, true);
            bot.play("idle");

            bots.add(bot);
        }

        public function updateBots(): void {
            for (var i:int = 0; i < bots.length; i++) {
                var bot:FlxSprite = bots.members[i];
                bot.immovable = false;
                bot.angle = bot.pathAngle;
                if (bot.pathSpeed == 0) {
                    bot.stopFollowingPath(true);
                    bot.velocity.x = bot.velocity.y = 0;
                    bot.immovable = true;
                    bot.angle = 0;
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

        public function placeAlien(): void {
            var pos:FlxPoint = getRoomCenter(getRandomRoom(false));
            var alien:FlxSprite = new FlxSprite(pos.x, pos.y);
            alien.loadGraphic(PlayState.CivTiles, true, true, 16, 16);
            alien.width = alien.height = 8;

            alien.addAnimation("run", [13, 14], 8, true);
            //alien.addAnimation("idle", [0,3], 1.5, true);
            alien.play("run");

            aliens.add(alien);

            // target
            var newDestination:FlxPoint = getRoomCenter(new FlxPoint(5, 2));
            var path:FlxPath = level.findPath(new FlxPoint(alien.x, alien.y), newDestination);
            alien.followPath(path, ALIEN_SPEED);
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
                        var newDestination:FlxPoint = getRoomCenter(new FlxPoint(5, 2));
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
            // controls always occur
            var mousePos:FlxPoint = new FlxPoint(FlxG.mouse.x, FlxG.mouse.y);
            var mouseTilePos:FlxPoint = nearestTileCenter(FlxG.mouse.x, FlxG.mouse.y);
            if(FlxG.mouse.justPressed()) {
                var selectedNewMember:Boolean = false;
                for (var i:int = 0; i < bots.length; i++) {
                    var bot:FlxSprite = bots.members[i];
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
                    stateLabel.text = "running"
                }
            } 
            if (paused)
                return pauseGroup.update();

            // pre
            updateCivs();
            updateBots();
            updateAliens();

            if (10-timeRemaining > aliens.length) {
                placeAlien();
            }

            super.update();

            // post
            FlxG.collide(level,civs);
            FlxG.collide(level,bots);
            FlxG.collide(level,aliens);
            FlxG.collide(bots,aliens);
            FlxG.collide(bots,civs);

            // the end
            timeRemaining -= FlxG.elapsed
            if (timeRemaining < 0) { timeRemaining = 0; }
            timerLabel.text = timeRemaining.toFixed(2);
        }

        // UTILITY FUNCTIONS (rooms are 8x6 need to make these contants)

        public function getRandomRoom(includePod:Boolean):FlxPoint {
            var r:Number = FlxG.random() * 100;
            if (r > 90 && includePod) {
                return new FlxPoint(5, 2);
            }
            return new FlxPoint((int)(FlxG.random() * 5), (int)(FlxG.random() * 4));
        }

        public function getRoomCenter(roomPos:FlxPoint):FlxPoint {
            return new FlxPoint(toRaw(roomPos.x * 8 + 4) + 4, toRaw(roomPos.y * 6 + 3) + 0);
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

        // DEBUG
        override public function draw():void {
            super.draw();
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
