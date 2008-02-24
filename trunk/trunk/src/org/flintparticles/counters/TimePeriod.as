﻿
/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord (Big Room)
 * Copyright (c) Big Room Ventures Ltd. 2008
 * http://flintparticles.org
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
	import org.flintparticles.easing.Linear;	
	
	/**
	 * The TimePeriod counter causes the emitter to emit particles for a period of time
	 * and then stop. The rate of emission over that period can be modified using
	 * easing equations thet conform to the interface defined in Robert Penner's easing
	 * equations. An update to these equations is included in the 
	 * org.flintparticles.easing package.
	 */
	public class TimePeriod implements Counter
	{
		private var _particles : uint;
		private var _duration : Number;
		private var _particlesPassed : uint;
		private var _timePassed : Number;
		private var _easing : Function;

		/**
		 * The constructor creates a TimePeriod counter for use by an emitter. To
		 * add a TimePeriod counter to an emitter use the emitter's setCounter
		 * method.
		 * @param numParticles The number of particles to emit over the full duration
		 * of the time period
		 * @param duration The duration of the time period. After this time is up the
		 * emitter will not release any more particles.
		 * @param easing An easing function used to distribute the emission of the
		 * particles over the time period. If no easing function is passed a simple
		 * linear distribution is used in which particles are emitted at a constant 
		 * rate over the time period.
		 */
		public function TimePeriod( numParticles : uint, duration : Number, easing : Function = null )
		{
			_particles = numParticles;
			_duration = duration;
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
		 * The startEmitter method is used by the emitter to obtain the number 
		 * of particles to emit when it starts up. It need not be called by the
		 * user.
		 * @return The number of particles to emit at the start.
		 */
		public function startEmitter() : uint
		{
			_particlesPassed = 0;
			_timePassed = 0;
			return 0;
		}

		/**
		 * The updateEmitter method is used by the emitter to obtain the number
		 * of particles it should have emitted since the previous time it called 
		 * the method. It need not be called by the user.
		 * @param time The time, in seconds, since the previous call to this method.
		 * @return The number of particles to emit this frame.
		 */
		public function updateEmitter( time : Number ) : uint
		{
			if( _particlesPassed == _particles )
			{
				return 0;
			}
			
			_timePassed += time;
			
			if( _timePassed >= _duration )
			{
				var newParticles:uint = _particles - _particlesPassed;
				_particlesPassed = _particles;
				return newParticles;
			}
			
			var oldParticles:uint = _particlesPassed;
			_particlesPassed = Math.round( _easing( _timePassed, 0, _particles, _duration ) );
			return _particlesPassed - oldParticles;
		}
	}
}