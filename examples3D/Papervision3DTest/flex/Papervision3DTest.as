package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.flintparticles.common.actions.Age;
	import org.flintparticles.common.actions.ColorChange;
	import org.flintparticles.common.counters.Steady;
	import org.flintparticles.common.energyEasing.Quadratic;
	import org.flintparticles.common.initializers.Lifetime;
	import org.flintparticles.threeD.actions.*;
	import org.flintparticles.threeD.emitters.Emitter3D;
	import org.flintparticles.threeD.geom.Vector3D;
	import org.flintparticles.threeD.initializers.*;
	import org.flintparticles.threeD.papervision3d.PV3DRenderer;
	import org.flintparticles.threeD.papervision3d.initializers.ApplyMaterial;
	import org.flintparticles.threeD.papervision3d.initializers.PV3DImageClass;
	import org.flintparticles.threeD.zones.*;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;	

	[SWF(width='400', height='400', frameRate='61', backgroundColor='#000000')]

	/**
	 * 
	 */
	public class Papervision3DTest extends Sprite 
	{
		// width:384 height:255
		[Embed(source="assets/184098.jpg")]
		public var Image1:Class;

		private var viewport:Viewport3D;
		private var emitter:Emitter3D;
		private var renderer:BasicRenderEngine;
		private var flintRenderer:PV3DRenderer;
		private var scene:Scene3D;
		private var camera:Camera3D;
		
		public function Papervision3DTest()
		{
			// create a viewport
			viewport = new Viewport3D( 400, 400 );
			addChild( viewport );
			
			renderer = new BasicRenderEngine();
			scene = new Scene3D();
			camera = new Camera3D();
			
			emitter = new Emitter3D();
			emitter.counter = new Steady( 4 );
			emitter.addInitializer( new Position( new PointZone( new Vector3D( 0, -100, 0 ) ) ) );
			emitter.addInitializer( new Velocity( new DiscZone( new Vector3D( 0, 270, 0 ), new Vector3D( 0, 1, 0 ), 60 ) ) );
			emitter.addInitializer( new Lifetime( 4 ) );
			
			var bmp:Bitmap = new Image1();
			var materials:MaterialsList = new MaterialsList();
			var material:BitmapMaterial = new BitmapMaterial( bmp.bitmapData );
			materials.addMaterial( material, "all" );
			
			emitter.addInitializer( new PV3DImageClass( Cube, materials, 50, 50, 50 ) );
//			emitter.addInitializer( new ApplyMaterial( BitmapMaterial, new Image1().bitmapData ) );
			emitter.addInitializer( new RotateVelocity( new Vector3D( 1, 1, 1 ), 3 ) );
			
			emitter.addAction( new Move() );
			emitter.addAction( new Rotate() );
			emitter.addAction( new Accelerate( new Vector3D( 0, -150, 0 ) ) );
			emitter.addAction( new Age( Quadratic.easeIn ) );
			emitter.addAction( new ColorChange( 0xFFCC0000, 0x00FFFFFF ) );
			
			flintRenderer = new PV3DRenderer( scene );
			flintRenderer.addEmitter( emitter );
			emitter.start();

			addEventListener( Event.ENTER_FRAME, render );
		}
		
		private function render( ev:Event ):void
		{
			// render the view
			renderer.renderScene( scene, camera, viewport);
		}
	}
}