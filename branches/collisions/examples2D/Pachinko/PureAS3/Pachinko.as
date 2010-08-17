package  
{
	import org.flintparticles.common.counters.TimePeriod;
	import org.flintparticles.common.displayObjects.Dot;
	import org.flintparticles.common.initializers.CollisionRadiusInit;
	import org.flintparticles.common.initializers.SharedImage;
	import org.flintparticles.twoD.actions.Accelerate;
	import org.flintparticles.twoD.actions.Collide;
	import org.flintparticles.twoD.actions.CollisionZone;
	import org.flintparticles.twoD.actions.DeathZone;
	import org.flintparticles.twoD.actions.Move;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.initializers.Position;
	import org.flintparticles.twoD.initializers.Velocity;
	import org.flintparticles.twoD.zones.DiscZone;
	import org.flintparticles.twoD.zones.LineZone;
	import org.flintparticles.twoD.zones.PointZone;
	import org.flintparticles.twoD.zones.RectangleZone;

	import flash.geom.Point;

	/**
	 * @author Richard Lord
	 */
	public class Pachinko extends Emitter2D 
	{
		public function Pachinko()
		{
			counter = new TimePeriod( 100, 1 );
			
			addInitializer( new SharedImage( new Dot( 5 ) ) );
			addInitializer( new CollisionRadiusInit( 5 ) );
			addInitializer( new Position( new LineZone( new Point( 50, -10 ), new Point( 450, -10 ) ) ) );
			addInitializer( new Velocity( new DiscZone( new Point( 0, 100 ), 20 ) ) );
			
			addAction( new Move() );
			addAction( new Accelerate( 0, 100 ) );
			addAction( new Collide() );
			addAction( new DeathZone( new RectangleZone( 0, -50, 500, 510 ), true ) );
			addAction( new CollisionZone( new RectangleZone( 0, -30, 500, 530 ), 0.5 ) );
		}
		
		public function addPin( x:Number, y:Number ):void
		{
			addAction( new CollisionZone( new PointZone( new Point( x, y ) ), 0.5 ) );
		}
	}
}
