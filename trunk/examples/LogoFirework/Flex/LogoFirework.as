
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
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	
	import org.flintparticles.actions.*;
	import org.flintparticles.counters.*;
	import org.flintparticles.emitters.*;
	import org.flintparticles.energyEasing.Quadratic;
	import org.flintparticles.events.FlintEvent;
	import org.flintparticles.initializers.*;
	import org.flintparticles.zones.*;	

	/**
	 * This example creates an image from flying particles. This is the code for the Flex project.
	 * 
	 * <p>This is the document class for a flash movie created in a flex or flash project.
	 * You can either publish it directly using the mxmlc compiler in the Flex SDK,
	 * or you can associate it as the document class of an empty Flash movie in Flash CS3.
	 * The movie size should be set at 500px wide, 300px high, with a background colour of black.</p>
	 */

	public class LogoFirework extends Sprite
	{
		[Embed(source="../assets/flint.png")]
		public var Logo:Class;

		public function LogoFirework()
		{
			var emitter:PixelEmitter = new PixelEmitter();

			emitter.addFilter( new BlurFilter( 2, 2, 1 ) );
			emitter.addFilter( new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.96,0 ] ) );

			emitter.setCounter( new Blast( 1500 ) );
			
			emitter.addInitializer( new ColorInit( 0xFFFF3300, 0xFFFFFF00 ) );
			emitter.addInitializer( new Lifetime( 6 ) );
			emitter.addInitializer( new Position( new DiscZone( new Point( 0, 0 ), 10 ) ) );
			var bitmap:Bitmap = new Logo();
			emitter.addInitializer( new Velocity( new BitmapDataZone( bitmap.bitmapData, -132, -300 ) ) );
			
			emitter.addAction( new Age( Quadratic.easeIn ) );
			emitter.addAction( new Fade( 1.0, 0 ) );
			emitter.addAction( new Move() );
			emitter.addAction( new LinearDrag( 0.5 ) );
			emitter.addAction( new Accelerate( 0, 70 ) );
			
			emitter.addEventListener( FlintEvent.EMITTER_EMPTY, restart );

			addChild( emitter );
			emitter.x = 250;
			emitter.y = 300;
			emitter.start( );
		}
		
		public function restart( ev:FlintEvent ):void
		{
			Emitter( ev.target ).start();
		}
	}
}