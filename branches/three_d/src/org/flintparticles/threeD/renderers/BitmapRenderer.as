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

package org.flintparticles.threeD.renderers
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.flintparticles.threeD.geom.Vector3D;
	import org.flintparticles.threeD.particles.Particle3D;	

	/**
	 * This 3D renderer is rubbish. It's just good enough to test the rest of the system, but 
	 * not useful for much else. There will be much better 3D renderers soon.
	 */
	public class BitmapRenderer extends Flint3DRendererBase
	{
		protected static var ZERO_POINT:Point = new Point( 0, 0 );
		
		/**
		 * @private
		 */
		protected var _bitmap:Bitmap;
		/**
		 * @private
		 */
		protected var _preFilters:Array;
		/**
		 * @private
		 */
		protected var _postFilters:Array;
		/**
		 * @private
		 */
		protected var _paletteMap:Array;
		/**
		 * @private
		 */
		protected var _smoothing:Boolean;
		/**
		 * @private
		 */
		protected var _canvas:Rectangle;
		/**
		 * @private
		 */
		protected var _zSort:Boolean;

		/**
		 * The constructor creates a BitmapRenderer. After creation it should be
		 * added to the display list of a DisplayObjectContainer to place it on 
		 * the stage and should be applied to an Emitter using the Emitter's
		 * renderer property.
		 * 
		 * @param canvas The area within the renderer on which particles can be drawn.
		 * Particles outside this area will not be drawn.
		 * @param smoothing Whether to use smoothing when scaling the Bitmap and, if the
		 * particles are represented by bitmaps, when drawing the particles.
		 * Smoothing removes pixelation when images are scaled and rotated, but it
		 * takes longer so it may slow down your particle system.
		 * 
		 * @see org.flintparticles.twoD.emitters.Emitter#renderer
		 */
		public function BitmapRenderer( canvas:Rectangle, zSort:Boolean = false, smoothing:Boolean = false )
		{
			super();
			mouseEnabled = false;
			mouseChildren = false;
			_zSort = zSort;
			_smoothing = smoothing;
			_preFilters = new Array();
			_postFilters = new Array();
			_canvas = canvas;
			createBitmap();
		}
		
		/**
		 * The addFilter method adds a BitmapFilter to the renderer. These filters
		 * are applied each frame, before or after the new particle positions are 
		 * drawn, instead of wiping the display clear. Use of a blur filter, for 
		 * example, will produce a trail behind each particle as the previous images
		 * blur and fade more each frame.
		 * 
		 * @param filter The filter to apply
		 * @param postRender If false, the filter is applied before drawing the particles
		 * in their new positions. If true the filter is applied after drawing the particles.
		 */
		public function addFilter( filter:BitmapFilter, postRender:Boolean = false ):void
		{
			if( postRender )
			{
				_postFilters.push( filter );
			}
			else
			{
				_preFilters.push( filter );
			}
		}
		
		/**
		 * Removes a BitmapFilter object from the Renderer.
		 * 
		 * @param filter The BitmapFilter to remove
		 * 
		 * @see addFilter()
		 */
		public function removeFilter( filter:BitmapFilter ):void
		{
			for( var i:int = 0; i < _preFilters.length; ++i )
			{
				if( _preFilters[i] == filter )
				{
					_preFilters.splice( i, 1 );
					return;
				}
			}
			for( i = 0; i < _postFilters.length; ++i )
			{
				if( _postFilters[i] == filter )
				{
					_postFilters.splice( i, 1 );
					return;
				}
			}
		}
		
		/**
		 * Sets a palette map for the renderer. See the paletteMap method in flash's BitmapData object for
		 * information about how palette maps work. The palette map will be applied to the full canvas of the 
		 * renderer after all filters have been applied and the particles have been drawn.
		 */
		public function setPaletteMap( red : Array = null , green : Array = null , blue : Array = null, alpha : Array = null ) : void
		{
			_paletteMap = new Array(4);
			_paletteMap[0] = alpha;
			_paletteMap[1] = red;
			_paletteMap[2] = green;
			_paletteMap[3] = blue;
		}
		/**
		 * Clears any palette map that has been set for the renderer.
		 */
		public function clearPaletteMap() : void
		{
			_paletteMap = null;
		}
		
		/**
		 * Create the Bitmap and BitmapData objects
		 */
		protected function createBitmap():void
		{
			if( !canvas )
			{
				return;
			}
			if( _bitmap && _bitmap.bitmapData )
			{
				_bitmap.bitmapData.dispose();
			}
			if( _bitmap )
			{
				removeChild( _bitmap );
			}
			_bitmap = new Bitmap( null, "auto", _smoothing);
			_bitmap.bitmapData = new BitmapData( _canvas.width, _canvas.height, true, 0 );
			addChild( _bitmap );
			_bitmap.x = _canvas.x;
			_bitmap.y = _canvas.y;
		}
		
		/**
		 * The canvas is the area within the renderer on which particles can be drawn.
		 * Particles outside this area will not be drawn.
		 */
		public function get canvas():Rectangle
		{
			return _canvas;
		}
		public function set canvas( value:Rectangle ):void
		{
			_canvas = value;
			createBitmap();
		}

		/**
		 * The canvas is the area within the renderer on which particles can be drawn.
		 * Particles outside this area will not be drawn.
		 */
		public function get zSort():Boolean
		{
			return _zSort;
		}
		public function set zSort( value:Boolean ):void
		{
			_zSort = value;
		}
				
		/**
		 * When the renderer is no longer required, this method must be called by the 
		 * user to free up memory used by the renderer. If you don't call this method
		 * then the renderer's bitmap data will remain in memory.
		 */
		public function dispose():void
		{
			if( _bitmap && _bitmap.bitmapData )
			{
				_bitmap.bitmapData.dispose();
			}
		}

		/**
		 * @inheritDoc
		 */
		override protected function renderParticles( particles:Array ):void
		{
			if( !_bitmap )
			{
				return;
			}
			if( _dirty )
			{
				calculateTransform();
			}
			
			var i:int;
			var len:int;
			_bitmap.bitmapData.lock();
			len = _preFilters.length;
			for( i = 0; i < len; ++i )
			{
				_bitmap.bitmapData.applyFilter( _bitmap.bitmapData, _bitmap.bitmapData.rect, BitmapRenderer.ZERO_POINT, _preFilters[i] );
			}
			if( len == 0 && _postFilters.length == 0 )
			{
				_bitmap.bitmapData.fillRect( _bitmap.bitmapData.rect, 0 );
			}
			if( _zSort )
			{
				
			}
			else
			{
				len = particles.length;
				for( i = 0; i < len; ++i )
				{
					drawParticle( particles[i] );
				}
			}
			len = _postFilters.length;
			for( i = 0; i < len; ++i )
			{
				_bitmap.bitmapData.applyFilter( _bitmap.bitmapData, _bitmap.bitmapData.rect, BitmapRenderer.ZERO_POINT, _postFilters[i] );
			}
			if( _paletteMap )
			{
				_bitmap.bitmapData.paletteMap( _bitmap.bitmapData, _bitmap.bitmapData.rect, ZERO_POINT, _paletteMap[1] , _paletteMap[2] , _paletteMap[3] , _paletteMap[0] );
			}
			_bitmap.bitmapData.unlock();
		}
		
		/**
		 * Used internally here and in derived classes to alter the manner of 
		 * the particle rendering.
		 * 
		 * @param particle The particle to draw on the bitmap.
		 */
		protected function drawParticle( particle:Particle3D ):void
		{
			var pos:Vector3D = _spaceTransform.transformVector( particle.position );
			var scale:Number = _zoom * _projectionDistance / pos.z;
			var matrix:Matrix = new Matrix( particle.scale * scale, 0, 0, particle.scale * scale, pos.x * scale, -pos.y * scale );
			matrix.translate( -_canvas.x, -_canvas.y );
			_bitmap.bitmapData.draw( particle.image, matrix, particle.colorTransform, DisplayObject( particle.image ).blendMode, null, _smoothing );
		}
	}
}