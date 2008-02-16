/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord
 * Copyright (c) Big Room Ventures Ltd. 2008
 * Version: 1.0.0
 * Available at http://flashgamecode.net/
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

package bigroom.flint.examples
{
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	
	import bigroom.flint.actions.GravityWell;
	import bigroom.flint.actions.MoveEuler;
	import bigroom.flint.counters.Blast;
	import bigroom.flint.emitters.PixelEmitter;
	import bigroom.flint.initializers.ColorInit;
	import bigroom.flint.initializers.Position;
	import bigroom.flint.initializers.Velocity;
	import bigroom.flint.zones.DiscZone;
	import bigroom.flint.zones.PointZone;	

	public class Thousands extends PixelEmitter
	{
		public function Thousands()
		{
			addFilter( new BlurFilter( 2, 2, 1 ) );
			addFilter( new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.99,0 ] ) );

			setCounter( new Blast( 2000 ) );
			
			addInitializer( new ColorInit( 0xFFFF00FF, 0xFF00FFFF ) );
			addInitializer( new Position( new DiscZone( new Point( 0, 0 ), 200 ) ) );
			addInitializer( new Velocity( new PointZone( new Point( 0, 0 ) ) ) );

			addAction( new MoveEuler() );
			addAction( new GravityWell( 25, 200, 200 ) );
			addAction( new GravityWell( 25, 75, 75 ) );
			addAction( new GravityWell( 25, 325, 325 ) );
			addAction( new GravityWell( 25, 75, 325 ) );
			addAction( new GravityWell( 25, 325, 75 ) );
		}
	}
}