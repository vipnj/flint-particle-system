﻿/*
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
	 * The Blast counter causes the emitter to emit a single burst of
	 * particles when it starts and then emit no further particles.
	 * It is used, for example, to simulate an explosion.
	 */
	public class Blast implements Counter
	{
		protected var _startMin:uint;
		protected var _startMax:uint;
		
		/**
		 * The constructor creates a Blast counter for use by an emitter. To
		 * add a Blast counter to an emitter use the emitter's setCounter
		 * method.
		 * <p>If two parameters are passed to the constructor then a random
		 * value between the two is used. This allows for some variation
		 * between emitters using the same Blast settings. Otherwise the 
		 * single value passed in is used.</p>
		 * @param startMin The minimum number of particles to emit
		 * when the emitter starts.
		 * @param startMax The maximum number of particles to emit
		 * when the emitter starts. If not set then the emitter
		 * will emit exactly the startMin number of particles.
		 */
		public function Blast( startMin:Number, startMax:Number = NaN )
		{
			_startMin = startMin;
			_startMax = isNaN( startMax ) ? startMin : startMax;
		}
		
		/**
		 * The startEmitter method is used by the emitter to obtain the number 
		 * of particles to emit when it starts up. It need not be called by the
		 * user.
		 */
		public function startEmitter():uint
		{
			return Math.round( _startMin + Math.random() * ( _startMax - _startMin ) );
		}
		
		/**
		 * The updateEmitter method is used by the emitter to obtain the number
		 * of particles it should have emitted since the previous time it called 
		 * the method. It need not be called by the user.
		 * @param time The time, in seconds, since the previous call to this method.
		 */
		public function updateEmitter( time:Number ):uint
		{
			return 0;
		}
	}
}