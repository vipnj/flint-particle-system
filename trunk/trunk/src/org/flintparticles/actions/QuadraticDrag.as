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

package org.flintparticles.actions 
{
	import org.flintparticles.actions.Action;
	import org.flintparticles.emitters.Emitter;
	import org.flintparticles.particles.Particle;	

	/**
	 * The QuadraticDrag action applies drag to the particle to slow it down when it's moving.
	 * The drag force is proportional to the square of the velocity of the particle.
	 */

	public class QuadraticDrag extends Action
	{
		private var _drag:Number;
		
		/**
		 * The constructor creates a QuadraticDrag action for use by 
		 * an emitter. To add a QuadraticDrag to all particles created by an emitter, use the
		 * emitter's addAction method.
		 * 
		 * @see org.flintparticles.emitters.Emitter#addAction()
		 * 
		 * @param drag The amount of drag. A higher number produces a stronger drag force.
		 */
		public function QuadraticDrag( drag:Number )
		{
			_drag = drag;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function update( emitter:Emitter, particle:Particle, time:Number ):void
		{
			var len2:Number = particle.velX * particle.velX + particle.velY * particle.velY;
			if( len2 == 0 )
			{
				return;
			}
			var scale:Number = 1 - _drag * time * Math.sqrt( len2 );
			if( scale < 0 )
			{
				particle.velX = 0;
				particle.velY = 0;
			}
			else
			{
				particle.velX *= scale;
				particle.velY *= scale;
			}
		}
	}
}