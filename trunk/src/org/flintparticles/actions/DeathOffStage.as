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
	import flash.geom.Point;
	
	import org.flintparticles.actions.Action;
	import org.flintparticles.emitters.Emitter;
	import org.flintparticles.particles.Particle;	

	/**
	 * The DeathOffStage action marks the particle as dead if it is outside the stage.
	 * Warning: The DeathOffStage action is very slow.
	 */

	public class DeathOffStage extends Action
	{
		private var _padding:Number;
		private var _left:Number = NaN;
		private var _right:Number = NaN;
		private var _top:Number = NaN;
		private var _bottom:Number = NaN;
		
		/**
		 * The constructor creates a DeathOffStage action for use by 
		 * an emitter. To add a DeathOffStage to all particles created by an emitter, use the
		 * emitter's addAction method.
		 * 
		 * @see org.flintparticles.emitters.Emitter#addAction()
		 * 
		 * @param padding An additional distance, in pixels, to add around the stage
		 * to allow for the size of the particles.
		 */
		public function DeathOffStage( padding:Number = 10 )
		{
			_padding = padding;
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
		override public function update( emitter:Emitter, particle:Particle, time:Number ):void
		{
			if( !emitter.stage )
			{
				return;
			}
			if( isNaN( _top ) )
			{
				var point:Point = emitter.parent.localToGlobal( new Point( 0, 0 ) );
				_left = point.x - _padding;
				_right = point.x + emitter.stage.stageWidth + _padding;
				_top = point.y - _padding;
				_bottom = point.y + emitter.stage.stageHeight + _padding;
			}
			
			if( particle.x < _left || particle.x > _right || particle.y < _top || particle.y > _bottom )
			{
				particle.isDead = true;
			}
		}
	}
}
