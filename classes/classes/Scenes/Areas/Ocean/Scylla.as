/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Ocean 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.internals.*;

public class Scylla extends Monster
	{

		override public function handleWait():Object {
			if (player.hasStatusEffect(StatusEffects.ScyllaBind)) {
				outputText("You're being squeezed tightly by the scylla’s powerful tentacles. That's without mentioning the fact she's rubbing in your sensitive place quite a bit, giving you a knowing grin.");
				player.takeLustDamage(player.sens / 4 + 20);
				player.takePhysDamage(100 + rand(40));
				return true;
			}
			return super.handleWait();
		}

		override public function handleStruggle():Boolean {
			outputText("You struggle to get free from the [monster name] mighty tentacles. ");
			if (rand(3) == 0 || rand(120) < player.str / 1.5) {
				outputText("As force alone seems ineffective, you bite one of her tentacles and she screams in surprise, releasing you.");
				player.removeStatusEffect(StatusEffects.ScyllaBind);
			}
			else {
				outputText("Despite all of your struggle she manage to maintain her hold on you.");
				player.takeLustDamage(player.sens / 5 + 5);
				player.takePhysDamage(100 + rand(80));
			}
			return true;
		}

		public function scyllaConstrict():void {
			outputText("The " + this.short + "’s tentacles grab you all at once and start to squeeze you!");
			player.createStatusEffect(StatusEffects.ScyllaBind,0,0,0,0); 
			if (!player.hasPerk(PerkLib.Juggernaut) && armorPerk != "Heavy") {
				player.takePhysDamage(4+rand(6));
			}
		}
		
		public function scyllaInkSpray():void {
			clearOutput();
			outputText("The scylla stretches all her tentacles apart revealing a huge gaping pussy at the center which spray a cloud of ink all around you impairing your vision. ");
			player.createStatusEffect(StatusEffects.Blind, 2, 0, 0, 0);
		}
		
		public function scyllaTentacleSlap():void {
			clearOutput();
			var damage:Number = 0;
			damage += eBaseStrengthDamage() * 2;
			outputText("The scylla slaps you with her tentacles, dealing ");
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			outputText(" damage!");
		}
		public function scyllaTentacleSlap2():void {
			clearOutput();
			var damage:Number = 0;
			damage += eBaseStrengthDamage() * 2;
			outputText("The scylla slaps you with her tentacles, dealing ");
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			outputText(" damage!");
		}
		
		override protected function performCombatAction():void {
			var choice:Number = rand(6);
			if (choice < 3) {
				if (player.hasStatusEffect(StatusEffects.ScyllaBind)) scyllaTentacleSlap2();
				else scyllaTentacleSlap();
			}
			if (choice == 3 || choice == 4) {
				if (player.hasStatusEffect(StatusEffects.ScyllaBind)) scyllaTentacleSlap2();
				else scyllaConstrict();
			}
			if (choice == 5) {
				if (player.hasStatusEffect(StatusEffects.Blind) || player.hasStatusEffect(StatusEffects.ScyllaBind)) {
					if (player.hasStatusEffect(StatusEffects.ScyllaBind)) scyllaTentacleSlap2();
					else scyllaTentacleSlap();
				}
				else scyllaInkSpray();
			}
		}
		
		public function Scylla() 
		{
			this.a = "the ";
			this.short = "scylla";
			this.imageName = "scylla";
			this.long = "You are currently fighting 10 feet tall scylla.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 200, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 10*12;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_NOTICEABLE;
			this.lowerBody = LowerBody.SCYLLA;
			this.skin.setBaseOnly({color:"slippery"});
			this.hairColor = "brown";
			this.hairLength = 5;
			initStrTouSpeInte(350, 100, 100, 150);
			initWisLibSensCor(150, 100, 50, 50);
			this.weaponName = "tentacle";
			this.weaponVerb="slash";
			this.weaponAttack = 86;
			this.armorName = "thick skin";
			this.armorDef = 52;
			this.bonusHP = 5000;
			this.bonusLust = 20;
			this.lust = 20;
			this.lustVuln = .2;
			this.level = 70;
			this.gems = 0;
			this.drop = new WeightedDrop(consumables.BLACKIN, 1);
			this.createPerk(PerkLib.Tank, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}