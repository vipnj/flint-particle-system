
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
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.flintparticles.actions.*;
	import org.flintparticles.displayObjects.Rect;
	import org.flintparticles.emitters.Emitter;
	import org.flintparticles.renderers.*;	

	[SWF(width='500', height='500', frameRate='61', backgroundColor='#000000')]
	
	/**
	 * This example creates a grid of squares that explode when you click on them.
	 * 
	 * <p>This is the document class for the Flex project.</p>
	 */

	public class SquareExplosion extends Sprite
	{
		public var emitter:Emitter;
		
		public function SquareExplosion()
		{
			var maxd:Number = Math.sqrt( 25 * 25 * 2 );
			var boxes:Array = new Array();
			for( var row:uint = 0; row < 50; ++row )
			{
				for( var column:uint = 0; column < 50; ++column )
				{
					var v:int = row - 25;
					var h:int = column - 25;
					var d:Number = Math.sqrt( v * v + h * h );
					var e:uint = Math.floor( 255 * ( maxd - d ) / maxd );
					var color:uint = ( e << 16 ) | ( e << 8 ) | e;
					var box:Rect = new Rect( 10, 10, color );
					addChild( box );
					box.x = 5 + column * 10;
					box.y = 5 + row * 10;
					boxes.push( box );
				}
			}
			emitter = new Emitter();
			emitter.addAction( new Move() );
			emitter.addAction( new LinearDrag( 1 ) );
			
			var renderer:DisplayObjectRenderer = new DisplayObjectRenderer();
			emitter.renderer = renderer;
			addChild( renderer );
			
			emitter.addDisplayObjects( boxes );
			emitter.start( );
			
			stage.addEventListener( MouseEvent.CLICK, click );
		}
		
		public function click( ev:MouseEvent ):void
		{
			var p:Point = DisplayObjectRenderer( emitter.renderer ).globalToLocal( new Point( ev.stageX, ev.stageY ) );
			emitter.addAction( new Explosion( 500000, p.x, p.y, 500 ) );
		}
	}
}