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

package org.flintparticles.threeD.particles
{
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.threeD.geom.Quaternion;
	import org.flintparticles.threeD.geom.Vector3D;	

	/**
	 * The Particle3D class extends the Particle class to include state properties 
	 * that are relevant to particles in 3D space.
	 */
	public class Particle3D extends Particle
	{
		/**
		 * The position of the particle (in the renderer's units).
		 */
		public var position:Vector3D;
		/**
		 * The velocity of the particle (in the renderer's units per second).
		 */
		public var velocity:Vector3D;
		
		/**
		 * The rotation of the particle, represented as a unit quaternion.
		 */
		public var rotation:Quaternion;
		
		/**
		 * The rate of rotation of the particle, represented as a vector in the direction of 
		 * the axis of rotation and whose magnitude indicates the number of rotations per second.
		 */
		public var angVelocity:Vector3D;
	
		/**
		 * The position of the particle in the emitter's x-axis spacial sorted array
		 */
		public var sortID:int;
		
		/**
		 * Creates a Particle3D. Alternatively particles can be reused by using an
		 * instance of the Particle3DCreator class to create them. Usually the 
		 * emitter will create the particles and the user doesn't need to create 
		 * them.
		 */
		public function Particle3D()
		{
			super();
		}
		
		/**
		 * Sets the particles properties to their default values.
		 */
		override public function initialize():void
		{
			super.initialize();
			position = new Vector3D( 0, 0, 0, 1 );
			velocity = new Vector3D( 0, 0, 0, 0 );
			rotation = new Quaternion( 1, 0, 0, 0 );
			angVelocity = new Vector3D( 0, 0, 0, 0 );
			sortID = -1;
		}
	}
}
