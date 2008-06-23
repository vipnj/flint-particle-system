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
	
	import org.flintparticles.common.actions.ActionBase;
	import org.flintparticles.common.emitters.Emitter;
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.twoD.particles.Particle2D;	

	/**
	 * The MouseExplosion action applies a force on the particle to push it away from
	 * the mouse. The force applied is inversely proportional to the square of the 
	 * distance from the particle to the mouse.
	 */

	public class MouseAntiGravity extends ActionBase
	{
		private var _power:Number;
		private var _gravityConst:Number = 10000; // scales the power to more usable levels
		private var _epsilonSq:Number;
		private var _renderer:DisplayObject;
		
		/**
		 * The constructor creates a MouseExplosion action for use by 
		 * an emitter. To add a MouseExplosion to all particles created by an emitter, use the
		 * emitter's addAction method.
		 * 
		 * @see org.flintparticles.common.emitters.Emitter#addAction()
		 * 
		 * @param power The strength of the force - larger numbers produce a stronger force.
		 * @param renderer The display object whose coordinate system the mouse position is 
		 * converted to. This is usually the renderer for the particle system created by the emitter.
		 * @param epsilon The minimum distance for which the explosion force is calculated. 
		 * Particles closer than this distance experience the explosion as it they were 
		 * this distance away. This stops the explosion effect blowing up as distances get 
		 * small.
		 */
		public function MouseAntiGravity( power:Number, renderer:DisplayObject, epsilon:Number = 1 )
		{
			_power = power * _gravityConst;
			_epsilonSq = epsilon * epsilon;
			_renderer = renderer;
		}
		
		/**
		 * The strength of the explosive force.
		 */
		public function get power():Number
		{
			return _power / _gravityConst;
		}
		public function set power( value:Number ):void
		{
			_power = value * _gravityConst;
		}
		
		/**
		 * The display object whose coordinate system the mouse position is converted to. This
		 * is usually the renderer for the particle system created by the emitter.
		 */
		public function get renderer():DisplayObject
		{
			return _renderer;
		}
		public function set renderer( value:DisplayObject ):void
		{
			_renderer = value;
		}
		
		/**
		 * The minimum distance for which the explosion force is calculated. 
		 * Particles closer than this distance experience the explosion as it they were 
		 * this distance away. This stops the explosion effect blowing up as distances get 
		 * small.
		 */
		public function get epsilon():Number
		{
			return Math.sqrt( _epsilonSq );
		}
		public function set epsilon( value:Number ):void
		{
			_epsilonSq = value * value;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function update( emitter:Emitter, particle:Particle, time:Number ):void
		{
			var p:Particle2D = Particle2D( particle );
			var x:Number = p.x - _renderer.mouseX;
			var y:Number = p.y - _renderer.mouseY;
			var dSq:Number = x * x + y * y;
			if( dSq == 0 )
			{
				return;
			}
			var d:Number = Math.sqrt( dSq );
			if( dSq < _epsilonSq ) dSq = _epsilonSq; // stop it blowing uyp to ridiculous values
			var factor:Number = ( _power * time ) / ( dSq * d );
			p.velX += x * factor;
			p.velY += y * factor;
		}
	}
}
