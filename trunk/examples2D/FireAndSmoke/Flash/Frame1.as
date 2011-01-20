
/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord
 * Copyright (c) Richard Lord 2008-2011
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

var smoke:Emitter2D = new Emitter2D();
smoke.counter = new Steady( 10 );

smoke.addInitializer( new Lifetime( 11, 12 ) );
smoke.addInitializer( new Velocity( new DiscSectorZone( new Point( 0, 0 ), 40, 30, -4 * Math.PI / 7, -3 * Math.PI / 7 ) ) );
smoke.addInitializer( new SharedImage( new RadialDot( 6 ) ) );
  
smoke.addAction( new Age( ) );
smoke.addAction( new Move( ) );
smoke.addAction( new LinearDrag( 0.01 ) );
smoke.addAction( new ScaleImage( 1, 15 ) );
smoke.addAction( new Fade( 0.15, 0 ) );
smoke.addAction( new RandomDrift( 15, 15 ) );

smoke.x = 150;
smoke.y = 380;
smoke.start( );

var fire:Emitter2D = new Emitter2D();
fire.counter = new Steady( 60 );

fire.addInitializer( new Lifetime( 2, 3 ) );
fire.addInitializer( new Velocity( new DiscSectorZone( new Point( 0, 0 ), 20, 10, -Math.PI, 0 ) ) );
fire.addInitializer( new Position( new DiscZone( new Point( 0, 0 ), 3 ) ) );
fire.addInitializer( new SharedImage( new FireBlob() ) );

fire.addAction( new Age( ) );
fire.addAction( new Move( ) );
fire.addAction( new LinearDrag( 1 ) );
fire.addAction( new Accelerate( 0, -40 ) );
fire.addAction( new ColorChange( 0xFFFFCC00, 0x00CC0000 ) );
fire.addAction( new ScaleImage( 1, 1.5 ) );
fire.addAction( new RotateToDirection() );

fire.x = 150;
fire.y = 380;
fire.start( );

var renderer:BitmapRenderer = new BitmapRenderer( new Rectangle( 0, 0, 300, 400 ) );
renderer.addEmitter( fire );
renderer.addEmitter( smoke );
addChild( renderer );