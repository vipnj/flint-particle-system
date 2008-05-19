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
	 * The BitmapData zone defines a shaped zone based on a BitmapData object.
	 * The zone contains all pixels in the bitmap that are not transparent -
	 * i.e. they have an alpha value greater than zero.
	 */

	public class BitmapDataZone implements Zone 
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
		 * The constructor creates a BitmapDataZone object.
		 * 
		 * @param bitmapData The bitmapData object that defines the zone.
		 * @param xOffset A horizontal offset to apply to the pixels in the BitmapData object 
		 * to reposition the zone
		 * @param yOffset A vertical offset to apply to the pixels in the BitmapData object 
		 * to reposition the zone
		 */
		public function BitmapDataZone( bitmapData : BitmapData, xOffset : Number = 0, yOffset : Number = 0 )
		{
			_bitmapData = bitmapData;
			_left = xOffset;
			_top = yOffset;
			invalidate();
		}
		
		/**
		 * The bitmapData object that defines the zone.
		 */
		public function get bitmapData() : BitmapData
		{
			return _bitmapData;
		}
		public function set bitmapData( value : BitmapData ) : void
		{
			_bitmapData = value;
			invalidate();
		}

		/**
		 * A horizontal offset to apply to the pixels in the BitmapData object 
		 * to reposition the zone
		 */
		public function get xOffset() : Number
		{
			return _left;
		}
		public function set xOffset( value : Number ) : void
		{
			_left = value;
			invalidate();
		}

		/**
		 * A vertical offset to apply to the pixels in the BitmapData object 
		 * to reposition the zone
		 */
		public function get yOffset() : Number
		{
			return _top;
		}
		public function set yOffset( value : Number ) : void
		{
			_top = value;
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
					if ( ( pixel >> 24 & 0xFF ) != 0 )
					{
						++_area;
						_validPoints.push( new Point( x + _left, y + _top ) );
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
				return ( pixel >> 24 & 0xFF ) != 0;
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
/*			do
			{
				var x : Number = Math.random( ) * _width;
				var y : Number = Math.random( ) * _height;
				var pixel : uint = _bitmapData.getPixel32( Math.round( x ), Math.round( y ) );
			}
			while( ( pixel >> 24 & 0xFF ) == 0 );
			return new Point( x + _left, y + _top );*/
			return _validPoints[ Math.floor( Math.random() * _validPoints.length ) ];
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
