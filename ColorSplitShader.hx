package shaders;

import flixel.graphics.tile.FlxGraphicsShader;
import flixel.system.FlxAssets.FlxShader;
import gameTools.managers.TimeManager;

/**
 * ...
 * @author Isaac
 */
class ColorSplitShader extends FlxShader 
{
	@:glFragmentSource('
	#pragma header


uniform vec2 u_resolution;
uniform float borderWidth;

void main() {
	
	//grab the flixel texture
	vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
	
	/* Uncomment if you want the base image preserved! Otherwise, this will layer new colors over the original image
	if (color.a == 0.)
	{
	*/
		//variables that will determine what colors we use
		float r = 0.0;
		float g = 0.0;
		float b = 0.0;
		
		//checks if the image is non-transparent at textureCoordv.x - borderwidth. If it is solid, add r to the image
		if (flixel_texture2D(bitmap, vec2((openfl_TextureCoordv.x - borderWidth), openfl_TextureCoordv.y)).a != 0.)
		{
			r = 0.3;
		}
		
		//do the same for blue, but at a different offset
		if (flixel_texture2D(bitmap, vec2((openfl_TextureCoordv.x - borderWidth*0.5), (openfl_TextureCoordv.y - borderWidth*0.5))).a != 0.)
		{
			g = 0.3;
		}
		
		//and finally for green, but this time at texturecoordv.y - borderwidth. You can switch up the -s here for +s or whatever to get different combinations of r / g / b
		if (flixel_texture2D(bitmap, vec2((openfl_TextureCoordv.x), (openfl_TextureCoordv.y - borderWidth*0.5))).a != 0.)
		{
			b = 0.3;
		}
		
		gl_FragColor = vec4(color.r + r, color.g + g, color.b + b, 0);
		/* Uncomment if you want the base image preserved! Otherwise, this will layer new colors over the original image
	}
	else  {
		gl_FragColor = color;
	}
	*/
}
	')
	
	var borderSize:Float = 0.05;
	public function new() 
	{
		super();
	
		borderWidth.value = [borderSize];
	}
	
	public function update()
	{
		borderWidth.value = [borderSize];
	}
	
}