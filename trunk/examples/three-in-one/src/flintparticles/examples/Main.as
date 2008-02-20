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

package org.flintparticles.examples
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import org.flintparticles.examples.Smoke;
	import org.flintparticles.examples.Sparkler;
	import org.flintparticles.examples.Thousands;
	import org.flintparticles.emitters.Emitter;	

	public class Main extends Sprite
    {
    	private var emitters:Array;
    	
	   	public var thousandsBtn:SimpleButton;
		public var fireBtn:SimpleButton;
		public var sparklerBtn:SimpleButton;
		public var logoBtn:SimpleButton;
  	
		public function Main()
		{
			emitters = new Array();
			
			thousandsBtn.addEventListener( MouseEvent.CLICK, thousands, false, 0, true );
			fireBtn.addEventListener( MouseEvent.CLICK, smokeAndFire, false, 0, true );
			sparklerBtn.addEventListener( MouseEvent.CLICK, sparkler, false, 0, true );
			logoBtn.addEventListener( MouseEvent.CLICK, goWebsite, false, 0, true );
			
			thousands( null );
		}
		
		private function goWebsite( ev:MouseEvent ):void
		{
			navigateToURL( new URLRequest( "http://flashgamecode.net/flint" ) );
		}
		
		private function cleanUp():void
		{
			for( var i:uint = 0; i < emitters.length; ++i )
			{
				removeChild( emitters[i] );
			}
			emitters.length = 0;
		}
		
		private function thousands( ev:MouseEvent ):void
		{
			cleanUp();
			var emitter:Emitter = new Thousands();
			addChildAt( emitter, 0 );
			emitter.x = 200;
			emitter.y = 200;
			emitter.start();
			emitters.push( emitter );
		}

		private function smokeAndFire( ev:MouseEvent ):void
		{
			cleanUp();
			var emitter:Emitter = new Smoke();
			addChildAt( emitter, 0 );
			emitter.x = 200;
			emitter.y = 380;
			emitter.start();
			emitters.push( emitter );

			emitter = new Fire();
			addChildAt( emitter, 1 );
			emitter.x = 200;
			emitter.y = 380;
			emitter.start();
			emitters.push( emitter );
		}
		
		private function sparkler( ev:MouseEvent ):void
		{
			cleanUp();
			var emitter:Emitter = new Sparkler();
			addChildAt( emitter, 0 );
			emitter.start();
			emitters.push( emitter );
		}

    }
}