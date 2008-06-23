package org.flintparticles.twoD.particles 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import org.flintparticles.common.particles.ParticleFactory;
	import org.flintparticles.common.utils.DisplayObjectUtils;
	import org.flintparticles.common.utils.Maths;	

	public class Particle2DUtils 
	{
		/**
		 * Adds existing display objects as particles to the emitter. This allows you, for example, 
		 * to take an existing image and subject it to the actions of the emitter.
		 * 
		 * <p>This method moves all the display objects into the emitter's renderer,
		 * removing them from their current position within the display list. It will
		 * only work if a renderer has been defined for the emitter and the renderer has
		 * been added to the display list.</p>
		 * 
		 * @param renderer The display object whose coordinate system the display object's position
		 * is converted to. This is usually the renderer for the particle system created by the emitter.
		 * @param objects Each parameter is another display object for adding to the emitter.
		 * If you pass an array as the parameter, each item in the array should be another
		 * display object for adding to the emitter.
		 */
		public static function createParticles2DFromDisplayObjects( displayObjects:Array, renderer:DisplayObject = null, factory:ParticleFactory = null ):Array
		{
			var particles:Array = new Array();
			for( var i:Number = 0; i < displayObjects.length; ++i )
			{
				particles.push( createParticle2DFromDisplayObject( displayObjects[i], renderer, factory ) );
			}
			return particles;
		}
		
		/*
		 * Used internally to add an individual display object to the emitter
		 */
		public static function createParticle2DFromDisplayObject( obj:DisplayObject, renderer:DisplayObject = null, factory:ParticleFactory = null ):Particle2D
		{
			var particle:Particle2D;
			if( factory )
			{
				particle = Particle2D( factory.createParticle() );
			}
			else
			{
				particle = new Particle2D();
			}
			if ( obj.parent && renderer )
			{
				var p : Point = renderer.globalToLocal( obj.localToGlobal( new Point( 0, 0 ) ) );
				particle.x = p.x;
				particle.y = p.y;
				var r : Number = DisplayObjectUtils.globalToLocalRotation( renderer, DisplayObjectUtils.localToGlobalRotation( obj, 0 ) );
				particle.rotation = Maths.asRadians( r );
				obj.parent.removeChild( obj );
			}
			else
			{
				particle.x = obj.x;
				particle.y = obj.y;
				particle.rotation = Maths.asRadians( obj.rotation );
			}
			particle.image = obj;
			return particle;
		}

		public static function createPixelParticlesFromBitmapData( bitmapData:BitmapData, factory:ParticleFactory = null, offsetX:Number = 0, offsetY:Number = 0 ):Array
		{
			var particles:Array = new Array();
			var width:int = bitmapData.width;
			var height:int = bitmapData.height;
			var y:int;
			var x:int;
			var p:Particle2D;
			if( factory )
			{
				for( y = 0; y < height; ++y )
				{
					for( x = 0; x < width; ++x )
					{
						p = Particle2D( factory.createParticle() );
						p.x = x + offsetX;
						p.y = y + offsetY;
						p.color = bitmapData.getPixel32( x, y );
						particles.push( p );
					}
				}
			}
			else
			{
				for( y = 0; y < height; ++y )
				{
					for( x = 0; x < width; ++x )
					{
						p = new Particle2D();
						p.x = x + offsetX;
						p.y = y + offsetY;
						p.color = bitmapData.getPixel32( x, y );
						particles.push( p );
					}
				}
			}
			return particles;
		}
	}
}
