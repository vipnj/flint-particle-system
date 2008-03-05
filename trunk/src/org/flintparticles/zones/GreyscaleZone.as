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

package org.flintparticles.zones 
{
	import flash.display.BitmapData;
	import flash.geom.Point;	

	/**
	 * The Greyscale zone defines a shaped zone based on a BitmapData object.
	 * The zone contains all pixels in the bitmap that are not black, with a weighting
	 * such that lighter pixels are more likely to be selected than darker pixels
	 * when creating particles inside the zone.
	 */

	public class GreyscaleZone implements Zone 
	{
		private var _bitmapData : BitmapData;
		private var _left : Number;
		private var _top : Number;
		private var _right : Number;
		private var _bottom : Number;
		private var _width : Number;
		private var _height : Number;
		private var _area : Number;
		private var _validPoints : Array;
		
		/**
		 * The constructor creates a GreyscaleZone object.
		 * 
		 * @param bitmapData The bitmapData object that defines the zone.
		 * @param xOffset A horizontal offset to apply to the pixels in the BitmapData object 
		 * to reposition the zone
		 * @param yOffset A vertical offset to apply to the pixels in the BitmapData object 
		 * to reposition the zone
		 */
		public function GreyscaleZone( bitmapData : BitmapData, xOffset : Number = 0, yOffset : Number = 0 )
		{
			_bitmapData = bitmapData;
			_left = xOffset;
			_top = yOffset;
			invalidate();
		}
		
		/**
		 * This method forces the zone to revaluate itself. It should be called whenever the 
		 * contents of the BitmapData object change. However, it is an intensive method and 
		 * calling it frequently will likely slow your code down.
		 */
		public function invalidate():void
		{
			_width = _bitmapData.width;
			_height = _bitmapData.height;
			_right = _left + _width;
			_bottom = _top + _height;
			
			_validPoints = new Array();
			_area = 0;
			for( var x : uint = 0; x < _width ; ++x )
			{
				for( var y : uint = 0; y < _height ; ++y )
				{
					var pixel : uint = _bitmapData.getPixel32( x, y );
					var grey : Number = 0.11 * ( pixel & 0xFF ) + 0.59 * ( ( pixel >>> 8 ) & 0xFF ) + 0.3 * ( ( pixel >>> 16 ) & 0xFF );
					if ( grey != 0 )
					{
						_area += grey / 255;
						_validPoints.push( new WeightedPoint( x + _left, y + _top, _area ) );
					}
				}
			}
		}

		/**
		 * The contains method determines whether a point is inside the zone.
		 * 
		 * @param point The location to test for.
		 * @return true if point is inside the zone, false if it is outside.
		 */
		public function contains( x : Number, y : Number ) : Boolean
		{
			if( x >= _left && x <= _right && y >= _top && y <= _bottom )
			{
				var pixel : uint = _bitmapData.getPixel32( Math.round( x - _left ), Math.round( y - _top ) );
				return ( pixel & 0xFFFFFF ) != 0;
			}
			return false;
		}

		/**
		 * The getLocation method returns a random point inside the zone.
		 * 
		 * @return a random point inside the zone.
		 */
		public function getLocation() : Point
		{
			var value:Number = Math.random() * _area;
			var low:uint = 0;
			var mid:uint;
			var high:uint = _validPoints.length;
			while( low < high )
			{
				mid = Math.floor( ( low + high ) * 0.5 );
				if( _validPoints[ mid ].weight < value )
				{
					low = mid + 1;
				}
				else
				{
					high = mid;
				}
			}
			return _validPoints[low].point;
		}
		
		/**
		 * The getArea method returns the size of the zone.
		 * It's used by the MultiZone class to manage the balancing between the
		 * different zones.
		 * 
		 * @return the size of the zone.
		 */
		public function getArea() : Number
		{
			return _area;
		}
	}
}

import flash.geom.Point;

class WeightedPoint 
{
	public var point:Point;
	public var weight:Number;
	
	public function WeightedPoint( x:int, y:int, topWeight:Number ):void
	{
		point = new Point( x, y );
		weight = topWeight;
	}
}