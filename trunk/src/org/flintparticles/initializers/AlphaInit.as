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

package org.flintparticles.initializers 
{
	import org.flintparticles.emitters.Emitter;
	import org.flintparticles.particles.Particle;	

	/**
	 * The AlphaInit Initializer sets the alpha transparency of the particle.
	 */

	public class AlphaInit extends Initializer
	{
		private var _min:Number;
		private var _max:Number;
		
		/**
		 * The constructor creates an AlphaInit initializer for use by 
		 * an emitter. To add an AlphaInit to all particles created by an emitter, use the
		 * emitter's addInitializer method.
		 * 
		 * <p>The alpha of particles initialized by this class
		 * will be a random value between the minimum and maximum
		 * values set. If no maximum value is set, the minimum value
		 * is used with no variation.</p>
		 * 
		 * @param minAlpha the minimum alpha for particles
		 * initialized by the instance. The value should be between 1 and 0.
		 * @param maxAlpha the maximum alpha for particles
		 * initialized by the instance. The value should be between 1 and 0.
		 * 
		 * @see org.flintparticles.emitters.Emitter#addInitializer().
		 */
		public function AlphaInit( minAlpha:Number, maxAlpha:Number = NaN )
		{
			_min = minAlpha;
			if( isNaN( maxAlpha ) )
			{
				_max = _min;
			}
			else
			{
				_max = maxAlpha;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function initialize( emitter:Emitter, particle:Particle ):void
		{
			var alpha:Number;
			if( _max == _min )
			{
				alpha = _min;
			}
			else
			{
				alpha = _min + Math.random() * ( _max - _min );
			}
			particle.color = ( particle.color & 0xFFFFFF ) | ( Math.round( alpha * 255 ) << 24 );
		}
	}
}