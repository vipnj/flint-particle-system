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
	
	import bigroom.flint.actions.Age;
	import bigroom.flint.actions.MoveEuler;
	import bigroom.flint.actions.RotateToDirection;
	import bigroom.flint.activities.FollowMouse;
	import bigroom.flint.counters.Steady;
	import bigroom.flint.displayObjects.LineShape;
	import bigroom.flint.emitters.BitmapEmitter;
	import bigroom.flint.initializers.ColorInit;
	import bigroom.flint.initializers.Lifetime;
	import bigroom.flint.initializers.SharedImage;
	import bigroom.flint.initializers.Velocity;
	import bigroom.flint.zones.DiscZone;	

	public class Sparkler extends BitmapEmitter
	{
		public function Sparkler()
		{
			addActivity( new FollowMouse() );
			
			addFilter( new BlurFilter( 2, 2, 1 ) );
			addFilter( new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.95,0 ] ) );

			setCounter( new Steady( 150 ) );
			
			addInitializer( new SharedImage( new LineShape( 6 ) ) );
			addInitializer( new ColorInit( 0xFFFFCC00, 0xFFFFCC00 ) );
			addInitializer( new Velocity( new DiscZone( new Point( 0, 0 ), 200, 350 ) ) );
			addInitializer( new Lifetime( 0.2, 0.4 ) );
			
			addAction( new Age() );
			addAction( new MoveEuler() );
			addAction( new RotateToDirection() );
		}
	}
}