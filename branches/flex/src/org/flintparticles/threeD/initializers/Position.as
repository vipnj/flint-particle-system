/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord (Big Room)
 * Copyright (c) Big Room Ventures Ltd. 2008
 * http://flintparticles.org
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

package org.flintparticles.threeD.initializers 
{
	import org.flintparticles.common.emitters.Emitter;
	import org.flintparticles.common.initializers.InitializerBase;
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.threeD.emitters.Emitter3D;
	import org.flintparticles.threeD.geom.Quaternion;
	import org.flintparticles.threeD.geom.Vector3D;
	import org.flintparticles.threeD.particles.Particle3D;
	import org.flintparticles.threeD.zones.Zone3D;	

	/**
	 * The Position Initializer sets the initial location of the particle.
	 * 
	 * <p>The class uses zones to place the particle. A zone defines a region
	 * in relation to the emitter and the particle is placed at a random point within
	 * that region. For precise placement, the Point zone defines a single
	 * point at which all particles will be placed. Various zones (and the
	 * Zones interface for use when implementing custom zones) are defined
	 * in the org.flintparticles.threeD.zones package.</p>
	 */

	public class Position extends InitializerBase
	{
		private var _zone : Zone3D;

		/**
		 * The constructor creates a Position initializer for use by 
		 * an emitter. To add a Position to all particles created by an emitter, use the
		 * emitter's addInitializer method.
		 * 
		 * @param zone The zone to place all particles in.
		 * 
		 * @see org.flintparticles.common.emitters.Emitter#addInitializer()
		 */
		public function Position( zone : Zone3D = null )
		{
			_zone = zone;
		}
		
		/**
		 * The zone.
		 */
		public function get zone():Zone3D
		{
			return _zone;
		}
		public function set zone( value:Zone3D ):void
		{
			_zone = value;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function initialize( emitter : Emitter, particle : Particle ) : void
		{
			var p:Particle3D = Particle3D( particle );
			var e:Emitter3D = Emitter3D( emitter );
			var position:Vector3D = zone.getLocation();
			position.w = 0;
			if( !e.rotation.equals( Quaternion.IDENTITY ) )
			{
				e.rotationTransform.transformVectorSelf( position );
			}
			p.position.incrementBy( position );
		}
	}
}
