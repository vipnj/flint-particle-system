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
	import flash.geom.Point;
	
	import org.flintparticles.common.counters.*;
	import org.flintparticles.common.displayObjects.Line;
	import org.flintparticles.common.initializers.*;
	import org.flintparticles.twoD.actions.*;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.initializers.*;
	import org.flintparticles.twoD.zones.*;	

	public class Rain extends Emitter2D
	{
		public function Rain()
		{
			counter = new Steady( 300 );
			
			addInitializer( new ImageClass( Line, 8 ) );
			addInitializer( new Position( new LineZone( new Point( 5, 5 ), new Point( 505, 5 ) ) ) );
			addInitializer( new Velocity( new PointZone( new Point( -60, 300 ) ) ) );
			addInitializer( new AlphaInit( 0.25, 0.5 ) );
			
			addAction( new Move() );
			addAction( new DeathZone( new RectangleZone( -10, -10, 510, 410 ), true ) );
			addAction( new RotateToDirection() );
		}
	}
}