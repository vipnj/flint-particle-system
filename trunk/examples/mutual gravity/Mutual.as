
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
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	
	import org.flintparticles.actions.*;
	import org.flintparticles.counters.Blast;
	import org.flintparticles.emitters.BitmapEmitter;
	import org.flintparticles.initializers.*;
	import org.flintparticles.zones.DiscZone;
	import org.flintparticles.displayObjects.Dot;

	public class Mutual extends BitmapEmitter
	{
		public function Mutual()
		{
			super( );

			addFilter( new BlurFilter( 2, 2, 1 ) );

			setCounter( new Blast( 40 ) );
			
			addInitializer( new SharedImage( new Dot( 2 ) ) );
			addInitializer( new ColorInit( 0xFFFF00FF, 0xFF00FFFF ) );
			addInitializer( new Position( new DiscZone( new Point( 0, 0 ), 200 ) ) );
			addInitializer( new Velocity( new DiscZone( new Point( 0, 0 ), 10 ) ) );

			addAction( new MutualGravity( 10, 500, 3 ) );
			addAction( new BoundingBox( 0, 0, 400, 400 ) );
			addAction( new SpeedLimit( 200 ) );
			addAction( new Move() );
		}
	}
}