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
	import flash.geom.Point;
	
	import bigroom.flint.actions.Action;
	import bigroom.flint.emitters.Emitter;
	import bigroom.flint.particles.Particle;
	import bigroom.flint.zones.Zone;	

	/**
	 * The DeathZone action marks the particle as dead if it is inside
	 * a zone.
	 */

	public class DeathZone implements Action 
	{
		private var _zone:Zone;
		private var _invertZone:Boolean;
		
		/**
		 * The constructor creates a DeathZone action for use by 
		 * an emitter. To add a DeathZone to all particles created by an emitter, use the
		 * emitter's addAction method.
		 * 
		 * @see bigroom.flint.emitters.Emitter#addAction()
		 * @see bigroom.flint.zones
		 * 
		 * @param zone The zone to use. Any item from the bigroom.flint.zones
		 * package can be used.
		 * @param invertZone If true, the zone is treated as the safe area
		 * and everywhere outside the zone results in the particle dying.
		 */
		public function DeathZone( zone:Zone, invertZone:Boolean = false )
		{
			_zone = zone;
			_invertZone = invertZone;
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
			var inside:Boolean = _zone.contains( new Point( particle.x, particle.y ) );
			if ( _invertZone )
			{
				inside = !inside;
			}
			if ( inside )
			{
				particle.isDead = true;
			}
		}
	}
}
