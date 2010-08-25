package org.flintparticles.threeD.geom
{
	import flexunit.framework.TestCase;

	public class Point3DTest extends TestCase
	{
		public function testZero():void
		{
			assertEquals( "Zero x correctly", 0, Point3D.ZERO.x );
			assertEquals( "Zero y correctly", 0, Point3D.ZERO.y );
			assertEquals( "Zero z correctly", 0, Point3D.ZERO.z );
			assertEquals( "Zero w correctly", 1, Point3D.ZERO.w );
		}
		
		public function testConstructor():void
		{
			var p:Point3D = new Point3D();
			assertEquals( "Set default x correctly", 0, p.x );
			assertEquals( "Set default y correctly", 0, p.y );
			assertEquals( "Set default z correctly", 0, p.z );
			assertEquals( "Set default w correctly", 1, p.w );

			p = new Point3D( 4.3, 5.6, -3.4 );
			assertEquals( "Set x correctly", 4.3, p.x );
			assertEquals( "Set y correctly", 5.6, p.y );
			assertEquals( "Set z correctly", -3.4, p.z );
			assertEquals( "Set w correctly", 1, p.w );
		}
		
		public function testReset():void
		{
			var p:Point3D = new Point3D( 4.3, 5.6, -3.4 );
			p.w = 5;
			p.reset( 2, 3, 4 );
			assertEquals( "Reset x correctly", 2, p.x );
			assertEquals( "Reset y correctly", 3, p.y );
			assertEquals( "Reset z correctly", 4, p.z );
			assertEquals( "Reset w correctly", 1, p.w );
		}
		
		public function testAssign():void
		{
			var p:Point3D = new Point3D( 4.3, 5.6, -3.4 );
			p.w = 5;
			p.assign( new Point3D( 2, 3, 4 ) );
			assertEquals( "Assign x correctly", 2, p.x );
			assertEquals( "Assign y correctly", 3, p.y );
			assertEquals( "Assign z correctly", 4, p.z );
			assertEquals( "Assign w correctly", 1, p.w );
		}
		
		public function testClone():void
		{
			var p:Point3D = new Point3D( 2, 3, 4 );
			p.w = 5;
			var q:Point3D = p.clone();
			assertEquals( "Clone x correctly", 2, q.x );
			assertEquals( "Clone y correctly", 3, q.y );
			assertEquals( "Clone z correctly", 4, q.z );
			assertEquals( "Clone w correctly", 5, q.w );
			var r:Point3D = new Point3D();
			p.clone( r );
			assertEquals( "Clone into x correctly", 2, r.x );
			assertEquals( "Clone into y correctly", 3, r.y );
			assertEquals( "Clone into z correctly", 4, r.z );
			assertEquals( "Clone into w correctly", 5, r.w );
		}
		
		public function testAdd():void
		{
			var p:Point3D = new Point3D( 2, 3, 4 );
			var q:Point3D = p.add( new Vector3D( 5, 6, 7 ) );
			assertEquals( "Add x correctly", 7, q.x );
			assertEquals( "Add y correctly", 9, q.y );
			assertEquals( "Add z correctly", 11, q.z );
			assertEquals( "Add w correctly", 1, q.w );
			
			p.add( new Vector3D( 1, 2, 3 ), q );
			assertEquals( "Add into x correctly", 3, q.x );
			assertEquals( "Add into y correctly", 5, q.y );
			assertEquals( "Add into z correctly", 7, q.z );
			assertEquals( "Add into w correctly", 1, q.w );
		}
		
		public function testSubtract():void
		{
			var p:Point3D = new Point3D( 2, 3, 4 );
			var q:Point3D = p.subtract( new Vector3D( 5, 7, 6 ) );
			assertEquals( "Subtract x correctly", -3, q.x );
			assertEquals( "Subtract y correctly", -4, q.y );
			assertEquals( "Subtract z correctly", -2, q.z );
			assertEquals( "Subtract w correctly", 1, q.w );
			
			p.subtract( new Vector3D( -1, -2, -3 ), q );
			assertEquals( "Subtract into x correctly", 3, q.x );
			assertEquals( "Subtract into y correctly", 5, q.y );
			assertEquals( "Subtract into z correctly", 7, q.z );
			assertEquals( "Subtract into w correctly", 1, q.w );
		}
		
		public function testVectorTo():void
		{
			var p:Point3D = new Point3D( 2, 3, 4 );
			var v:Vector3D = p.vectorTo( new Point3D( 5, 7, 9 ) );
			assertEquals( "VectorTo x correctly", 3, v.x );
			assertEquals( "VectorTo y correctly", 4, v.y );
			assertEquals( "VectorTo z correctly", 5, v.z );
			assertEquals( "VectorTo w correctly", 0, v.w );
			
			p.vectorTo( new Point3D( 1, 5, 2 ), v );
			assertEquals( "VectorTo into x correctly", -1, v.x );
			assertEquals( "VectorTo into y correctly", 2, v.y );
			assertEquals( "VectorTo into z correctly", -2, v.z );
			assertEquals( "VectorTo into w correctly", 0, v.w );
		}
		
		public function testMultiply():void
		{
			var p:Point3D = new Point3D( 2, 3, 4 );
			var q:Point3D = p.multiply( 3 );
			assertEquals( "Multiply x correctly", 6, q.x );
			assertEquals( "Multiply y correctly", 9, q.y );
			assertEquals( "Multiply z correctly", 12, q.z );
			assertEquals( "Multiply w correctly", 1, q.w );
			
			p.multiply( -2, q );
			assertEquals( "Multiply into x correctly", -4, q.x );
			assertEquals( "Multiply into y correctly", -6, q.y );
			assertEquals( "Multiply into z correctly", -8, q.z );
			assertEquals( "Multiply into w correctly", 1, q.w );
		}
		
		public function testDivide():void
		{
			var p:Point3D = new Point3D( 2, 3, 4 );
			var q:Point3D = p.divide( 2 );
			assertEquals( "Divide x correctly", 1, q.x );
			assertEquals( "Divide y correctly", 1.5, q.y );
			assertEquals( "Divide z correctly", 2, q.z );
			assertEquals( "Divide w correctly", 1, q.w );
			
			p.divide( -2, q );
			assertEquals( "Divide into x correctly", -1, q.x );
			assertEquals( "Divide into y correctly", -1.5, q.y );
			assertEquals( "Divide into z correctly", -2, q.z );
			assertEquals( "Divide into w correctly", 1, q.w );
		}
		
		public function testIncrementBy():void
		{
			var p:Point3D = new Point3D( 2, 3, 4 );
			p.incrementBy( new Vector3D( 5, 6, 7 ) );
			assertEquals( "Increment x correctly", 7, p.x );
			assertEquals( "Increment y correctly", 9, p.y );
			assertEquals( "Increment z correctly", 11, p.z );
			assertEquals( "Increment w correctly", 1, p.w );
		}
		
		public function testDecrementBy():void
		{
			var p:Point3D = new Point3D( 2, 3, 4 );
			p.decrementBy( new Vector3D( 5, 7, 6 ) );
			assertEquals( "Decrement x correctly", -3, p.x );
			assertEquals( "Decrement y correctly", -4, p.y );
			assertEquals( "Decrement z correctly", -2, p.z );
			assertEquals( "Decrement w correctly", 1, p.w );
		}
		
		public function testScaleBy():void
		{
			var p:Point3D = new Point3D( 2, 3, 4 );
			p.scaleBy( 3 );
			assertEquals( "ScaleBy x correctly", 6, p.x );
			assertEquals( "ScaleBy y correctly", 9, p.y );
			assertEquals( "ScaleBy z correctly", 12, p.z );
			assertEquals( "ScaleBy w correctly", 1, p.w );
		}
		
		public function testDivideBy():void
		{
			var p:Point3D = new Point3D( 2, 3, 4 );
			p.divideBy( 2 );
			assertEquals( "DivideBy x correctly", 1, p.x );
			assertEquals( "DivideBy y correctly", 1.5, p.y );
			assertEquals( "DivideBy z correctly", 2, p.z );
			assertEquals( "DivideBy w correctly", 1, p.w );
		}
		
		public function testEquals():void
		{
			var p:Point3D = new Point3D( 2, 3, 4 );
			var q:Point3D = new Point3D( 2, 3, 4 );
			var r:Point3D = new Point3D( 4, 5, 6 );
			assertTrue( "Equals tests correctly", p.equals( q ) );
			assertFalse( "Not Equals tests correctly", p.equals( r ) );
		}
		
		public function testNearTo():void
		{
			var p:Point3D = new Point3D( 2, 3, 4 );
			var q:Point3D = new Point3D( 2.1, 2.9, 4 );
			var r:Point3D = new Point3D( 4, 5, 6 );
			assertTrue( "Equals tests correctly", p.nearTo( q, 0.2 ) );
			assertFalse( "Not Equals tests correctly", p.nearTo( r, 0.2 ) );
		}
		
		public function testDistance():void
		{
			var p:Point3D = new Point3D( 2, 3, 4 );
			var q:Point3D = new Point3D( 5, 7, -8 );
			var d:Number = p.distance( q );
			assertEquals( "Distance is correct", d, 13 );
		}
		
		public function testDistanceSquared():void
		{
			var p:Point3D = new Point3D( 2, 3, 4 );
			var q:Point3D = new Point3D( 4, 6, -3 );
			var d:Number = p.distanceSquared( q );
			assertEquals( "Distance is correct", d, 62 );
		}
		
		public function testProject():void
		{
			var p:Point3D = new Point3D( 2, 3, 4 );
			p.w = 2;
			p.project();
			assertEquals( "Project x correctly", 1, p.x );
			assertEquals( "Project y correctly", 1.5, p.y );
			assertEquals( "Project z correctly", 2, p.z );
			assertEquals( "Project w correctly", 1, p.w );
		}
	}
}