package org.flintparticles.threeD.geom
{
	import flexunit.framework.TestCase;
	
	public class Vector3DTest extends TestCase
	{
		public function testZero():void
		{
			assertEquals( "Zero x correctly", 0, Vector3D.ZERO.x );
			assertEquals( "Zero y correctly", 0, Vector3D.ZERO.y );
			assertEquals( "Zero z correctly", 0, Vector3D.ZERO.z );
			assertEquals( "Zero w correctly", 0, Vector3D.ZERO.w );
		}
		
		public function testAxisX():void
		{
			assertEquals( "AxisX x correctly", 1, Vector3D.AXISX.x );
			assertEquals( "AxisX y correctly", 0, Vector3D.AXISX.y );
			assertEquals( "AxisX z correctly", 0, Vector3D.AXISX.z );
			assertEquals( "AxisX w correctly", 0, Vector3D.AXISX.w );
		}
		
		public function testAxisY():void
		{
			assertEquals( "AxisY x correctly", 0, Vector3D.AXISY.x );
			assertEquals( "AxisY y correctly", 1, Vector3D.AXISY.y );
			assertEquals( "AxisY z correctly", 0, Vector3D.AXISY.z );
			assertEquals( "AxisY w correctly", 0, Vector3D.AXISY.w );
		}
		
		public function testAxisZ():void
		{
			assertEquals( "AxisZ x correctly", 0, Vector3D.AXISZ.x );
			assertEquals( "AxisZ y correctly", 0, Vector3D.AXISZ.y );
			assertEquals( "AxisZ z correctly", 1, Vector3D.AXISZ.z );
			assertEquals( "AxisZ w correctly", 0, Vector3D.AXISZ.w );
		}
		
		public function testConstructor():void
		{
			var p:Vector3D = new Vector3D();
			assertEquals( "Set default x correctly", 0, p.x );
			assertEquals( "Set default y correctly", 0, p.y );
			assertEquals( "Set default z correctly", 0, p.z );
			assertEquals( "Set default w correctly", 0, p.w );

			p = new Vector3D( 4.3, 5.6, -3.4 );
			assertEquals( "Set x correctly", 4.3, p.x );
			assertEquals( "Set y correctly", 5.6, p.y );
			assertEquals( "Set z correctly", -3.4, p.z );
			assertEquals( "Set w correctly", 0, p.w );
		}
		
		public function testReset():void
		{
			var p:Vector3D = new Vector3D( 4.3, 5.6, -3.4 );
			p.reset( 2, 3, 4 );
			assertEquals( "Reset x correctly", 2, p.x );
			assertEquals( "Reset y correctly", 3, p.y );
			assertEquals( "Reset z correctly", 4, p.z );
			assertEquals( "Reset w correctly", 0, p.w );
		}
		
		public function testAssign():void
		{
			var p:Vector3D = new Vector3D( 4.3, 5.6, -3.4 );
			p.assign( new Vector3D( 2, 3, 4 ) );
			assertEquals( "Assign x correctly", 2, p.x );
			assertEquals( "Assign y correctly", 3, p.y );
			assertEquals( "Assign z correctly", 4, p.z );
			assertEquals( "Assign w correctly", 0, p.w );
		}
		
		public function testClone():void
		{
			var p:Vector3D = new Vector3D( 2, 3, 4 );
			var q:Vector3D = p.clone();
			assertEquals( "Clone x correctly", 2, q.x );
			assertEquals( "Clone y correctly", 3, q.y );
			assertEquals( "Clone z correctly", 4, q.z );
			assertEquals( "Clone w correctly", 0, q.w );
			var r:Vector3D = new Vector3D();
			p.clone( r );
			assertEquals( "Clone into x correctly", 2, r.x );
			assertEquals( "Clone into y correctly", 3, r.y );
			assertEquals( "Clone into z correctly", 4, r.z );
			assertEquals( "Clone into w correctly", 0, r.w );
		}
		
		public function testAdd():void
		{
			var p:Vector3D = new Vector3D( 2, 3, 4 );
			var q:Vector3D = p.add( new Vector3D( 5, 6, 7 ) );
			assertEquals( "Add x correctly", 7, q.x );
			assertEquals( "Add y correctly", 9, q.y );
			assertEquals( "Add z correctly", 11, q.z );
			assertEquals( "Add w correctly", 0, q.w );
			
			p.add( new Vector3D( 1, 2, 3 ), q );
			assertEquals( "Add into x correctly", 3, q.x );
			assertEquals( "Add into y correctly", 5, q.y );
			assertEquals( "Add into z correctly", 7, q.z );
			assertEquals( "Add into w correctly", 0, q.w );
		}
		
		public function testSubtract():void
		{
			var p:Vector3D = new Vector3D( 2, 3, 4 );
			var q:Vector3D = p.subtract( new Vector3D( 5, 7, 6 ) );
			assertEquals( "Subtract x correctly", -3, q.x );
			assertEquals( "Subtract y correctly", -4, q.y );
			assertEquals( "Subtract z correctly", -2, q.z );
			assertEquals( "Subtract w correctly", 0, q.w );
			
			p.subtract( new Vector3D( -1, -2, -3 ), q );
			assertEquals( "Subtract into x correctly", 3, q.x );
			assertEquals( "Subtract into y correctly", 5, q.y );
			assertEquals( "Subtract into z correctly", 7, q.z );
			assertEquals( "Subtract into w correctly", 0, q.w );
		}
		
		public function testMultiply():void
		{
			var p:Vector3D = new Vector3D( 2, 3, 4 );
			var q:Vector3D = p.multiply( 3 );
			assertEquals( "Multiply x correctly", 6, q.x );
			assertEquals( "Multiply y correctly", 9, q.y );
			assertEquals( "Multiply z correctly", 12, q.z );
			assertEquals( "Multiply w correctly", 0, q.w );
			
			p.multiply( -2, q );
			assertEquals( "Multiply into x correctly", -4, q.x );
			assertEquals( "Multiply into y correctly", -6, q.y );
			assertEquals( "Multiply into z correctly", -8, q.z );
			assertEquals( "Multiply into w correctly", 0, q.w );
		}
		
		public function testDivide():void
		{
			var p:Vector3D = new Vector3D( 2, 3, 4 );
			var q:Vector3D = p.divide( 2 );
			assertEquals( "Divide x correctly", 1, q.x );
			assertEquals( "Divide y correctly", 1.5, q.y );
			assertEquals( "Divide z correctly", 2, q.z );
			assertEquals( "Divide w correctly", 0, q.w );
			
			p.divide( -2, q );
			assertEquals( "Divide into x correctly", -1, q.x );
			assertEquals( "Divide into y correctly", -1.5, q.y );
			assertEquals( "Divide into z correctly", -2, q.z );
			assertEquals( "Divide into w correctly", 0, q.w );
		}
		
		public function testIncrementBy():void
		{
			var p:Vector3D = new Vector3D( 2, 3, 4 );
			p.incrementBy( new Vector3D( 5, 6, 7 ) );
			assertEquals( "Increment x correctly", 7, p.x );
			assertEquals( "Increment y correctly", 9, p.y );
			assertEquals( "Increment z correctly", 11, p.z );
			assertEquals( "Increment w correctly", 0, p.w );
		}
		
		public function testDecrementBy():void
		{
			var p:Vector3D = new Vector3D( 2, 3, 4 );
			p.decrementBy( new Vector3D( 5, 7, 6 ) );
			assertEquals( "Decrement x correctly", -3, p.x );
			assertEquals( "Decrement y correctly", -4, p.y );
			assertEquals( "Decrement z correctly", -2, p.z );
			assertEquals( "Decrement w correctly", 0, p.w );
		}
		
		public function testScaleBy():void
		{
			var p:Vector3D = new Vector3D( 2, 3, 4 );
			p.scaleBy( 3 );
			assertEquals( "ScaleBy x correctly", 6, p.x );
			assertEquals( "ScaleBy y correctly", 9, p.y );
			assertEquals( "ScaleBy z correctly", 12, p.z );
			assertEquals( "ScaleBy w correctly", 0, p.w );
		}
		
		public function testDivideBy():void
		{
			var p:Vector3D = new Vector3D( 2, 3, 4 );
			p.divideBy( 2 );
			assertEquals( "DivideBy x correctly", 1, p.x );
			assertEquals( "DivideBy y correctly", 1.5, p.y );
			assertEquals( "DivideBy z correctly", 2, p.z );
			assertEquals( "DivideBy w correctly", 0, p.w );
		}
		
		public function testEquals():void
		{
			var p:Vector3D = new Vector3D( 2, 3, 4 );
			var q:Vector3D = new Vector3D( 2, 3, 4 );
			var r:Vector3D = new Vector3D( 4, 5, 6 );
			assertTrue( "Equals tests correctly", p.equals( q ) );
			assertFalse( "Not Equals tests correctly", p.equals( r ) );
		}
		
		public function testNearEquals():void
		{
			var p:Vector3D = new Vector3D( 2, 3, 4 );
			var q:Vector3D = new Vector3D( 2.1, 2.9, 4 );
			var r:Vector3D = new Vector3D( 4, 5, 6 );
			assertTrue( "Equals tests correctly", p.nearEquals( q, 0.2 ) );
			assertFalse( "Not Equals tests correctly", p.nearEquals( r, 0.2 ) );
		}
		
		public function testDotProduct():void
		{
			var p:Vector3D = new Vector3D( 2, 3, 4 );
			var q:Vector3D = new Vector3D( 4, 5, 6 );
			var d:Number = p.dotProduct( q );
			assertEquals( "Dotproduct correct", 47, d );
		}
		
		public function testCrossProduct():void
		{
			var p:Vector3D = new Vector3D( 3,-3, 1 );
			var q:Vector3D = new Vector3D( 4, 9, 2 );
			var r:Vector3D = p.crossProduct( q );
			assertEquals( "CrossProduct x correctly", -15, r.x );
			assertEquals( "CrossProduct y correctly", -2, r.y );
			assertEquals( "CrossProduct z correctly", 39, r.z );
			assertEquals( "CrossProduct w correctly", 0, r.w );
		}

		public function testLength():void
		{
			var p:Vector3D = new Vector3D( 3, -4, 12 );
			assertEquals( "Length is correct", p.length, 13 );
		}
		
		public function testLengthSquared():void
		{
			var p:Vector3D = new Vector3D( -2, 3, 4 );
			assertEquals( "Distance is correct", p.lengthSquared, 29 );
		}
		
		public function testNegative():void
		{
			var p:Vector3D = new Vector3D( 2, -3, 4 );
			var q:Vector3D = p.negative();
			assertEquals( "Negative x correctly", -2, q.x );
			assertEquals( "Negative y correctly", 3, q.y );
			assertEquals( "Negative z correctly", -4, q.z );
			assertEquals( "Negative w correctly", 0, q.w );
			var r:Vector3D = new Vector3D();
			p.negative( r );
			assertEquals( "Negative into x correctly", -2, r.x );
			assertEquals( "Negative into y correctly", 3, r.y );
			assertEquals( "Negative into z correctly", -4, r.z );
			assertEquals( "Negative into w correctly", 0, r.w );
		}
		
		public function testNegate():void
		{
			var p:Vector3D = new Vector3D( 2, -3, 4 );
			p.negate();
			assertEquals( "Negate x correctly", -2, p.x );
			assertEquals( "Negate y correctly", 3, p.y );
			assertEquals( "Negate z correctly", -4, p.z );
			assertEquals( "Negate w correctly", 0, p.w );
		}
		
		public function testNormalize():void
		{
			var p:Vector3D = new Vector3D( 3, -4, 12 );
			p.normalize();
			assertEquals( "Normalize x correctly", 3/13, p.x );
			assertEquals( "Normalize y correctly", -4/13, p.y );
			assertEquals( "Normalize z correctly", 12/13, p.z );
			assertEquals( "Normalize w correctly", 0, p.w );
		}
		
		public function testUnit():void
		{
			var p:Vector3D = new Vector3D( 3, -4, 12 );
			var q:Vector3D = p.unit();
			assertEquals( "Negative x correctly", 3/13, q.x );
			assertEquals( "Negative y correctly", -4/13, q.y );
			assertEquals( "Negative z correctly", 12/13, q.z );
			assertEquals( "Negative w correctly", 0, q.w );
			var r:Vector3D = new Vector3D();
			p.unit( r );
			assertEquals( "Negative into x correctly", 3/13, r.x );
			assertEquals( "Negative into y correctly", -4/13, r.y );
			assertEquals( "Negative into z correctly", 12/13, r.z );
			assertEquals( "Negative into w correctly", 0, r.w );
		}
	}
}