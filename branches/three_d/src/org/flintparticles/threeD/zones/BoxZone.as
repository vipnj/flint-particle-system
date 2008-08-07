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

package org.flintparticles.threeD.zones 
{
	import org.flintparticles.threeD.geom.Matrix3D;
	import org.flintparticles.threeD.geom.Vector3D;				

	/**
	 * The RectangleZone zone defines a rectangular shaped zone.
	 */

	public class BoxZone implements Zone3D 
	{
		private var _width:Number;
		private var _height:Number;
		private var _depth:Number;
		private var _center:Vector3D;
		private var _upAxis:Vector3D;
		private var _depthAxis:Vector3D;
		private var _transformTo:Matrix3D;
		private var _transformFrom:Matrix3D;
		
		/**
		 * The constructor creates a RectangleZone zone.
		 * 
		 * @param left The left coordinate of the rectangle defining the region of the zone.
		 * @param top The top coordinate of the rectangle defining the region of the zone.
		 * @param right The right coordinate of the rectangle defining the region of the zone.
		 * @param bottom The bottom coordinate of the rectangle defining the region of the zone.
		 */
		public function BoxZone( width:Number, height:Number, depth:Number, center:Vector3D, upAxis:Vector3D, depthAxis:Vector3D )
		{
			_width = width;
			_height = height;
			_depth = depth;
			_center = center.clone();
			_center.w = 1;
			_upAxis = upAxis.unit();
			_upAxis.w = 0;
			_depthAxis = depthAxis.unit();
			_depthAxis.w = 0;
			init();
		}
		
		private function init():void
		{
			_transformFrom = Matrix3D.newRotateCoordinateSpace( null, _upAxis, _depthAxis );
			_transformFrom.appendTranslate( _center );
			_transformFrom.prependTranslate( new Vector3D( -_width/2, -_height/2, -_depth/2 ) );
			_transformTo = _transformFrom.inverse;
		}
		
		/**
		 * The contains method determines whether a point is inside the zone.
		 * This method is used by the initializers and actions that
		 * use the zone. Usually, it need not be called directly by the user.
		 * 
		 * @param x The x coordinate of the location to test for.
		 * @param y The y coordinate of the location to test for.
		 * @return true if point is inside the zone, false if it is outside.
		 */
		public function contains( p:Vector3D ):Boolean
		{
			var q:Vector3D = _transformTo.transformVector( p );
			return q.x >= 0 && q.x <= _width && q.y >= 0 && q.y <= _height && q.z >= 0 && q.z <= _depth;
		}
		
		/**
		 * The getLocation method returns a random point inside the zone.
		 * This method is used by the initializers and actions that
		 * use the zone. Usually, it need not be called directly by the user.
		 * 
		 * @return a random point inside the zone.
		 */
		public function getLocation():Vector3D
		{
			var p:Vector3D = new Vector3D( Math.random() * _width, Math.random() * _height, Math.random() * _depth, 1 );
			return _transformFrom.transformVectorSelf( p );
		}
		
		/**
		 * The getArea method returns the size of the zone.
		 * This method is used by the MultiZone class. Usually, 
		 * it need not be called directly by the user.
		 * 
		 * @return a random point inside the zone.
		 */
		public function getVolume():Number
		{
			return _width * _height * _depth;
		}
	}
}
