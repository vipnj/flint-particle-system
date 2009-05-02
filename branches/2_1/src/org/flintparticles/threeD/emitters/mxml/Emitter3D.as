package org.flintparticles.threeD.emitters.mxml 
{
	import org.flintparticles.threeD.emitters.Emitter3D;
	
	import mx.core.IMXMLObject;	

	/**
	 * @author Richard
	 */
	public class Emitter3D extends org.flintparticles.threeD.emitters.Emitter3D implements IMXMLObject 
	{
		public function Emitter3D()
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
