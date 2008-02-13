/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord
 * Copyright (c) Big Room Ventures Ltd. 2008
 * Version: 1.0.0
 * Available at http://flashgamecode.net/
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
	import bigroom.flint.particles.Particle;
	import bigroom.flint.emitters.Emitter;	

	/**
	 * The Explosion action applies a force on the particle to push it away from
	 * a single point - the center of the explosion. The force applied is inversely 
	 * proportional to the square of the distance from the particle to the point.
	 */

	public class Explosion implements Action 
	{
		private var _x:Number;
		private var _y:Number;
		private var _power:Number;
		private var _distanceFactor:Number = 0.01;
		
		/**
		 * The constructor creates an Explosion action for use by 
		 * an emitter. To add a Explosion to all particles created by an emitter, use the
		 * emitter's addAction method.
		 * 
		 * @see bigroom.flint.emitters.Emitter#addAction()
		 * 
		 * @param power The strength of the force - larger numbers produce a stringer force.
		 * @param x The x coordinate of the point towards which the force draws the particles.
		 * @param y The y coordinate of the point towards which the force draws the particles.
		 */
		public function Explosion( power:Number, x:Number, y:Number )
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
			var x:Number = ( particle.x - _x ) * _distanceFactor;
			var y:Number = ( particle.y - _y ) * _distanceFactor;
			var d2:Number = x * x + y * y;
			if( d2 == 0 )
			{
				return;
			}
			var len:Number = Math.sqrt( d2 );
			if( d2 < 1 ) d2 = 1; // stop it blowing uyp to ridiculous values
			var factor:Number = ( _power * time ) / ( d2 * len );
			particle.velX += x * factor;
			particle.velY += y * factor;
		}
	}
}
