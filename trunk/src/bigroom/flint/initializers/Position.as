/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord
 * Copyright (c) Big Room Ventures Ltd. 2008
 * Version: 1.0.0
 * Available at http://flashgamecode.net/
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
	 * The Position Initializer sets the initial location of the particle.
	 * 
	 * <p>The class uses zones to place the particle. A zone defines an area
	 * of the stage and the particle is placed at a random point within
	 * that area. For precise placement, the Point zone defines a single
	 * point at which all particles will be placed. Various zones (and the
	 * Zones interface for use when implementing custom zones) are defined
	 * in the bigroom.flint.zones package.</p>
	 */

	public class Position implements Initializer 
	{
		private var _zone : Zone;

		/**
		 * The constructor creates a Position initializer for use by 
		 * an emitter. To add a Position to all particles created by an emitter, use the
		 * emitter's addInitializer method.
		 * 
		 * @param zone The zone to place all particles in.
		 * 
		 * @see bigroom.flint.emitters.Emitter#addInitializer()
		 */
		public function Position( zone : Zone )
		{
			_zone = zone;
		}

		/**
		 * The init method is used by the emitter to initialize the particle.
		 * It is called within the emitter's createParticle method and need not
		 * be called by the user.
		 * 
		 * @param emitter The Emitter that created the particle.
		 * @param particle The particle to be initialized.
		 */
		public function init( emitter : Emitter, particle : Particle ) : void
		{
			var loc:Point = _zone.getLocation();
			particle.x = loc.x;
			particle.y = loc.y;
		}
	}
}
