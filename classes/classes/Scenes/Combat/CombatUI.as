/**
 * Coded by aimozg on 27.09.2017.
 */
package classes.Scenes.Combat {
import classes.BodyParts.Face;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;
import classes.Scenes.Areas.Desert.SandTrap;
import classes.Scenes.Areas.Forest.Alraune;
import classes.Scenes.Areas.HighMountains.Izumi;
import classes.Scenes.Dungeons.D3.DriderIncubus;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.Scenes.Dungeons.D3.SuccubusGardener;
import classes.Scenes.NPCs.Ceraph;
import classes.Scenes.SceneLib;
import classes.StatusEffectClass;
import classes.StatusEffects;

import coc.view.ButtonDataList;
import coc.view.CoCButton;

public class CombatUI extends BaseCombatContent {
	
	public function CombatUI() {
	}
	
	private var magspButtons:ButtonDataList = new ButtonDataList();
	private var physpButtons:ButtonDataList = new ButtonDataList();
	private var spellButtons:ButtonDataList = new ButtonDataList();
	private var kiButtons:ButtonDataList = new ButtonDataList();
	private var otherButtons:ButtonDataList = new ButtonDataList();
	public function mainMenu():void {
		menu();
		magspButtons.clear();
		physpButtons.clear();
		spellButtons.clear();
		kiButtons.clear();
		otherButtons.clear();
		
		var btnMelee:CoCButton      = button(0);
		var btnRanged:CoCButton     = button(1);
		var btnTease:CoCButton      = button(2);
		var btnWait:CoCButton       = button(3);
		var btnItems:CoCButton      = button(4);
		var btnPSpecials:CoCButton  = button(5);
		var btnMSpecials:CoCButton  = button(6);
		var btnMagic:CoCButton      = button(7);
		var btnKiPowers:CoCButton = button(8);
		var btnOther:CoCButton      = button(9);
		var btnSpecial1:CoCButton   = button(10);
		var btnSpecial2:CoCButton   = button(11);
		var btnSpecial3:CoCButton   = button(12);
		var btnFantasize:CoCButton  = button(13);
		var btnRun:CoCButton        = button(14);
		/*
		 0 [ Melee ] [ Range ] [ Tease ] [  Wait   ] [ Items ]
		 5 ability groups
		10 [   ?   ] [   ?   ] [   ?   ] [Fantasize] [  Run  ]
		 */
		
		//Standard menu before modifications.
		if (flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 2) {
			btnMelee.show("E.Attack", combat.baseelementalattacks, "Command your elemental to attack the enemy.  Damage it will deal is affcted by your wisdom and intelligence.");
		} else {
			btnMelee.show("Attack", combat.attack, "Attempt to attack the enemy with your "+player.weaponName+".  Damage done is determined by your strength and weapon.");
			if (!player.isFlying() && monster.isFlying() && player.weapon != weapons.FRTAXE) {
				btnMelee.disable("No way you could reach enemy in air with melee attacks.");
			} else if (player.isFlying()) {
				if (player.weapon != weapons.SPEAR && player.weapon != weapons.LANCE && player.weapon != weapons.FRTAXE) {
					btnMelee.disable("No way you could reach enemy with melee attacks while flying.");
				}
				else if (player.wings.type == Wings.BAT_ARM) {
					btnMelee.disable("No way you could use your melee weapon with those arms while flying.");
				}
			} else if (player.hasStatusEffect(StatusEffects.KnockedBack)) {
				outputText("\n<b>You'll need to close some distance before you can use any physical attacks!</b>");
			}
			if(player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 11){
				btnMelee.disable("You are currently unable to attack");
			}
		}
		// Ranged
		switch (player.weaponRangePerk) {
			case "Bow":
				btnRanged.show("Bow", combat.fireBow, "Attempt to attack the enemy with your " + player.weaponRangeName + ".  Damage done is determined by your speed and weapon.");
				break;
			case "Crossbow":
				btnRanged.show("Crossbow", combat.fireBow, "Attempt to attack the enemy with your " + player.weaponRangeName + ".  Damage done is determined only by your weapon.");
				break;
			case "Throwing":
                btnRanged.show("Throw", combat.fireBow, "Attempt to throw " + player.weaponRangeName + " at enemy.  Damage done is determined by your strength and weapon.");
                if ( player.ammo <= 0 && player.weaponRange != weaponsrange.SHUNHAR) btnRanged.disable("You have used all your throwing weapons in this fight.");
				break;
			case "Pistol":
			case "Rifle":
                if (player.ammo <= 0)
                    btnRanged.show("Reload", combat.reloadWeapon, "Your " + player.weaponRangeName + " is out of ammo.  You'll have to reload it before attack.");
                else btnRanged.show("Shoot", combat.fireBow, "Fire a round at your opponent with your " + player.weaponRangeName + "!  Damage done is determined only by your weapon.");
				break;
			default:
				btnRanged.showDisabled("Shoot");
		}
		if(player.isFlying() && player.wings.type == Wings.BAT_ARM){btnRanged.disable("It would be rather difficult to aim while flapping your arms.");}
		btnItems.show("Items", inventory.inventoryMenu, "The inventory allows you to use an item.  Be careful as this leaves you open to a counterattack when in combat.");
		
		// Submenus
		
		// Submenu - Physical Specials
		if (player.isFlying()) combat.pspecials.buildMenuForFlying(physpButtons);
		else combat.pspecials.buildMenu(physpButtons);
		if (physpButtons.length > 0) btnPSpecials.show("P. Specials", submenuPhySpecials, "Physical special attack menu.", "Physical Specials");
		if (!player.isFlying() && monster.isFlying() && !player.canFly()) {
			btnPSpecials.disable("No way you could reach enemy in air with p. specials.");
		}
		// Submenu - Magical Specials
		combat.mspecials.buildMenu(magspButtons);
		if (magspButtons.length > 0) btnMSpecials.show("M. Specials", submenuMagSpecials, "Mental and supernatural special attack menu.", "Magical Specials");
		if (combat.isPlayerSilenced()) {
			btnMSpecials.disable();
		}
		// Submenu - Spells
		combat.magic.buildMenu(spellButtons);
		if (spellButtons.length > 0) btnMagic.show("Spells", submenuSpells, "Opens your spells menu, where you can cast any spells you have learned.", "Spells");
		if (player.hasStatusEffect(StatusEffects.OniRampage)) {
			btnMagic.disable("You are too angry to think straight. Smash your puny opponents first and think later.\n\n");
		} else if (!combat.canUseMagic()) {
			btnMagic.disable();
		}
		// Submenu - KiPowers
		combat.kiPowers.buildMenu(kiButtons);
		if (kiButtons.length > 0) btnKiPowers.show("Ki", submenuKi, "Ki attacks menu.", "Ki Specials");
		// Submenu - Other
		combat.buildOtherActions(otherButtons);
		if (otherButtons.length > 0) btnOther.show("Other", submenuOther, "Combat options and uncategorized actions");
		
		btnFantasize.show("Fantasize", combat.fantasize, "Fantasize about your opponent in a sexual way.  Its probably a pretty bad idea to do this unless you want to end up getting raped.");
		btnTease.show("Tease", combat.teaseAttack, "Attempt to make an enemy more aroused by striking a seductive pose and exposing parts of your body.");
		btnWait.show("Wait", combat.wait, "Take no action for this round.  Why would you do this?  This is a terrible idea.");
		btnRun.show("Run", combat.runAway, "Choosing to run will let you try to escape from your enemy. However, it will be hard to escape enemies that are faster than you and if you fail, your enemy will get a free attack.");
		
		// Modifications - full or partial replacements
		if (isPlayerBound()) {
			mainMenuWhenBound();
		} else if (isPlayerStunned()) {
			menu();
			addButton(0, "Recover", combat.wait);
		} else if (player.hasStatusEffect(StatusEffects.ChanneledAttack)) {
			mainMenuWhenChanneling();
		} else if (player.hasStatusEffect(StatusEffects.KnockedBack)) {
			if (player.ammo <= 0 && (player.weaponRangeName == "flintlock pistol" || player.weaponRangeName == "blunderbuss rifle")){
				btnMelee.show("Reload&Approach", combat.approachAfterKnockback1, "Reload your range weapon while approaching.", "Reload and Approach");
			} else if (player.ammo > 0 && (player.weaponRangeName == "flintlock pistol" || player.weaponRangeName == "blunderbuss rifle")) {
				btnMelee.show("Shoot&Approach", combat.approachAfterKnockback2, "Fire a round at your opponent and approach.", "Fire and Approach");
			} else {
				btnMelee.show("Approach", combat.approachAfterKnockback3, "Close some distance between you and your opponent.");
			}
		} else if (monster.hasStatusEffect(StatusEffects.Constricted)) {
			menu();
			addButton(0, "Squeeze", SceneLib.desert.nagaScene.naggaSqueeze).hint("Squeeze some HP out of your opponent! \n\nFatigue Cost: " + physicalCost(20) + "");
			addButton(1, "Tease", SceneLib.desert.nagaScene.naggaTease);
			addButton(4, "Release", SceneLib.desert.nagaScene.nagaLeggoMyEggo);
		} else if (monster.hasStatusEffect(StatusEffects.ConstrictedScylla)) {
			menu();
			addButton(0, "Squeeze", combat.ScyllaSqueeze);
			if (monster.plural) {
				button(0).hint("Squeeze your foes with your tentacles attempting to break them appart! \n\nFatigue Cost: " + physicalCost(50) + "");
			} else {
				button(0).hint("Squeeze your foe with your tentacle attempting to break it appart! \n\nFatigue Cost: " + physicalCost(20) + "");
			}
			addButton(1, "Tease", combat.ScyllaTease).hint("Use a free limb to caress and pleasure your grappled foe. \n\nFatigue Cost: " + physicalCost(20) + "");
			addButton(4, "Release", combat.ScyllaLeggoMyEggo);
		} else if (monster.hasStatusEffect(StatusEffects.GooEngulf)) {
			menu();
			addButton(0, "Tease", combat.GooTease).hint("Mold limb to caress and pleasure your grappled foe. \n\nFatigue Cost: " + physicalCost(20) + "");
			addButton(4, "Release", combat.GooLeggoMyEggo);
		} else if (monster.hasStatusEffect(StatusEffects.EmbraceVampire)) {
			menu();
			if (player.faceType == Face.VAMPIRE) {
				addButton(0, "Bite", combat.VampiricBite).hint("Suck on the blood of an opponent. \n\nFatigue Cost: " + physicalCost(20) + "");
				if (player.fatigueLeft() <= combat.physicalCost(20)) {
					button(0).disable("You are too tired to bite " + monster.a + " " + monster.short + ".");
				}
			}
			else addButtonDisabled(0, "Bite", "If only you had fangs.");
			addButton(4, "Release", combat.VampireLeggoMyEggo);
		} else if (monster.hasStatusEffect(StatusEffects.Pounce)) {
			menu();
			addButton(0, "Claws", combat.clawsRend).hint("Rend your enemy using your claws. \n\nFatigue Cost: " + physicalCost(20) + "");
			if (player.fatigueLeft() <= combat.physicalCost(20)) {
				button(0).disable("You are too tired to bite " + monster.a + " " + monster.short + ".");
			}
			//addButton(4, "Release", combat.PussyLeggoMyEggo);
		} else if (player.hasPerk(PerkLib.FirstAttackElementals) && flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 3 && flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] != 1) {
			menu();
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsAir)) addButton(0, "Air", combat.baseelementalattacks, Combat.AIR);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarth)) addButton(1, "Earth", combat.baseelementalattacks, Combat.EARTH);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsFire)) addButton(2, "Fire", combat.baseelementalattacks, Combat.FIRE);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsWater)) addButton(3, "Water", combat.baseelementalattacks, Combat.WATER);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsEther)) addButton(4, "Ether", combat.baseelementalattacks, Combat.ETHER);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsWood)) addButton(5, "Wood", combat.baseelementalattacks, Combat.WOOD);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsMetal)) addButton(6, "Metal", combat.baseelementalattacks, Combat.METAL);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsIce)) addButton(7, "Ice", combat.baseelementalattacks, Combat.ICE);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsLightning)) addButton(8, "Lightning", combat.baseelementalattacks, Combat.LIGHTNING);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsDarkness)) addButton(9, "Darkness", combat.baseelementalattacks, Combat.DARKNESS);
		}
		
		// Modifications - monster-special actions
		if (monster is SandTrap) {
			btnSpecial1.show("Climb", (monster as SandTrap).sandTrapWait, "Climb the sand to move away from the sand trap.");
		} else if (monster is Alraune) {
			if (player.fatigueLeft() < 50) btnSpecial1.disable("You're too tired to struggle.");
			else btnSpecial1.show("Struggle", (monster as Alraune).alrauneWait, "Struggle to forcefully pull yourself a good distance away from plant woman.");
		} else if (monster is DriderIncubus) {
			var drider:DriderIncubus = monster as DriderIncubus;
			if (!drider.goblinFree) btnSpecial1.show("Free Goblin", drider.freeGoblin);
		} else if (monster is Lethice) {
			var lethice:Lethice = monster as Lethice;
			if (player.hasStatusEffect(StatusEffects.LethicesRapeTentacles)) {
				if (player.lust < combat.magic.getWhiteMagicLustCap()
					&& player.hasStatusEffect(StatusEffects.KnowsWhitefire)
					&& !player.hasPerk(PerkLib.BloodMage)
					&& player.mana >= 30) {
					btnSpecial1.show("Dispell", lethice.dispellRapetacles);
				}
			}
		}
	}
	
	internal function mainMenuWhenBound():void {
		menu();
		var btnStruggle:CoCButton  = addButton(0, "Struggle", combat.struggle);
		var btnBoundWait:CoCButton = addButton(1, "Wait", combat.wait);
		if (player.hasStatusEffect(StatusEffects.UBERWEB)) {
			addButton(6, "M. Special", submenuMagSpecials);
		}
		if (player.hasStatusEffect(StatusEffects.Bound)) {
			btnStruggle.call((monster as Ceraph).ceraphBindingStruggle);
			btnBoundWait.call((monster as Ceraph).ceraphBoundWait);
		}
		if (player.hasStatusEffect(StatusEffects.Chokeslam)) {
			btnStruggle.call((monster as Izumi).chokeSlamStruggle);
			btnBoundWait.call((monster as Izumi).chokeSlamWait);
		}
		if (player.hasStatusEffect(StatusEffects.Titsmother)) {
			btnStruggle.call((monster as Izumi).titSmotherStruggle);
			btnBoundWait.call((monster as Izumi).titSmotherWait);
		}
		if (player.hasStatusEffect(StatusEffects.Tentagrappled)) {
			btnStruggle.call((monster as SuccubusGardener).grappleStruggle);
			btnBoundWait.call((monster as SuccubusGardener).grappleWait);
		}
		if (player.hasStatusEffect(StatusEffects.LethicesRapeTentacles) && player.statusEffectv3(StatusEffects.LethicesRapeTentacles) == 1) {
			outputText("\n<b>Lethice's tentacles have a firm grip of your limbs!</b>");
			addButton(0, "Struggle", (monster as Lethice).grappleStruggle);
			addButton(1, "Wait", (monster as Lethice).grappleWait);
			
			var whitefireLustCap:int = player.maxLust() * 0.75;
			if (player.hasPerk(PerkLib.Enlightened) && player.cor < (10 + player.corruptionTolerance())) whitefireLustCap += (player.maxLust() * 0.1);
			var gotEnergy:Boolean = !player.hasPerk(PerkLib.BloodMage) && player.mana >= 30;
			if (player.lust < whitefireLustCap && player.hasStatusEffect(StatusEffects.KnowsWhitefire) && gotEnergy) {
				addButton(2, "Dispell", (monster as Lethice).dispellRapetacles);
			}
		}
	}
	
	internal function mainMenuWhenChanneling():void {
		menu();
		var chatk:StatusEffectClass  = player.statusEffectByType(StatusEffects.ChanneledAttack);
		var chtype:StatusEffectClass = player.statusEffectByType(StatusEffects.ChanneledAttackType);
		var btnContinue:CoCButton    = button(0);
		var btnStop:CoCButton        = button(1);
		btnStop.show("Stop", combat.stopChanneledSpecial, "Stop channeling.");
		if (chatk && chatk.value1 >= 1) {
			if (!isPlayerBound() && !isPlayerSilenced() && !isPlayerStunned()) {
				switch (chtype.value1) {
					case 1:
						btnContinue.show("Continue", combat.mspecials.singCompellingAria, "Continue singing.");
						break;
					case 2:
						btnContinue.show("Continue", combat.mspecials.startOniRampage, "Continue starting rampage.");
						break;
					case 3:
						btnContinue.show("Continue", combat.mspecials.OrgasmicLightningStrike, "Continue masturbating.");
						break;
				}
			}
		}
	}
	internal function submenuMagSpecials():void {
		if (inCombat && player.hasStatusEffect(StatusEffects.Sealed) && (player.statusEffectv2(StatusEffects.Sealed) == 6 || player.statusEffectv2(StatusEffects.Sealed) == 10)) {
			clearOutput();
			if (player.statusEffectv2(StatusEffects.Sealed) == 6) outputText("You try to ready a special ability, but wind up stumbling dizzily instead.  <b>Your ability to use magical special attacks was sealed, and now you've wasted a chance to attack!</b>\n\n");
			if (player.statusEffectv2(StatusEffects.Sealed) == 10) outputText("You try to use a magical ability but you are currently silenced by the alraune vines!\n\n");
			enemyAI();
			return;
		}
		magspButtons.submenu(mainMenu);
	}
	internal function submenuPhySpecials():void {
		if (inCombat && player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 5) {
			clearOutput();
			outputText("You try to ready a special attack, but wind up stumbling dizzily instead.  <b>Your ability to use physical special attacks was sealed, and now you've wasted a chance to attack!</b>\n\n");
			enemyAI();
			return;
		}
		if (player.hasStatusEffect(StatusEffects.TaintedMind)) {
			(monster as DriderIncubus).taintedMindAttackAttempt();
			return;
		}
		physpButtons.submenu(mainMenu);
	}
	internal function submenuSpells():void {
		if (inCombat && player.hasStatusEffect(StatusEffects.Sealed) && (player.statusEffectv2(StatusEffects.Sealed) == 2 || player.statusEffectv2(StatusEffects.Sealed) == 10)) {
			clearOutput();
			if (player.statusEffectv2(StatusEffects.Sealed) == 2) outputText("You reach for your magic, but you just can't manage the focus necessary.  <b>Your ability to use magic was sealed, and now you've wasted a chance to attack!</b>\n\n");
			if (player.statusEffectv2(StatusEffects.Sealed) == 10) outputText("You try to use magic but you are currently silenced by the alraune vines!\n\n");
			enemyAI();
			return;
		}
		spellButtons.submenu(mainMenu);
	}
	internal function submenuKi():void {
		//if (inCombat && player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 5) {
		//clearOutput();
		//outputText("You try to ready a special attack, but wind up stumbling dizzily instead.  <b>Your ability to use physical special attacks was sealed, and now you've wasted a chance to attack!</b>\n\n");
		//enemyAI();
		//return;
		//}
		kiButtons.submenu(mainMenu);
	}
	internal function submenuOther():void {
		otherButtons.submenu(mainMenu);
	}
}
}
