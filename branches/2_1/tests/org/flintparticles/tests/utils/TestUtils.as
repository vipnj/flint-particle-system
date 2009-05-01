package org.flintparticles.tests.utils
{

	/**
	 * @author Richard
	 */
	public class TestUtils
	{
		public static function testNear( a:Number, b:Number, e:Number = 0.0000000001 ):Boolean
		{
			return Math.abs( a - b ) < e;
		}
	}
}
