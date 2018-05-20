package classes.Scenes.Areas.Forest
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class TentacleBeast extends Monster
	{
		override public function handleWait():Object {
			if (player.hasStatusEffect(StatusEffects.TentacleBind)) {
				if (player.cocks.length > 0)
					outputText("The creature continues spiraling around your cock, sending shivers up and down your body. You must escape or this creature will overwhelm you!");
				else if (player.hasVagina())
					outputText("The creature continues sucking your clit and now has latched two more suckers on your nipples, amplifying your growing lust. You must escape or you will become a mere toy to this thing!");
				else outputText("The creature continues probing at your asshole and has now latched " + num2Text(player.totalNipples()) + " more suckers onto your nipples, amplifying your growing lust.  You must escape or you will become a mere toy to this thing!");
				player.takeLustDamage(8 + player.sens / 10);
				return true;
			}
			return super.handleWait();
		}

		override public function handleStruggle():Boolean {
			outputText("You struggle with all of your might to free yourself from the tentacles before the creature can fulfill whatever unholy desire it has for you.\n");
			//33% chance to break free + up to 50% chance for strength
			if (!(rand(3) == 0 || rand(80) < player.str / 2)) {
				outputText("Despite trying to escape, the creature only tightens its grip, making it difficult to breathe.\n\n");
				player.takePhysDamage(5);
				if (player.cocks.length > 0) {
					outputText("The creature continues spiraling around your cock, sending shivers up and down your body. You must escape or this creature will overwhelm you!");
				} else if (player.hasVagina()) {
					outputText("The creature continues sucking your clit and now has latched two more suckers on your nipples, amplifying your growing lust. You must escape or you will become a mere toy to this thing!");
				} else {
					outputText("The creature continues probing at your asshole and has now latched " + num2Text(player.totalNipples()) + " more suckers onto your nipples, amplifying your growing lust.  You must escape or you will become a mere toy to this thing!");
				}
				player.takeLustDamage(3 + player.sens / 10 + player.lib / 20);
				return true;
			}
			outputText("As the creature attempts to adjust your position in its grip, you free one of your [legs] and hit the beast in its beak, causing it to let out an inhuman cry and drop you to the ground smartly.\n\n");
			player.removeStatusEffect(StatusEffects.TentacleBind);
			createStatusEffect(StatusEffects.TentacleCoolDown, 3, 0, 0, 0);
			return false;
		}

		private function tentaclePhysicalAttack():void {
			outputText("The shambling horror throws its tentacles at you with a murderous force.\n");
			var temp:int = int((str + weaponAttack) - Math.random()*(player.tou) - player.armorDef);
			if(temp < 0) temp = 0;
			//Miss
			if(temp == 0 || (player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80)) {
				outputText("However, you quickly evade the clumsy efforts of the abomination to strike you.");
			}
			//Hit
			else {
				outputText("The tentacles crash upon your body mercilessly. ");
				player.takePhysDamage(temp, true);
			}
		}
		private function tentacleEntwine():void {
			outputText("The beast lunges its tentacles at you from all directions in an attempt to immobilize you.\n");
			//Not Trapped yet
			if(!player.hasStatusEffect(StatusEffects.TentacleBind)) {
				//Success
				if(int(Math.random()*(((player.spe)/2))) > 15 || (player.hasPerk(PerkLib.Evade) && int(Math.random()*(((player.spe)/2))) > 15)) {
					outputText("In an impressive display of gymnastics, you dodge, duck, dip, dive, and roll away from the shower of grab-happy arms trying to hold you. Your instincts tell you that this was a GOOD thing.\n");
				}
				//Fail
				else {
					outputText("While you attempt to avoid the onslaught of pseudopods, one catches you around your [foot] and drags you to the ground. You attempt to reach for it to pull it off only to have all of the other tentacles grab you in various places and immobilize you in the air. You are trapped and helpless!!!\n\n");
					//Male/Herm Version:
					if(player.hasCock()) outputText("The creature, having immobilized you, coils a long tendril about your penis. You shudder as the creature begins stroking your cock like a maid at a dairy farm in an attempt to provoke a response from you. Unable to resist, your [cock] easily becomes erect, signaling to the creature that you are responsive to harsher stimulation.\n");
					//Female Version:
					else if(player.hasVagina()) outputText("The creature quickly positions a long tentacle with a single sucker over your clitoris. You feel the power of the suction on you, and your body quickly heats up.  Your clit engorges, prompting the beast to latch the sucker onto your [clit].\n");
					//Genderless
					else outputText("The creature quickly positions a long tentacle against your " + Appearance.assholeDescript(player) + ". It circles your pucker with slow, delicate strokes that bring unexpected warmth to your body.\n");
					player.dynStats("lus", (8+player.sens/20));
					player.createStatusEffect(StatusEffects.TentacleBind,0,0,0,0);
				}
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if (hpVictory) {
				outputText("The creature lets out an ear-piercing screech as it collapses upon itself. Its green coloring quickly fades to brown as the life drains from it, leaving you victorious.", true);
				EngineCore.awardAchievement("Tentacle Beast Slayer", kACHIEVEMENTS.GENERAL_TENTACLE_BEAST_SLAYER);
			} else {
				outputText("The tentacle beast's mass begins quivering and sighing, the tentacles wrapping around each other and feverishly caressing each other.  It seems the beast has given up on fighting.");
			}
			if (hasStatusEffect(StatusEffects.PhyllaFight)) {
				removeStatusEffect(StatusEffects.PhyllaFight);
				SceneLib.desert.antsScene.phyllaTentacleDefeat();
			}
			else {
				if(!hpVictory && player.gender > 0 && flags[kFLAGS.SFW_MODE] <= 0) {
					outputText("  Perhaps you could use it to sate yourself?", true);
					EngineCore.doYesNo(SceneLib.forest.tentacleBeastScene.tentacleVictoryRape,cleanupAfterCombat);
				} else {
					cleanupAfterCombat();
				}
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (hpVictory) {
				outputText("Overcome by your wounds, you turn to make a last desperate attempt to run...\n\n");
				if (hasStatusEffect(StatusEffects.PhyllaFight)) {
					removeStatusEffect(StatusEffects.PhyllaFight);
					outputText("...and make it into the nearby tunnel.  ");
					SceneLib.desert.antsScene.phyllaTentaclePCLoss();
				} else
					SceneLib.forest.tentacleBeastScene.tentacleLossRape();
			} else {
				outputText("You give up on fighting, too aroused to resist any longer.  Shrugging, you walk into the writhing mass...\n\n");
				if(hasStatusEffect(StatusEffects.PhyllaFight)) {
					removeStatusEffect(StatusEffects.PhyllaFight);
					outputText("...but an insistent voice rouses you from your stupor.  You manage to run into a nearby tunnel.  ");
					SceneLib.desert.antsScene.phyllaTentaclePCLoss();
				} else
					doNext(SceneLib.forest.tentacleBeastScene.tentacleLossRape);
			}
		}

		override protected function performCombatAction():void
		{
			//tentacle beasts have special AI
			if (rand(2) == 0 || hasStatusEffect(StatusEffects.TentacleCoolDown))
				special1();
			else special2();
		}

		public function TentacleBeast()
		{
			trace("TentacleBeast Constructor!");
			this.a = "the ";
			this.short = "tentacle beast";
			this.imageName = "tentaclebeast";
			this.long = "You see the massive, shambling form of the tentacle beast before you.  Appearing as a large shrub, it shifts its bulbous mass and reveals a collection of thorny tendrils and cephalopodic limbs.";
			// this.plural = false;
			this.createCock(40,1.5);
			this.createCock(60,1.5);
			this.createCock(50,1.5);
			this.createCock(20,1.5);
			this.balls = 0;
			this.ballSize = 0;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			this.pronoun1 = "it";
			this.pronoun2 = "it";
			this.pronoun3 = "its";
			this.createBreastRow(0,0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(9) + 70;
			this.hips.type = Hips.RATING_BOYISH;
			this.butt.type = Butt.RATING_BUTTLESS;
			this.skin.setBaseOnly({color:"green"});
			this.skinDesc = "bark";
			this.hairColor = "green";
			this.hairLength = 1;
			initStrTouSpeInte(73, 90, 25, 45);
			initWisLibSensCor(40, 90, 20, 100);
			this.weaponName = "whip-tendril";
			this.weaponVerb="thorny tendril";
			this.weaponAttack = 10;
			this.armorName = "rubbery skin";
			this.armorDef = 18;
			this.bonusHP = 400;
			this.bonusLust = 20;
			this.lust = 10;
			this.lustVuln = 0.8;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 12;
			this.gems = rand(25)+10;
			this.drop = new WeightedDrop(null, 1);
			this.special1 = tentaclePhysicalAttack;
			this.special2 = tentacleEntwine;
			this.special3 = tentaclePhysicalAttack;
			this.tailType = Tail.DEMONIC;
			checkMonster();
		}

	}

}
