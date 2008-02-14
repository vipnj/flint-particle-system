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
	import bigroom.flint.emitters.Emitter;
	import bigroom.flint.particles.Particle;

	/**
	 * The TargetRotateVelocity action adjusts the angular velocity of the particle towards the target angular velocity.
	 */
	public class TargetRotateVelocity implements Action
	{
		private var _vel:Number;
		private var _scaleFactor:Number;
		
		/**
		 * The constructor creates a TargetRotateVelocity action for use by 
		 * an emitter. To add a TargetRotateVelocity to all particles created by an emitter, use the
		 * emitter's addAction method.
		 * 
		 * @see bigroom.flint.emitters.Emitter#addAction()
		 * 
		 * @param vel The target angular velocity, in radians per second.
		 * @param scaleFactor Adjusts how quickly the particle reaches the target angular velocity.
		 * Larger numbers cause it to approach the target angular velocity more quickly.
		 */
		public function TargetRotateVelocity( vel:Number, scaleFactor:Number = 0.1 )
		{
			_vel = vel;
			_scaleFactor = scaleFactor;
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
			particle.angVelocity += ( _vel - particle.angVelocity ) * _scaleFactor * time;
		}
	}
}
