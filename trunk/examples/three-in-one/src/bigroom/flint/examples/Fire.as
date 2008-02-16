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
	
	import bigroom.flint.actions.Accelerate;
	import bigroom.flint.actions.Age;
	import bigroom.flint.actions.ColorChange;
	import bigroom.flint.actions.LinearDrag;
	import bigroom.flint.actions.MoveEuler;
	import bigroom.flint.actions.Scale;
	import bigroom.flint.counters.Steady;
	import bigroom.flint.displayObjects.RadialDot;
	import bigroom.flint.emitters.DisplayObjectEmitter;
	import bigroom.flint.initializers.ImageClass;
	import bigroom.flint.initializers.Lifetime;
	import bigroom.flint.initializers.Position;
	import bigroom.flint.initializers.Velocity;
	import bigroom.flint.zones.DiscZone;
	import bigroom.flint.zones.DiscSectorZone;	

	/**
	 * 
	 */

	public class Fire extends DisplayObjectEmitter
	{
		public function Fire()
		{
			super();
			
			setCounter( new Steady( 55, 65 ) );
			
			addInitializer( new Lifetime( 2, 3 ) );
			addInitializer( new Velocity( new DiscSectorZone( new Point( 0, 0 ), 20, 10, -Math.PI, 0 ) ) );
			addInitializer( new Position( new DiscZone( new Point( 0, 0 ), 3 ) ) );
			addInitializer( new ImageClass( RadialDot, 5 ) );
			
			addAction( new Age() );
			addAction( new MoveEuler() );
			addAction( new LinearDrag( 1 ) );
			addAction( new Accelerate( 0, -40 ) );
			addAction( new ColorChange( 0xFFFFCC00, 0x00CC0000 ) );
			addAction( new Scale( 1, 1.5 ) );
		}
	}
}
