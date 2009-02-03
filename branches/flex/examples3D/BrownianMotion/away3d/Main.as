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
	import flash.events.Event;
	
	import org.flintparticles.threeD.away3d.Away3DRenderer;
	import org.flintparticles.threeD.emitters.Emitter3D;
	
	import away3d.containers.View3D;	

	[SWF(width='400', height='400', frameRate='61', backgroundColor='#000000')]
	
	public class Main extends Sprite
	{
		private var emitter:Emitter3D;
		private var view:View3D;
		private var renderer:Away3DRenderer;
		
		public function Main()
		{
			emitter = new BrownianMotion( stage );

			view = new View3D({x:200,y:200});
			addChild(view);
			renderer = new Away3DRenderer( view.scene );
			renderer.addEmitter( emitter );

			emitter.start();
			
			addEventListener( Event.ENTER_FRAME, render, false, 0, true );
		}
		
		private function render( ev:Event ):void
		{
			// render the view
			view.render();
		}
	}
}