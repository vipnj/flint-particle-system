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

package org.flintparticles.twoD.actions 
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import org.flintparticles.common.actions.ActionBase;
	import org.flintparticles.common.emitters.Emitter;
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.twoD.particles.Particle2D;	

	/**
	 * The BoundingBox action confines each particle to a box. The 
	 * particle bounces back off the side of the box when it reaches 
	 * the edge. The bounce treats the particle as a circular body
	 * and displays no loss of energy in the collision.
	 */

	public class BoundingBox extends ActionBase
	{
		private var _left : Number;
		private var _top : Number;
		private var _right : Number;
		private var _bottom : Number;

		/**
		 * The constructor creates a BoundingBox action for use by 
		 * an emitter. To add a BoundingBox to all particles created by an emitter, use the
		 * emitter's addAction method.
		 * 
		 * @see org.flintparticles.common.emitters.Emitter#addAction()
		 * 
		 * @param left The left coordinate of the box. The coordinates are in the
		 * coordinate space of the object containing the emitter.
		 * @param top The top coordinate of the box. The coordinates are in the
		 * coordinate space of the object containing the emitter.
		 * @param right The right coordinate of the box. The coordinates are in the
		 * coordinate space of the object containing the emitter.
		 * @param bottom The bottom coordinate of the box. The coordinates are in the
		 * coordinate space of the object containing the emitter.
		 */
		public function BoundingBox( left:Number, top:Number, right:Number, bottom:Number )
		{
			_left = left;
			_top = top;
			_right = right;
			_bottom = bottom;
		}
		
		/**
		 * The bounding box.
		 */
		public function get box():Rectangle
		{
			return new Rectangle( _left, _top, _right - _left, _bottom - _top );
		}
		public function set box( value:Rectangle ):void
		{
			_left = value.left;
			_right = value.right;
			_top = value.top;
			_bottom = value.bottom;
		}

		/**
		 * The left coordinate of the bounding box.
		 */
		public function get left():Number
		{
			return _left;
		}
		public function set left( value:Number ):void
		{
			_left = value;
		}

		/**
		 * The top coordinate of the bounding box.
		 */
		public function get top():Number
		{
			return _top;
		}
		public function set top( value:Number ):void
		{
			_top = value;
		}

		/**
		 * The left coordinate of the bounding box.
		 */
		public function get right():Number
		{
			return _right;
		}
		public function set right( value:Number ):void
		{
			_right = value;
		}

		/**
		 * The left coordinate of the bounding box.
		 */
		public function get bottom():Number
		{
			return _bottom;
		}
		public function set bottom( value:Number ):void
		{
			_bottom = value;
		}

		/**
		 * Returns a value of -20, so that the BoundingBox executes after all movement has occured.
		 * 
		 * @see org.flintparticles.common.actions.Action#getDefaultPriority()
		 */
		override public function getDefaultPriority():Number
		{
			return -20;
		}

		/**
		 * Tests whether the particle is at the edge of the box and, if so,
		 * adjusts its velocity to bounce in back towards the center of the
		 * box.
		 * 
		 * <p>This method is called by the emitter and need not be called by the 
		 * user</p>
		 * 
		 * @param emitter The Emitter that created the particle.
		 * @param particle The particle to be updated.
		 * @param time The duration of the frame - used for time based updates.
		 * 
		 * @see org.flintparticles.common.actions.Action#update()
		 */
		override public function update( emitter : Emitter, particle : Particle, time : Number ) : void
		{
			var p:Particle2D = Particle2D( particle );
			var halfWidth:Number;
			var halfHeight:Number;
			if( particle.image && particle.image is DisplayObject )
			{
				var img:DisplayObject = particle.image;
				halfWidth = particle.scale * img.width * 0.5;
				halfHeight = particle.scale * img.height * 0.5;
			}
			else
			{
				halfWidth = halfHeight = 0;
			}
			var position:Number;
			if ( p.velX > 0 && ( position = p.x + halfWidth ) >= _right )
			{
				p.velX = -p.velX;
				p.x += 2 * ( _right - position );
			}
			else if ( p.velX < 0 && ( position = p.x - halfWidth ) <= _left )
			{
				p.velX = -p.velX;
				p.x += 2 * ( _left - position );
			}
			if ( p.velY > 0 && ( position = p.y + halfHeight ) >= _bottom )
			{
				p.velY = -p.velY;
				p.y += 2 * ( _bottom - position );
			}
			else if ( p.velY < 0 && ( position = p.y - halfHeight ) <= _top )
			{
				p.velY = -p.velY;
				p.y += 2 * ( _top - position );
			}
		}
	}
}
