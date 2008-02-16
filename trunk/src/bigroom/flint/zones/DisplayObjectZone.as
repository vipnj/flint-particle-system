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

package bigroom.flint.zones 
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import bigroom.flint.emitters.Emitter;	

	/**
	 * The DisplayObjectZone zone defines a shaped zone based on a DisplayObject.
	 * The zone contains the shape of the DisplayObject. The DisplayObject must be
	 * on the stage for it to be used, since it's position on stage determines the 
	 * position of the zone.
	 */

	public class DisplayObjectZone  implements Zone 
	{
		private var _displayObject : DisplayObject;
		private var _emitter : Emitter;
		private var _area : Number;

		
		/**
		 * The constructor creates a DisplayObjectZone object.
		 * 
		 * @param displayObject The DisplayObject that defines the zone.
		 * @param emitter The emitter that you plan to use the zone with. The 
		 * coordinates of the DisplayObject are translated to the local coordinate 
		 * space of the emitter.
		 */
		public function DisplayObjectZone( displayObject : DisplayObject, emitter : Emitter )
		{
			_displayObject = displayObject;
			_emitter = emitter;
			
			var bounds:Rectangle = _displayObject.getBounds( _displayObject.stage );
			
			_area = 0;
			var right:Number = bounds.right;
			var bottom:Number = bounds.bottom;
			for( var x : uint = bounds.left; x <= right ; ++x )
			{
				for( var y : uint = bounds.top; y <= bottom ; ++y )
				{
					if ( _displayObject.hitTestPoint( x, y, true ) )
					{
						++_area;
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
			var point:Point = new Point( x, y );
			point = _emitter.parent.localToGlobal( point );
			return _displayObject.hitTestPoint( point.x, point.y, true );
		}

		/**
		 * The getLocation method returns a random point inside the zone.
		 * 
		 * @return a random point inside the zone.
		 */
		public function getLocation() : Point
		{
			var bounds:Rectangle = _displayObject.getBounds( _displayObject.stage );
			do
			{
				var x : Number = bounds.left + Math.random( ) * bounds.width;
				var y : Number = bounds.top + Math.random( ) * bounds.height;
			}
			while( !_displayObject.hitTestPoint( x, y, true ) );
			var point:Point = new Point( x, y );
			point = _emitter.globalToLocal( point );
			return point;
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
