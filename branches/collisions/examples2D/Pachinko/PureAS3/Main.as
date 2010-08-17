/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord
 * Copyright (c) Richard Lord 2008-2010
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
	import org.flintparticles.twoD.renderers.BitmapRenderer;

	import flash.display.Sprite;
	import flash.geom.Rectangle;

	[SWF(width='500', height='500', frameRate='61', backgroundColor='#000000')]
	
	public class Main extends Sprite
	{
		private var emitter:Pachinko;
		
		public function Main()
		{
			emitter = new Pachinko();
			
			var renderer:BitmapRenderer = new BitmapRenderer( new Rectangle( 0, 0, 500, 500 ) );
			renderer.addEmitter( emitter );
			addChild( renderer );
			
			var pins:Array = [
				198, 152, 211, 139, 224, 126, 237, 113, 250, 100, 263, 113, 276, 126, 289, 139, 302, 152,
				100, 100, 100, 110, 100, 120, 100, 130, 100, 140, 100, 150,
				120, 100, 120, 110, 120, 120, 120, 130, 120, 140, 120, 150,
				380, 100, 380, 110, 380, 120, 380, 130, 380, 140, 380, 150,
				400, 100, 400, 110, 400, 120, 400, 130, 400, 140, 400, 150
			];
			
			for( var i:int = 0; i < pins.length; i += 2 )
			{
				addPin( pins[i], pins[i+1] );
			}
			
			emitter.start();
		}
		
		private function addPin( x:Number, y:Number ) : void
		{
			graphics.beginFill( 0x999999 );
			graphics.drawCircle( x, y, 1 );
			graphics.endFill();
			
			emitter.addPin( x, y );
		}
	}
}