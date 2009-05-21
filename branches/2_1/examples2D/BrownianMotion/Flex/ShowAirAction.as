/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord
 * Copyright (c) Richard Lord 2008-2009
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

package
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.core.IMXMLObject;
	
	import org.flintparticles.common.actions.ActionBase;
	import org.flintparticles.common.emitters.Emitter;
	import org.flintparticles.common.particles.Particle;	

	/**
	 * The KeyDownAction Action uses another action. It applies the other action
	 * to the particles only if a specified key is down.
	 * 
	 * @see org.flintparticles.common.actions.Action
	 */

	public class ShowAirAction extends ActionBase implements IMXMLObject
	{
		private var _isDown:Boolean;
		
		/**
		 * The constructor creates a KeyDownAction action for use by 
		 * an emitter. To add a KeyDownAction to all particles created by an emitter, use the
		 * emitter's addAction method.
		 * 
		 * @see org.flintparticles.emitters.Emitter#addAction()
		 * 
		 * @param action The action to apply when the key is down.
		 * @param keyCode The key code of the key that controls the action.
		 * @param stage A reference to the stage.
		 */
		public function ShowAirAction()
		{
			_isDown = false;
		}
		
		public function initialized( document:Object, id:String ):void
		{
			if( document.stage )
			{
				setStage( document.stage );
			}
			else
			{
				DisplayObject( document ).addEventListener( Event.ADDED_TO_STAGE, addedToStage );
			}
		}
			
		private function addedToStage( ev:Event ):void
		{
			setStage( ev.target.stage );
		}	
		
		private function setStage( stage:DisplayObject ):void
		{
			stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDownListener, false, 0, true );
			stage.addEventListener( KeyboardEvent.KEY_UP, keyUpListener, false, 0, true );
		}
		
		private function keyDownListener( ev:KeyboardEvent ):void
		{
			if( ev.keyCode == Keyboard.SHIFT )
			{
				_isDown = true;
			}
		}
		private function keyUpListener( ev:KeyboardEvent ):void
		{
			if( ev.keyCode == Keyboard.SHIFT )
			{
				_isDown = false;
			}
		}

		/**
		 * If the key is down, this method calls the update method of the 
		 * action that is applied.
		 * 
		 * <p>This method is called by the emitter and need not be called by the 
		 * user</p>
		 * 
		 * @param emitter The Emitter that created the particle.
		 * @param particle The particle to be updated.
		 * @param time The duration of the frame - used for time based updates.
		 * 
		 * @see org.flintparticles.common.actions.Action#update()
		 */
		override public function update( emitter:Emitter, particle:Particle, time:Number ):void
		{
			if( particle.mass == 1 )
			{
				if( _isDown )
				{
					particle.color = 0;
				}
				else
				{
					particle.color = 0xFF666666;
				}
			}
		}
	}
}