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

package org.flintparticles.common.emitters
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	
	import org.flintparticles.common.actions.Action;
	import org.flintparticles.common.activities.Activity;
	import org.flintparticles.common.counters.Counter;
	import org.flintparticles.common.counters.ZeroCounter;
	import org.flintparticles.common.events.EmitterEvent;
	import org.flintparticles.common.events.ParticleEvent;
	import org.flintparticles.common.initializers.Initializer;
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.common.particles.ParticleFactory;	

	/**
	 * Dispatched when a particle dies and is about to be removed from the system.
	 * As soon as the event has been handled the particle will be removed but at the
	 * time of the event it still exists so its properties (e.g. its location) can be
	 * read from it.
	 * 
	 * @eventType org.flintparticles.common.events.FlintEvent.PARTICLE_DEAD
	 */
	[Event(name="particleDead", type="org.flintparticles.common.events.ParticleEvent")]

	/**
	 * Dispatched when a particle is created and has just been added to the emitter.
	 * 
	 * @eventType org.flintparticles.common.events.FlintEvent.PARTICLE_CREATED
	 */
	[Event(name="particleCreated", type="org.flintparticles.common.events.ParticleEvent")]

	/**
	 * Dispatched when a pre-existing particle is added to the emitter.
	 * 
	 * @eventType org.flintparticles.common.events.FlintEvent.PARTICLE_ADDED
	 */
	[Event(name="particleAdded", type="org.flintparticles.common.events.ParticleEvent")]

	/**
	 * Dispatched when an emitter contains no particles.
	 * 
	 * @eventType org.flintparticles.common.events.FlintEvent.EMITTER_EMPTY
	 */
	[Event(name="emitterEmpty", type="org.flintparticles.common.events.EmitterEvent")]

	/**
	 * Dispatched when the particle system has updated and the state of the particles
	 * has changed.
	 * 
	 * @eventType org.flintparticles.common.events.FlintEvent.EMITTER_UPDATED
	 */
	[Event(name="emitterUpdated", type="org.flintparticles.common.events.EmitterEvent")]

	/**
	 * The Emitter class is the basse class for the Emitter2D and Emitter3D classes.
	 * The emitter class contains the common behavioour used by these two concrete
	 * classes.
	 * 
	 * <p>An Emitter manages the creation and ongoing state of particles. It uses 
	 * a number of utility classes to customise its behaviour.</p>
	 * 
	 * <p>An emitter uses Initializers to customise the initial state of particles
	 * that it creates; their position, velocity, color etc. These are added to the 
	 * emitter using the addInitializer method.</p>
	 * 
	 * <p>An emitter uses Actions to customise the behaviour of particles that
	 * it creates; to apply gravity, drag, fade etc. These are added to the emitter 
	 * using the addAction method.</p>
	 * 
	 * <p>An emitter uses Activities to customise its own behaviour in an ongoing
	 * manner, to move it or rotate it for example.</p>
	 * 
	 * <p>An emitter uses a Counter to know when and how many particles to emit.</p>
	 * 
	 * <p>All timings in the emitter are based on actual time passed, 
	 * independent of the frame rate of the flash movie.</p>
	 * 
	 * <p>Most functionality is best added to an emitter using Actions,
	 * Initializers, Activities and Counters. This offers greater 
	 * flexibility to combine behaviours without needing to subclass 
	 * the Emitter classes.</p>
	 */

	public class Emitter extends EventDispatcher
	{
		/**
		 * @private
		 */
		protected var _particleFactory:ParticleFactory;
		
		/**
		 * @private
		 */
		protected var _initializers:Array;
		/**
		 * @private
		 */
		protected var _actions:Array;
		/**
		 * @private
		 */
		protected var _particles:Array;
		/**
		 * @private
		 */
		protected var _activities:Array;
		/**
		 * @private
		 */
		protected var _counter:Counter;

		/**
		 * @private
		 */
		protected var _initializersPriority:Array;
		/**
		 * @private
		 */
		protected var _actionsPriority:Array;
		/**
		 * @private
		 */
		protected var _activitiesPriority:Array;

		private var _time:int;
		
		private var _ticker:Shape;

		/**
		 * The constructor creates an emitter.
		 */
		public function Emitter()
		{
			_particles = new Array();
			_actions = new Array();
			_initializers = new Array();
			_activities = new Array();
			_actionsPriority = new Array();
			_initializersPriority = new Array();
			_activitiesPriority = new Array();
			_counter = new ZeroCounter();
			_ticker = new Shape();
		}
		
		/**
		 * Adds an Initializer object to the Emitter. Initializers set the
		 * initial state of particles created by the emitter.
		 * 
		 * @param initializer The Initializer to add
		 * @param priority Indicates the sequencing of the initializers. Higher 
		 * numbers cause an initializer to be run before other initialzers. All 
		 * initializers have a default priority which is used if no value is passed in this 
		 * parameter. The default priority is usually the one you want so this 
		 * parameter is only used when you need to override the default.
		 * 
		 * @see removeInitializer()
		 * @see org.flintParticles.common.initializers.Initializer.getDefaultPriority()
		 */
		public function addInitializer( initializer:Initializer, priority:Number = NaN ):void
		{
			if( isNaN( priority ) )
			{
				priority = initializer.getDefaultPriority();
			}
			for( var i:int = 0; i < _initializersPriority.length; ++i )
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
		 * Removes an Initializer from the Emitter.
		 * 
		 * @param initializer The Initializer to remove
		 * 
		 * @see addInitializer()
		 */
		public function removeInitializer( initializer:Initializer ):void
		{
			for( var i:int = 0; i < _initializers.length; ++i )
			{
				if( _initializers[i] == initializer )
				{
					_initializers.splice( i, 1 );
					_initializersPriority.splice( i, 1 );
					initializer.removedFromEmitter( this );
					return;
				}
			}
		}
		
		/**
		 * Adds an Action to the Emitter. Actions set the behaviour of particles 
		 * created by the emitter.
		 * 
		 * @param action The Action to add
		 * @param priority Indicates the sequencing of the actions. Higher numbers 
		 * cause an action to be run before other actions. All actions have a default 
		 * priority which is used if no value is passed in this parameter. The 
		 * default priority is usually the one you want so this parameter is only 
		 * used when you need to override the default.
		 * 
		 * @see removeAction();
		 * @see org.flintParticles.common.actions.Action.getDefaultPriority()
		 */
		public function addAction( action:Action, priority:Number = NaN ):void
		{
			if( isNaN( priority ) )
			{
				priority = action.getDefaultPriority();
			}
			for( var i:int = 0; i < _actionsPriority.length; ++i )
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
		 * Removes an Action from the Emitter.
		 * 
		 * @param action The Action to remove
		 * 
		 * @see addAction()
		 */
		public function removeAction( action:Action ):void
		{
			for( var i:int = 0; i < _actions.length; ++i )
			{
				if( _actions[i] == action )
				{
					_actions.splice( i, 1 );
					_actionsPriority.splice( i, 1 );
					action.removedFromEmitter( this );
					return;
				}
			}
		}
		
		/**
		 * Adds an Activity to the Emitter. Activities set the behaviour
		 * of the Emitter.
		 * 
		 * @param activity The activity to add
		 * @param priority Indicates the sequencing of the activities. Higher 
		 * numbers cause an activity to be run before other activities. All 
		 * activities have a default priority which is used if no value is passed 
		 * in this parameter. The default priority is usually the one you want so 
		 * this parameter is only used when you need to override the default.
		 * 
		 * @see removeActivity()
		 * @see org.flintParticles.common.activities.Activity.getDefaultPriority()
		 */
		public function addActivity( activity:Activity, priority:Number = NaN ):void
		{
			if( isNaN( priority ) )
			{
				priority = activity.getDefaultPriority();
			}
			for( var i:int = 0; i < _activitiesPriority.length; ++i )
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
		 * Removes an Activity from the Emitter.
		 * 
		 * @param activity The Activity to remove
		 * 
		 * @see addActivity()
		 */
		public function removeActivity( activity:Activity ):void
		{
			for( var i:int = 0; i < _activities.length; ++i )
			{
				if( _activities[i] == activity )
				{
					_activities.splice( i, 1 );
					_activitiesPriority.splice( i, 1 );
					activity.removedFromEmitter( this );
					return;
				}
			}
		}
		
		/**
		 * The Counter for the Emitter. The counter defines when and
		 * with what frequency the emitter emits particles.
		 */		
		public function get counter():Counter
		{
			return _counter;
		}
		public function set counter( value:Counter ):void
		{
			_counter = value;
		}
		
		/**
		 * This is the particle factory used by the emitter to create and dispose 
		 * of particles. The 2D and 3D libraries each have a default particle
		 * factory that is used by the Emitter2D and Emitter3D classes. Any custom 
		 * particle factory should implement the ParticleFactory interface.
		 * @see org.flintparticles.common.particles.ParticleFactory
		 */		
		public function get particleFactory():ParticleFactory
		{
			return _particleFactory;
		}
		public function set particleFactory( value:ParticleFactory ):void
		{
			_particleFactory = value;
		}
		
		/**
		 * The array of all particles created by this emitter.
		 */
		public function get particles():Array
		{
			return _particles;
		}

		/*
		 * Used internally to create a particle.
		 */
		protected function createParticle():Particle
		{
			var particle:Particle = _particleFactory.createParticle();
			var len:int = _initializers.length;
			initParticle( particle );
			for ( var i:int = 0; i < len; ++i )
			{
				_initializers[i].initialize( this, particle );
			}
			_particles.push( particle );
			dispatchEvent( new ParticleEvent( ParticleEvent.PARTICLE_CREATED, particle ) );
			return particle;
		}
		
		/**
		 * Emitters do their own particle initialization here - usually involves 
		 * positioning and rotating the particle to match the position and rotation 
		 * of the emitter. This method is called before any initializers that are
		 * assigned to the emitter, so initializers can override any properties set 
		 * here.
		 * 
		 * <p>The implementation of this method in this base class does nothing.</p>
		 */
		protected function initParticle( particle:Particle ):void
		{
		}
		
		/**
		 * Adds existing particles to the emitter. This enables users to create 
		 * particles externally to the emitter and then pass the particles to the
		 * emitter for management.
		 * 
		 * @param particles An array of particles
		 * @param applyInitializers Indicates whether to apply the emitter's
		 * initializer behaviours to the particle (true) or not (false).
		 */
		public function addExistingParticles( particles:Array, applyInitializers:Boolean = false ):void
		{
			var len:int = particles.length;
			var i:int;
			if( applyInitializers )
			{
				var len2:int = _initializers.length;
				for ( var j:int = 0; j < len2; ++j )
				{
					for ( i = 0; i < len; ++i )
					{
						_initializers[j].initialize( this, particles[i] );
					}
				}
			}
			for( i = 0; i < len; ++i )
			{
				_particles.push( particles[i] );
				dispatchEvent( new ParticleEvent( ParticleEvent.PARTICLE_ADDED, particles[i] ) );
			}
		}
		
		/**
		 * Starts the emitter. Until start is called, the emitter will not emit or 
		 * update any particles.
		 */
		public function start():void
		{
			_ticker.removeEventListener( Event.ENTER_FRAME, frameLoop );
			_ticker.addEventListener( Event.ENTER_FRAME, frameLoop );
			_time = getTimer();
			var len:int = _activities.length;
			for ( var i:int = 0; i < len; ++i )
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
		 * Used internally to update the emitter. This method listens for the 
		 * enterframe event. It simply calculates the duration of the frame then 
		 * calls frameUpdate, passing the frame duration to that method.
		 * 
		 * @see frameUpdate();
		 */
		protected function frameLoop( ev:Event ):void
		{
			// update timer
			var oldTime:int = _time;
			_time = getTimer();
			var frameTime:Number = ( _time - oldTime ) * 0.001;
			frameUpdate( frameTime );
		}
		
		/**
		 * Used internally and in derived classes to update the emitter.
		 * 
		 * <p>Asks the counter how many particles to create then creates those
		 * particles. Calls sortParticles. Applies the activities to the emitter.
		 * Applies the Actions to all the particles. Removes all dead particles.
		 * Dispatches an emitterUpdated event which tells the renderer to redraw
		 * the particles.
		 * 
		 * @param time The duration, in seconds, of the current frame.
		 * 
		 * @see sortParticles();
		 */
		protected function frameUpdate( time:Number ):void
		{
			var i:int;
			var particle:Particle;
			var len:int = _counter.updateEmitter( this, time );
			for( i = 0; i < len; ++i )
			{
				createParticle();
			}
			sortParticles();
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
				var len2:int = _particles.length;
				
				for( var j:int = 0; j < len; ++j )
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
						dispatchEvent( new ParticleEvent( ParticleEvent.PARTICLE_DEAD, particle ) );
						_particleFactory.disposeParticle( particle );
						_particles.splice( i, 1 );
					}
				}
			}
			else 
			{
				dispatchEvent( new EmitterEvent( EmitterEvent.EMITTER_EMPTY ) );
			}
			dispatchEvent( new EmitterEvent( EmitterEvent.EMITTER_UPDATED ) );
		}
		
		/**
		 * Used to sort the particles as required. In this base class this method 
		 * does nothing.
		 */
		protected function sortParticles():void
		{
		}
		
		/**
		 * Pauses the emitter.
		 */
		public function pause():void
		{
			_ticker.removeEventListener( Event.ENTER_FRAME, frameLoop );
		}
		
		/**
		 * Resumes the emitter after a pause.
		 */
		public function resume():void
		{
			_ticker.removeEventListener( Event.ENTER_FRAME, frameLoop );
			_ticker.addEventListener( Event.ENTER_FRAME, frameLoop );
			_time = getTimer();
		}
		
		/**
		 * Cleans up the emitter prior to removal. If you don't call this method,
		 * the garbage collector will clean up all the particles in the usual way.
		 * If you use this method, the particles will be returned to the particle
		 * factory for reuse and the particleDead event is sent for each particle.
		 */
		public function dispose():void
		{
			_ticker.removeEventListener( Event.ENTER_FRAME, frameLoop );
			var len:int = _particles.length;
			for ( var i:int = 0; i < len; ++i )
			{
				dispatchEvent( new ParticleEvent( ParticleEvent.PARTICLE_DEAD, _particles[i] ) );
				_particleFactory.disposeParticle( _particles[i] );
			}
			_particles.length = 0;
		}
		
		/**
		 * Makes the emitter skip forwards a period of time with a single update.
		 * Used when you want the emitter to look like it's been running for a while.
		 * 
		 * @param time The time, in seconds, to skip ahead.
		 * @param frameRate The frame rate for calculating the new positions. The
		 * emitter will calculate each frame over the time period to get the new state
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
	}
}