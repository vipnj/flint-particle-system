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
	import org.flintparticles.particles.Particle;	

	/**
	 * The Action class is the abstract base class for all particle actions. Instances of the Action 
	 * class should not be directly created because the Action class itself simply defines default
	 * methods that do nothing. Classes that extend the Action class implement their own functionality 
	 * for the methods they want to use.
	 * 
	 * <p>An Action is a class that is used to modify an aspect of a particle 
	 * every frame. Actions may, for example, move the particle of modify 
	 * its velocity.</p>
	 * <p>Actions are added to all particles created by an emitter by using the emitter's addAction
	 * method.<p>
	 * 
	 * @see org.flintparticles.emitters.Emitter#addAction()
	 */
	public class Action
	{
		/**
		 * The constructor creates an Action object. But you shouldn't use it because the Action
		 * class is abstract.
		 */
		public function Action()
		{
		}
		
		/**
		 * The addedToEmitter method is called from the emitter when the Action is added to it
		 * 
		 * @param emitter The Emitter that the Action was added to.
		 */
		public function addedToEmitter( emitter:Emitter ):void
		{
		}
		
		/**
		 * The update method is called every frame for every particle created
		 * by the emitter.
		 * 
		 * @param emitter The Emitter that created the particle.
		 * @param particle The particle to be updated.
		 * @param time The duration of the frame - used for time based updates.
		 */
		public function update( emitter:Emitter, particle:Particle, time:Number ):void
		{
		}
	}
}