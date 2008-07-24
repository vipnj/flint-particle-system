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
	 * The Collide action detects collisions between particles and modifies their velocities
	 * in response to the collision. All paticles are approximated to a circular shape for
	 * the collisions and they are assumed to be off equal density.
	 * 
	 * <p>If the particles reach a stationary, or near stationary, state under an accelerating 
	 * force (e.g. gravity) then they will fall through each other. This is due to the nature
	 * of the alogorithm used, which is designed for speed of execution and sufficient accuracy 
	 * when the particles are in motion, not for absolute precision.</p>
	 */

	public class Collide extends Action
	{
		private var _radius:Number;
		private var _bounce:Number;
		
		/**
		 * The constructor creates a Collide action for use by  an emitter.
		 * To add a Collide to all particles created by an emitter, use the
		 * emitter's addAction method.
		 * 
		 * @see org.flintparticles.common.emitters.Emitter#addAction()
		 * 
		 * @param radius The radius of a particle used when calculating the collisions. this
		 * radius is multiplied by the scale property of each particle to get the particle's
		 * actual size and relative mass for calculating the collision and response.
		 * @param bounce The coefficient of restitution when the particles collide. A value of 
		 * 1 gives a pure elastic collision, with no energy loss. A value
		 * between 0 and 1 causes the particle to loose enegy in the collision. A value greater 
		 * than 1 causes the particle to gain energy in the collision.
		 */
		public function Collide( radius:Number, bounce:Number= 1 )
		{
			_radius = radius;
			_bounce = bounce;
		}
		
		/**
		 * The radius of a particle used when calculating the collisions. this
		 * radius is multiplied by the scale property of each particle to get the particle's
		 * actual size and relative mass for calculating the collision and response.
		 */
		public function get radius():Number
		{
			return _radius;
		}
		public function set radius( value:Number ):void
		{
			_radius = value;
		}
		
		/**
		 * The coefficient of restitution when the particles collide. A value of 
		 * 1 gives a pure elastic collision, with no energy loss. A value
		 * between 0 and 1 causes the particle to loose enegy in the collision. A value greater 
		 * than 1 causes the particle to gain energy in the collision.
		 */
		public function get bounce():Number
		{
			return _bounce;
		}
		public function set bounce( value:Number ):void
		{
			_bounce = value;
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
			var len:int = particles.length;
			var factor:Number;
			var distanceSq:Number;
			var collisionDist:Number;
			var dx:Number, dy:Number;
			var n1:Number, n2:Number;
			var relN:Number;
			var m1:Number, m2:Number;
			var f1:Number, f2:Number;
			for( i = particle.spaceSortX + 1; i < len; ++i )
			{
				other = particles[sortedX[i]];
				collisionDist = other.scale * _radius + particle.scale * _radius;
				if( ( dx = other.x - particle.x ) > collisionDist ) continue;
				dy = other.y - particle.y;
				if( dy > collisionDist || dy < -collisionDist ) continue;
				distanceSq = dy * dy + dx * dx;
				if( distanceSq <= collisionDist * collisionDist && distanceSq > 0 )
				{
					factor = 1 / Math.sqrt( distanceSq );
					dx *= factor;
					dy *= factor;
					n1 = dx * particle.velX + dy * particle.velY;
					n2 = dx * other.velX + dy * other.velY;
					relN = n1 - n2;
					if( relN > 0 ) // colliding, not separating
					{
						m1 = particle.scale * particle.scale;
						m2 = other.scale * other.scale;
						factor = ( ( 1 + _bounce ) * relN ) / ( m1 + m2 );
						f1 = factor * m2;
						f2 = -factor * m1;
						particle.velX -= f1 * dx;
						particle.velY -= f1 * dy;
						other.velX -= f2 * dx;
						other.velY -= f2 * dy;
					}
				} 
			}
		}
	}
}
