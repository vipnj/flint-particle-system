package bigroom.flint.examples
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import bigroom.flint.emitters.Emitter;
	
	import flash.net.navigateToURL;
	import flash.net.URLRequest;	

	public class Main extends Sprite
    {
    	private var emitters:Array;
    	
	   	public var thousandsBtn:SimpleButton;
		public var fireBtn:SimpleButton;
		public var sparklerBtn:SimpleButton;
		public var logoBtn:SimpleButton;
  	
		public function Main()
		{
			emitters = new Array();
			
			thousandsBtn.addEventListener( MouseEvent.CLICK, thousands, false, 0, true );
			fireBtn.addEventListener( MouseEvent.CLICK, smokeAndFire, false, 0, true );
			sparklerBtn.addEventListener( MouseEvent.CLICK, sparkler, false, 0, true );
			logoBtn.addEventListener( MouseEvent.CLICK, goWebsite, false, 0, true );
			
			thousands( null );
		}
		
		private function goWebsite( ev:MouseEvent ):void
		{
			navigateToURL( new URLRequest( "http://flashgamecode.net/flint" ) );
		}
		
		private function cleanUp():void
		{
			for( var i:uint = 0; i < emitters.length; ++i )
			{
				removeChild( emitters[i] );
			}
			emitters.length = 0;
		}
		
		private function thousands( ev:MouseEvent ):void
		{
			cleanUp();
			var emitter:Emitter = new Thousands();
			addChildAt( emitter, 0 );
			emitter.x = 200;
			emitter.y = 200;
			emitter.start();
			emitters.push( emitter );
		}

		private function smokeAndFire( ev:MouseEvent ):void
		{
			cleanUp();
			var emitter:Emitter = new Smoke();
			addChildAt( emitter, 0 );
			emitter.x = 200;
			emitter.y = 380;
			emitter.start();
			emitters.push( emitter );

			emitter = new Fire();
			addChildAt( emitter, 1 );
			emitter.x = 200;
			emitter.y = 380;
			emitter.start();
			emitters.push( emitter );
		}
		
		private function sparkler( ev:MouseEvent ):void
		{
			cleanUp();
			var emitter:Emitter = new Sparkler();
			addChildAt( emitter, 0 );
			emitter.start();
			emitters.push( emitter );
		}

    }
}