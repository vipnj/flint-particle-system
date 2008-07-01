﻿/*
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
	import flash.display.DisplayObject;
	
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.threeD.geom.Vector3D;
	import org.flintparticles.threeD.particles.Particle3D;	

	/**
	 * The DisplayObjectRenderer is a native Flint 3D renderer that draws particles
	 * as display objects in the renderer. The particles are drawn face-on to the
	 * camera, with perspective applied to position and scale the particles.
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
	 * 
	 * <p>Because the DisplayObject3DRenderer directly uses the particle's image,
	 * it is not suitable in situations where the same particle will be displayed 
	 * by two different renderers.</p> 
	 */
	public class DisplayObjectRenderer extends Flint3DRendererBase
	{
		/**
		 * The constructor creates a DisplayObject3DRenderer. After creation the
		 * renderer should be added to the display list of a DisplayObjectContainer 
		 * to place it on the stage.
		 * 
		 * <p>Emitter's should be added to the renderer using the renderer's
		 * addEmitter method. The renderer displays all the particles created
		 * by the emitter's that have been added to it.</p>
		 * 
		 * @param zSort Whether to sort the particles according to their
		 * z order when rendering them or not.
		 */
		public function DisplayObjectRenderer( zSort:Boolean = true)
		{
			super( zSort );
		}
		
		/**
		 * This method positions and scales the particles according to the
		 * particles' positions relative to the camera viewport.
		 * 
		 * <p>This method is called internally by Flint and shouldn't need to be called
		 * by the user.</p>
		 * 
		 * @param particles The particles to be rendered.
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
				var pos:Vector3D = _projectionTransform.transformVector( particle.position );
				particle.dictionary[this] = pos.z;
				if( pos.z < _nearDistance || pos.z > _farDistance )
				{
					img.visible = false;
				}
				else
				{
					var scale:Number = particle.scale * _projectionDistance / pos.z;
					pos.project();
					img.scaleX = scale;
					img.scaleY = scale;
					img.x = pos.x;
					img.y = -pos.y;
					img.transform.colorTransform = particle.colorTransform;
					img.visible = true;
				}
			}
			if( _zSort )
			{
				particles.sort( sortOnZ );
				for( i = 0; i < len; ++i )
				{
					swapChildrenAt( i, getChildIndex( particles[i].image ) );
				}
			}
		}
		
		/**
		 * @private
		 */
		protected function sortOnZ( p1:Particle3D, p2:Particle3D ):int
		{
			/*
			 * TODO: does this work?
			 * return Number( p2.dictionary[this] ) - Number( p1.dictionary[this] )
			 */
			var order:Number = Number( p2.dictionary[this] ) - Number( p1.dictionary[this] );
			if( order < 0 )
			{
				return -1;
			}
			if( order > 0 )
			{
				return 1;
			}
			return 0;
		}

		/**
		 * This method is called when a particle is added to an emitter -
		 * usually becaus ethe emitter has just created the particle. The
		 * method adds the particle's image to the renderer's display list.
		 * It is called internally by Flint and need not be called by the user.
		 * 
		 * @param particle The particle being added to the emitter.
		 */
		override protected function addParticle( particle:Particle ):void
		{
			addChildAt( particle.image, 0 );
		}
		
		/**
		 * This method is called when a particle is removed from an emitter -
		 * usually because the particle is dying. The method removes the 
		 * particle's image from the renderer's display list. It is called 
		 * internally by Flint and need not be called by the user.
		 * 
		 * @param particle The particle being removed from the emitter.
		 */
		override protected function removeParticle( particle:Particle ):void
		{
			removeChild( particle.image );
		}
	}
}