package org.flintparticles.twoD.zones 
{
	import org.flintparticles.twoD.particles.Particle2D;		

	public interface InteractiveZone2D 
	{
		function collideParticle( particle:Particle2D, bounce:Number = 1 ):Boolean;
	}
}
