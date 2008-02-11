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
	import bigroom.flint.emitters.Emitter;
	import bigroom.flint.particles.Particle;	

	/**
	 * The RandomDrift action moves the particle by a random small amount every frame,
	 * causing the particle to drift around.
	 */

	public class RandomDrift implements Action 
	{
		private var _sizeX:Number;
		private var _sizeY:Number;
		
		/**
		 * The constructor creates a RandomDrift action for use by 
		 * an emitter. To add a RandomDrift to all particles created by an emitter, use the
		 * emitter's addAction method.
		 * 
		 * @see Emitter.addAction.
		 * 
		 * @param sizeX The maximum amount of horizontal drift in pixels per second.
		 * @param sizeY The maximum amount of vertical drift in pixels per second.
		 */
		public function RandomDrift( sizeX:Number, sizeY:Number )
		{
			_sizeX = sizeX * 2;
			_sizeY = sizeY * 2;
			
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
			particle.velX += ( Math.random() - 0.5 ) * _sizeX * time;
			particle.velY += ( Math.random() - 0.5 ) * _sizeY * time;
		}
	}
}
