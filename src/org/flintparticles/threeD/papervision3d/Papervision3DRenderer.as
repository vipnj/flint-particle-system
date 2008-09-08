package org.flintparticles.threeD.papervision3d 
{
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.common.renderers.RendererBase;
	import org.flintparticles.threeD.particles.Particle3D;
	
	import org.papervision3d.core.proto.DisplayObjectContainer3D;
	import org.papervision3d.objects.DisplayObject3D;	

	/**
	 * 
	 */
	public class Papervision3DRenderer extends RendererBase
	{
		private var _container:DisplayObjectContainer3D;
		
		public function Papervision3DRenderer( container:DisplayObjectContainer3D )
		{
			super();
			_container = container;
		}
		
		/**
		 * This method applies the particle's state to the associated image object.
		 * 
		 * <p>This method is called internally by Flint and shouldn't need to be called
		 * by the user.</p>
		 * 
		 * @param particles The particles to be rendered.
		 */
		override protected function renderParticles( particles:Array ):void
		{
			var o:DisplayObject3D;
			for each( var p:Particle3D in particles )
			{
				o = p.image;
				o.x = p.position.x;
				o.y = p.position.y;
				o.z = p.position.z;
				o.scaleX = o.scaleY = o.scaleZ = p.scale;
				// rotation
				
				o.material.fillColor = p.color & 0xFFFFFF;
				o.material.fillAlpha = p.alpha;
			}
		}
		
		/**
		 * This method is called when a particle is added to an emitter -
		 * usually because the emitter has just created the particle. The
		 * method adds the particle's image to the container's display list.
		 * It is called internally by Flint and need not be called by the user.
		 * 
		 * @param particle The particle being added to the emitter.
		 */
		override protected function addParticle( particle:Particle ):void
		{
			_container.addChild( DisplayObject3D( particle.image ) );
		}
		
		/**
		 * This method is called when a particle is removed from an emitter -
		 * usually because the particle is dying. The method removes the 
		 * particle's image from the container's display list. It is called 
		 * internally by Flint and need not be called by the user.
		 * 
		 * @param particle The particle being removed from the emitter.
		 */
		override protected function removeParticle( particle:Particle ):void
		{
			_container.removeChild( DisplayObject3D( particle.image ) );
		}
	}
}
