﻿/*
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

import org.flintparticles.common.actions.*;
import org.flintparticles.common.counters.*;
import org.flintparticles.common.displayObjects.RadialDot;
import org.flintparticles.common.initializers.*;
import org.flintparticles.twoD.actions.*;
import org.flintparticles.twoD.emitters.Emitter2D;
import org.flintparticles.twoD.initializers.*;
import org.flintparticles.twoD.renderers.*;
import org.flintparticles.twoD.zones.*;	

var emitter:Emitter2D = new Emitter2D();

emitter.counter = new Steady( 250 );

emitter.addInitializer( new Lifetime( 1.5 ) );
emitter.addInitializer( new Velocity( new DiscSectorZone( new Point( 0, 0 ), 20, 10, -Math.PI, 0 ) ) );
var bitmapData:BitmapData = new Logo( 265, 80);
emitter.addInitializer( new Position( new BitmapDataZone( bitmapData ) ) );
emitter.addInitializer( new ImageClass( RadialDot, 7 ) );

emitter.addAction( new Age() );
emitter.addAction( new Move() );
emitter.addAction( new LinearDrag( 1 ) );
emitter.addAction( new Accelerate( 0, -40 ) );
emitter.addAction( new ColorChange( 0xFFFF9900, 0x00CC0000 ) );
emitter.addAction( new ScaleImage( 1, 1.5 ) );

var renderer:BitmapRenderer = new BitmapRenderer( new Rectangle( 0, 0, 500, 200 ) );
renderer.addEmitter( emitter );
addChild( renderer );

emitter.x = 118;
emitter.y = 70;
emitter.start( );

var bitmap:Bitmap = new Bitmap();
bitmap.bitmapData = bitmapData;
addChild( bitmap );
bitmap.x = 118;
bitmap.y = 70;