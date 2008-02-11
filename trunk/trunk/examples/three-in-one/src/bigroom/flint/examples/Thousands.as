
package bigroom.flint.examples
{
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	
	import bigroom.flint.actions.GravityWell;
	import bigroom.flint.actions.MoveEuler;
	import bigroom.flint.counters.Blast;
	import bigroom.flint.emitters.PixelEmitter;
	import bigroom.flint.initializers.ColorInit;
	import bigroom.flint.initializers.Position;
	import bigroom.flint.initializers.Velocity;
	import bigroom.flint.zones.Disc;
	import bigroom.flint.zones.PointZone;	

	public class Thousands extends PixelEmitter
	{
		public function Thousands()
		{
			addFilter( new BlurFilter( 2, 2, 1 ) );
			addFilter( new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.99,0 ] ) );

			setCounter( new Blast( 2000 ) );
			
			addInitializer( new ColorInit( 0xFFFF00FF, 0xFF00FFFF ) );
			addInitializer( new Position( new Disc( new Point( 0, 0 ), 200 ) ) );
			addInitializer( new Velocity( new PointZone( new Point( 0, 0 ) ) ) );

			addAction( new MoveEuler() );
			addAction( new GravityWell( 25, 200, 200 ) );
			addAction( new GravityWell( 25, 75, 75 ) );
			addAction( new GravityWell( 25, 325, 325 ) );
			addAction( new GravityWell( 25, 75, 325 ) );
			addAction( new GravityWell( 25, 325, 75 ) );
		}
	}
}