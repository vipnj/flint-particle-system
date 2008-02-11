﻿/*
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
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import bigroom.flint.particles.Particle;	

	public class PixelEmitter extends BitmapEmitter
	{
		/**
		 * The constructor creates a PixelEmitter. After creation it should be
		 * added to the display list of a DisplayObjectContainer to place it on the stage.
		 */
		public function PixelEmitter()
		{
			super();
		}
		
		/**
		 * Used internally to draw the particles.
		 */
		override protected function drawParticle( particle:Particle ):void
		{
			_bitmap.bitmapData.setPixel32( Math.round( particle.x + _offset.x ), Math.round( particle.y + _offset.y ), particle.color );
		}
	}
}