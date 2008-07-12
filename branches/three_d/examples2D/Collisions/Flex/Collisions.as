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
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.flintparticles.twoD.actions.*;
	import org.flintparticles.common.counters.*;
	import org.flintparticles.common.displayObjects.Dot;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.common.initializers.*;
	import org.flintparticles.twoD.initializers.*;
	import org.flintparticles.twoD.renderers.*;
	import org.flintparticles.twoD.zones.*;	

	[SWF(width='500', height='500', frameRate='61', backgroundColor='#000000')]
	
	/**
	 * This example creates a fountain of stars.
	 * 
	 * <p>This is the document class for the Flex project.</p>
	 */

	public class Collisions extends Sprite
	{
		private var emitter:Emitter2D;
		
		public function Collisions()
		{
			emitter = new Emitter2D();

			emitter.counter = new Blast( 150 );
			
			emitter.addInitializer( new SharedImage( new Dot( 10 ) ) );
			emitter.addInitializer( new ColorInit( 0xFFFF33FF, 0xFF33FFFF ) );
			emitter.addInitializer( new Position( new PointZone( new Point( 250, 250 ) ) ) );
			emitter.addInitializer( new Velocity( new DiscZone( new Point( 0, 0 ), 50, 100 ) ) );
			emitter.addInitializer( new ScaleInit( 0.2, 1 ) );
			
			emitter.addAction( new Move() );
			emitter.addAction( new Collide( 10, 1 ) );
			emitter.addAction( new BoundingBox( 0, 0, 500, 500 ) );
			
			var renderer:BitmapRenderer = new BitmapRenderer( new Rectangle( 0, 0, 500, 500 ) );
			renderer.addEmitter( emitter );
			addChild( renderer );

			emitter.start();
		}
	}
}