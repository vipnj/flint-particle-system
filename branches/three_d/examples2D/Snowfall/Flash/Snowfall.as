
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
	
	import org.flintparticles.common.counters.*;
	import org.flintparticles.common.displayObjects.Dot;
	import org.flintparticles.common.initializers.*;
	import org.flintparticles.twoD.actions.*;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.initializers.*;
	import org.flintparticles.twoD.renderers.*;
	import org.flintparticles.twoD.zones.*;

	/**
	 * This example creates snow.
	 * 
	 * <p>This is the document class for the Flash project.</p>
	 */

	public class Snowfall extends Sprite
	{
		private var emitter:Emitter2D;
		
		public function Snowfall()
		{
			emitter = new Emitter2D();

			emitter.counter = new Steady( 50 );
			
			emitter.addInitializer( new ImageClass( Dot, 2 ) );
			emitter.addInitializer( new Position( new LineZone( new Point( -5, -5 ), new Point( 505, -5 ) ) ) );
			emitter.addInitializer( new Velocity( new PointZone( new Point( 0, 50 ) ) ) );
			emitter.addInitializer( new ScaleInit( 0.75, 1.5 ) );
			
			emitter.addAction( new Move() );
			emitter.addAction( new DeathZone( new RectangleZone( -10, -10, 510, 410 ), true ) );
			emitter.addAction( new RandomDrift( 10, 10 ) );
			
			var renderer:DisplayObjectRenderer = new DisplayObjectRenderer();
			renderer.addEmitter( emitter );
			addChild( renderer );
			
			emitter.start();
			emitter.runAhead( 10 );
		}
	}
}