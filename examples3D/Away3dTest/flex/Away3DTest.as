package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.flintparticles.common.actions.Age;
	import org.flintparticles.common.counters.Steady;
	import org.flintparticles.common.initializers.Lifetime;
	import org.flintparticles.threeD.actions.*;
	import org.flintparticles.threeD.away3d.initializers.A3DImageClass;
	import org.flintparticles.threeD.away3d.renderers.Object3DRenderer;
	import org.flintparticles.threeD.emitters.Emitter3D;
	import org.flintparticles.threeD.geom.Vector3D;
	import org.flintparticles.threeD.initializers.*;
	import org.flintparticles.threeD.zones.*;
	
	import away3d.containers.View3D;
	import away3d.primitives.Sphere;	

	[SWF(width='400', height='400', frameRate='61', backgroundColor='#000000')]

	/**
	 * 
	 */
	public class Away3DTest extends Sprite 
	{
		private var view:View3D;
		private var emitter:Emitter3D;
		private var renderer:Object3DRenderer;
		
		public function Away3DTest()
		{
			// create a viewport
			view = new View3D({x:200,y:200});
			addChild(view);
			
			emitter = new Emitter3D();
			emitter.counter = new Steady( 20 );
			emitter.addInitializer( new Position( new PointZone( new Vector3D( 0, -100, 0 ) ) ) );
			emitter.addInitializer( new Velocity( new DiscZone( new Vector3D( 0, 270, 0 ), new Vector3D( 0, 1, 0 ), 60 ) ) );
			emitter.addInitializer( new Lifetime( 4 ) );
			emitter.addInitializer( new A3DImageClass( Sphere, { radius:10, segmentsW:4, segmentsH:4 } ) );
			
			emitter.addAction( new Move() );
			emitter.addAction( new Accelerate( new Vector3D( 0, -150, 0 ) ) );
			emitter.addAction( new Age() );
			
			renderer = new Object3DRenderer( view.scene );
			renderer.addEmitter( emitter );
			emitter.start();

			addEventListener( Event.ENTER_FRAME, render );
		}
		
		private function render( ev:Event ):void
		{
			// render the view
			view.render();
		}
	}
}
