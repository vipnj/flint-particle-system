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
	import org.flintparticles.threeD.emitters.Emitter3D;
	import org.flintparticles.threeD.geom.Point3D;
	import org.flintparticles.threeD.renderers.BitmapRenderer;
	import org.flintparticles.threeD.renderers.controllers.OrbitCamera;

	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;

	[SWF(width='400', height='400', frameRate='61', backgroundColor='#000000')]
	
	public class Main extends Sprite
	{
		private var smoke:Emitter3D;
		private var fire:Emitter3D;
		private var orbitter:OrbitCamera;
		
		public function Main()
		{
			var txt:TextField = new TextField();
			txt.text = "Use arrow keys to track in/out and orbit around the fire.";
			txt.autoSize = "left";
			txt.textColor = 0xFFFFFF;
			addChild( txt );

			smoke = new Smoke();			
			smoke.start( );
			
			fire = new Fire();
			fire.start( );
			
			var renderer:BitmapRenderer = new BitmapRenderer( new Rectangle( -200, -200, 400, 400 ) );
			renderer.x = 200;
			renderer.y = 200;
			renderer.addEmitter( smoke );
			renderer.addEmitter( fire );
			addChild( renderer );
			
			renderer.camera.position = new Point3D( 0, 150, -400 );
			renderer.camera.target = new Point3D( 0, 150, 0 );
			renderer.camera.projectionDistance = 400;
			orbitter = new OrbitCamera( stage, renderer.camera );
			orbitter.start();
		}
	}
}