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
	import flash.geom.Point;
	
	import bigroom.flint.actions.Age;
	import bigroom.flint.actions.Fade;
	import bigroom.flint.actions.LinearDrag;
	import bigroom.flint.actions.MoveEuler;
	import bigroom.flint.actions.RandomDrift;
	import bigroom.flint.actions.Scale;
	import bigroom.flint.counters.Steady;
	import bigroom.flint.displayObjects.RadialDot;
	import bigroom.flint.emitters.BitmapEmitter;
	import bigroom.flint.initializers.ColorInit;
	import bigroom.flint.initializers.Lifetime;
	import bigroom.flint.initializers.Position;
	import bigroom.flint.initializers.SharedImage;
	import bigroom.flint.initializers.Velocity;
	import bigroom.flint.zones.DiscSector;
	import bigroom.flint.zones.PointZone;	

	/**
	 * 
	 */

	public class Smoke extends BitmapEmitter
	{
		public function Smoke()
		{
			super();
			
			setCounter( new Steady( 9, 11 ) );
			
			addInitializer( new Lifetime( 11, 12 ) );
			addInitializer( new Velocity( new DiscSector( new Point( 0, 0 ), 40, 30, -4 * Math.PI / 7, -3 * Math.PI / 7 ) ) );
			addInitializer( new Position( new PointZone( new Point( 0, 0 ) ) ) );
			addInitializer( new ColorInit( 0xFFFFFFFF, 0xFFFFFFFF ) );
			addInitializer( new SharedImage( new RadialDot( 7 ) ) );
			
			addAction( new Age() );
			addAction( new MoveEuler() );
			addAction( new LinearDrag( 0.01 ) );
			addAction( new Scale( 1, 10 ) );
			addAction( new Fade( 0.2, 0 ) );
			addAction( new RandomDrift( 10, 10 ) );
		}
	}
}
