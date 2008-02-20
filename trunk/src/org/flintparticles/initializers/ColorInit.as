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
	import org.flintparticles.utils.interpolateColors;	

	/**
	 * The ColorInit Initializer sets the color of the particle.
	 */

	public class ColorInit implements Initializer 
	{
		private var _min:uint;
		private var _max:uint;
		
		/**
		 * The constructor creates a ColorInit initializer for use by 
		 * an emitter. To add a ColorInit to all particles created by an emitter, use the
		 * emitter's addInitializer method.
		 * 
		 * <p>The color of particles initialized by this class
		 * will be a random value between the two values pased to
		 * the constructor. For a fixed value, pass the same color
		 * in for both parameters.</p>
		 * 
		 * @param color1 the 32bit (ARGB) color at one end of the color range to use.
		 * @param color2 the 32bit (ARGB) color at the other end of the color range to use.
		 * 
		 * @see org.flintparticles.emitters.Emitter#addInitializer()
		 */
		public function ColorInit( color1:uint, color2:uint )
		{
			_min = color1;
			_max = color2;
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
			if( _max == _min )
			{
				particle.color = _min;
			}
			else
			{
				particle.color = interpolateColors( _min, _max, Math.random() );
			}
		}
	}
}