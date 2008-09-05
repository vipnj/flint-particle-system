package org.flintparticles.threeD.away3d 
{
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.common.renderers.RendererBase;
	import org.flintparticles.threeD.particles.Particle3D;
	
	import away3d.containers.ObjectContainer3D;
	import away3d.core.base.Object3D;	

	/**
	 * 
	 */
	public class Object3DRenderer extends RendererBase
	{
		private var _container:ObjectContainer3D;
		
		public function Object3DRenderer( container:ObjectContainer3D )
		{
			super();
			_container = container;
		}
		
		/**
		 * This method positions and scales the particles according to the
		 * particles' positions relative to the camera viewport.
		 * 
		 * <p>This method is called internally by Flint and shouldn't need to be called
		 * by the user.</p>
		 * 
		 * @param particles The particles to be rendered.
		 */
		override protected function renderParticles( particles:Array ):void
		{
			var o:Object3D;
			for each( var p:Particle3D in particles )
			{
				o = p.image;
				o.x = p.position.x;
				o.y = p.position.y;
				o.z = p.position.z;
				o.scaleX = o.scaleY = o.scaleZ = p.scale;
			}
		}
		
		/**
		 * This method is called when a particle is added to an emitter -
		 * usually becaus ethe emitter has just created the particle. The
		 * method adds the particle's image to the renderer's display list.
		 * It is called internally by Flint and need not be called by the user.
		 * 
		 * @param particle The particle being added to the emitter.
		 */
		override protected function addParticle( particle:Particle ):void
		{
			_container.addChild( Object3D( particle.image ) );
		}
		
		/**
		 * This method is called when a particle is removed from an emitter -
		 * usually because the particle is dying. The method removes the 
		 * particle's image from the renderer's display list. It is called 
		 * internally by Flint and need not be called by the user.
		 * 
		 * @param particle The particle being removed from the emitter.
		 */
		override protected function removeParticle( particle:Particle ):void
		{
			_container.removeChild( Object3D( particle.image ) );
		}
	}
}
