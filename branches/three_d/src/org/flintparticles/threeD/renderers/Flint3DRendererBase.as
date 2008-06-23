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
	import flash.geom.Matrix;
	
	import org.flintparticles.common.renderers.RendererBase;
	import org.flintparticles.threeD.geom.Matrix3D;
	import org.flintparticles.threeD.geom.Vector3D;	

	/**
	 * The DisplayObjectRenderer adds particles to its display list 
	 * and lets the flash player render them in its usual way.
	 * 
	 * <p>Particles may be represented by any DisplayObject and each particle 
	 * must use a different DisplayObject instance. The DisplayObject
	 * to be used should not be defined using the SharedImage initializer
	 * because this shares one DisplayObject instance between all the particles.
	 * The ImageClass initializer is commonly used because this creates a new 
	 * DisplayObject for each particle.</p>
	 * 
	 * <p>The DisplayObjectRenderer has mouse events disabled for itself and any 
	 * display objects in its display list. To enable mouse events for the renderer
	 * or its children set the mouseEnabled or mouseChildren properties to true.</p>
	 */
	public class Flint3DRendererBase extends RendererBase
	{
		private var _position:Vector3D;
		private var _rotation:Vector3D;
		/**
		 * @private
		 */
		protected var _projectionDistance:Number = 50;
		/**
		 * @private
		 */
		protected var _zoom:Number = 10;
		/**
		 * @private
		 */
		protected var _spaceTransform:Matrix3D;
		/**
		 * @private
		 */
		protected var _flashTransform:Matrix;
		/**
		 * @private
		 */
		protected var _dirty:Boolean = true;
		
		/**
		 * The constructor creates a DisplayObjectRenderer. After creation it should
		 * be added to the display list of a DisplayObjectContainer to place it on 
		 * the stage and should be applied to an Emitter using the Emitter's
		 * renderer property.
		 * 
		 * @see org.flintparticles.twoD.emitters.Emitter#renderer
		 */
		public function Flint3DRendererBase()
		{
			super();
			_position = new Vector3D( 0, 0, 0, 1 );
			_rotation = new Vector3D( 0, 0, 1, 0 );
		}
		
		/**
		 * The position of the camera.
		 */
		public function get position():Vector3D
		{
			return _position;
		}
		public function set position( value:Vector3D ):void
		{
			_position = value.clone();
			_position.w = 1;
			_dirty = true;
		}
		
		/**
		 * The rotation of the camera.
		 */
		public function setAxisRotation( axis:Vector3D, angle:Number = NaN ):void
		{
			_rotation = axis.clone();
			if( !isNaN( angle ) )
			{
				_rotation.w = angle;
			}
			_dirty = true;
		}
		
		public function get spaceTransform():Matrix3D
		{
			if( _dirty )
			{
				calculateTransform();
			}
			return _spaceTransform;
		}
		
		protected function calculateTransform():void
		{
			_spaceTransform = Matrix3D.newRotateAboutAxis( _rotation );
			_spaceTransform.append( Matrix3D.newTranslate( _position.negative ) );
			_flashTransform = new Matrix( 1, 0, 0, -1, 0, 0 );
			_dirty = false;
		}
		
		/**
		 * The rotation of the camera.
		 */
		public function get distanceToProjection():Number
		{
			return _projectionDistance;
		}
		public function set distanceToProjection( value:Number ):void
		{
			_projectionDistance = value;
		}
		
		/**
		 * The rotation of the camera.
		 */
		public function get zoom():Number
		{
			return _zoom;
		}
		public function set zoom( value:Number ):void
		{
			_zoom = value;
		}
	}
}