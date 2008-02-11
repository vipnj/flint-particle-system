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

package bigroom.flint.counters 
{
	/**
	 * The Counter interface must be implemented by all counters.
	 * <p>A counter is a class that tells an emitter how many particles to
	 * emit at any time. The two methods allow the emission of particles
	 * when the emitter starts and every frame thereafter.</p>
	 * 
	 * <p>A counter is set for an emitter using the emitter's 
	 * setCounter method.</p>
	 */
	public interface Counter 
	{
		/**
		 * The startEmitter method is called when the emitter starts.
		 * @return The number of particles the emitter should emit
		 * at the moment it starts.
		 */
		function startEmitter():uint;
		
		/**
		 * The updateEmitter method is called every frame after the
		 * emitter has started.
		 * @return The number of particles the emitter should emit
		 * at this time.
		 */
		function updateEmitter( time:Number ):uint;
	}
}
