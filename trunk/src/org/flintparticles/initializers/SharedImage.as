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

package org.flintparticles.initializers 
{
	import flash.display.DisplayObject;
	
	import org.flintparticles.emitters.Emitter;
	import org.flintparticles.particles.Particle;	

	/**
	 * The SharedImage Initializer sets the DisplayObject to use to draw
	 * the particle. It is used with the BitmapEmitter. When using the
	 * DisplayObjectEmitter the ImageClass Initializer must be used.
	 * 
	 * With the BitmapEmitter, the DisplayObject is copied into the bitmap
	 * using the particle's property to place the image correctly. So
	 * all many particles can share the same DisplayObject because it is
	 * only indirectly used to display the particle.
	 */

	public class SharedImage extends Initializer
	{
		private var _image:DisplayObject;
		
		/**
		 * The constructor creates a SharedImage initializer for use by 
		 * an emitter. To add a SharedImage to all particles created by 
		 * an emitter, use the emitter's addInitializer method.
		 * 
		 * @param image The DisplayObject to use for each particle created by the emitter.
		 * 
		 * @see org.flintparticles.emitters.Emitter#addInitializer()
		 */
		public function SharedImage( image:DisplayObject )
		{
			_image = image;
		}
		
		/**
		 * The init method is used by the emitter to initialize the particle.
		 * It is called within the emitter's createParticle method and need not
		 * be called by the user.
		 * 
		 * @param emitter The Emitter that created the particle.
		 * @param particle The particle to be initialized.
		 */
		override public function initialize( emitter:Emitter, particle:Particle ):void
		{
			particle.image = _image;
		}
	}
}
