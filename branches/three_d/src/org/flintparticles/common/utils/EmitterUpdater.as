/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord (Big Room)
 * Copyright (c) Big Room Ventures Ltd. 2008
 * http://flintparticles.org
 * 
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

package org.flintparticles.common.utils 
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	
	import org.flintparticles.common.emitters.Emitter;	

	/**
	 * This class is used to provide a constant tick event to update the emitters
	 * every frame. This is the internal tick that is used when the useInternalTick
	 * property of the emitter is set to true.
	 * 
	 * <p>Usually developers don't need to use this class at all - its use is
	 * internal to the Emitter classes.</p>
	 * 
	 * @see org.flintparticles.common.emitters.Emitter.Emitter()
	 */
	public class EmitterUpdater extends EventDispatcher
	{
		private var _shape:Shape;
		private var _time:Number;
		private var _running:Boolean;
		private var _emitters:Array;
		
		/**
		 * The constructor creates an EmitterUpdater object.
		 */
		public function EmitterUpdater()
		{
			_shape = new Shape();
			_emitters = new Array();
		}

		/**
		 * Starts the EmitterUpdater
		 */
		public function start():void
		{
			if( !_running )
			{
				_shape.addEventListener( Event.ENTER_FRAME, frameUpdate );
				_time = getTimer();
				_running = true;
			}
		}
		
		/**
		 * Stops the EmitterUpdater
		 */
		public function stop():void
		{
			if( _running )
			{
				_shape.removeEventListener( Event.ENTER_FRAME, frameUpdate );
				_running = false;
			}
		}
		
		/**
		 * Adds an emitter to the EmitterUpdater. Once added, the emitter's
		 * update method will be called every frame.
		 * 
		 * @param emitter The emitter to add.
		 */
		public function addEmitter( emitter:Emitter ):void
		{
			var i:int = _emitters.indexOf( emitter );
			if( i == -1 )
			{
				_emitters.push( emitter );
			}
		}
		
		/**
		 * Removes an emitter from the EmitterUpdater. Once removed, the emitter's
		 * update method will no longer be called by the EmitterUpdater.
		 */
		public function removeEmitter( emitter:Emitter ):void
		{
			var i:int = _emitters.indexOf( emitter );
			if( i != -1 )
			{
				_emitters.splice( i, 1 );
			}
		}

		private function frameUpdate( ev:Event ):void
		{
			var oldTime:int = _time;
			_time = getTimer();
			var frameTime:Number = ( _time - oldTime ) * 0.001;
			for each( var emitter:Emitter in _emitters )
			{
				emitter.update( frameTime );
			}
		}
	}
}
