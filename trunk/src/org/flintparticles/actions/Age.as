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

package org.flintparticles.actions 
{
	import org.flintparticles.emitters.Emitter;
	import org.flintparticles.energy.Linear;
	import org.flintparticles.particles.Particle;	

	/**
	 * The Age action operates in conjunction with the Lifetime 
	 * initializer. The Lifetime initializer sets the lifetime for
	 * the particle. The Age action then ages the particle over time,
	 * altering its energy to reflect its age. This energy can then
	 * be used by actions like Fade and ColorChange to alter the
	 * appearence of the particle as it ages.
	 * 
	 * <p>When the particle's lifetime is over, this action marks it 
	 * as dead.</p>
	 * 
	 * <p>When adjusting the energy this action can use any of the
	 * eassing functions in the org.flintparticles.energy package.</p>
	 */
	public class Age implements Action 
	{
		private var _easing:Function;
		
		/**
		 * The constructor creates an Age action for use by 
		 * an emitter. To add an Age to all particles created by an emitter, use the
		 * emitter's addAction method.
		 * 
		 * @see org.flintparticles.emitters.Emitter#addAction()
		 * 
		 * @param easing an easing function to use to modify the 
		 * energy curve over the lifetime of the particle. The default
		 * null produces a linear response with no easing.
		 */
		public function Age( easing:Function = null )
		{
			if ( easing == null )
			{
				_easing = Linear.easeNone;
			}
			else
			{
				_easing = easing;
			}
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
			particle.age += time;
			particle.energy = _easing( particle.age, particle.lifetime );
			if ( particle.energy <= 0 )
			{
				particle.isDead = true;
			}
		}
	}
}
