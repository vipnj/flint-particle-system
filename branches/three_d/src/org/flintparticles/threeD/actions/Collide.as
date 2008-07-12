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

package org.flintparticles.threeD.actions 
{
	import org.flintparticles.common.actions.ActionBase;
	import org.flintparticles.common.emitters.Emitter;
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.threeD.emitters.Emitter3D;
	import org.flintparticles.threeD.particles.Particle3D;	
	import org.flintparticles.threeD.geom.Vector3D;	

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

	public class Collide extends ActionBase
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
			Emitter3D( emitter ).spaceSort = true;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function update( emitter:Emitter, particle:Particle, time:Number ):void
		{
			var p:Particle3D = Particle3D( particle );
			var e:Emitter3D = Emitter3D( emitter );
			var particles:Array = e.particles;
			var sortedX:Array = e.spaceSortedX;
			var other:Particle3D;
			var i:int;
			var len:int = particles.length;
			var factor:Number;
			var distanceSq:Number;
			var collisionDist:Number;
			var d:Vector3D = new Vector3D();
			var n1:Number, n2:Number;
			var relN:Number;
			var m1:Number, m2:Number;
			var f1:Number, f2:Number;
			for( i = p.sortID + 1; i < len; ++i )
			{
				other = particles[sortedX[i]];
				collisionDist = other.scale * _radius + p.scale * _radius;
				if( ( d.x = other.position.x - p.position.x ) > collisionDist ) break;
				d.y = other.position.y - p.position.y;
				if( d.y > collisionDist || d.y < -collisionDist ) continue;
				d.z = other.position.z - p.position.z;
				if( d.z > collisionDist || d.z < -collisionDist ) continue;
				distanceSq = d.lengthSquared;
				if( distanceSq <= collisionDist * collisionDist && distanceSq > 0 )
				{
					d.normalize();
					n1 = p.velocity.dotProduct( d );
					n2 = other.velocity.dotProduct( d );
					relN = n1 - n2;
					if( relN > 0 ) // colliding, not separating
					{
						m1 = p.scale * p.scale * p.scale; // assume common density so mass is proportinate to volume
						m2 = other.scale * other.scale * other.scale;
						factor = ( 2 * _bounce * relN ) / ( m1 + m2 );
						f1 = factor * m2;
						f2 = -factor * m1;
						p.velocity.decrementBy( d.multiply( f1 ) );
						other.velocity.decrementBy( d.multiply( f2 ) );
					}
				} 
			}
		}
	}
}
