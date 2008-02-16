/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord (Big Room)
 * Copyright (c) Big Room Ventures Ltd. 2008
 * Version: 1.0.0
 * 
 * 
 * Licence Agreement
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package bigroom.flint.initializers 
{
	import flash.geom.Point;
	
	import bigroom.flint.emitters.Emitter;
	import bigroom.flint.particles.Particle;
	import bigroom.flint.zones.Zone;	

	/**
	 * The ColorInit Initializer sets the velocity of the particle. It is
	 * usually combined with the MoveEuler action to move the particle
	 * using this velocity.
	 * 
	 * <p>The initial velocity is defined using a zone from the 
	 * bigroom.flint.zones package. The use of zones enables diverse 
	 * ranges of velocities. For example, to use a specific velocity,
	 * a Point zone can be used. To use a varied speed in a specific
	 * direction, a LineZone zone can be used. For a fixed speed in
	 * a varied direction, a Disc or DiscSector zone with identical
	 * inner and outer radius can be used. A Disc or DiscSector with
	 * different inner and outer radius produces a range of speeds
	 * in a range of directions.
	 */

	public class Velocity implements Initializer
	{
		private var _zone:Zone;

		/**
		 * The constructor creates a Velocity initializer for use by 
		 * an emitter. To add a Velocity to all particles created by an emitter, use the
		 * emitter's addInitializer method.
		 * 
		 * @param velocity The zone to use for creating the velocity.
		 * 
		 * @see bigroom.flint.emitters.Emitter#addInitializer()
		 */
		public function Velocity( velocity:Zone )
		{
			_zone = velocity;
		}
		
		/**
		 * The init method is used by the emitter to initialize the particle.
		 * It is called within the emitter's createParticle method and need not
		 * be called by the user.
		 * 
		 * @param emitter The Emitter that created the particle.
		 * @param particle The particle to be initialized.
		 */
		public function init( emitter:Emitter, particle:Particle ):void
		{
			var loc:Point;
			if( emitter.rotRadians == 0 )
			{
				loc = _zone.getLocation();
				particle.velX = loc.x;
				particle.velY = loc.y;
			}
			else
			{
				var sin:Number = Math.sin( emitter.rotRadians );
				var cos:Number = Math.cos( emitter.rotRadians );
				loc = _zone.getLocation();
				particle.velX = cos * loc.x - sin * loc.y;
				particle.velY = cos * loc.y + sin * loc.x;
			}
		}
	}
}
