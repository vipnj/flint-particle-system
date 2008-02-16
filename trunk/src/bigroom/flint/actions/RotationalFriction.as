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
	 * The RotationalFriction action applies friction to the particle's rotational movement
	 * to slow it down when it's rotating. The frictional force is constant, irrespective 
	 * of how fast the particle is rotating. For forces proportional to the particle's 
	 * angular velocity, use one of the rotational drag effects -
	 * RotationalLinearDrag and RotationalQuadraticDrag.
	 */

	public class RotationalFriction implements Action 
	{
		private var _friction:Number;
		
		/**
		 * The constructor creates a RotationalFriction action for use by 
		 * an emitter. To add a RotationalFriction to all particles created by an emitter, 
		 * use the emitter's addAction method.
		 * 
		 * @see bigroom.flint.emitters.Emitter#addAction()
		 * 
		 * @param friction The amount of friction. A higher number produces a stronger frictional force.
		 */
		public function RotationalFriction( friction:Number )
		{
			_friction = friction;
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
			if( particle.angVelocity == 0 )
			{
				return;
			}
			var scale:Number = 1 - _friction * time / particle.angVelocity;
			if( scale < 0 )
			{
				particle.angVelocity = 0;
			}
			else
			{
				particle.angVelocity *= scale;
			}
		}
	}
}