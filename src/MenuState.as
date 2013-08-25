package
{
	import org.flixel.*;

	public class MenuState extends FlxState
	{
		override public function create():void
		{
            FlxG.bgColor = 0xff1c1b1c;

			var t:FlxText;
			t = new FlxText(0,20,FlxG.width,"REASSESSMENT");
			t.size = 64;
			t.alignment = "center";
			add(t);
			t = new FlxText(0,FlxG.height-40,FlxG.width,"click to play");
			t.size = 28;
			t.alignment = "center";
			add(t);

			// instructions
			var instructions:Array = new Array(
				"The station is under attack.",
				"Save all the civilians before the escape pod jettisons.",
				"You have 10 seconds.",
				"",
				"Press SPACE to pause. You will need it.",
				"Click robots to select them. Click again to direct.",
				"Press R to restart.",
				"",
				"Civilians - Chickens with their heads cut off.",
				"Doorbot - Can obstruct aliens or civilians.",
				"Mapbot - Restores civilians' critical thinking skills."
				);

			for (var i:int = 0; i < instructions.length; i++) {
				t = new FlxText(0, 100 + 30 * i, FlxG.width, instructions[i]);
				t.size = 16;
				t.alignment = "center";
				add(t);
			}

			var s:FlxSprite;

			// selection
			s = new FlxSprite(100, 255);
            s.loadGraphic(PlayState.CivTiles, true, true, 16, 16);
            s.frame = 5;
            add(s);
			s = new FlxSprite(120, 255);
            s.loadGraphic(PlayState.CivTiles, true, true, 16, 16);
            s.frame = 4;
            add(s);

			// bots and civs
			s = new FlxSprite(145, 345);
            s.loadGraphic(PlayState.CivTiles, true, true, 16, 16);
            s.frame = 0;
            s.addAnimation("run", [1, 0, 2, 3], 8, true);
            s.play("run");
            add(s);

			s = new FlxSprite(150, 375);
            s.loadGraphic(PlayState.CivTiles, true, true, 16, 16);
            s.frame = 6;
            s.addAnimation("run", [10, 11], 8, true);
            s.play("run");
            add(s);

			s = new FlxSprite(110, 405);
            s.loadGraphic(PlayState.CivTiles, true, true, 16, 16);
            s.frame = 8;
            s.addAnimation("idle", [6, 7], 8, true);
            s.play("idle");
            add(s);

			FlxG.mouse.show();
		}

		override public function update():void
		{
			super.update();

			if(FlxG.mouse.justPressed())
			{
				FlxG.mouse.hide();
				FlxG.switchState(new PlayState());
			}
		}
	}
}
