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
	 * The MouseGravity action applies a force on the particle to draw it towards
	 * the mouse. The force applied is inversely proportional to the square
	 * of the distance from the particle to the mouse.
	 */

	public class MatchVelocity extends Action
	{
		private var _min:Number;
		private var _acc:Number;
		
		/**
		 * The constructor creates a MouseGravity action for use by 
		 * an emitter. To add a MouseGravity to all particles created by an emitter, use the
		 * emitter's addAction method.
		 * 
		 * @see org.flintparticles.emitters.Emitter#addAction()
		 * 
		 * @param power The strength of the force - larger numbers produce a stringer force.
		 * @param epsilon The minimum distance for which gravity is calculated. Particles closer
		 * than this distance experience a gravity force as it they were this distance away.
		 * This stops the gravity effect blowing up as distances get small. For realistic gravity 
		 * effects you will want a small epsilon ( ~1 ), but for stable visual effects a larger
		 * epsilon (~100) is often better.
		 */
		public function MatchVelocity( minimum:Number, acceleration:Number )
		{
			_min = minimum;
			_acc = acceleration;
		}
		
		/**
		 * The strength of the gravity force.
		 */
		public function get minimum():Number
		{
			return _min;
		}
		public function set minimum( value:Number ):void
		{
			_min = value;
		}
		
		/**
		 * The minimum distance for which the gravity force is calculated. 
		 * Particles closer than this distance experience the gravity as it they were 
		 * this distance away. This stops the gravity effect blowing up as distances get 
		 * small.
		 */
		public function get acceleration():Number
		{
			return _acc;
		}
		public function set acceleration( value:Number ):void
		{
			_acc = value;
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
		override public function update( emitter:Emitter, particle:Particle, time:Number ):void
		{
			var particles:Array = emitter.particles;
			var sortedX:Array = emitter.spaceSortedX;
			var other:Particle;
			var i:int;
			var len:uint = particles.length;
			var dx:Number;
			var dy:Number;
			var velX:Number = 0;
			var velY:Number = 0;
			var count:uint = 0;
			var factor:Number;
			for( i = particle.spaceSortX - 1; i >= 0; --i )
			{
				other = particles[sortedX[i]];
				if( ( dx = particle.x - other.x ) > _min ) break;
				dy = other.y - particle.y;
				if( dy > _min || dy < -_min ) continue;
				velX += other.velX;
				velY += other.velY;
				++count;
			}
			for( i = particle.spaceSortX + 1; i < len; ++i )
			{
				other = particles[sortedX[i]];
				if( ( dx = other.x - particle.x ) > _min ) break;
				dy = other.y - particle.y;
				if( dy > _min || dy < -_min ) continue;
				velX += other.velX;
				velY += other.velY;
				++count;
			}
			if( count != 0 )
			{
				velX = velX / count - particle.velX;
				velY = velY / count - particle.velY;
				if( velX != 0 || velY != 0 )
				{
					factor = time * _acc / Math.sqrt( velX * velX + velY * velY );
					if( factor > 1 ) factor = 1;
					particle.velX += factor * velX;
					particle.velY += factor * velY;
				}
			}
		}
	}
}
