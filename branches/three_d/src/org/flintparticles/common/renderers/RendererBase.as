
package org.flintparticles.common.renderers 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	import org.flintparticles.common.emitters.Emitter;
	import org.flintparticles.common.events.EmitterEvent;
	import org.flintparticles.common.events.ParticleEvent;
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.common.renderers.Renderer;	

	/**
	 * 
	 */

	public class RendererBase extends Sprite implements Renderer 
	{
		private var _emitters:Array;
		
		public function RendererBase()
		{
			_emitters = new Array();
			mouseEnabled = false;
			mouseChildren = false;
			addEventListener( Event.ADDED_TO_STAGE, addedToStage, false, 0, true );
		}
		
		public function addEmitter( emitter : Emitter ) : void
		{
			_emitters.push( emitter );
			if( stage )
			{
				stage.invalidate();
			}
			emitter.addEventListener( EmitterEvent.EMITTER_UPDATED, emitterUpdated, false, 0, true );
			emitter.addEventListener( ParticleEvent.PARTICLE_CREATED, particleAdded, false, 0, true );
			emitter.addEventListener( ParticleEvent.PARTICLE_DEAD, particleRemoved, false, 0, true );
			addEventListener( Event.RENDER, updateParticles, false, 0, true );
		}

		public function removeEmitter( emitter : Emitter ) : void
		{
			for( var i:int = 0; i < _emitters.length; ++i )
			{
				if( _emitters[i] == emitter )
				{
					_emitters.splice( i, 1 );
					if( stage )
					{
						stage.invalidate();
					}
					emitter.removeEventListener( EmitterEvent.EMITTER_UPDATED, emitterUpdated );
					emitter.removeEventListener( ParticleEvent.PARTICLE_CREATED, particleAdded );
					emitter.removeEventListener( ParticleEvent.PARTICLE_DEAD, particleRemoved );
					removeEventListener( Event.RENDER, updateParticles );
					return;
				}
			}
		}
		
		private function addedToStage( ev:Event ):void
		{
			if( stage )
			{
				stage.invalidate();
			}
		}
		
		private function particleAdded( ev:ParticleEvent ):void
		{
			addParticle( ev.particle );
			if( stage )
			{
				stage.invalidate();
			}
		}
		
		private function particleRemoved( ev:ParticleEvent ):void
		{
			removeParticle( ev.particle );
			if( stage )
			{
				stage.invalidate();
			}
		}

		private function emitterUpdated( ev:EmitterEvent ):void
		{
			if( stage )
			{
				stage.invalidate();
			}
		}
		
		private function updateParticles( ev:Event ) : void
		{
			var particles:Array = new Array();
			for( var i:int = 0; i < _emitters.length; ++i )
			{
				particles = particles.concat( _emitters[i].particles );
			}
			renderParticles( particles );
		}
		
		
		
		/**
		 * The addParticle method is called when a particle is added to the emitter that
		 * this renderer is assigned to.
		 * @param particle The particle.
		 */
		protected function addParticle( particle:Particle ):void
		{
		}
		
		/**
		 * The removeParticle method is called when a particle is removed from the 
		 * emitter that this renderer is assigned to.
		 * @param particle The particle.
		 */
		protected function removeParticle( particle:Particle ):void
		{
		}
		
		/**
		 * The renderParticles method is called every frame so the renderer can
		 * draw the particles that are in the emitter that this renderer is
		 * assigned to.
		 * @param particles The particles to draw.
		 */
		protected function renderParticles( particles:Array ):void
		{
		}
	}
}
