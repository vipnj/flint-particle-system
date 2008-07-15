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

package org.flintparticles.threeD.actions 
{
	import org.flintparticles.common.actions.ActionBase;
	import org.flintparticles.common.emitters.Emitter;
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.threeD.geom.Vector3D;
	import org.flintparticles.threeD.particles.Particle3D;	

	/**
	 * The TurnTowardsPoint action causes the particle to constantly adjust its direction
	 * so that it travels towards a particular point.
	 */

	public class TurnTowardsPoint extends ActionBase
	{
		private var _point:Vector3D;
		private var _power:Number;
		
		/**
		 * The constructor creates a TurnTowardsPoint action for use by 
		 * an emitter. To add a TurnTowardsPoint to all particles created by an emitter, use the
		 * emitter's addAction method.
		 * 
		 * @see org.flintparticles.common.emitters.Emitter#addAction()
		 * 
		 * @param power The strength of the turn action. Higher values produce a sharper turn.
		 * @param point The point towards which the particle turns.
		 */
		public function TurnTowardsPoint( point:Vector3D, power:Number )
		{
			_power = power;
			_point = point.clone();
		}
		
		/**
		 * The strength of theturn action. Higher values produce a sharper turn.
		 */
		public function get power():Number
		{
			return _power;
		}
		public function set power( value:Number ):void
		{
			_power = value;
		}
		
		/**
		 * The x coordinate of the point that the particle turns towards.
		 */
		public function get point():Vector3D
		{
			return _point;
		}
		public function set point( value:Vector3D ):void
		{
			_point = value.clone();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function update( emitter:Emitter, particle:Particle, time:Number ):void
		{
			var p:Particle3D = Particle3D( particle );
			var velDirection:Vector3D = p.velocity.unit();
			var velLength:Number = p.velocity.length;
			var acc:Number = power * time;
			var toTarget:Vector3D = _point.subtract( p.position );
			var len:Number = toTarget.length;
			if( len == 0 )
			{
				return;
			}
			toTarget.scaleBy( 1 / len );
			var targetPerp:Vector3D = toTarget.subtract( velDirection.scaleBy( toTarget.dotProduct( velDirection ) ) );
				p.velocity.incrementBy( targetPerp.scaleBy( acc / targetPerp.length ) );
				p.velocity.scaleBy( velLength / p.velocity.length );
			
			
/*			var p:Particle3D = Particle3D( particle );
			var current:Vector3D = p.velocity.unit();
			var target:Vector3D = p.position.subtract( _point ).normalize();
			var axis:Vector3D = current.cross( target );
			var angle:Number = Math.acos( current.dotProduct( target ) );
			var moveBy:Number = _power * time;
			if( angle <= moveBy && angle >= -moveBy )
			{
				p.velocity.assign( target.scaleBy( p.velocity.length ) );
			}
			else if( angle > moveBy )
			{
				angle = moveBy;
				
				
				
			p.rotation.setFromAxisRotation( axis, angle );
			
			
			var turnLeft:Boolean = ( ( p.y - _y ) * p.velX + ( _x - p.x ) * p.velY > 0 );
			var newAngle:Number;
			if ( turnLeft )
			{
				newAngle = Math.atan2( p.velY, p.velX ) - _power * time;
				
			}
			else
			{
				newAngle = Math.atan2( p.velY, p.velX ) + _power * time;
			}
			var len:Number = Math.sqrt( p.velX * p.velX + p.velY * p.velY );
			p.velX = len * Math.cos( newAngle );
			p.velY = len * Math.sin( newAngle );*/
		}
	}
}
