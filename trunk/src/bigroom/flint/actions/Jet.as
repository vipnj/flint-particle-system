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
	import bigroom.flint.zones.Zone;

	/**
	 * The Jet Action applies an acceleration to the particle only if it is in the specified zone. 
	 */

	public class Jet implements Action 
	{
		private var _x:Number;
		private var _y:Number;
		private var _zone:Zone;
		private var _invert:Boolean;
		
		/**
		 * The constructor creates a Jet action for use by 
		 * an emitter. To add a Jet to all particles created by an emitter, use the
		 * emitter's addAction method.
		 * 
		 * @see bigroom.flint.emitters.Emitter#addAction()
		 * 
		 * @param accelerationX The x coordinate of the acceleration to apply, in pixels 
		 * per second per second.
		 * @param accelerationY The y coordinate of the acceleration to apply, in pixels 
		 * per second per second.
		 * @param zone The zone in which to apply the acceleration.
		 * @param invertZone If false (the default) the acceleration is applied only to particles inside 
		 * the zone. If true the acceleration is applied only to particles outside the zone.
		 */
		public function Jet( accelerationX:Number, accelerationY:Number, zone:Zone, invertZone:Boolean = false )
		{
			_x = accelerationX;
			_y = accelerationY;
			_zone = zone;
			_invert = invertZone;
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
			if( _zone.contains( particle.x, particle.y ) )
			{
				if( !_invert )
				{
					particle.velX += _x * time;
					particle.velY += _y * time;
				}
			}
			else
			{
				if( _invert )
				{
					particle.velX += _x * time;
					particle.velY += _y * time;
				}
			}
		}
	}
}