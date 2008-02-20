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

package org.flintparticles.counters
{
	/**
	 * The Steady counter causes the emitter to emit particles continuously
	 * at a steady rate. It can be used to simuate any continuous particle
	 * stream. The rate can also be varies by setting a range of value for the
	 * emission rate.
	 */
	public class Steady implements Counter
	{
		protected var _timeToNext:Number;
		protected var _rateMin:Number;
		protected var _rateMax:Number;
		
		/**
		 * The constructor creates a Steady counter for use by an emitter. To
		 * add a Steady counter to an emitter use the emitter's setCounter
		 * method.
		 * <p>If two parameters are passed to the constructor then a random
		 * value between the two is used. This allows for random variation
		 * in the emission rate over the lifetime of the emitter. Otherwise the 
		 * single value passed in is used.</p>
		 * @param rateMin The minimum number of particles to emit
		 * per second.
		 * @param rateMax The maximum number of particles to emit
		 * per second. If not set then the emitter
		 * will emit exactly the rateMin number of particles per second.
		 */
		public function Steady( rateMin:Number, rateMax:Number = NaN )
		{
			_rateMin = rateMin;
			_rateMax = isNaN( rateMax ) ? rateMin : rateMax;
		}
		
		/**
		 * The startEmitter method is used by the emitter to obtain the number 
		 * of particles to emit when it starts up. It need not be called by the
		 * user.
		 */
		public function startEmitter():uint
		{
			newTimeToNext();
			return 0;
		}
		
		private function newTimeToNext():void
		{
			var rate:Number = _rateMin + Math.random() * ( _rateMax - _rateMin );
			_timeToNext = 1 / rate;
		}
		
		/**
		 * The updateEmitter method is used by the emitter to obtain the number
		 * of particles it should have emitted since the previous time it called 
		 * the method. It need not be called by the user.
		 * @param time The time, in seconds, since the previous call to this method.
		 */
		public function updateEmitter( time:Number ):uint
		{
			var emitTime:Number = time;
			var count:uint = 0;
			emitTime -= _timeToNext;
			while ( emitTime >= 0 )
			{
				++count;
				newTimeToNext();
				emitTime -= _timeToNext;
			}
			_timeToNext = -emitTime;
			
			return count;
		}
	}
}