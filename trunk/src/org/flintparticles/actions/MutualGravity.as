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
	import org.flintparticles.emitters.Emitter;
	import org.flintparticles.particles.Particle;	

	/**
	 * The MutualGravity Action applies forces to attract each particle towards the other particles.
	 */
	public class MutualGravity extends Action
	{
		private var _power:Number;
		private var _maxDistance:Number;
		private var _maxDistanceSq:Number;
		private var _epsilonSq:Number;
		private var _gravityConst:Number = 1000;
		
		/**
		 * The constructor creates a MutualGravity action for use by 
		 * an emitter. To add a MutualGravity to all particles created by an emitter, use the
		 * emitter's addAction method.
		 * 
		 * @see org.flintparticles.emitters.Emitter#addAction()
		 * 
		 * @param power The strength of the gravitational pull between the particles.
		 * @param maxDistance the maximum distance between particles for the gravitational
		 * effect to be calculated. You can speed up this method by reducing the maxDistance
		 * since often only the closest other particles have a significant effect on the 
		 * motion of a particle.
		 */
		public function MutualGravity( power:Number, maxDistance:Number, epsilon:Number = 1 )
		{
			_power = power * _gravityConst;
			_maxDistance = maxDistance;
			_maxDistanceSq = maxDistance * maxDistance;
			_epsilonSq = epsilon * epsilon;
		}
		
		/**
		 * @inheritDoc
		 * 
		 * <p>Returns a value of 10, so that the MutualGravity action executes before other actions.</p>
		 */
		override public function getDefaultPriority():Number
		{
			return 10;
		}

		/**
		 * @inheritDoc
		 */
		override public function addedToEmitter( emitter:Emitter ) : void
		{
			emitter.spaceSort = true;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function update( emitter : Emitter, particle : Particle, time : Number ) : void
		{
			var particles:Array = emitter.particles;
			var sortedX:Array = emitter.spaceSortedX;
			var other:Particle;
			var i:int;
			var len:uint = particles.length;
			var factor:Number;
			var distance:Number;
			var distanceSq:Number;
			var dx:Number;
			var dy:Number;
			for( i = particle.spaceSortX + 1; i < len; ++i )
			{
				other = particles[sortedX[i]];
				if( ( dx = other.x - particle.x ) > _maxDistance ) break;
				if( ( dy = other.y - particle.y ) > _maxDistance ) continue;
				distanceSq = dx * dx + dy * dy;
				if( distanceSq <= _maxDistanceSq && distanceSq > 0 )
				{
					distance = Math.sqrt( distanceSq );
					if( distanceSq < _epsilonSq )
					{
						distanceSq = _epsilonSq;
					}
					factor = ( _power * time ) / ( distanceSq * distance );
					particle.velX += ( dx *= factor );
					particle.velY += ( dy *= factor );
					other.velX -= dx;
					other.velY -= dy;
				} 
			}
		}
	}
}
