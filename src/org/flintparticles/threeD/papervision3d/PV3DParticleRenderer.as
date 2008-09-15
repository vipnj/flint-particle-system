package org.flintparticles.threeD.papervision3d 
{
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.common.renderers.RendererBase;
	import org.flintparticles.threeD.particles.Particle3D;
	import org.papervision3d.core.geom.Particles;
	import org.papervision3d.core.geom.renderables.Particle;

	/**
	 * 
	 */
	public class PV3DParticleRenderer extends RendererBase
	{
		private var _container:Particles;
		
		public function PV3DParticleRenderer( container:Particles )
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
			var o:org.papervision3d.core.geom.renderables.Particle;
			for each( var p:Particle3D in particles )
			{
				o = p.image;
				o.x = p.position.x;
				o.y = p.position.y;
				o.z = p.position.z;
				if( p.dictionary["pv3dBaseSize"] )
				{
					o.size = p.scale * p.dictionary["pv3dBaseSize"];
				}
				else
				{
					o.size = p.scale;
				}
				// TODO: rotation
				
				if( o.material )
				{
					o.material.fillColor = p.color & 0xFFFFFF;
					o.material.fillAlpha = p.alpha;
				}
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
		override protected function addParticle( particle:org.flintparticles.common.particles.Particle ):void
		{
			_container.addParticle( org.papervision3d.core.geom.renderables.Particle( particle.image ) );
		}
		
		/**
		 * This method is called when a particle is removed from an emitter -
		 * usually because the particle is dying. The method removes the 
		 * particle's image from the container's display list. It is called 
		 * internally by Flint and need not be called by the user.
		 * 
		 * @param particle The particle being removed from the emitter.
		 */
		override protected function removeParticle( particle:org.flintparticles.common.particles.Particle ):void
		{
			_container.removeParticle( org.papervision3d.core.geom.renderables.Particle( particle.image ) );
		}
	}
}
