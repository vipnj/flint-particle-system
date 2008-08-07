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
	import org.flintparticles.threeD.geom.Vector3D;
	import org.flintparticles.threeD.particles.Particle3D;	

	/**
	 * The AntiGravity action applies a force to the particle to push it away from
	 * a single point - the center of the effect. The force applied is inversely 
	 * proportional to the square of the distance from the particle to the point.
	 */

	public class AntiGravity extends ActionBase
	{
		private var _pos:Vector3D;
		private var _power:Number;
		private var _gravityConst:Number = 10000; // this just scales the power so we don't have to use very large numbers
		private var _epsilonSq:Number;
		
		/**
		 * The constructor creates an AntiGravity action for use by an emitter. 
		 * To add an AntiGravity to all particles created by an emitter, use the
		 * emitter's addAction method.
		 * 
		 * @see org.flintparticles.common.emitters.Emitter#addAction()
		 * 
		 * @param power The strength of the force - larger numbers produce a 
		 * stronger force.
		 * @param position The point in 3D space that the force pushes the 
		 * particles away from.
		 * @param epsilon The minimum distance for which the anti-gravity force is 
		 * calculated. Particles closer than this distance experience the 
		 * anti-gravity as it they were this distance away. This stops the 
		 * anti-gravity effect blowing up as distances get very small.
		 */
		public function AntiGravity( power:Number, position:Vector3D, epsilon:Number = 1 )
		{
			this.power = power;
			this.position = position;
			this.epsilon = epsilon;
		}
		
		/**
		 * The strength of the anti-gravity force - larger numbers produce a 
		 * stronger force.
		 */
		public function get power():Number
		{
			return _power / _gravityConst;
		}
		public function set power( value:Number ):void
		{
			_power = value * _gravityConst;
		}
		
		/**
		 * The position of the center of the anti-gravity force.
		 */
		public function get position():Vector3D
		{
			return _pos;
		}
		public function set position( value:Vector3D ):void
		{
			_pos = value.clone();
			_pos.w = 1;
		}
		
		/**
		 * The minimum distance for which the anti-gravity force is calculated. 
		 * Particles closer than this distance experience the anti-gravity as if 
		 * they were this distance away. This stops the anti-gravity effect blowing 
		 * up as distances get very small.
		 */
		public function get epsilon():Number
		{
			return Math.sqrt( _epsilonSq );
		}
		public function set epsilon( value:Number ):void
		{
			_epsilonSq = value * value;
		}
		
		/**
		 * Applies the anti-gravity force to a particle.
		 * 
		 * <p>This method is called by the emitter and need not be called by the 
		 * user</p>
		 * 
		 * @param emitter The Emitter that created the particle.
		 * @param particle The particle to be updated.
		 * @param time The duration of the frame - used for time based updates.
		 * 
		 * @see org.flintparticles.common.actions.Action#update()
		 */
		override public function update( emitter:Emitter, particle:Particle, time:Number ):void
		{
			var p:Particle3D = Particle3D( particle );
			var offset:Vector3D = p.position.subtract( _pos );
			var dSq:Number = offset.lengthSquared;
			if( dSq == 0 )
			{
				return;
			}
			var d:Number = Math.sqrt( dSq );
			if( dSq < _epsilonSq ) dSq = _epsilonSq;
			var factor:Number = ( _power * time ) / ( dSq * d );
			p.velocity.incrementBy( offset.scaleBy( factor ) );
		}
	}
}
