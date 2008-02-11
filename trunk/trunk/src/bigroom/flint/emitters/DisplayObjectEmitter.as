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

package bigroom.flint.emitters
{
	import bigroom.flint.particles.Particle;
	
	import flash.display.DisplayObject;
	import flash.geom.Transform;	

	/**
	 * The DisplayObjectEmitter is an emitter that manages its particles by
	 * adding them to its display list and letting the flash renderer deal
	 * will displaying them.
	 * 
	 * <p>Consequently particle must be represented by a DisplayObject, and
	 * each must use a different DisplayObject instance. The DisplayObject
	 * to be used should not be defined using the SharedImage initializer
	 * because this shares one DisplayObject instance between all the particles.
	 * The ImageClass initializer is commonly used because this creates a new 
	 * DisplayObject for each particle.</p>
	 */
	public class DisplayObjectEmitter extends Emitter
	{
		/**
		 * The constructor creates a DisplayObjectEmitter. After creation it should be
		 * added to the display list of a DisplayObjectContainer to place it on the stage.
		 */
		public function DisplayObjectEmitter()
		{
			super();
		}
		
		/**
		 * Used internally. During the update phase, the particle's properties are copied to the
		 * DisplayObject representing the particle.
		 */
		override protected function update( time:Number ):void
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
		 * Used internally. When created, the particle is added to the emitter's display list.
		 */
		override protected function particleCreated( particle:Particle ):void
		{
			addChild( particle.image );
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