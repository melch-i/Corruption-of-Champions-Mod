﻿package classes.Scenes.Areas.Mountain
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class HellHound extends Monster
	{
		protected function hellhoundFire():void {
			//Blind dodge change
			if(hasStatusEffect(StatusEffects.Blind)) {
				outputText(capitalA + short + " completely misses you with a wave of dark fire! Thank the gods it's blind!");
				return;
			}
			/*if(player.hasStatusEffect(StatusEffects.Web_dash_Silence) >= 0) {
				outputText("You reach inside yourself to breathe flames, but as you ready to release a torrent of fire, it backs up in your throat, blocked by the webbing across your mouth.  It causes you to cry out as the sudden, heated force explodes in your own throat.\n");
				changeFatigue(10);
				takeMagicDamage(10+rand(20));
				enemyAI();
				return;
			}*/
			if(player.hasPerk(PerkLib.Evade) && player.spe >= 35 && rand(3) != 0) {
				outputText("Both the hellhound's heads breathe in deeply before blasting a wave of dark fire at you.  You easily avoid the wave, diving to the side and making the most of your talents at evasion.");
			}
			else if(player.hasPerk(PerkLib.Misdirection) && rand(100) < 20 && player.armorName == "red, high-society bodysuit") {
				outputText("Using Raphael's teachings and the movement afforded by your bodysuit, you anticipate and sidestep " + a + short + "'s fire.\n");
			}
			else if(player.hasPerk(PerkLib.Flexibility) && player.spe > 30 && rand(10) != 0) {
				outputText("Both the hellhound's heads breathe in deeply before blasting a wave of dark fire at you.  You twist and drop with incredible flexibility, watching the fire blow harmlessly overhead.");
			}
			else {
				//Determine the damage to be taken
				var temp:Number = 15 + rand(10);
				if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) temp *= 3;
				if (player.hasPerk(PerkLib.FireAffinity)) temp *= 0.3;
				temp = Math.round(temp);
				if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				player.addStatusValue(StatusEffects.Blizzard,1,-1);
				temp *= 0.2;
				outputText("Both the hellhound's heads breathe in deeply before blasting a wave of dark fire at you. While the flames don't burn much due to protection of blizzard, the unnatural heat fills your body with arousal. ");
				}
				else {
				outputText("Both the hellhound's heads breathe in deeply before blasting a wave of dark fire at you. While the flames don't burn much, the unnatural heat fills your body with arousal. ");
				}
				temp = Math.round(temp);
				player.takeMagicDamage(temp, true);
				player.dynStats("lus", 20+(player.sens/10));
				statScreenRefresh();
				if(player.HP <= 0) {
					doNext(SceneLib.combat.endHpLoss);
					return;
				}
				if(player.lust >= player.maxLust()) {
					doNext(SceneLib.combat.endLustLoss);
					return;
				}
			}
			doNext(EventParser.playerMenu);
		}
		protected function hellhoundScent():void {
			if(player.hasStatusEffect(StatusEffects.NoFlee)) {
				if(spe == 100) {
					hellhoundFire();
					return;
				}
				else {
					outputText("The hellhound sniffs your scent again, seemingly gaining more and more energy as he circles faster around you.");
					spe = 100;	
				}
			}
			else {
				spe += 40;
				outputText("The hellhound keeps his four eyes on you as he sniffs the ground where you were moments ago. He raises his heads back up and gives you a fiery grin - he seems to have acquired your scent!  It'll be hard to get away now...");
				player.createStatusEffect(StatusEffects.NoFlee,0,0,0,0);
			}
			/*if(spe >= 80) {
				if(spe == 100) {
					hellhoundFire();
					return;
				}
				else {
					outputText("The hellhound sniffs your scent again, seemingly gaining more and more energy as he circles faster around you.");
					spe = 100;	
				}
			}
			else {
				spe += 40;
				outputText("The hellhound keeps his four eyes on you as he sniffs the ground where you were moments ago. He raises his heads back up and gives you a firey grin - He seems to have aquired you scent!  Running away will now be much more difficult...");
			}
			if(player.HP <= 0) {
				doNext(endHpLoss);
				return;
			}
			if(player.lust > player.maxLust()) {
				doNext(endLustLoss);
				return;
			}
			doNext(1);*/
		}
		

		override public function defeated(hpVictory:Boolean):void
		{
			if (hpVictory) {
				outputText("The hellhound's flames dim and the heads let out a whine before the creature slumps down, defeated and nearly unconscious.", true);
				//Rape if not naga, turned on, and girl that can fit!
				if (player.hasVagina() && player.lust >= 33 && !player.isNaga()) {
					outputText("  You find yourself musing that you could probably take advantage of the poor 'doggy'.  Do you fuck it?");
					EngineCore.simpleChoices("Fuck it", SceneLib.mountain.hellHoundScene.hellHoundPropahRape, "", null, "", null, "", null, "Leave", SceneLib.combat.cleanupAfterCombatImpl);
				} else {
					SceneLib.combat.cleanupAfterCombatImpl();
				}
			} else {
				outputText("Unable to bear hurting you anymore, the hellhound's flames dim as he stops his attack. The two heads look at you, whining plaintively.  The hellhound slowly pads over to you and nudges its noses at your crotch.  It seems he wishes to pleasure you.\n\n", true);
				var temp2:Function =null;
				if (player.gender > 0 && player.lust >= 33) {
					outputText("You realize your desires aren't quite sated.  You could let it please you");
					//Rape if not naga, turned on, and girl that can fit!
					if (player.hasVagina() && player.lust >= 33 && !player.isNaga()) {
						outputText(" or make it fuck you");
						temp2 = SceneLib.mountain.hellHoundScene.hellHoundPropahRape;
					}
					outputText(".  What do you do?");
					EngineCore.simpleChoices("Lick", SceneLib.mountain.hellHoundScene.hellHoundGetsRaped, "Fuck", temp2, "", null, "", null, "Leave", SceneLib.combat.cleanupAfterCombatImpl);
				}
				else {
					outputText("You turn away, not really turned on enough to be interested in such an offer.");
					SceneLib.combat.cleanupAfterCombatImpl();
				}
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nThe hellhound snorts and leaves you to your fate.");
				doNext(SceneLib.combat.cleanupAfterCombatImpl);
			} else {
				SceneLib.mountain.hellHoundScene.hellhoundRapesPlayer();
			}
		}

		public function HellHound(noInit:Boolean=false)
		{
			if (noInit) return;
			trace("HellHound Constructor!");
			this.a = "the ";
			this.short = "hellhound";
			this.imageName = "hellhound";
			this.long = "It looks like a large demon on all fours with two heads placed side-by-side. The heads are shaped almost like human heads, but they have dog ears on the top and have a long dog snout coming out where their mouths and noses would be.  Its eyes and mouth are filled with flames and its hind legs capped with dog paws, but its front ones almost look like human hands.  Its limbs end in large, menacing claws. A thick layer of dark fur covers his entire body like armor.  Both heads look at you hungrily as the hellhound circles around you. You get the feeling that reasoning with this beast will be impossible.";
			// this.plural = false;
			this.createCock(8,2,CockTypesEnum.DOG);
			this.createCock(8,2,CockTypesEnum.DOG);
			this.balls = 2;
			this.ballSize = 4;
			this.cumMultiplier = 5;
			// this.hoursSinceCum = 0;
			this.createBreastRow();
			this.createBreastRow();
			this.createBreastRow();
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 47;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE + 1;
			this.lowerBody = LowerBody.DOG;
			this.skin.growFur({color:"black"});
			this.hairColor = "red";
			this.hairLength = 3;
			initStrTouSpeInte(64, 64, 50, 1);
			initWisLibSensCor(1, 95, 20, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 10;
			this.armorName = "thick fur";
			this.armorDef = 7;
			this.bonusLust = 10;
			this.lust = 25;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 10;
			this.gems = 15+rand(12);
			this.drop = new WeightedDrop().add(consumables.CANINEP, 3)
					.addMany(1, consumables.BULBYPP,
							consumables.KNOTTYP,
							consumables.BLACKPP,
							consumables.DBLPEPP,
							consumables.LARGEPP);
			this.tailType = Tail.DOG;
			this.special1 = hellhoundFire;
			this.special2 = hellhoundScent;
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

	

}
