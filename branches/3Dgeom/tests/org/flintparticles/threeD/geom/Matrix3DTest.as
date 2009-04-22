package org.flintparticles.threeD.geom 
{
	import flexunit.framework.TestCase;	

	/**
	 * @author Richard
	 */
	public class Matrix3DTest extends TestCase 
	{
		public function assertMatrixMatch( matrix:Matrix3D, match:Array, message:String ):void
		{
			assertEquals( message + " n11", match[0], matrix.n11 );
			assertEquals( message + " n12", match[1], matrix.n12 );
			assertEquals( message + " n13", match[2], matrix.n13 );
			assertEquals( message + " n14", match[3], matrix.n14 );
			assertEquals( message + " n21", match[4], matrix.n21 );
			assertEquals( message + " n22", match[5], matrix.n22 );
			assertEquals( message + " n23", match[6], matrix.n23 );
			assertEquals( message + " n24", match[7], matrix.n24 );
			assertEquals( message + " n31", match[8], matrix.n31 );
			assertEquals( message + " n32", match[9], matrix.n32 );
			assertEquals( message + " n33", match[10], matrix.n33 );
			assertEquals( message + " n34", match[11], matrix.n34 );
			assertEquals( message + " n41", match[12], matrix.n41 );
			assertEquals( message + " n42", match[13], matrix.n42 );
			assertEquals( message + " n43", match[14], matrix.n43 );
			assertEquals( message + " n44", match[15], matrix.n44 );
		}
		
		public function assertMatrixNearMatch( matrix:Matrix3D, match:Array, message:String, e:Number = 0.00001 ):void
		{
			assertTrue( message + " n11", Math.abs( match[0] - matrix.n11 ) <= e );
			assertTrue( message + " n12", Math.abs( match[1] - matrix.n12 ) <= e );
			assertTrue( message + " n13", Math.abs( match[2] - matrix.n13 ) <= e );
			assertTrue( message + " n14", Math.abs( match[3] - matrix.n14 ) <= e );
			assertTrue( message + " n21", Math.abs( match[4] - matrix.n21 ) <= e );
			assertTrue( message + " n22", Math.abs( match[5] - matrix.n22 ) <= e );
			assertTrue( message + " n23", Math.abs( match[6] - matrix.n23 ) <= e );
			assertTrue( message + " n24", Math.abs( match[7] - matrix.n24 ) <= e );
			assertTrue( message + " n31", Math.abs( match[8] - matrix.n31 ) <= e );
			assertTrue( message + " n32", Math.abs( match[9] - matrix.n32 ) <= e );
			assertTrue( message + " n33", Math.abs( match[10] - matrix.n33 ) <= e );
			assertTrue( message + " n34", Math.abs( match[11] - matrix.n34 ) <= e );
			assertTrue( message + " n41", Math.abs( match[12] - matrix.n41 ) <= e );
			assertTrue( message + " n42", Math.abs( match[13] - matrix.n42 ) <= e );
			assertTrue( message + " n43", Math.abs( match[14] - matrix.n43 ) <= e );
			assertTrue( message + " n44", Math.abs( match[15] - matrix.n44 ) <= e );
		}
		
		public function testZero():void
		{
			assertMatrixMatch( Matrix3D.ZERO, 
				[0,0,0,0,
				 0,0,0,0,
				 0,0,0,0,
				 0,0,0,0], 
			"ZERO" );
		}
		
		public function testIdentity():void
		{
			assertMatrixMatch( Matrix3D.IDENTITY, 
				[1,0,0,0,
				 0,1,0,0,
				 0,0,1,0,
				 0,0,0,1], 
			"ZERO" );
		}
		
		public function testNewScale():void
		{
			var m:Matrix3D = Matrix3D.newScale( 2, 3, 4 );
			assertMatrixMatch( m, 
				[2,0,0,0,
				 0,3,0,0,
				 0,0,4,0,
				 0,0,0,1], 
			"newScale" );
		}
		
		public function testNewTranslation():void
		{
			var m:Matrix3D = Matrix3D.newTranslate( 2, 3, 4 );
			assertMatrixMatch( m, 
				[1,0,0,2,
				 0,1,0,3,
				 0,0,1,4,
				 0,0,0,1], 
			"newTranslation" );
		}

		public function testNewRotate():void
		{
			var m:Matrix3D = Matrix3D.newRotate( 2 * Math.PI, new Vector3D( 2, 3, 4 ) );
			assertMatrixNearMatch( m, 
				[1,0,0,0,
				 0,1,0,0,
				 0,0,1,0,
				 0,0,0,1], 
			"newRotates 2 * PI around any axis" );
			m = Matrix3D.newRotate( Math.PI, new Vector3D( 1, 0, 0 ) );
			assertMatrixNearMatch( m, 
				[1,0,0,0,
				 0,-1,0,0,
				 0,0,-1,0,
				 0,0,0,1], 
			"newRotates PI around x axis" );
			m = Matrix3D.newRotate( Math.PI, new Vector3D( 0, 1, 0 ) );
			assertMatrixNearMatch( m, 
				[-1,0,0,0,
				 0,1,0,0,
				 0,0,-1,0,
				 0,0,0,1], 
			"newRotates PI around y axis" );
			m = Matrix3D.newRotate( Math.PI, new Vector3D( 0, 0, 1 ) );
			assertMatrixNearMatch( m, 
				[-1,0,0,0,
				 0,-1,0,0,
				 0,0,1,0,
				 0,0,0,1], 
			"newRotates PI around z axis" );
			m = Matrix3D.newRotate( Math.PI * 0.5, new Vector3D( 1, 0, 0 ) );
			assertMatrixNearMatch( m, 
				[1,0,0,0,
				 0,0,-1,0,
				 0,1,0,0,
				 0,0,0,1], 
			"newRotates PI/2 around x axis" );
			m = Matrix3D.newRotate( Math.PI * 0.5, new Vector3D( 0, 1, 0 ) );
			assertMatrixNearMatch( m, 
				[0,0,1,0,
				 0,1,0,0,
				 -1,0,0,0,
				 0,0,0,1], 
			"newRotates PI/2 around y axis" );
			m = Matrix3D.newRotate( Math.PI * 0.5, new Vector3D( 0, 0, 1 ) );
			assertMatrixNearMatch( m, 
				[0,-1,0,0,
				 1,0,0,0,
				 0,0,1,0,
				 0,0,0,1], 
			"newRotates PI/2 around z axis" );
			m = Matrix3D.newRotate( 2 * Math.PI, new Vector3D( 2, 3, 4 ), new Point3D( -4, 5, 3 ) );
			assertMatrixNearMatch( m, 
				[1,0,0,0,
				 0,1,0,0,
				 0,0,1,0,
				 0,0,0,1], 
			"newRotates 2 * PI around offset axis" );
			m = Matrix3D.newRotate( Math.PI, new Vector3D( 1, 0, 0 ), new Point3D( 0, 1, 0 ) );
			assertMatrixNearMatch( m, 
				[1,0,0,0,
				 0,-1,0,2,
				 0,0,-1,0,
				 0,0,0,1], 
			"newRotates PI around offset x axis" );
			m = Matrix3D.newRotate( Math.PI, new Vector3D( 0, 1, 0 ), new Point3D( 0, 0, 1 ) );
			assertMatrixNearMatch( m, 
				[-1,0,0,0,
				 0,1,0,0,
				 0,0,-1,2,
				 0,0,0,1], 
			"newRotates PI around offset y axis" );
			m = Matrix3D.newRotate( Math.PI, new Vector3D( 0, 0, 1 ), new Point3D( 1, 0, 0 ) );
			assertMatrixNearMatch( m, 
				[-1,0,0,2,
				 0,-1,0,0,
				 0,0,1,0,
				 0,0,0,1], 
			"newRotates PI around offset z axis" );
			m = Matrix3D.newRotate( Math.PI * 0.5, new Vector3D( 1, 0, 0 ), new Point3D( 0, 0, 1 ) );
			assertMatrixNearMatch( m, 
				[1,0,0,0,
				 0,0,-1,1,
				 0,1,0,1,
				 0,0,0,1], 
			"newRotates PI/2 around offset x axis" );
			m = Matrix3D.newRotate( Math.PI * 0.5, new Vector3D( 0, 1, 0 ), new Point3D( 1, 0, 0 ) );
			assertMatrixNearMatch( m, 
				[0,0,1,1,
				 0,1,0,0,
				 -1,0,0,1,
				 0,0,0,1], 
			"newRotates PI/2 around offset y axis" );
			m = Matrix3D.newRotate( Math.PI * 0.5, new Vector3D( 0, 0, 1 ), new Point3D( 0, 1, 0 ) );
			assertMatrixNearMatch( m, 
				[0,-1,0,1,
				 1,0,0,1,
				 0,0,1,0,
				 0,0,0,1], 
			"newRotates PI/2 around offset z axis" );
		}
		
		public function testNewBasisTransform():void
		{
			var m:Matrix3D = Matrix3D.newBasisTransform( new Vector3D( 1, 0, 0 ), new Vector3D( 0, 1, 0 ), new Vector3D( 0, 0, 1 ) );
			assertMatrixMatch( m, 
				[1,0,0,0,
				 0,1,0,0,
				 0,0,1,0,
				 0,0,0,1], 
			"newBasisTransform to identity" );
			m = Matrix3D.newBasisTransform( new Vector3D( 2, 0, 0 ), new Vector3D( 0, 4, 0 ), new Vector3D( 0, 0, -2 ) );
			assertMatrixMatch( m, 
				[0.5,0,0,0,
				 0,0.25,0,0,
				 0,0,-0.5,0,
				 0,0,0,1], 
			"newBasisTransform scaling" );
			m = Matrix3D.newBasisTransform( new Vector3D( 0, 1, 0 ), new Vector3D( 0, 0, 1 ), new Vector3D( 1, 0, 0 ) );
			assertMatrixMatch( m, 
				[0,1,0,0,
				 0,0,1,0,
				 1,0,0,0,
				 0,0,0,1], 
			"newBasisTransform rotating" );
		}
		
		public function testConstructor():void
		{
			var m:Matrix3D = new Matrix3D();
			assertMatrixMatch( m, 
				[1,0,0,0,
				 0,1,0,0,
				 0,0,1,0,
				 0,0,0,1], 
			"Empty Constructor" );
			
			var a:Array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
			m = new Matrix3D( a );
			assertMatrixMatch( m, a, "Constructor" );
		}

		public function testCopy():void
		{
			var m:Matrix3D = new Matrix3D();
			var a:Array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
			var m2:Matrix3D = new Matrix3D( a );
			m.copy( m2 );
			assertMatrixMatch( m, a, "copy" );
		}

		public function testClone():void
		{
			var a:Array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
			var m2:Matrix3D = new Matrix3D( a );
			var m:Matrix3D = m2.clone();
			assertMatrixMatch( m, a, "clone" );
		}

		public function testEquals():void
		{
			var a:Array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
			var m:Matrix3D = new Matrix3D( a );
			var m2:Matrix3D = new Matrix3D( a );
			assertTrue( "equals match", m.equals( m2 ) );
			for( var i:int = 0; i < 16; ++i )
			{
				if( i != 0 )
				{
					a[i-1] = i;
				}
				a[i] = 0;
				m2 = new Matrix3D( a );
				assertFalse( "equals not match " + i, m.equals( m2 ) );
			}
		}

		public function testNearEquals():void
		{
			var e:Number = 0.001;
			var a:Array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
			var m:Matrix3D = new Matrix3D( a );
			var m2:Matrix3D = new Matrix3D( a );
			assertTrue( "nearEquals match", m.nearEquals( m2, e ) );
			for( var i:int = 0; i < 16; ++i )
			{
				if( i != 0 )
				{
					a[i-1] = i;
				}
				a[i] += e / 2;
				m2 = new Matrix3D( a );
				assertTrue( "nearEquals match " + i, m.nearEquals( m2, e ) );
				a[i] += e;
				m2 = new Matrix3D( a );
				assertFalse( "nearEquals not match " + i, m.nearEquals( m2, e ) );
			}
		}
	}
}
