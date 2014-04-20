package;

import flixel.addons.nape.FlxNapeSprite;
import flixel.addons.nape.FlxNapeState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAngle;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Polygon;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxNapeState
{
	var accel:FlxAccelerometer;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		accel = new FlxAccelerometer();
		var walls:Body = new Body(BodyType.STATIC, Vec2.get());
		walls.shapes.add(new Polygon(Polygon.rect( -16, 0, 16, FlxG.height), new Material(0, 100,100)));
		walls.shapes.add(new Polygon(Polygon.rect(FlxG.width, 0, 16, FlxG.height), new Material(0, 100,100)));
		walls.shapes.add(new Polygon(Polygon.rect(0, -16, FlxG.width, 16), new Material(0, 100,100)));
		walls.shapes.add(new Polygon(Polygon.rect(0, FlxG.height, FlxG.width, 16), new Material(0, 100,100)));
		FlxNapeState.space.bodies.add(walls);
		FlxNapeState.space.gravity = Vec2.get(0, 500);
		
		for (i in 0...20) {
			var box:Box = new Box(FlxRandom.intRanged(0, FlxG.width - 30), FlxRandom.intRanged(0, FlxG.height - 30));
			box.body.space = FlxNapeState.space;
			add(box);
		}
		
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
		
		FlxNapeState.space.gravity.setxy(-accel.x * 500, accel.y * 500);
		trace(accel.x);
		trace(accel.y);
		trace(accel.z);
	}	
}