/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord
 * Copyright (c) Big Room Ventures Ltd. 2008
 * http://flintparticles.org/
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

package
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import org.flintparticles.common.counters.*;
	import org.flintparticles.common.displayObjects.Dot;
	import org.flintparticles.common.initializers.*;
	import org.flintparticles.threeD.actions.*;
	import org.flintparticles.threeD.emitters.Emitter3D;
	import org.flintparticles.threeD.geom.Vector3D;
	import org.flintparticles.threeD.initializers.*;
	import org.flintparticles.threeD.renderers.*;
	import org.flintparticles.threeD.zones.*;	

	[SWF(width='500', height='500', frameRate='61', backgroundColor='#000000')]
	
	/**
	 * This example creates a set of colliding balls.
	 * 
	 * <p>This is the document class for the Flex project.</p>
	 */

	public class Collisions extends Sprite
	{
		private var emitter:Emitter3D;
		
		public function Collisions()
		{
			emitter = new Emitter3D();

			emitter.counter = new Blast( 150 );
			
			emitter.addInitializer( new SharedImage( new Dot( 10 ) ) );
			emitter.addInitializer( new ColorInit( 0xFFFF33FF, 0xFF33FFFF ) );
			emitter.addInitializer( new Position( new PointZone( new Vector3D( 0, 0, 0 ) ) ) );
			emitter.addInitializer( new Velocity( new DiscZone( new Vector3D( 0, 0, 0 ), new Vector3D( 0, 1, 0 ), 100, 50 ) ) );
			
			emitter.addAction( new Move() );
			emitter.addAction( new Collide( 10, 1 ) );
			emitter.addAction( new BoundingBox( -250, 250, -250, 250, -250, 250 ) );
			
			var renderer:BitmapRenderer = new BitmapRenderer( new Rectangle( -300, -300, 600, 600 ) );
			renderer.camera.position = new Vector3D( 0, 200, -500 );
			renderer.camera.target = new Vector3D( 0, 0, 0 );
			renderer.addEmitter( emitter );
			renderer.x = 250;
			renderer.y = 250;
			addChild( renderer );

			emitter.start();
		}
	}
}