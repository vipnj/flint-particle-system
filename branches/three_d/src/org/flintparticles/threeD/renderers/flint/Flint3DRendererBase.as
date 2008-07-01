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

package org.flintparticles.threeD.renderers.flint
{
	import org.flintparticles.common.renderers.RendererBase;
	import org.flintparticles.threeD.geom.Matrix3D;	

	/**
	 * Base class for the built-in Flint renderers. This class does the common 
	 * 3D stuff used by all the built-in renderers.
	 * 
	 * <p>The built-in renderers don't require any additional 3D libraries to
	 * use. They display the particles as billboards or pixels within a standard
	 * display object with depth, perspective and z-sorting to create a 3D
	 * view on the particle systems. The built-in renderers use a left-hand
	 * coordinate system. In camera local coordinates, the x axis is horizontal 
	 * to the right, the y axis is vertical up and the z axis is away from the 
	 * camera.</p>
	 * 
	 * <p>The advantage to these Flint renderers is that they don't require any
	 * additional 3D libraries in order to operate. This keeps file size small
	 * and may make the renderers more efficient.</p>
	 * 
	 * <p>The disadvantage is that these renderers don't allow the particle
	 * system to be integrated with other objects within a 3D scene. For that, you
	 * need a generic 3D system and an appropriate renderer to draw the Flint
	 * particle systems within a 3D scene in that 3D system.</p>
	 * 
	 * <p>Flint are collaborating with developers of 3D systems to create the 
	 * appropriate renderers.</p>
	 */
	public class Flint3DRendererBase extends RendererBase
	{
		/**
		 * @private
		 */
		protected var _projectionDistance:Number = 400;
		/**
		 * @private
		 */
		protected var _nearDistance:Number = 10;
		/**
		 * @private
		 */
		protected var _farDistance:Number = 2000;
		/**
		 * @private
		 */
		protected var _cameraTransform:Matrix3D;
		/**
		 * @private
		 */
		protected var _dirty:Boolean = true;
		/**
		 * @private
		 */
		protected var _projectionTransform:Matrix3D;
		/**
		 * @private
		 */
		protected var _zSort:Boolean;
		
		/**
		 * The constructor creates a Flint3DRendererBase. This constructor
		 * shouldn't be called directly because this is an abstract base class
		 * and developers shouldbe using teh classes derived from this base class.
		 * 
		 * @param zSort Whether to sort the particle images in z-order (true) or
		 * not (false) when rendering them.
		 * 
		 * @see org.flintparticles.twoD.emitters.Emitter#renderer
		 */
		public function Flint3DRendererBase( zSort:Boolean )
		{
			super();
			_zSort = zSort;
			_cameraTransform = Matrix3D.IDENTITY.clone();
		}
		
		/**
		 * The transformation matrix that positions the camera in world space.
		 * Particles will be transformed using the inverse of this transformation
		 * to position them in the camera's coordinate system.
		 */
		public function get cameraTransform():Matrix3D
		{
			return _cameraTransform.clone();
		}
		public function set cameraTransform( value:Matrix3D ):void
		{
			_cameraTransform = value.clone();
			_dirty = true;
		}
		
		/**
		 * The distance to the camera's near plane
		 * - particles closer than this are not rendered.
		 * 
		 * The default value is 10.
		 */
		public function get nearPlaneDistance():Number
		{
			return _nearDistance;
		}
		public function set nearPlaneDistance( value:Number ):void
		{
			_nearDistance = value;
		}
		
		/**
		 * The distance to the camera's far plane
		 * - particles farther away than this are not rendered.
		 * 
		 * The default value is 2000.
		 */
		public function get farPlaneDistance():Number
		{
			return _farDistance;
		}
		public function set farPlaneDistance( value:Number ):void
		{
			_farDistance = value;
		}
		
		/**
		 * The distance to the camera's projection distance. Particles this
		 * distance from the camera are rendered at their normal size. Perspective
		 * will cause closer particles to appear larger than normal and more 
		 * distant particles to appear smaller than normal.
		 * 
		 * The default value is 400.
		 */
		public function get projectionDistance():Number
		{
			return _projectionDistance;
		}
		public function set projectionDistance( value:Number ):void
		{
			_projectionDistance = value;
			_dirty = true;
		}

		/**
		 * Used to recalculate the projection matrix to transform particles
		 * to the camera's coordinate system and project them on the camera's
		 * projection plane.
		 */
		protected function calculateTransform():void
		{
			_projectionTransform = new Matrix3D( [
				_projectionDistance, 0, 0, 0,
				0, _projectionDistance, 0, 0,
				0, 0, 1, 0,
				0, 0, 1, 0
			] );
			_projectionTransform.prepend( _cameraTransform.inverse );
			_dirty = false;
		}
	}
}