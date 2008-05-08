
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
	import flash.filters.BlurFilter;
	import flash.geom.Rectangle;
	
	import org.flintparticles.actions.*;
	import org.flintparticles.counters.*;
	import org.flintparticles.displayObjects.Dot;
	import org.flintparticles.emitters.Emitter;
	import org.flintparticles.initializers.*;
	import org.flintparticles.renderers.*;
	import org.flintparticles.zones.*;	

	[SWF(width='400', height='400', frameRate='61', backgroundColor='#000000')]
	
	/**
	 * This example creates an abstract effect using Mutual Gravity to attract the particles to each other.
	 * 
	 * <p>This is the document class for the Flex project.</p>
	 */

	public class MutualG extends Sprite
	{
		private var emitter:Emitter;
		
		public function MutualG()
		{
			emitter = new Emitter();

			emitter.counter = new Blast( 30 );
			
			emitter.addInitializer( new SharedImage( new Dot( 2 ) ) );
			emitter.addInitializer( new ColorInit( 0xFFFF00FF, 0xFF00FFFF ) );
			emitter.addInitializer( new Position( new RectangleZone( 10, 10, 380, 380 ) ) );

			emitter.addAction( new MutualGravity( 10, 500, 3 ) );
			emitter.addAction( new BoundingBox( 0, 0, 400, 400 ) );
			emitter.addAction( new SpeedLimit( 150 ) );
			emitter.addAction( new Move() );
			
			var renderer:BitmapRenderer = new BitmapRenderer( new Rectangle( 0, 0, 400, 400 ) );
			renderer.addFilter( new BlurFilter( 2, 2, 1 ) );
			emitter.renderer = renderer;
			addChild( renderer );

			emitter.start( );
		}
	}
}