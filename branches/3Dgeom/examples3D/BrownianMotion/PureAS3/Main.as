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
	import flash.text.TextField;
	
	import org.flintparticles.threeD.emitters.Emitter3D;
	import org.flintparticles.threeD.geom.Point3D;
	import org.flintparticles.threeD.renderers.*;
	import org.flintparticles.threeD.renderers.controllers.OrbitCamera;	

	[SWF(width='400', height='400', frameRate='61', backgroundColor='#000000')]
	
	public class Main extends Sprite
	{
		private var emitter:Emitter3D;
		private var orbitter:OrbitCamera;
		
		public function Main()
		{
			var txt:TextField = new TextField();
			txt.text = "Hold down the shift key to hide the air particles.";
			txt.autoSize = "left";
			txt.textColor = 0xFFFFFF;
			addChild( txt );

			emitter = new BrownianMotion( stage );

			var renderer:DisplayObjectRenderer = new DisplayObjectRenderer();
			renderer.x = 200;
			renderer.y = 200;
			renderer.addEmitter( emitter );
			addChild( renderer );
			
			renderer.camera.position = new Point3D( 0, 0, -400 );
			renderer.camera.target = new Point3D( 0, 0, 0 );
			renderer.camera.projectionDistance = 400;
			orbitter = new OrbitCamera( stage, renderer.camera );
			orbitter.start();

			emitter.start();
		}
	}
}