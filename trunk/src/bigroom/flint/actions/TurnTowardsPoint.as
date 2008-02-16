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

package bigroom.flint.actions 
{
	import bigroom.flint.actions.Action;
	import bigroom.flint.emitters.Emitter;
	import bigroom.flint.particles.Particle;

	/**
	 * The TurnTowardsPoint action causes the particle to constantly adjust its velocity
	 * so that it travels towards a particular point.
	 */

	public class TurnTowardsPoint implements Action 
	{
		private var _x:Number;
		private var _y:Number;
		private var _power:Number;
		
		/**
		 * The constructor creates a TurnTowardsPoint action for use by 
		 * an emitter. To add a TurnTowardsPoint to all particles created by an emitter, use the
		 * emitter's addAction method.
		 * 
		 * @see bigroom.flint.emitters.Emitter#addAction()
		 * 
		 * @param power The strength of the swarming action.
		 * @param x The x coordinate of the point around which the particle swarms.
		 * @param y The y coordinate of the point around which the particle swarms.
		 */
		public function TurnTowardsPoint( x:Number, y:Number, power:Number )
		{
			_power = power;
			_x = x;
			_y = y;
		}
		
		/**
		 * The update method is used by the emitter to apply the action.
		 * It is called within the emitter's update loop and need not
		 * be called by the user.
		 * 
		 * @param emitter The Emitter that created the particle.
		 * @param particle The particle to be updated.
		 * @param time The duration of the frame - used for time based updates.
		 */
		public function update( emitter:Emitter, particle:Particle, time:Number ):void
		{
			var turnLeft:Boolean = ( ( particle.y - _y ) * particle.velX + ( _x - particle.x ) * particle.velY > 0 );
			var newAngle:Number;
			if ( turnLeft )
			{
				newAngle = Math.atan2( particle.velY, particle.velX ) - _power * time;
				
			}
			else
			{
				newAngle = Math.atan2( particle.velY, particle.velX ) + _power * time;
			}
			var len:Number = Math.sqrt( particle.velX * particle.velX + particle.velY * particle.velY );
			particle.velX = len * Math.cos( newAngle );
			particle.velY = len * Math.sin( newAngle );
		}
	}
}
