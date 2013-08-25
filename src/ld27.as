package
{
	import org.flixel.*;
	[SWF(width="768", height="496", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	/* width="1152", height="744" */
	public class ld27 extends FlxGame
	{
		public function ld27()
		{
			super(768,496,MenuState,1);
			forceDebugger = true;
			FlxG.flashFramerate = 60;
			FlxG.framerate = 120;
			FlxG.worldDivisions = 12;
		}
	}
}
