/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class DualBFSword extends Weapon {
		
		public function DualBFSword() {
			super("DBFSwo", "D.B.F.Sword", "dual big fucking swords", "a pair of big fucking swords", "slash", 50, 4000, "Big Fucking Swords - the best solution for a tiny e-pen complex at this side of the Mareth!  This pair of 2H 2,5 meters long swords requires 150 strength to fully unleash it power.", "Dual Large");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 150) boost += 20;
			if (game.player.str >= 100) boost += 15;
			if (game.player.str >= 50) boost += 10;
			return (5 + boost); 
		}
	}
}