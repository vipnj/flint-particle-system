
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
	import org.flintparticles.threeD.actions.*;
	import org.flintparticles.threeD.emitters.Emitter3D;
	import org.flintparticles.threeD.geom.Vector3D;
	import org.flintparticles.threeD.particles.Particle3DUtils;
	import org.flintparticles.threeD.renderers.*;
	import org.flintparticles.threeD.zones.FrustrumZone;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;	

	[SWF(width='500', height='350', frameRate='61', backgroundColor='#000000')]
	
	public class ExplodeImage extends Sprite
	{
		// width:384 height:255
		[Embed(source="assets/184098.jpg")]
		public var Image1:Class;

		private var emitter:Emitter3D;
		private var bitmap:Bitmap;
		private var renderer:DisplayObjectRenderer;
		
		public function ExplodeImage()
		{
			var txt:TextField = new TextField();
			txt.text = "Click on the image";
			txt.textColor = 0xFFFFFF;
			addChild( txt );

			bitmap = new Image1();
			
			renderer = new DisplayObjectRenderer();
			renderer.camera.dolly( -400 );
			renderer.camera.projectionDistance = 400;
			renderer.y = 175;
			renderer.x = 250;
			addChild( renderer );
			
			emitter = new Emitter3D();
			emitter.addAction( new Move() );
			emitter.addAction( new DeathZone( new FrustrumZone( renderer.camera, new Rectangle( -250, -175, 500, 350 ) ), true ) );
			emitter.position = new Vector3D( 0, 0, 0, 1 );

			var particles:Array = Particle3DUtils.createRectangleParticlesFromBitmapData( bitmap.bitmapData, 20, emitter.particleFactory, new Vector3D( -192, 127, 0 ) );
			emitter.addExistingParticles( particles, false );
									
			renderer.addEmitter( emitter );
			emitter.start();
			stage.addEventListener( MouseEvent.CLICK, explode, false, 0, true );
		}
		
		private function explode( ev:MouseEvent ):void
		{
			var p:Point = renderer.globalToLocal( new Point( ev.stageX, ev.stageY ) );
			emitter.addAction( new Explosion( 8, new Vector3D( p.x, -p.y, 50 ), 500 ) );
			stage.removeEventListener( MouseEvent.CLICK, explode );
		}
	}
}