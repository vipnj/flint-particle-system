package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.flintparticles.common.actions.Age;
	import org.flintparticles.common.actions.ColorChange;
	import org.flintparticles.common.counters.*;
	import org.flintparticles.common.initializers.Lifetime;
	import org.flintparticles.threeD.actions.*;
	import org.flintparticles.threeD.emitters.Emitter3D;
	import org.flintparticles.threeD.geom.Vector3D;
	import org.flintparticles.threeD.initializers.*;
	import org.flintparticles.threeD.papervision3d.PV3DParticleRenderer;
	import org.flintparticles.threeD.papervision3d.initializers.ApplyMaterial;
	import org.flintparticles.threeD.papervision3d.initializers.PV3DImageClass;
	import org.flintparticles.threeD.zones.*;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.core.geom.Particles;
	import org.papervision3d.core.geom.renderables.Particle;
	import org.papervision3d.materials.special.ParticleMaterial;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;	

	[SWF(width='400', height='400', frameRate='61', backgroundColor='#000000')]

	/**
	 * 
	 */
	public class Papervision3DTest2 extends Sprite 
	{
		private var viewport:Viewport3D;
		private var emitter:Emitter3D;
		private var renderer:BasicRenderEngine;
		private var flintRenderer:PV3DParticleRenderer;
		private var scene:Scene3D;
		private var camera:Camera3D;
		
		
		public function Papervision3DTest2()
		{
			// create a viewport
			viewport = new Viewport3D( 400, 400 );
			addChild( viewport );
			
			renderer = new BasicRenderEngine();
			scene = new Scene3D();
			camera = new Camera3D();
			
			var particles:Particles = new Particles();
			scene.addChild( particles );
			
			emitter = new Emitter3D();
			emitter.counter = new Steady( 10 );
			emitter.addInitializer( new Position( new PointZone( new Vector3D( 0, -100, 0 ) ) ) );
			emitter.addInitializer( new Velocity( new DiscZone( new Vector3D( 0, 270, 0 ), new Vector3D( 0, 1, 0 ), 60 ) ) );
			emitter.addInitializer( new Lifetime( 4 ) );
			emitter.addInitializer( new PV3DImageClass( Particle, null, 20 ) );
			emitter.addInitializer( new ApplyMaterial( ParticleMaterial, 0xFFFFFF, 1, 1 ) );
			
			emitter.addAction( new Move() );
			emitter.addAction( new Accelerate( new Vector3D( 0, -150, 0 ) ) );
			emitter.addAction( new Age() );
			emitter.addAction( new ColorChange( 0xFFCC0000, 0x00FFFFFF ) );
			
			flintRenderer = new PV3DParticleRenderer( particles );
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