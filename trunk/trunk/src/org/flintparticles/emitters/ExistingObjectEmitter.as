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

package org.flintparticles.emitters
{
	import flash.display.DisplayObject;
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	import flash.geom.Transform;
	
	import org.flintparticles.counters.Counter;
	import org.flintparticles.particles.Particle;
	import org.flintparticles.utils.DisplayObjectUtils;
	import org.flintparticles.utils.Maths;	

	/**
	 * The ExistingObjectEmitter is an emitter that uses display objects
	 * that already exist on the display list as its particles.
	 * 
	 * The display objects are moved into the emitter's display list while 
	 * retaining their position and rotation in space and then are subjected to the 
	 * initializers and actions of the emitter.
	 */
	public class ExistingObjectEmitter extends Emitter
	{
		/**
		 * The constructor creates an ExistingObjectEmitter. After creation it should be
		 * added to the display list of a DisplayObjectContainer to place it on the stage.
		 */
		public function ExistingObjectEmitter()
		{
			super();
		}
		
		/**
		 * Do not use. The ExistingObjectEmitter uses existing display objects as its
		 * particles and cannot create particles using a counter
		 */
		override public function setCounter( counter:Counter ):void
		{
			throw new IllegalOperationError( "Counters may not e set on the ExistingObjectsEmitter" );
		}
		
		/**
		 * Used to add display objects as particles to the emitter
		 * 
		 * @param objects Each parameter is another display object for adding to the emitter.
		 * If you pass an array as the parameter, each item in the array another
		 * display object for adding to the emitter.
		 */
		public function addObjects( ...objects ):void
		{
			for( var i:Number = 0; i < objects.length; ++i )
			{
				if( objects[i] is Array )
				{
					for( var j:Number = 0; j < objects[i].length; ++j )
					{
						addObject( objects[i][j] );
					}
				}
				else
				{
					addObject( objects[i] );
				}
			}
		}
		
		private function addObject( obj:DisplayObject ):void
		{
			var particle:Particle = _creator.createParticle();
			var len:uint = _initializers.length;
			for ( var i:uint = 0; i < len; ++i )
			{
				_initializers[i].initialize( this, particle );
			}
			var p:Point = new Point( 0, 0 );
			p = globalToLocal( obj.localToGlobal( p ) );
			var r:Number = DisplayObjectUtils.globalToLocalRotation( this, DisplayObjectUtils.localToGlobalRotation( obj, 0 ) );
			obj.parent.removeChild( obj );
			addChild( obj );
			obj.x = particle.x = p.x + x;
			obj.y = particle.y = p.y + x;
			particle.image = obj;
			particle.rotation = Maths.asRadians( r + rotation );
			_particles.unshift( particle );
		}
		
		/**
		 * Used internally. During the update phase, the particle's properties are copied to the
		 * DisplayObject representing the particle.
		 */
		override protected function render( time:Number ):void
		{
			var particle:Particle;
			var len:uint = _particles.length;
			for( var i:uint = 0; i < len; ++i )
			{
				particle = _particles[i];
				particle.image.transform.colorTransform = particle.colorTransform;
				particle.image.transform.matrix = particle.matrixTransform;
			}
		}
		
		/**
		 * Used internally. When destroyed, the particle is removed from the emitter's display list.
		 */
		override protected function particleDestroyed( particle:Particle ):void
		{
			removeChild( particle.image );
		}
	}
}