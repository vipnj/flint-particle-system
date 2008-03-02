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

package org.flintparticles.emitters
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import org.flintparticles.actions.Action;
	import org.flintparticles.activities.Activity;
	import org.flintparticles.counters.Counter;
	import org.flintparticles.events.FlintEvent;
	import org.flintparticles.initializers.Initializer;
	import org.flintparticles.particles.Particle;
	import org.flintparticles.particles.ParticleCreator;
	import org.flintparticles.utils.Maths;	

	/**
	 * Dispatched when a particle dies and is about to be removed from the system.
	 * As soon as the event has been handled the particle will be removed but at the
	 * time of the event it still exists so its properties (e.g. its location) can be
	 * read from it.
	 * 
	 * @eventType org.flintparticles.events.FlintEvent.PARTICLE_DEAD
	 */
	[Event(name="particleDead", type="org.flintparticles.events.FlintEvent")]

	/**
	 * Dispatched when an emitter contains no particles. Used, for example, to remove an
	 * emitter when it contains no particles.
	 * 
	 * @eventType org.flintparticles.events.FlintEvent.EMITTER_EMPTY
	 */
	[Event(name="emitterEmpty", type="org.flintparticles.events.FlintEvent")]
	import flash.geom.Point;	
	
	/**
	 * The base class for all particle emitters. The Emitter class extends the Sprite
	 * class so it is itself a DisplayObject. Thus, an Emitter is displayed by simply
	 * adding it as a child to a DisplayObjectContainer.
	 * 
	 * <p>At its core, the Emitter
	 * class manages the creation and ongoing state of particles. It uses a number of
	 * utility classes to customise its behaviour.</p>
	 * 
	 * <p>An emitter uses Initializers to customise the initial state of particles
	 * that it creates. These are added to the emitter using the addInitializer 
	 * method.</p>
	 * 
	 * <p>An emitter uses Actions to customise the behaviour of particles that
	 * it creates. These are added to the emitter using the addAction method.</p>
	 * 
	 * <p>An emitter uses Activities to customise its own behaviour, such as its
	 * position and rotation.</p>
	 * 
	 * <p>An emitter uses a Counter to know when and how many particles to emit.</p>
	 * 
	 * <p>All timings in the emitter are based on actual time passed, not on frames.</p>
	 * 
	 * <p>The emitter base class does not display the particles it creates. This is
	 * usually handled in one of the derived classes like BitmapEmitter and
	 * DisplayObjectEmitter.</p>
	 * 
	 * <p>Most other functionality is est added to an emitter using Actions,
	 * Initializers, Activities and Counters. This offers greater flexibility to 
	 * combine behaviours witout needing to further subclass the Emitter itself.</p>
	 */

	public class Emitter extends Sprite
	{
		// manages the creation, reuse and destruction of particles
		private static var _creator:ParticleCreator = new ParticleCreator();
		
		protected var _initializers:Array;
		protected var _actions:Array;
		protected var _particles:Array;
		protected var _activities:Array;
		protected var _counter:Counter;

		protected var _initializersPriority:Array;
		protected var _actionsPriority:Array;
		protected var _particlesPriority:Array;
		protected var _activitiesPriority:Array;

		private var _time:uint;
		protected var _x:Number = 0;
		protected var _y:Number = 0;
		protected var _rotation:Number = 0;
		
		/**
		 * Identifies whether the particles should be arranged
		 * into spacially sorted arrays - this speeds up proximity
		 * testing for those actions that need it
		 */
		public var spaceSort:Boolean = false;
		/**
		 * The array of particle indices sorted based on the paricles horizontal position.
		 * To persuade the emitter to create this array you should set the spaceSort property
		 * to true. Usually, actions that need this set to true will do so in their addedToEmitter
		 * method.
		 */
		public var spaceSortedX:Array;

		/**
		 * The constructor creates an emitter. However, it is more common to 
		 * create one of the subclasses that implements a specific display method.
		 */
		public function Emitter()
		{
			_particles = new Array();
			_actions = new Array();
			_initializers = new Array();
			_activities = new Array();
			_particlesPriority = new Array();
			_actionsPriority = new Array();
			_initializersPriority = new Array();
			_activitiesPriority = new Array();
			
			addEventListener( Event.REMOVED_FROM_STAGE, removed, false, 0, true );
		}
		
		/**
		 * Indicates the x coordinate of the Emitter instance relative to 
		 * the local coordinates of the parent DisplayObjectContainer.
		 */
		override public function get x():Number
		{
			return _x;
		}
		override public function set x( value:Number ):void
		{
			_x = value;
		}
		/**
		 * Indicates the y coordinate of the Emitter instance relative to 
		 * the local coordinates of the parent DisplayObjectContainer.
		 */
		override public function get y():Number
		{
			return _y;
		}
		override public function set y( value:Number ):void
		{
			_y = value;
		}
		/**
		 * Indicates the rotation of the Emitter, 
		 * in degrees, from its original orientation.
		 */
		override public function get rotation():Number
		{
			return Maths.asDegrees( _rotation );
		}
		override public function set rotation( value:Number ):void
		{
			_rotation = Maths.asRadians( value );
		}
		/**
		 * Indicates the rotation of the Emitter, 
		 * in radians, from its original orientation.
		 */
		public function get rotRadians():Number
		{
			return _rotation;
		}
		public function set rotRadians( value:Number ):void
		{
			_rotation = value;
		}
		
		/**
		 * Adds an Initializer object to the Emitter. Initializers set the
		 * initial properties of particles created by the emitter.
		 * 
		 * @param initializer The Initializer to add
		 * @param priority Indicates the sequencing of the initializers. Higher numbers cause
		 * an initializer to be run before other initialzers. All initializers have a default priority
		 * which is used if no value is passed in this parameter. The default priority is usually
		 * the one you want so this parameter is only used when you need to override the default.
		 */
		public function addInitializer( initializer:Initializer, priority:Number = NaN ):void
		{
			if( isNaN( priority ) )
			{
				priority = initializer.getDefaultPriority();
			}
			for( var i:uint = 0; i < _initializersPriority.length; ++i )
			{
				if( _initializersPriority[ i ] < priority )
				{
					break;
				}
			}
			_initializers.splice( i, 0, initializer );
			_initializersPriority.splice( i, 0, priority );
			initializer.addedToEmitter( this );
		}
		
		/**
		 * Removes an Initializer object from the Emitter.
		 * 
		 * @param initializer The Initializer to remove
		 * 
		 * @see addInitializer()
		 */
		public function removeInitializer( initializer:Initializer ):void
		{
			for( var i:uint = 0; i < _initializers.length; ++i )
			{
				if( _initializers[i] == initializer )
				{
					_initializers.splice( i, 1 );
					_initializersPriority.splice( i, 1 );
					return;
				}
			}
		}
		
		/**
		 * Adds an Action object to the Emitter. Actions set the behaviour
		 * of particles created by the emitter.
		 * 
		 * @param action The Action to add
		 * @param priority Indicates the sequencing of the actions. Higher numbers cause
		 * an action to be run before other actions. All actions have a default priority
		 * which is used if no value is passed in this parameter. The default priority is usually
		 * the one you want so this parameter is only used when you need to override the default.
		 */
		public function addAction( action:Action, priority:Number = NaN ):void
		{
			if( isNaN( priority ) )
			{
				priority = action.getDefaultPriority();
			}
			for( var i:uint = 0; i < _actionsPriority.length; ++i )
			{
				if( _actionsPriority[ i ] < priority )
				{
					break;
				}
			}
			_actions.splice( i, 0, action );
			_actionsPriority.splice( i, 0, priority );
			action.addedToEmitter( this );
		}
		
		/**
		 * Removes an Action object from the Emitter.
		 * 
		 * @param action The Action to remove
		 * 
		 * @see addAction()
		 */
		public function removeAction( action:Action ):void
		{
			for( var i:uint = 0; i < _actions.length; ++i )
			{
				if( _actions[i] == action )
				{
					_actions.splice( i, 1 );
					_actionsPriority.splice( i, 1 );
					return;
				}
			}
		}
		
		/**
		 * Adds an Activity to the Emitter. Activities set the behaviour
		 * of the Emitter.
		 * 
		 * @param activity The activity to add
		 * @param priority Indicates the sequencing of the activities. Higher numbers cause
		 * an activity to be run before other activities. All activities have a default priority
		 * which is used if no value is passed in this parameter. The default priority is usually
		 * the one you want so this parameter is only used when you need to override the default.
		 */
		public function addActivity( activity:Activity, priority:Number = NaN ):void
		{
			if( isNaN( priority ) )
			{
				priority = activity.getDefaultPriority();
			}
			for( var i:uint = 0; i < _activitiesPriority.length; ++i )
			{
				if( _activitiesPriority[ i ] < priority )
				{
					break;
				}
			}
			_activities.splice( i, 0, activity );
			_activitiesPriority.splice( i, 0, priority );
			activity.addedToEmitter( this );
		}
		
		/**
		 * Removes an Activity object from the Emitter.
		 * 
		 * @param activity The Activity to remove
		 * 
		 * @see addActivity()
		 */
		public function removeActivity( activity:Activity ):void
		{
			for( var i:uint = 0; i < _activities.length; ++i )
			{
				if( _activities[i] == activity )
				{
					_activities.splice( i, 1 );
					_activitiesPriority.splice( i, 1 );
					return;
				}
			}
		}
		
		/**
		 * Sets the Counter for the Emitter. The counter defines when and
		 * with what frequency the emitter emits particles.
		 * 
		 * @param counter THe counter to use
		 */		
		public function setCounter( counter:Counter ):void
		{
			_counter = counter;
		}
		
		/**
		 * Returns the array of all particles created by this emitter.
		 */
		public function get particles():Array
		{
			return _particles;
		}
		
		/**
		 * Used internally to create a particle.
		 */
		private function createParticle():Particle
		{
			var particle:Particle = _creator.createParticle();
			var len:uint = _initializers.length;
			for ( var i:uint = 0; i < len; ++i )
			{
				_initializers[i].initialize( this, particle );
			}
			particle.x += _x;
			particle.y += _y;
			_particles.unshift( particle );
			particleCreated( particle );
			return particle;
		}
		
		/**
		 * Starts the emitter. Until start is called, the emitter will not emit any particles.
		 */
		public function start():void
		{
			removeEventListener( Event.ENTER_FRAME, frameLoop );
			addEventListener( Event.ENTER_FRAME, frameLoop, false, 0, true );
			_time = getTimer();
			var len:uint = _activities.length;
			for ( var i:uint = 0; i < len; ++i )
			{
				_activities[i].initialize( this );
			}
			len = _counter.startEmitter( this );
			for ( i = 0; i < len; ++i )
			{
				createParticle();
			}
		}
		
		/**
		 * Used internally to update the emitter.
		 */
		private function frameLoop( ev:Event ):void
		{
			// update timer
			var oldTime:uint = _time;
			_time = getTimer();
			var frameTime:Number = ( _time - oldTime ) * 0.001;
			if( stage )
			{
				var maxTime:Number = 3 / stage.frameRate;
				if( frameTime > maxTime )
				{
					frameTime = maxTime;
				}
			}
			frameUpdate( frameTime );
		}
		
		/**
		 * Used internally and in derived classes to update the emitter.
		 * @param time The duration, in seconds, of the current frame.
		 */
		protected function frameUpdate( time:Number ):void
		{
			var i:uint;
			var particle:Particle;
			var len:uint = _counter.updateEmitter( this, time );
			for( i = 0; i < len; ++i )
			{
				createParticle();
			}
			if( spaceSort )
			{
				spaceSortedX = _particles.sortOn( "x", Array.NUMERIC | Array.RETURNINDEXEDARRAY );
				len = _particles.length;
				for( i = 0; i < len; ++i )
				{
					_particles[ spaceSortedX[i] ].spaceSortX = i;
				}
			}
			len = _activities.length;
			for ( i = 0; i < len; ++i )
			{
				_activities[i].update( this, time );
			}
			if ( _particles.length > 0 )
			{
				
				// update particle state
				len = _actions.length;
				var action:Action;
				var len2:uint = _particles.length;
				
				for( var j:uint = 0; j < len; ++j )
				{
					action = _actions[j];
					for ( i = 0; i < len2; ++i )
					{
						particle = _particles[i];
						action.update( this, particle, time );
					}
				}
				// remove dead particles
				for ( i = len2; i--; )
				{
					particle = _particles[i];
					if ( particle.isDead )
					{
						dispatchEvent( new FlintEvent( FlintEvent.PARTICLE_DEAD, particle ) );
						particleDestroyed( particle );
						_creator.disposeParticle( particle );
						_particles.splice( i, 1 );
					}
				}
			}
			else 
			{
				dispatchEvent( new FlintEvent( FlintEvent.EMITTER_EMPTY ) );
			}
			render( time );
		}
		
		/**
		 * Pauses the emitter.
		 */
		public function pause():void
		{
			removeEventListener( Event.ENTER_FRAME, frameLoop );
		}
		
		/**
		 * Resumes the emitter after a pause.
		 */
		public function resume():void
		{
			removeEventListener( Event.ENTER_FRAME, frameLoop );
			addEventListener( Event.ENTER_FRAME, frameLoop, false, 0, true );
			_time = getTimer();
		}
		
		private function removed( ev:Event ):void
		{
			if( ev.target == this )
			{
				dispose();
			}
		}
		
		/**
		 * Cleans up the emitter prior to removal. This metid is automatically
		 * called when the emitter is removed from the stage.
		 */
		private function dispose():void
		{
			removeEventListener( Event.ENTER_FRAME, frameLoop );
			var len:uint = _particles.length;
			for ( var i:uint = 0; i < len; ++i )
			{
				_creator.disposeParticle( _particles[i] );
			}
			_particles.length = 0;
			cleanUp();
		}
		
		/**
		 * Makes the emitter skip forwards a period of time with a single update.
		 * Used when you want the emitter to look like it's been running for a while.
		 * 
		 * @param time The time, in seconds, to skip ahead.
		 * @param frameRate The frame rate for calculating the new positions. The
		 * emitter will calculate each frame over the time period tp get the new state
		 * for the emitter and its particles. A higher frameRate will be more
		 * accurate but will take longer to calculate.
		 */
		public function runAhead( time:Number, frameRate:Number= 10 ):void
		{
			pause();
			var step:Number = 1 / frameRate;
			while ( time > 0 )
			{
				time -= step;
				frameUpdate( step );
			}
			resume();
		}
		
		/**
		 * Used in derived classes when they need to perform additional actions
		 * on a newly created particle.
		 */
		protected function particleCreated( particle:Particle ):void
		{
		}
		
		/**
		 * Used in derived classes when they need to perform additional actions
		 * on a particle that is about to be destroyed.
		 */
		protected function particleDestroyed( particle:Particle ):void
		{
		}		
		
		/**
		 * Used in derived classes to draw the particles.
		 */
		protected function render( time:Number ):void
		{
		}
		
		/**
		 * Used in derived classes when they need to do additional tasks when the emitter
		 * is disposed of.
		 */
		protected function cleanUp():void
		{
		}
		
		/**
		 * Converts the point object from the emitter's 
		 * (local) coordinates to the Stage (global) coordinates.
		 * 
		 * @param point The name or identifier of a point created 
		 * with the Point class, specifying the x and y coordinates as properties.
		 * @return A Point object with coordinates relative to the Stage.
		 */
		override public function localToGlobal( point:Point ):Point
		{
			var p:Point = super.localToGlobal( point );
			p.x += _x;
			p.y += _y;
			return p;
		}
		
		/**
		 * Converts the point object from the Stage (global)
		 * coordinates to the emitter's (local) coordinates.
		 * 
		 * @param point An object created with the Point class. 
		 * The Point object specifies the x and y coordinates as properties.
		 * @return A Point object with coordinates relative to the display object.
		 */
		override public function globalToLocal( point:Point ):Point
		{
			var p:Point = super.globalToLocal( point );
			p.x -= _x;
			p.y -= _y;
			return p;
		}
	}
}