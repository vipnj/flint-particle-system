package org.flintparticles.twoD.emitters.mxml 
{
	import org.flintparticles.twoD.emitters.Emitter2D;
	
	import mx.core.IMXMLObject;
	
	/**
	 * @author Richard
	 */
	public class Emitter2D extends org.flintparticles.twoD.emitters.Emitter2D implements IMXMLObject 
	{
		public function Emitter2D()
		{
			super( );
		}
		
		[Inspectable]
		public var runAheadTime:Number = 0;
		
		[Inspectable]
		public var runAheadFrameRate:Number = 10;
		
		[Inspeactable]
		public var autoStart:Boolean = false;
		
		public function initialized(document:Object, id:String):void
		{
			if( autoStart )
			{
				start();
			}
			if( runAheadTime )
			{
				runAhead( runAheadTime, runAheadFrameRate );
			}
		}
	}
}
