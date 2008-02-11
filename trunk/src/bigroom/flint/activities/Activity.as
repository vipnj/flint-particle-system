/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord
 * Copyright (c) Big Room Ventures Ltd. 2008
 * Version: 1.0.0
 * Available at http://flashgamecode.net/
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

package bigroom.flint.activities
{
	import bigroom.flint.emitters.Emitter;
	
	/**
	 * The Activity interface must be implemented by all emitter Activities.
	 * 
	 * <p>An Activity is a class that is used to modify the 
	 * behaviour of the emitter over time. It may, for example, move or
	 * rotate the emitter.</p>
	 * 
	 * <p>Activities are added to the emitter by using its addActivity method.</p> 
	 */
	public interface Activity
	{
		
		/**
		 * The initialize method is called once when the emitter starts.
		 * 
		 * @param emitter The Emitter that is using the Activity.
		 */
		function initialize( emitter:Emitter ):void;
		
		/**
		 * The update method is called every frame by the emitter.
		 * 
		 * @param emitter The Emitter that is using the Activity.
		 * @param time The duration of the frame in seconds - used for time based updates.
		 */
		function update( emitter:Emitter, time:Number ):void;
	}
}