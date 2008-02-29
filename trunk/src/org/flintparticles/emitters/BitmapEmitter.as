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
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import org.flintparticles.particles.Particle;	

	/**
	 * The BitmapEmitter is an emitter that manages its particles by
	 * drawing them all onto a single Bitmap display object.
	 * 
	 * <p>The image to be used for each particle is a DisplayObject, but this 
	 * DisplayObject is not used directly but is, rather, copied into the
	 * bitmap with the various properties of the particle applied.
	 * Consequently each each particle may be represented by the same DisplayObject
	 * instance and the SharedImage initializer can be used with this emitter.</p>
	 * 
	 * <p>The BitmapEmitter allows the use of BitmapFilters to modify the appearance
	 * of the bitmap. Every frame, under normal circumstances, the Bitmap used to
	 * display the particles is wiped clean before all the particles are redrawn.
	 * However, if one or more filters aare added to the emitter, the filters are
	 * applied to the bitmap instead of wiping it clean. This enables various trail
	 * effects by using blur and other filters.</p>
	 */
	public class BitmapEmitter extends Emitter
	{
		protected var _bitmap:Bitmap;
		protected var _offset:Point;
		private var _preFilters:Array;
		private var _postFilters:Array;

		/**
		 * The constructor creates a BitmapEmitter. After creation it should be
		 * added to the display list of a DisplayObjectContainer to place it on the stage.
		 */
		public function BitmapEmitter()
		{
			super();
			_preFilters = new Array();
			_postFilters = new Array();
			addEventListener( Event.ADDED_TO_STAGE, addedToStage, false, 0, true );
		}
		
		/**
		 * The addFilter method adds a BitmapFilter to the emitter. These filters
		 * are applied each frame before the new particle positions are drawn, instead
		 * of wiping the display clear. Use of a blur filter, for example, will
		 * produce a trail behind each particle as the previous images blur and fade
		 * more each frame.
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
		 * Removes a BitmapFilter object from the Emitter.
		 * 
		 * @param filter The BitmapFilter to remove
		 * 
		 * @see addFilter()
		 */
		public function removeFilter( filter:BitmapFilter ):void
		{
			for( var i:uint = 0; i < _preFilters.length; ++i )
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
		 * Create the correct sized bitmap when the emitter is added to the display list.
		 */
		private function addedToStage( ev:Event ):void
		{
			if( _bitmap && _bitmap.bitmapData )
			{
				_bitmap.bitmapData.dispose();
			}
			if( !stage || stage.stageWidth == 0 )
			{
				_bitmap = null;
				return;
			}
			_bitmap = new Bitmap();
			_bitmap.bitmapData = new BitmapData( stage.stageWidth, stage.stageHeight, true, 0 );
			addChild( _bitmap );
			_offset = parent.localToGlobal( new Point( 0, 0 ) );
			_bitmap.x = - _offset.x;
			_bitmap.y = - _offset.y;
		}
		
		/**
		 * Starts the emitter. Until start is called, the emitter will not emit any particles.
		 */
		override public function start():void
		{
			super.start();
			if( !_bitmap )
			{
				addedToStage( null );
			}
		}
		
		/**
		 * Used internally. Applies filters and renders the particle's image onto the bitmap.
		 */
		override protected function render( time:Number ):void
		{
			if( !_bitmap )
			{
				addedToStage( null );
				if( !_bitmap )
				{
					return;
				}
			}
			var i:uint;
			var len:uint;
			_bitmap.bitmapData.lock();
			len = _preFilters.length;
			for( i = 0; i < len; ++i )
			{
				_bitmap.bitmapData.applyFilter( _bitmap.bitmapData, _bitmap.bitmapData.rect, new Point( 0, 0 ), _preFilters[i] );
			}
			if( len == 0 && _postFilters.length == 0 )
			{
				_bitmap.bitmapData.fillRect( _bitmap.bitmapData.rect, 0 );
			}
			len = _particles.length;
			if ( len )
			{
				for( i = 0; i < len; ++i )
				{
					drawParticle( _particles[i] );
				}
			}
			len = _postFilters.length;
			for( i = 0; i < len; ++i )
			{
				_bitmap.bitmapData.applyFilter( _bitmap.bitmapData, _bitmap.bitmapData.rect, new Point( 0, 0 ), _postFilters[i] );
			}
			_bitmap.bitmapData.unlock();
		}
		
		/**
		 * Used internally here and in derived classes to alter the manner of 
		 * the particle rendering (e.g. te PixelRenderer just sets a single pixel.
		 */
		protected function drawParticle( particle:Particle ):void
		{
			var matrix:Matrix;
			matrix = particle.matrixTransform;
			matrix.translate( _offset.x, _offset.y );
			_bitmap.bitmapData.draw( particle.image, matrix, particle.colorTransform );
		}
		
		/**
		 * Used internally. When the Emitter is disposed it calls tis method and
		 * we dump the BitmapData object.
		 */
		override protected function cleanUp():void
		{
			_bitmap.bitmapData.dispose();
		}
	}
}