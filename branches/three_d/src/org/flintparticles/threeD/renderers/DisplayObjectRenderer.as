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
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.threeD.geom.Matrix3D;
	import org.flintparticles.threeD.geom.Vector3D;
	import org.flintparticles.threeD.particles.Particle3D;	

	/**
	 * This 3D renderer is rubbish. It's just good enough to test the rest of the system, but 
	 * not useful for much else. There will be much better 3D renderers soon.
	 */
	public class DisplayObjectRenderer extends Flint3DRendererBase
	{
		/**
		 * The constructor creates a DisplayObjectRenderer. After creation it should
		 * be added to the display list of a DisplayObjectContainer to place it on 
		 * the stage and should be applied to an Emitter using the Emitter's
		 * renderer property.
		 * 
		 * @see org.flintparticles.twoD.emitters.Emitter#renderer
		 */
		public function DisplayObjectRenderer()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function renderParticles( particles:Array ):void
		{
			if( _dirty )
			{
				calculateTransform();
			}
			
			var particle:Particle3D;
			var img:DisplayObject;
			var len:int = particles.length;
			for( var i:int = 0; i < len; ++i )
			{
				particle = particles[i];
				img = particle.image;
				img.transform.colorTransform = particle.colorTransform;
				var pos:Vector3D = _spaceTransform.transformVector( particle.position );
				var scale:Number = _zoom * _projectionDistance / pos.z;
				img.transform.matrix = new Matrix( particle.scale * scale, 0, 0, particle.scale * scale, pos.x * scale, -pos.y * scale );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function addParticle( particle:Particle ):void
		{
			addChildAt( particle.image, 0 );
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function removeParticle( particle:Particle ):void
		{
			removeChild( particle.image );
		}
	}
}