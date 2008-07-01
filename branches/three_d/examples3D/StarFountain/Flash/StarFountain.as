
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
	
	import org.flintparticles.common.actions.*;
	import org.flintparticles.common.counters.*;
	import org.flintparticles.common.displayObjects.Star;
	import org.flintparticles.common.initializers.*;
	import org.flintparticles.threeD.actions.*;
	import org.flintparticles.threeD.emitters.Emitter3D;
	import org.flintparticles.threeD.geom.Matrix3D;
	import org.flintparticles.threeD.geom.Vector3D;
	import org.flintparticles.threeD.initializers.*;
	import org.flintparticles.threeD.renderers.flint.*;
	import org.flintparticles.threeD.zones.*;	

	/**
	 * This example creates a fountain of stars.
	 * 
	 * <p>This is the document class for the Flex project.</p>
	 */

	public class StarFountain extends Sprite
	{
		private var emitter:Emitter3D;
		
		public function StarFountain()
		{
			emitter = new Emitter3D();

			emitter.counter = new Steady( 50 );
			
			emitter.addInitializer( new ImageClass( Star, 12 ) );
			emitter.addInitializer( new ColorInit( 0xFFFF33FF, 0xFF33FFFF ) );
			emitter.addInitializer( new Velocity( new DiscZone( new Vector3D( 0, 250, 0 ), new Vector3D( 0, 1, 0 ), 60, 0 ) ) );
			emitter.addInitializer( new Lifetime( 6 ) );
			
			emitter.addAction( new Move() );
			emitter.addAction( new Accelerate( new Vector3D( 0, -150, 0 ) ) );
			emitter.addAction( new Age() );
			
			var renderer:DisplayObjectRenderer = new DisplayObjectRenderer();
			renderer.cameraTransform = Matrix3D.newTranslate( new Vector3D( 0, 100, -300 ) );
			renderer.addEmitter( emitter );
			renderer.x = 250;
			renderer.y = 250;
			addChild( renderer );
			
			emitter.position = new Vector3D( 0, 0, 0, 1 );
			emitter.start( );
		}
	}
}