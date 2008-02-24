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

package org.flintparticles.initializers 
{
	import org.flintparticles.emitters.Emitter;
	import org.flintparticles.particles.Particle;	

	/**
	 * The RotateVelocity Initializer sets the angular velocity of the particle.
	 * It is usually combined with the Rotate action to rotate the particle
	 * using this angular velocity.
	 */

	public class RotateVelocity extends Initializer
	{
		private var _max:Number;
		private var _min:Number;

		/**
		 * The constructor creates a RotateVelocity initializer for use by 
		 * an emitter. To add a RotateVelocity to all particles created by an emitter, use the
		 * emitter's addInitializer method.
		 * 
		 * <p>The angularVelocity of particles initialized by this class
		 * will be a random value between the minimum and maximum
		 * values set. If no maximum value is set, the minimum value
		 * is used with no variation.</p>
		 * 
		 * @param minAngVelocity The minimum angularVelocity, in 
		 * radians per second, for the particle's angularVelocity.
		 * @param maxAngVelocity The maximum angularVelocity, in 
		 * radians per second, for the particle's angularVelocity.
		 * 
		 * @see org.flintparticles.emitters.Emitter#addInitializer()
		 */
		public function RotateVelocity( minAngVelocity:Number, maxAngVelocity:Number = NaN )
		{
			_min = minAngVelocity;
			_max = maxAngVelocity;
		}
		
		/**
		 * The init method is used by the emitter to initialize the particle.
		 * It is called within the emitter's createParticle method and need not
		 * be called by the user.
		 * 
		 * @param emitter The Emitter that created the particle.
		 * @param particle The particle to be initialized.
		 */
		override public function initialize( emitter:Emitter, particle:Particle ):void
		{
			if( isNaN( _max ) )
			{
				particle.angVelocity = _min;
			}
			else
			{
				particle.angVelocity = _min + Math.random() * ( _max - _min );
			}
		}
	}
}
