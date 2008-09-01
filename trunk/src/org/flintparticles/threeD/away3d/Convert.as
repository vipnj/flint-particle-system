package org.flintparticles.threeD.away3d 
{
	import org.flintparticles.threeD.geom.Vector3D;
	import org.flintparticles.threeD.geom.Matrix3D;
	import org.flintparticles.threeD.geom.Quaternion;
	
	import away3d.core.math.Matrix3D;
	import away3d.core.math.Number3D;	
	import away3d.core.math.Quaternion;	

	/**
	 * @author user
	 */
	public class Convert 
	{
		public static function Vector3DToA3D( v:Vector3D ):Number3D
		{
			return new Number3D( v.x, v.y, v.z );
		}

		public static function Vector3DFromA3D( v:Number3D ):Vector3D
		{
			return new Vector3D( v.x, v.y, v.z );
		}

		public static function Matrix3DToA3D( m:org.flintparticles.threeD.geom.Matrix3D ):away3d.core.math.Matrix3D
		{
			var n:away3d.core.math.Matrix3D = new away3d.core.math.Matrix3D();
			n.array2matrix( m.rawData, false, 1 );
			return n;
		}

		public static function Matrix3DFromA3D( m:away3d.core.math.Matrix3D ):org.flintparticles.threeD.geom.Matrix3D
		{
			return new org.flintparticles.threeD.geom.Matrix3D(
				[ m.sxx, m.sxy, m.sxz, m.tx, m.syx, m.syy, m.syz, m.ty, m.szx, m.szy, m.szz, m.tz, m.swx, m.swy, m.swz, m.tw ]
			);
		}
		
		public static function QuaternionToA3D( q:org.flintparticles.threeD.geom.Quaternion ):away3d.core.math.Quaternion
		{
			var r:away3d.core.math.Quaternion = new away3d.core.math.Quaternion();
			r.w = q.w;
			r.x = q.x;
			r.y = q.y;
			r.z = q.z;
			return r;
		}

		public static function QuaternionFromA3D( q:away3d.core.math.Quaternion ):org.flintparticles.threeD.geom.Quaternion
		{
			return new org.flintparticles.threeD.geom.Quaternion( q.w, q.x, q.y, q.z );
		}
	}
}
