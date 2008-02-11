
package bigroom.flint.examples
{
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	
	import bigroom.flint.actions.Age;
	import bigroom.flint.actions.MoveEuler;
	import bigroom.flint.actions.RotateToDirection;
	import bigroom.flint.activities.FollowMouse;
	import bigroom.flint.counters.Steady;
	import bigroom.flint.displayObjects.LineShape;
	import bigroom.flint.emitters.BitmapEmitter;
	import bigroom.flint.initializers.ColorInit;
	import bigroom.flint.initializers.Lifetime;
	import bigroom.flint.initializers.SharedImage;
	import bigroom.flint.initializers.Velocity;
	import bigroom.flint.zones.Disc;	

	public class Sparkler extends BitmapEmitter
	{
		public function Sparkler()
		{
			addActivity( new FollowMouse() );
			
			addFilter( new BlurFilter( 2, 2, 1 ) );
			addFilter( new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.95,0 ] ) );

			setCounter( new Steady( 150 ) );
			
			addInitializer( new SharedImage( new LineShape( 6 ) ) );
			addInitializer( new ColorInit( 0xFFFFCC00, 0xFFFFCC00 ) );
			addInitializer( new Velocity( new Disc( new Point( 0, 0 ), 200, 350 ) ) );
			addInitializer( new Lifetime( 0.2, 0.4 ) );
			
			addAction( new Age() );
			addAction( new MoveEuler() );
			addAction( new RotateToDirection() );
		}
	}
}