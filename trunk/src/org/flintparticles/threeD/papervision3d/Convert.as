package org.flintparticles.threeD.papervision3d 
{
	import org.flintparticles.threeD.geom.Vector3D;
	import org.flintparticles.threeD.geom.Matrix3D;
	import org.flintparticles.threeD.geom.Quaternion;
	
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.core.math.Number3D;	
	import org.papervision3d.core.math.Quaternion;	

	/**
	 * @author user
	 */
	public class Convert 
	{
		public static function Vector3DToPV3D( v:Vector3D ):Number3D
		{
			return new Number3D( v.x, v.y, v.z );
		}

		public static function Vector3DFromPV3D( v:Number3D ):Vector3D
		{
			return new Vector3D( v.x, v.y, v.z );
		}

		public static function Matrix3DToPV3D( m:org.flintparticles.threeD.geom.Matrix3D ):org.papervision3d.core.math.Matrix3D
		{
			return new org.papervision3d.core.math.Matrix3D( m.rawData );
		}

		public static function Matrix3DFromPV3D( m:org.papervision3d.core.math.Matrix3D ):org.flintparticles.threeD.geom.Matrix3D
		{
			return new org.flintparticles.threeD.geom.Matrix3D(
				[ m.n11, m.n12, m.n13, m.n14, m.n21, m.n22, m.n23, m.n24, m.n31, m.n32, m.n33, m.n34, m.n41, m.n42, m.n43, m.n44 ]
			);
		}
		
		public static function QuaternionToPV3D( q:org.flintparticles.threeD.geom.Quaternion ):org.papervision3d.core.math.Quaternion
		{
			return new org.papervision3d.core.math.Quaternion( q.x, q.y, q.z, q.w );
		}

		public static function QuaternionFromPV3D( q:org.papervision3d.core.math.Quaternion ):org.flintparticles.threeD.geom.Quaternion
		{
			return new org.flintparticles.threeD.geom.Quaternion( q.w, q.x, q.y, q.z );
		}
	}
}
