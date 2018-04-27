/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;
	
	public class Electra extends Monster
	{
		public var electraScene:ElectraFollower = SceneLib.electraScene;
		
		public function moveLightningClaw():void {
			if (game.flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1) outputText("Electra");
			else outputText("The raiju");
			outputText(" rushes at you with a mad glare trying to hit you with her claws.");
			HitOrMiss();
			HitOrMiss();
		}
		private function HitOrMiss():void {
			outputText("\n\n");
			if (game.flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1) outputText("Electra");
			else outputText("The raiju");
			outputText(" attempt to strike you with her claw.");
			if (player.getEvasionRoll()) {
				outputText("\nThrowing yourself out of the way, you manage to avoid the strike.");
			}
			else {
				var damage:Number = 0;
				damage += eBaseStrengthDamage();
				var damageLust:Number = 0;
				damageLust += Math.round(this.lib / 20);
				outputText(" You are slashed for ");
				player.takePhysDamage(damage, true);
				player.dynStats("lus", damageLust, "scale", false);
				outputText(" damage. The lingering electricity on her claws leaves you aroused. <b>(<font color=\"#ff00ff\">" + damageLust + "</font>)</b> lust damage.");
			}
		}
		
		public function moveStaticDischarge():void {
			if (game.flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1) outputText("Electra");
			else outputText("The raiju");
			outputText(" touches you with her claw and you feel some of her electricity rush and course through your body slowly building your arousal. This is very bad; there is no telling how long you will be able to stand it.");
			if (player.hasStatusEffect(StatusEffects.RaijuStaticDischarge)) {
				outputText(" Her repeated touches increase the voltage!!!!");
				player.dynStats("lus", 8 + int(player.sens) / 8);
			}
			else {
				player.createStatusEffect(StatusEffects.RaijuStaticDischarge, 0, 0, 0, 0);
				player.dynStats("lus", 4 + int(player.sens) / 8);
			}
			outputText("\n\n");
		}
		
		public function moveMasturbate():void {
			if (game.flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1) outputText("Electra");
			else outputText("The raiju");
			var damageLust:Number = 0;
			damageLust += Math.round(this.lib / 10);
			player.dynStats("lus", damageLust, "scale", false);
			outputText(" gleefully fingers herself while looking at you with a half crazed look.\n\n");
			outputText("\"<i>Do you know... How frustrating it is to be dependant on someone else to achieve release? Ohhhh soon you will find out!</i>\"\n\n");
			outputText("The display left you aroused but likely she's preparing something. <b>(<font color=\"#ff00ff\">" + damageLust + "</font>)</b> lust damage.\n\n");
			lust += maxLust() * 0.2;
			createStatusEffect(StatusEffects.RaijuUltReady,0,0,0,0);
		}
		public function moveOrgasmicLightningBolt():void {
			if (game.flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1) outputText("Electra");
			else outputText("The raiju");
			outputText(" screams in pleasure as a bolt of lightning rush out of her pussy straight toward you.");
			if (player.getEvasionRoll()) {
				outputText(" Throwing yourself out of the way, you manage to avoid the bolt.");
			}
			else {
				var damageLust:Number = 0;
				damageLust += lust * 2;
				damageLust = Math.round(damageLust);
				player.dynStats("lus", damageLust, "scale", false);
				outputText(" You are zapped clean but instead of feeling pain, you feel intense electric pleasure coursing through your body as the Raiju shares some of her unbridled arousal. <b>(<font color=\"#ff00ff\">" + damageLust + "</font>)</b> lust damage.");
			}
			lust -= lust * 0.2;
			if (lust < 0) lust = 0;
			removeStatusEffect(StatusEffects.RaijuUltReady);
			createStatusEffect(StatusEffects.AbilityCooldown1,5,0,0,0);
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.RaijuUltReady) && !hasStatusEffect(StatusEffects.AbilityCooldown1)) {
				moveOrgasmicLightningBolt();
			}
			else {
				var choice:Number = rand(5);
				if (choice < 3) moveLightningClaw();
				if (choice == 3) moveStaticDischarge();
				if (choice == 4) {
					/*if (hasStatusEffect(StatusEffects.AbilityCooldown1)) {
						if (rand(2) == 0) moveLightningClaw();
						else moveStaticDischarge();
					}
					else */moveMasturbate();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			/*if (flags[kFLAGS.ETNA_FOLLOWER] >= 2) etnaScene.etnaRapeIntro2();
			else if (flags[kFLAGS.ETNA_AFFECTION] > 75) etnaScene.etnaReady2Come2Camp();
			else if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] < 1 && flags[kFLAGS.ETNA_AFFECTION] > 15) etnaScene.etnaRape3rdWin();
			else */electraScene.PlayerSexElectra();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			electraScene.ElectraSexPlayer();
		}
		
		public function Electra() 
		{
			if (game.flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1) {
				this.a = "";
				this.short = "Electra";
				this.long = "You are fighting Electra, a lightning imbued weasel morph. She is fiercely masturbating as she looks you from a distance and you have issues figuring whenever she is going to strike.";
			}
			else {
				this.a = "the ";
				this.short = "raiju";
				this.long = "You are fighting a Raiju, a lightning imbued weasel morph. She is fiercely masturbating as she looks you from a distance and you have issues figuring whenever she is going to strike.";
			}
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,60,0,0,0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = 72;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.skinTone = "light";
			this.hairColor = "blue";
			this.hairLength = 13;
			initStrTouSpeInte(60, 110, 100, 150);
			initWisLibSensCor(150, 220, 80, 80);
			this.weaponName = "claw";
			this.weaponVerb="claw-slash";
			this.weaponAttack = 12;
			this.armorName = "indecent spider silk robe";
			this.armorDef = 12;
			this.bonusHP = 100;
			this.bonusLust = 50;
			this.lust = 30;
			this.lustVuln = .8;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 30;
			this.gems = 500;
			this.drop = new ChainedDrop().
					add(armors.INDESSR,1/10).
					add(consumables.L_DRAFT,1/4).
					add(consumables.VOLTTOP,0.7);
			this.rearBody.type = RearBody.RAIJU_MANE;
			this.arms.type = Arms.RAIJU;
			this.lowerBody = LowerBody.RAIJU;
			this.tailType = Tail.RAIJU;
			this.tailRecharge = 0;
			//if (flags[kFLAGS.ETNA_FOLLOWER] > 1 || flags[kFLAGS.ETNA_TALKED_ABOUT_HER] > 1) this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}