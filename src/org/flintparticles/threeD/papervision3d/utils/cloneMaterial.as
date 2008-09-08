/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord (Big Room)
 * Copyright (c) Big Room Ventures Ltd. 2008
 * http://flintparticles.org
 * 
 * 
 * Licence Agreement
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package org.flintparticles.threeD.papervision3d.utils 
{
	import org.papervision3d.core.material.*;
	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.materials.*;
	import org.papervision3d.materials.shadematerials.*;
	import org.papervision3d.materials.shaders.*;
	import org.papervision3d.materials.special.*;	
	
	/**
	 * This function clones a Papervision3d material.
	 * 
	 * The papervision3D MaterialObject3D class has a clone method, but because
	 * most of the derived materials classes don't override this with their own methods
	 * the clone method doesn't usually work.
	 * 
	 * Hopefully, one day, the PV3D material classes will correctly implement cloning
	 * and we can drop this function from Flint.
	 */
	public function cloneMaterial( material:MaterialObject3D ):MaterialObject3D
	{
		if( material is MovieAssetParticleMaterial )
		{
			// this one's difficult because the asset's linkageid is private
		}
		else if( material is BitmapParticleMaterial )
		{
			var bitmapParticleMaterial:BitmapParticleMaterial = new BitmapParticleMaterial( material.bitmap );
			bitmapParticleMaterial.copy( material );
			return bitmapParticleMaterial;
		}
		else if( material is ParticleMaterial )
		{
			var particleMaterial:ParticleMaterial = new ParticleMaterial( material.fillColor, material.fillAlpha, ParticleMaterial( material ).shape );
			particleMaterial.copy( material );
			return particleMaterial;
		}
		else if( material is LineMaterial )
		{
			var lineMaterial:LineMaterial = new LineMaterial();
			lineMaterial.copy( material );
			return lineMaterial;
		}
		else if( material is CellMaterial )
		{
		}
		else if( material is PhongMaterial )
		{
		}
		else if( material is EnvMapMaterial )
		{
		}
		else if( material is GouraudMaterial )
		{
		}
		else if( material is AbstractSmoothShadeMaterial )
		{
		}
		else if( material is FlatShadeMaterial )
		{
		}
		else if( material is AbstractLightShadeMaterial )
		{
		}
		else if( material is BitmapAssetMaterial )
		{
		}
		else if( material is BitmapColorMaterial )
		{
		}
		else if( material is BitmapFileMaterial )
		{
		}
		else if( material is BitmapViewportMaterial )
		{
		}
		else if( material is MovieAssetMaterial )
		{
		}
		else if( material is VideoStreamMaterial )
		{
		}
		else if( material is MovieMaterial )
		{
		}
		else if( material is BitmapMaterial )
		{
		}
		else if( material is BitmapWireframeMaterial )
		{
		}
		else if( material is ColorMaterial )
		{
			var colorMaterial:ColorMaterial = new ColorMaterial();
			colorMaterial.copy( material );
			return colorMaterial;
		}
		else if( material is CompositeMaterial )
		{
		}
		else if( material is ShadedMaterial )
		{
		}
		else if( material is WireframeMaterial )
		{
		}
		// MaterialObject3D
		return material.clone();
	}
}
