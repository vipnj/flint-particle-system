package org.flintparticles.threeD.away3d.renderers 
{
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.common.renderers.RendererBase;
	import org.flintparticles.threeD.particles.Particle3D;
	
	import away3d.containers.ObjectContainer3D;
	import away3d.core.base.Mesh;
	import away3d.core.base.Object3D;
	import away3d.sprites.MovieClipSprite;	

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
		 * This method applies the particle's state to the associated image object.
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
				// rotation
				
				// mesh rendering
				if( o is Mesh )
				{
					if( Mesh( o ).material["hasOwnProperty"]( "color" ) )
					{
						Mesh( o ).material["color"] = p.color & 0xFFFFFF;
					}
					if( Mesh( o ).material["hasOwnProperty"]( "alpha" ) )
					{
						Mesh( o ).material["alpha"] = p.alpha;
					}
				}
				
				// display object rendering
				else if( o is MovieClipSprite )
				{
					MovieClipSprite( o ).movieclip.transform.colorTransform = p.colorTransform;
					MovieClipSprite( o ).scaling = p.scale;
				}
				
				// others
				else
				{
					// can't do color transform
					// will try alpha - only works if objects have own canvas
					o.alpha = p.alpha;
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
		override protected function addParticle( particle:Particle ):void
		{
			_container.addChild( Object3D( particle.image ) );
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
			_container.removeChild( Object3D( particle.image ) );
		}
	}
}
