package org.flintparticles.common.utils 
{
	import org.flintparticles.common.emitters.Behaviour;		

	public class BehaviourArrayUtils 
	{
		public static function contains( array:Array, item:Behaviour ):Boolean
		{
			return array.indexOf( item ) != -1;
		}
		
		public static function remove( array:Array, item:Behaviour ):Boolean
		{
			var index:int = array.indexOf( item );
			if( index != -1 )
			{
				array.splice( index, 1 );
				return true;
			}
			return false;
		}

		public static function add( array:Array, item:Behaviour ):uint
		{
			var len:uint = array.length;
			for( var i:uint = 0; i < len; ++i )
			{
				if( array[i].priority < item.priority )
				{
					break;
				}
			}
			array.splice( i, 0, item );
			return len + 1;
		}

		public static function removeAt( array:Array, index:uint ):Behaviour
		{
			var temp:Behaviour = array[index] as Behaviour;
			array.splice( index, 1 );
			return temp;
		}
		
		public static function clear( array:Array ):void
		{
			array.length = 0;
		}
		
		public static function sortArray( array:Array ):void
		{
			array.sortOn( "priority", Array.NUMERIC );
		}
	}
}
