package org.flintparticles.twoD.renderers.mxml
{
	import flash.display.DisplayObject;
	
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.common.renderers.FlexRendererBase;
	import org.flintparticles.twoD.particles.Particle2D;	

	/**
	 * The DisplayObjectRenderer adds particles to its display list 
	 * and lets the flash player render them in its usual way.
	 * 
	 * <p>Particles may be represented by any DisplayObject and each particle 
	 * must use a different DisplayObject instance. The DisplayObject
	 * to be used should not be defined using the SharedImage initializer
	 * because this shares one DisplayObject instance between all the particles.
	 * The ImageClass initializer is commonly used because this creates a new 
	 * DisplayObject for each particle.</p>
	 * 
	 * <p>The DisplayObjectRenderer has mouse events disabled for itself and any 
	 * display objects in its display list. To enable mouse events for the renderer
	 * or its children set the mouseEnabled or mouseChildren properties to true.</p>
	 * 
	 * <p>Because the DisplayObject3DRenderer directly uses the particle's image,
	 * it is not suitable in situations where the same particle will be simultaneously
	 * displayed by two different renderers.</p> 
	 */
	public class DisplayObjectRenderer extends FlexRendererBase
	{
		/**
		 * The constructor creates a DisplayObjectRenderer. After creation it should
		 * be added to the display list of a DisplayObjectContainer to place it on 
		 * the stage and should be applied to an Emitter using the Emitter's
		 * renderer property.
		 * 
		 * @see org.flintparticles.twoD.emitters.Emitter#renderer
		 */
		public function DisplayObjectRenderer()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function renderParticles( particles:Array ):void
		{
			var particle:Particle2D;
			var img:DisplayObject;
			var len:int = particles.length;
			for( var i:int = 0; i < len; ++i )
			{
				particle = particles[i];
				img = particle.image;
				img.transform.colorTransform = particle.colorTransform;
				img.transform.matrix = particle.matrixTransform;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function addParticle( particle:Particle ):void
		{
			addChildAt( particle.image, 0 );
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function removeParticle( particle:Particle ):void
		{
			removeChild( particle.image );
		}
	}
}