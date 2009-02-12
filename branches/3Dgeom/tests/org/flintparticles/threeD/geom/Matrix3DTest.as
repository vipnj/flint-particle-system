package org.flintparticles.threeD.geom 
{
	import flexunit.framework.TestCase;	

	/**
	 * @author Richard
	 */
	public class Matrix3DTest extends TestCase 
	{
		public function testZero():void
		{
			assertEquals( "Zero n11 correctly", 0, Matrix3D.ZERO.n11 );
			assertEquals( "Zero n12 correctly", 0, Matrix3D.ZERO.n12 );
			assertEquals( "Zero n13 correctly", 0, Matrix3D.ZERO.n13 );
			assertEquals( "Zero n14 correctly", 0, Matrix3D.ZERO.n14 );
			assertEquals( "Zero n21 correctly", 0, Matrix3D.ZERO.n21 );
			assertEquals( "Zero n22 correctly", 0, Matrix3D.ZERO.n22 );
			assertEquals( "Zero n23 correctly", 0, Matrix3D.ZERO.n23 );
			assertEquals( "Zero n24 correctly", 0, Matrix3D.ZERO.n24 );
			assertEquals( "Zero n31 correctly", 0, Matrix3D.ZERO.n31 );
			assertEquals( "Zero n32 correctly", 0, Matrix3D.ZERO.n32 );
			assertEquals( "Zero n33 correctly", 0, Matrix3D.ZERO.n33 );
			assertEquals( "Zero n34 correctly", 0, Matrix3D.ZERO.n34 );
			assertEquals( "Zero n41 correctly", 0, Matrix3D.ZERO.n41 );
			assertEquals( "Zero n42 correctly", 0, Matrix3D.ZERO.n42 );
			assertEquals( "Zero n43 correctly", 0, Matrix3D.ZERO.n43 );
			assertEquals( "Zero n44 correctly", 0, Matrix3D.ZERO.n44 );
		}
		
		public function testIdentity():void
		{
			assertEquals( "Identity n11 correctly", 1, Matrix3D.IDENTITY.n11 );
			assertEquals( "Identity n12 correctly", 0, Matrix3D.IDENTITY.n12 );
			assertEquals( "Identity n13 correctly", 0, Matrix3D.IDENTITY.n13 );
			assertEquals( "Identity n14 correctly", 0, Matrix3D.IDENTITY.n14 );
			assertEquals( "Identity n21 correctly", 0, Matrix3D.IDENTITY.n21 );
			assertEquals( "Identity n22 correctly", 1, Matrix3D.IDENTITY.n22 );
			assertEquals( "Identity n23 correctly", 0, Matrix3D.IDENTITY.n23 );
			assertEquals( "Identity n24 correctly", 0, Matrix3D.IDENTITY.n24 );
			assertEquals( "Identity n31 correctly", 0, Matrix3D.IDENTITY.n31 );
			assertEquals( "Identity n32 correctly", 0, Matrix3D.IDENTITY.n32 );
			assertEquals( "Identity n33 correctly", 1, Matrix3D.IDENTITY.n33 );
			assertEquals( "Identity n34 correctly", 0, Matrix3D.IDENTITY.n34 );
			assertEquals( "Identity n41 correctly", 0, Matrix3D.IDENTITY.n41 );
			assertEquals( "Identity n42 correctly", 0, Matrix3D.IDENTITY.n42 );
			assertEquals( "Identity n43 correctly", 0, Matrix3D.IDENTITY.n43 );
			assertEquals( "Identity n44 correctly", 1, Matrix3D.IDENTITY.n44 );
		}
		
		public function testNewScale():void
		{
			var m:Matrix3D = Matrix3D.newScale( 2, 3, 4 );
			assertEquals( "New Scale n11 correctly", 2, m.n11 );
			assertEquals( "New Scale n12 correctly", 0, m.n12 );
			assertEquals( "New Scale n13 correctly", 0, m.n13 );
			assertEquals( "New Scale n14 correctly", 0, m.n14 );
			assertEquals( "New Scale n21 correctly", 0, m.n21 );
			assertEquals( "New Scale n22 correctly", 3, m.n22 );
			assertEquals( "New Scale n23 correctly", 0, m.n23 );
			assertEquals( "New Scale n24 correctly", 0, m.n24 );
			assertEquals( "New Scale n31 correctly", 0, m.n31 );
			assertEquals( "New Scale n32 correctly", 0, m.n32 );
			assertEquals( "New Scale n33 correctly", 4, m.n33 );
			assertEquals( "New Scale n34 correctly", 0, m.n34 );
			assertEquals( "New Scale n41 correctly", 0, m.n41 );
			assertEquals( "New Scale n42 correctly", 0, m.n42 );
			assertEquals( "New Scale n43 correctly", 0, m.n43 );
			assertEquals( "New Scale n44 correctly", 1, m.n44 );
		}
		
		public function testNewTranslation():void
		{
			var m:Matrix3D = Matrix3D.newTranslation( 2, 3, 4 );
			assertEquals( "New Translation n11 correctly", 1, m.n11 );
			assertEquals( "New Translation n12 correctly", 0, m.n12 );
			assertEquals( "New Translation n13 correctly", 0, m.n13 );
			assertEquals( "New Translation n14 correctly", 2, m.n14 );
			assertEquals( "New Translation n21 correctly", 0, m.n21 );
			assertEquals( "New Translation n22 correctly", 1, m.n22 );
			assertEquals( "New Translation n23 correctly", 0, m.n23 );
			assertEquals( "New Translation n24 correctly", 3, m.n24 );
			assertEquals( "New Translation n31 correctly", 0, m.n31 );
			assertEquals( "New Translation n32 correctly", 0, m.n32 );
			assertEquals( "New Translation n33 correctly", 1, m.n33 );
			assertEquals( "New Translation n34 correctly", 4, m.n34 );
			assertEquals( "New Translation n41 correctly", 0, m.n41 );
			assertEquals( "New Translation n42 correctly", 0, m.n42 );
			assertEquals( "New Translation n43 correctly", 0, m.n43 );
			assertEquals( "New Translation n44 correctly", 1, m.n44 );
		}
	}
}
