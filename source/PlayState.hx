package;

import flixel.addons.nape.FlxNapeState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxRandom;
import nape.geom.Vec2;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxNapeState
{
	private var accel:FlxAccelerometer;
	private var xText:FlxText;
	private var yText:FlxText;
	private var zText:FlxText;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		accel = new FlxAccelerometer();
		
		createWalls();
		FlxNapeState.space.gravity = Vec2.get(0, 500);
		
		for (i in 0...20) {
			var box:Box = new Box(FlxRandom.intRanged(0, FlxG.width - 30), FlxRandom.intRanged(0, FlxG.height - 30));
			box.body.space = FlxNapeState.space;
			add(box);
		}
		
		xText = new FlxText(0, 20, FlxG.width, "x", 30);
		xText.alignment = "center";
		yText = new FlxText(0, xText.frameHeight + 30, FlxG.width, "y", 30);
		yText.alignment = "center";
		zText = new FlxText(0, xText.frameHeight + yText.frameHeight + 40, FlxG.width, "z", 30);
		zText.alignment = "center";
		
		add(xText);
		add(yText);
		add(zText);
		
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		//var angle:Float = FlxAngle.TO_RAD * (FlxAngle.getAngle(FlxPoint.get(FlxG.width / 2, FlxG.height / 2), FlxG.mouse.getScreenPosition()) - 90);
		//FlxNapeState.space.gravity.setxy(Math.cos(angle) * 500, Math.sin(angle) * 500);
		if (accel.isSupported) 
		{
			xText.text = "x: " + Std.string(Math.round(accel.x * 10) / 10);
			yText.text = "y: " + Std.string(Math.round(accel.y * 10) / 10);
			zText.text = "z: " + Std.string(Math.round(accel.z * 10) / 10);
			
			FlxNapeState.space.gravity.setxy(-accel.x * 500, accel.y * 500);
		}
		
	}	
}