package classes.Scenes.Combat {
import classes.BaseContent;
import classes.BodyParts.Ears;
import classes.BodyParts.Face;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.CoC;
import classes.CoC_Settings;
import classes.EngineCore;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.ItemType;
import classes.Items.JewelryLib;
import classes.Items.ShieldLib;
import classes.Items.Weapon;
import classes.Items.WeaponLib;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Areas.Beach.Gorgon;
import classes.Scenes.Areas.Desert.Naga;
import classes.Scenes.Areas.Desert.SandTrap;
import classes.Scenes.Areas.Forest.Alraune;
import classes.Scenes.Areas.Forest.BeeGirl;
import classes.Scenes.Areas.Forest.Kitsune;
import classes.Scenes.Areas.GlacialRift.FrostGiant;
import classes.Scenes.Areas.GlacialRift.WinterWolf;
import classes.Scenes.Areas.HighMountains.Basilisk;
import classes.Scenes.Areas.HighMountains.Harpy;
import classes.Scenes.Areas.Mountain.Minotaur;
import classes.Scenes.Dungeons.D3.*;
import classes.Scenes.Dungeons.HelDungeon.HarpyMob;
import classes.Scenes.Dungeons.HelDungeon.HarpyQueen;
import classes.Scenes.NPCs.*;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.SceneLib;
import classes.StatusEffectClass;
import classes.StatusEffects;
import classes.StatusEffects.VampireThirstEffect;

import coc.view.ButtonData;
import coc.view.ButtonDataList;
import coc.view.MainView;

public class Combat extends BaseContent {
	public var pspecials:PhysicalSpecials  = new PhysicalSpecials();
	public var mspecials:MagicSpecials     = new MagicSpecials();
	public var magic:CombatMagic           = new CombatMagic();
	public var teases:CombatTeases         = new CombatTeases();
	public var kiPowers:CombatKiPowers = new CombatKiPowers();
	public var ui:CombatUI                 = new CombatUI();
	
	public static const AIR:int       = 1;
	public static const EARTH:int     = 2;
	public static const FIRE:int      = 3;
	public static const WATER:int     = 4;
	public static const ICE:int       = 5;
	public static const LIGHTNING:int = 6;
	public static const DARKNESS:int  = 7;
	public static const WOOD:int      = 8;
	public static const METAL:int     = 9;
	public static const ETHER:int     = 10;

	//Used to display image of the enemy while fighting
	//Set once during startCombat() to prevent it from changing every combat turn
	private var imageText:String = "";


	public static const ARROW:int = 1;
	public static const HPSPELL:int = 2;
	public static const LUSTSPELL:int = 3;
	public static const PHYSICAL:int = 4;
	private var _lastAttack:int = 0;

	public function get inCombat():Boolean {
        return CoC.instance.inCombat;
    }
	public function set inCombat(value:Boolean):void {
        CoC.instance.inCombat = value;
    }

	public function set lastAttack(value:int):void {
		_lastAttack = value;
	}

	public function get lastAttack():int {
		return _lastAttack;
	}

	public function physicalCost(mod:Number):Number {
		var costPercent:Number = 100;
		if(player.hasPerk(PerkLib.IronMan)) costPercent -= 50;
		mod *= costPercent/100;
		return mod;
	}
	public function bowCost(mod:Number):Number {
		var costPercent:Number = 100;
		if(player.hasPerk(PerkLib.BowShooting)) costPercent -= player.perkv1(PerkLib.BowShooting);
		//if(player.hasPerk(PerkLib.)) costPercent -= x0; ((tu umieścić perk dający zmniejszenie % kosztu użycia łuku jak IronMan dla fiz specjali ^^))
		mod *= costPercent/100;
		return mod;
	}
	public function maxTeaseLevel():Number {
		return teases.maxTeaseLevel();
	}
	public function spellCost(mod:Number):Number {
		return magic.spellCostImpl(mod);
	}
	public function spellCostWhite(mod:Number):Number {
		return magic.spellCostWhiteImpl(mod);
	}
	public function spellCostBlack(mod:Number):Number {
		return magic.spellCostBlackImpl(mod);
	}
	public function healCost(mod:Number):Number {
		return magic.healCostImpl(mod);
	}
	public function healCostWhite(mod:Number):Number {
		return magic.healCostWhiteImpl(mod);
	}
	public function healCostBlack(mod:Number):Number {
		return magic.healCostBlackImpl(mod);
	}
	public function spellMod():Number {
		return magic.spellModImpl();
	}
	public function spellModWhite():Number {
		return magic.spellModWhiteImpl();
	}
	public function spellModBlack():Number {
		return magic.spellModBlackImpl();
	}
	public function healMod():Number {
		return magic.healModImpl();
	}
	public function healModWhite():Number {
		return magic.healModWhiteImpl();
	}
	public function healModBlack():Number {
		return magic.healModBlackImpl();
	}
	public function maxFistAttacks():int {
		return 1;
	}
	public function maxClawsAttacks():int {
		return 1;
	}
	public function maxLargeAttacks():int {
		return 1;
	}
	public function maxCommonAttacks():int {
		return 1;
	}
	public function maxCurrentAttacks():int {
		return 1;
	}
	public function maxBowAttacks():int {
		if (player.hasPerk(PerkLib.Manyshot)) return 4;
		else return 1;
	}
	public function maxCrossbowAttacks():int {
		return 1;
	}
	public function maxThrowingAttacks():int {
		return 1;
	}
	public function maxCurrentRangeAttacks():int {
		if (player.weaponRangePerk == "Throwing") return maxThrowingAttacks();
		else if (player.weaponRangePerk == "Crossbow") return maxCrossbowAttacks();
		else if (player.weaponRangePerk == "Bow") return maxBowAttacks();
		else return 1;
	}
	
	public function PlayerHPRatio():Number{
		return player.HP/player.maxHP();
	}

	public function endHpVictory():void
{
	monster.defeated_(true);
}

public function endLustVictory():void
{
	monster.defeated_(false);
}

public function endHpLoss():void
{
	monster.won_(true,false);
}

public function endLustLoss():void
{
	if (player.hasStatusEffect(StatusEffects.Infested) && flags[kFLAGS.CAME_WORMS_AFTER_COMBAT] == 0) {
		flags[kFLAGS.CAME_WORMS_AFTER_COMBAT] = 1;
        SceneLib.mountain.wormsScene.infestOrgasm();
        monster.won_(false,true);
	} else {
		monster.won_(false,false);
	}
}

public function spellPerkUnlock():void {
		if(flags[kFLAGS.SPELLS_CAST] >= 10 && !player.hasPerk(PerkLib.SpellcastingAffinity)) {
			outputText("<b>You've become more comfortable with your spells, unlocking the Spellcasting Affinity perk and reducing mana cost of spells by 10%!</b>\n\n");
			player.createPerk(PerkLib.SpellcastingAffinity,10,0,0,0);
		}
		if(flags[kFLAGS.SPELLS_CAST] >= 30 && player.perkv1(PerkLib.SpellcastingAffinity) < 20) {
			outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 10%!</b>\n\n");
			player.setPerkValue(PerkLib.SpellcastingAffinity,1,20);
		}
		if(flags[kFLAGS.SPELLS_CAST] >= 70 && player.perkv1(PerkLib.SpellcastingAffinity) < 30) {
			outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 10%!</b>\n\n");
			player.setPerkValue(PerkLib.SpellcastingAffinity,1,30);
		}
		if(flags[kFLAGS.SPELLS_CAST] >= 150 && player.perkv1(PerkLib.SpellcastingAffinity) < 40) {
			outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 10%!</b>\n\n");
			player.setPerkValue(PerkLib.SpellcastingAffinity,1,40);
		}
		if(flags[kFLAGS.SPELLS_CAST] >= 310 && player.perkv1(PerkLib.SpellcastingAffinity) < 50) {
			outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 10%!</b>\n\n");
			player.setPerkValue(PerkLib.SpellcastingAffinity,1,50);
		}
	}
//combat is over. Clear shit out and go to main
public function cleanupAfterCombatImpl(nextFunc:Function = null):void {
	magic.cleanupAfterCombatImpl();
	if (nextFunc == null) nextFunc = camp.returnToCampUseOneHour;
	if (prison.inPrison && prison.prisonCombatWinEvent != null) nextFunc = prison.prisonCombatWinEvent;
	if (inCombat) {
		//clear status
		clearStatuses(false);

		//reset the stored image for next monster
		imageText = "";

		//Clear itemswapping in case it hung somehow
//No longer used:		itemSwapping = false;
		//Player won
		if(monster.HP < 1 || monster.lust > monster.maxLust()) {
			awardPlayer(nextFunc);
		}
		//Player lost
		else {
			if(monster.statusEffectv1(StatusEffects.Sparring) == 2) {
				clearOutput();
				outputText("The cow-girl has defeated you in a practice fight!");
				outputText("\n\nYou have to lean on Isabella's shoulder while the two of your hike back to camp.  She clearly won.");
				inCombat = false;
				player.HP = 1;
				statScreenRefresh();
				doNext(nextFunc);
				return;
			}
			//Next button is handled within the minerva loss function
			if(monster.hasStatusEffect(StatusEffects.PeachLootLoss)) {
				inCombat = false;
				player.HP = 1;
				statScreenRefresh();
				return;
			}
			if(monster.short == "Ember") {
				inCombat = false;
				player.HP = 1;
				statScreenRefresh();
				doNext(nextFunc);
				return;
			}
			var gemsLost:int = rand(10) + 1 + Math.round(monster.level / 2);
			if (inDungeon) gemsLost += 20 + monster.level * 2;
			//Increases gems lost in NG+.
			gemsLost *= 1 + (player.newGamePlusMod() * 0.5);
			//Round gems.
			gemsLost = Math.round(gemsLost);
			//Keep gems from going below zero.
			if (gemsLost > player.gems) gemsLost = player.gems;
			var timePasses:int = monster.handleCombatLossText(inDungeon, gemsLost); //Allows monsters to customize the loss text and the amount of time lost
			player.gems -= gemsLost;
			inCombat = false;
			if (prison.inPrison == false && flags[kFLAGS.PRISON_CAPTURE_CHANCE] > 0 && rand(100) < flags[kFLAGS.PRISON_CAPTURE_CHANCE] && (prison.trainingFeed.prisonCaptorFeedingQuestTrainingIsTimeUp() || !prison.trainingFeed.prisonCaptorFeedingQuestTrainingExists()) && (monster.short == "goblin" || monster.short == "goblin assassin" || monster.short == "imp" || monster.short == "imp lord" || monster.short == "imp warlord" || monster.short == "hellhound" || monster.short == "minotaur" || monster.short == "satyr" || monster.short == "gnoll" || monster.short == "gnoll spear-thrower" || monster.short == "basilisk")) {
				outputText("  You feel yourself being dragged and carried just before you black out.");
				doNext(prison.prisonIntro);
				return;
			}
			//BUNUS XPZ
			if(flags[kFLAGS.COMBAT_BONUS_XP_VALUE] > 0) {
				player.XP += flags[kFLAGS.COMBAT_BONUS_XP_VALUE];
				outputText("  Somehow you managed to gain " + flags[kFLAGS.COMBAT_BONUS_XP_VALUE] + " XP from the situation.");
				flags[kFLAGS.COMBAT_BONUS_XP_VALUE] = 0;
			}
			//Bonus lewts
			if (flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] != "") {
				outputText("  Somehow you came away from the encounter with " + ItemType.lookupItem(flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID]).longName + ".\n\n");
				inventory.takeItem(ItemType.lookupItem(flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID]), createCallBackFunction(camp.returnToCamp, timePasses));
			}
			else doNext(createCallBackFunction(camp.returnToCamp, timePasses));
		}
	}
	//Not actually in combat
	else doNext(nextFunc);
}

public function checkAchievementDamage(damage:Number):void
{
	flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] += damage;
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 50000) EngineCore.awardAchievement("Bloodletter", kACHIEVEMENTS.COMBAT_BLOOD_LETTER);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 200000) EngineCore.awardAchievement("Reiterpallasch", kACHIEVEMENTS.COMBAT_REITERPALLASCH);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 1000000) EngineCore.awardAchievement("Uncanny Bloodletter", kACHIEVEMENTS.COMBAT_UNCANNY_BLOOD_LETTER);
	if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_TOTAL_DAMAGE] >= 5000000) EngineCore.awardAchievement("Uncanny Reiterpallasch", kACHIEVEMENTS.COMBAT_UNCANNY_REITERPALLASCH);
	if (damage >= 50) EngineCore.awardAchievement("Pain", kACHIEVEMENTS.COMBAT_PAIN);
	if (damage >= 100) EngineCore.awardAchievement("Fractured Limbs", kACHIEVEMENTS.COMBAT_FRACTURED_LIMBS);
	if (damage >= 250) EngineCore.awardAchievement("Broken Bones", kACHIEVEMENTS.COMBAT_BROKEN_BONES);
	if (damage >= 500) EngineCore.awardAchievement("Overkill", kACHIEVEMENTS.COMBAT_OVERKILL);
	if (damage >= 1000) EngineCore.awardAchievement("Meat Pasty", kACHIEVEMENTS.COMBAT_MEAT_PASTY);
	if (damage >= 2500) EngineCore.awardAchievement("Pulverize", kACHIEVEMENTS.COMBAT_PULVERIZE);
	if (damage >= 5000) EngineCore.awardAchievement("Erase", kACHIEVEMENTS.COMBAT_ERASE);
}
public function approachAfterKnockback1():void
{
	clearOutput();
	outputText("You close the distance between you and [monster a] [monster name] as quickly as possible.\n\n");
	player.removeStatusEffect(StatusEffects.KnockedBack);
	if (player.weaponRangeName == "Ivory inlaid arquebus") player.ammo = 12;
	if (player.weaponRangeName == "blunderbuss rifle") player.ammo = 9;
	if (player.weaponRangeName == "flintlock pistol") player.ammo = 6;
	outputText("At the same time, you open the magazine of your ");
	if (player.weaponRangePerk == "Pistol") outputText("pistol");
	if (player.weaponRangePerk == "Rifle") outputText("rifle");
	outputText(" to reload the ammunition.");
	outputText("  This takes up a turn.\n\n");
	enemyAI();
}
public function approachAfterKnockback2():void
{
	clearOutput();
	outputText("You close the distance between you and [monster a] [monster name] as quickly as possible.\n\n");
	player.removeStatusEffect(StatusEffects.KnockedBack);
	outputText("At the same time, you fire a round at [monster name]. ");
	fireBow();
	return;
}
public function approachAfterKnockback3():void
{
	clearOutput();
	outputText("You close the distance between you and [monster a] [monster name] as quickly as possible.\n\n");
	player.removeStatusEffect(StatusEffects.KnockedBack);
	enemyAI();
	return;
}

public function isPlayerSilenced():Boolean
{
	var silenced:Boolean = false;
	if (player.hasStatusEffect(StatusEffects.ThroatPunch)) silenced = true;
	if (player.hasStatusEffect(StatusEffects.WebSilence)) silenced = true;
	if (player.hasStatusEffect(StatusEffects.GooArmorSilence)) silenced = true;
	return silenced;
}

public function isPlayerBound():Boolean
{
	var bound:Boolean = false;
	if (player.hasStatusEffect(StatusEffects.HarpyBind) || player.hasStatusEffect(StatusEffects.GooBind) || player.hasStatusEffect(StatusEffects.TentacleBind) || player.hasStatusEffect(StatusEffects.NagaBind) || player.hasStatusEffect(StatusEffects.ScyllaBind)
	 || player.hasStatusEffect(StatusEffects.WolfHold) || monster.hasStatusEffect(StatusEffects.QueenBind) || monster.hasStatusEffect(StatusEffects.PCTailTangle)) bound = true;
	if (player.hasStatusEffect(StatusEffects.HolliConstrict)) bound = true;
	if (player.hasStatusEffect(StatusEffects.GooArmorBind)) bound = true;
	if (monster.hasStatusEffect(StatusEffects.MinotaurEntangled)) {
		outputText("\n<b>You're bound up in the minotaur lord's chains!  All you can do is try to struggle free!</b>");
		bound = true;
	}
	if (player.hasStatusEffect(StatusEffects.UBERWEB)) bound = true;
	if (player.hasStatusEffect(StatusEffects.Bound)) bound = true;
	if (player.hasStatusEffect(StatusEffects.Chokeslam)) bound = true;
	if (player.hasStatusEffect(StatusEffects.Titsmother)) bound = true;
	if (player.hasStatusEffect(StatusEffects.GiantGrabbed)) {
		outputText("\n<b>You're trapped in the giant's hand!  All you can do is try to struggle free!</b>");
		bound = true;
	}
	if (player.hasStatusEffect(StatusEffects.Tentagrappled)) {
		outputText("\n<b>The demonesses tentacles are constricting your limbs!</b>");
		bound = true;
	}
	return bound;
}

public function isPlayerStunned():Boolean
{
	var stunned:Boolean = false;
	if (player.hasStatusEffect(StatusEffects.IsabellaStunned) || player.hasStatusEffect(StatusEffects.Stunned)) {
		outputText("\n<b>You're too stunned to attack!</b>  All you can do is wait and try to recover!");
		stunned = true;
	}
	if (player.hasStatusEffect(StatusEffects.Whispered)) {
		outputText("\n<b>Your mind is too addled to focus on combat!</b>  All you can do is try and recover!");
		stunned = true;
	}
	if (player.hasStatusEffect(StatusEffects.Confusion)) {
		outputText("\n<b>You're too confused</b> about who you are to try to attack!");
		stunned = true;
	}
	return stunned;
}

public function canUseMagic():Boolean {
	if (player.hasStatusEffect(StatusEffects.ThroatPunch)) return false;
	if (player.hasStatusEffect(StatusEffects.WebSilence)) return false;
	if (player.hasStatusEffect(StatusEffects.GooArmorSilence)) return false;
	if (player.hasStatusEffect(StatusEffects.WhipSilence)) return false;
	return true;
}

public function combatMenu(newRound:Boolean = true):void { //If returning from a sub menu set newRound to false
	clearOutput();
	flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] = 0;
	if (newRound) {
		flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] = 0;
		//todo move this?
		for each (var action:CombatAction in player.availableActions){
			action.onCombatRound();
		}
	}
	mainView.hideMenuButton(MainView.MENU_DATA);
	mainView.hideMenuButton(MainView.MENU_APPEARANCE);
	mainView.hideMenuButton(MainView.MENU_PERKS);
	hideUpDown();
	if (newRound) combatStatusesUpdate(); //Update Combat Statuses
	display();
	statScreenRefresh();
	if (newRound) combatRoundOver();
	if (combatIsOver()) return;
	ui.mainMenu();
	//Modify menus.
	if (SceneLib.urtaQuest.isUrta()) {
		addButton(0, "Attack", attack).hint("Attempt to attack the enemy with your [weapon].  Damage done is determined by your strength and weapon.");
		addButton(1, "P. Specials", SceneLib.urtaQuest.urtaSpecials).hint("Physical special attack menu.", "Physical Specials");
		addButton(2, "M. Specials", SceneLib.urtaQuest.urtaMSpecials).hint("Mental and supernatural special attack menu.", "Magical Specials");
		addButton(3, "Tease", teaseAttack);
		addButton(5, "Fantasize", fantasize).hint("Fantasize about your opponent in a sexual way.  Its probably a pretty bad idea to do this unless you want to end up getting raped.");
		addButton(6, "Wait", wait).hint("Take no action for this round.  Why would you do this?  This is a terrible idea.");
	}
	if (player.statusEffectv1(StatusEffects.ChanneledAttack) >= 1 && (isPlayerBound() || isPlayerSilenced() || isPlayerStunned())) {
		addButton(1, "Stop", stopChanneledSpecial);
	}
	if (monster.hasStatusEffect(StatusEffects.AttackDisabled))
	{
		if (monster is Lethice)
		{
			outputText("\n<b>With Lethice up in the air, you've got no way to reach her with your attacks!</b>");
		}
		else
		{
			outputText("\n<b>Chained up as you are, you can't manage any real physical attacks!</b>");
		}
	}
	//Disabled physical attacks
	if (monster.hasStatusEffect(StatusEffects.PhysicalDisabled)) {
		outputText("<b>  Even physical special attacks are out of the question.</b>");
		removeButton(1); //Removes bow usage.
	}
}
	internal function buildOtherActions(buttons:ButtonDataList):void {
		var bd:ButtonData;
		buttons.add("Surrender",combat.surrender,"Fantasize about your opponent in a sexual way so much it would fill up your lust you'll end up getting raped.");
		if (player.statusEffectv1(StatusEffects.SummonedElementals) >= 1) {
			buttons.add("Elementals",CoC.instance.perkMenu.summonsbehaviourOptions,"You can adjust your elemental summons behaviour during combat.");
		}
		if (CoC_Settings.debugBuild && !debug) {
			buttons.add("Inspect", combat.debugInspect).hint("Use your debug powers to inspect your enemy.");
		}
		if (player.hasPerk(PerkLib.JobDefender)) {
			buttons.add("Defend", defendpose).hint("Take no offensive action for this round.  Why would you do this?  Maybe because you will assume defensive pose?");
		}
		if (player.hasPerk(PerkLib.SecondWind) && !player.hasStatusEffect(StatusEffects.CooldownSecondWind)) {
			buttons.add("Second Wind", seconwindGo).hint("Enter your second wind, recovering from your wound and fatigue once per battle.");
		}
		if (!player.isFlying() && monster.isFlying()) {
			if (player.canFly()) {
				buttons.add("Take Flight", takeFlight).hint("Make use of your wings to take flight into the air for up to 7 turns. \n\nGives bonus to evasion, speed but also giving penalties to accuracy of range attacks or spells. Not to meantion for non spear users to attack in melee range.");
			}
		} else if (player.isFlying()) {
			buttons.add("Great Dive", greatDive).hint("Make a Great Dive to deal TONS of damage!");
		}
	}

	internal function teaseAttack():void {
	teases.teaseAttack();
}

public function stopChanneledSpecial():void {
	clearOutput();
	outputText("You decided to stop preparing your super ultra hyper mega fabious attack!\n\n");
	player.removeStatusEffect(StatusEffects.ChanneledAttack);
	player.removeStatusEffect(StatusEffects.ChanneledAttackType);
	combatRoundOver();
}

public function unarmedAttack():Number {
	var unarmed:Number = 0;
	if (player.hasPerk(PerkLib.AdvancedJobMonk) && player.wis >= 60) unarmed += 10 * (1 + player.newGamePlusMod());
	if (player.hasPerk(PerkLib.PrestigeJobKiArtMaster) && player.wis >= 200) unarmed += 10 * (1 + player.newGamePlusMod());
	if (player.hasStatusEffect(StatusEffects.MetalSkin)) {
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 6) unarmed += 4 * player.statusEffectv2(StatusEffects.SummonedElementalsMetal) * (1 + player.newGamePlusMod());
		else unarmed += 2 * player.statusEffectv2(StatusEffects.SummonedElementalsMetal) * (1 + player.newGamePlusMod());
	}
	if (player.hasStatusEffect(StatusEffects.CrinosShape)) unarmed *= 1.1;
	if (player.hasPerk(PerkLib.Lycanthropy)) unarmed += 8 * (1 + player.newGamePlusMod());
//	if (player.jewelryName == "fox hairpin") unarmed += .2;
	unarmed = Math.round(unarmed);
	return unarmed;
}

public function baseelementalattacks(elementType:int = -1):void {
	if(elementType == -1){
		elementType = flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE];
	} else {
		flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] = elementType;
	}
	var summonedElementals:int;
	switch(elementType){
		case AIR        : summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsAir); break;
		case EARTH      : summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsEarth); break;
		case FIRE       : summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsFire); break;
		case WATER      : summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsWater); break;
		case ICE        : summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsIce); break;
		case LIGHTNING  : summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsLightning); break;
		case DARKNESS   : summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsDarkness); break;
		case WOOD       : summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsWood); break;
		case METAL      : summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsMetal); break;
		case ETHER      : summonedElementals = player.statusEffectv2(StatusEffects.SummonedElementalsEther); break;
	}
	clearOutput();
	var manaCost:Number = 1;
	manaCost += player.inte / 8;
	manaCost += player.wis / 8;
	manaCost = Math.round(manaCost);
	if (summonedElementals >= 4 && player.hasPerk(PerkLib.StrongElementalBond)) manaCost -= 10;
	if (summonedElementals >= 6 && manaCost > 25 && player.hasPerk(PerkLib.StrongerElementalBond)) manaCost -= 20;
	if (summonedElementals >= 8 && manaCost > 45 && player.hasPerk(PerkLib.StrongestElementalBond)) manaCost -= 40;
	if (player.mana < manaCost) {
		outputText("Your mana is too low to fuel your elemental attack!\n\n");
		flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] = 1;
		doNext(combatMenu);
	}
	else {
		if (manaCost > 0) player.mana -= manaCost;
		elementalattacks(elementType,summonedElementals);
	}
}

public function elementalattacks(elementType:int, summonedElementals:int):void {
	var elementalDamage:Number = 0;
	var baseDamage:Number = summonedElementals * (player.scalingBonusIntelligence() + player.scalingBonusWisdom()) * 0.02;
	if (summonedElementals >= 1) elementalDamage += baseDamage;
	if (summonedElementals >= 5) elementalDamage += baseDamage;
	if (summonedElementals >= 9) elementalDamage += baseDamage;
	if (elementalDamage < 10) elementalDamage = 10;
	
	var elementalamplification:Number = 1;
	if (player.hasPerk(PerkLib.ElementalConjurerResolve)) elementalamplification += 0.1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
	if (player.hasPerk(PerkLib.ElementalConjurerDedication)) elementalamplification += 0.2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
	if (player.hasPerk(PerkLib.ElementalConjurerSacrifice)) elementalamplification += 0.3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
	if (player.weapon == weapons.SCECOMM) elementalamplification += 0.5;
	elementalDamage *= elementalamplification;
	//Determine if critical hit!
	var crit:Boolean = false;
	var critChance:int = 5;
	if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
		if (player.inte <= 100) critChance += (player.inte - 50) / 5;
		if (player.inte > 100) critChance += 10;
	}
	if (elementType == AIR || elementType == WATER || elementType == METAL || elementType == ETHER) critChance += 10;
	if (monster.isImmuneToCrits()) critChance = 0;
	if (rand(100) < critChance) {
		crit = true;
		switch(elementType){
			case ETHER: elementalDamage *= 2; break;
			case AIR:
			case METAL: elementalDamage *= 1.75; break;
			default: elementalDamage *= 1.5; break;
		}
	}
	switch(elementType){
		case EARTH:
		case WOOD:
			elementalDamage *= 2.5;
			break;
		case METAL:
			elementalDamage *= 1.5;
			break;
		case FIRE:
			if (monster.hasPerk(PerkLib.IceNature)) elementalDamage *= 5;
			if (monster.hasPerk(PerkLib.FireVulnerability)) elementalDamage *= 2;
			if (monster.hasPerk(PerkLib.IceVulnerability)) elementalDamage *= 0.5;
			if (monster.hasPerk(PerkLib.FireNature)) elementalDamage *= 0.2;
			break;
		case WATER:
		case ICE:
			if (monster.hasPerk(PerkLib.IceNature)) elementalDamage *= 0.2;
			if (monster.hasPerk(PerkLib.FireVulnerability)) elementalDamage *= 0.5;
			if (monster.hasPerk(PerkLib.IceVulnerability)) elementalDamage *= 2;
			if (monster.hasPerk(PerkLib.FireNature)) elementalDamage *= 5;
			break;
		case LIGHTNING:
			if (monster.hasPerk(PerkLib.DarknessNature)) elementalDamage *= 5;
			if (monster.hasPerk(PerkLib.LightningVulnerability)) elementalDamage *= 2;
			if (monster.hasPerk(PerkLib.DarknessVulnerability)) elementalDamage *= 0.5;
			if (monster.hasPerk(PerkLib.LightningNature)) elementalDamage *= 0.2;
			break;
		case DARKNESS:
			if (monster.hasPerk(PerkLib.DarknessNature)) elementalDamage *= 0.2;
			if (monster.hasPerk(PerkLib.LightningVulnerability)) elementalDamage *= 0.5;
			if (monster.hasPerk(PerkLib.DarknessVulnerability)) elementalDamage *= 2;
			if (monster.hasPerk(PerkLib.LightningNature)) elementalDamage *= 5;
			break;
		default: break;
	}
	if (elementType != AIR && elementType != ETHER) elementalDamage *= (monster.damagePercent(false, true) / 100);
	elementalDamage = Math.round(elementalDamage);
	outputText("Your elemental hit [monster a] [monster name]! ");
	if (crit == true) {
		outputText("<b>Critical! </b>");
	}
	doDamage(elementalDamage,true,true);
	outputText("\n\n");
	//checkMinionsAchievementDamage(elementalDamage);
	if (monster.HP >= 1 && monster.lust <= monster.maxLust()) {
		if (flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 3) {
			flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
		}
		else {
			wrathRegeneration();
			fatigueRecovery();
			manaRegeneration();
			kiRegeneration();
			enemyAI();
		}
	}
	else {
		if(monster.HP <= 0) doNext(endHpVictory);
		else doNext(endLustVictory);
	}
}

	internal function wait():void {
		var skipMonsterAction:Object; //If  If false, enemyAI() will be called. If null, default handling
		flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] = 1;
		//Gain fatigue if not fighting sand tarps
		if (!monster.hasStatusEffect(StatusEffects.Level)) {
			fatigue( -5);
			wrathRegeneration();
			manaRegeneration();
			kiRegeneration();
		}
		clearOutput();
		skipMonsterAction = monster.handleWait();
		if(skipMonsterAction == null) {
			if (player.hasStatusEffect(StatusEffects.Stunned)) {
				outputText("You wobble about, stunned for a moment.  After shaking your head, you clear the stars from your vision, but by then you've squandered your chance to act.\n\n");
				player.removeStatusEffect(StatusEffects.Stunned);
			}
			else {
				outputText("You decide not to take any action this round.\n\n");
			}
		}

		if (skipMonsterAction == true) {
			combatRoundOver();
		} else {
			enemyAI();
		}
	}

	internal function struggle():void {
		clearOutput();
		if (monster.handleStruggle()) {
			combatRoundOver();
		} else {
			enemyAI();
		}
	}

public function meleeAccuracy():Number {
	var accmod:Number = 200;
	return accmod;
}

public function arrowsAccuracy():Number {
	var accmod:Number = 80;
	if (player.hasPerk(PerkLib.HistoryScout) || player.hasPerk(PerkLib.PastLifeScout)) accmod += 40;
	if (player.hasPerk(PerkLib.Accuracy1)) {
		accmod += player.perkv1(PerkLib.Accuracy1);
	}
	if (player.hasPerk(PerkLib.Accuracy2)) {
		accmod -= player.perkv1(PerkLib.Accuracy2);
	}
	if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
		if (player.statusEffectv1(StatusEffects.Kelt) <= 100) accmod += player.statusEffectv1(StatusEffects.Kelt);
		else accmod += 100;
	}
	if (player.statusEffectv1(StatusEffects.Kindra) > 0) {
		if (player.statusEffectv1(StatusEffects.Kindra) <= 150) accmod += player.statusEffectv1(StatusEffects.Kindra);
		else accmod += 150;
	}
	if (player.inte > 50 && player.hasPerk(PerkLib.JobHunter)) {
		if (player.inte <= 150) accmod += (player.inte - 50);
		else accmod += 100;
	}
	if (player.isFlying()) accmod -= 100;
	return accmod;
}

public function oneArrowTotalCost():Number {
	var onearrowcost:Number = 25;
	//additional arrow effects costs
	if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1 || flags[kFLAGS.ELEMENTAL_ARROWS] == 2) onearrowcost += 15;
	if (flags[kFLAGS.CUPID_ARROWS] == 1) onearrowcost += 5;
	if (flags[kFLAGS.ENVENOMED_BOLTS] == 1) onearrowcost += 5;
	//Bow Shooting perk cost reduction
	if (player.hasPerk(PerkLib.BowShooting)) onearrowcost *= (1 - ((player.perkv1(PerkLib.BowShooting)) / 100));
	return onearrowcost;
}
public function oneThrowTotalCost():Number {
	var onearrowcost:Number = 25;
	return onearrowcost;
}

public function fireBow():void {
	clearOutput();
	if (monster.hasStatusEffect(StatusEffects.BowDisabled)) {
		outputText("You can't use your range weapon right now!");
		menu();
		addButton(0, "Next", combatMenu, false);
		return;
	}
	lastAttack = ARROW;
	if (player.weaponRangePerk == "Bow" || player.weaponRangePerk == "Crossbow") {
		var fireBowCost:Number = 0;
		fireBowCost += oneArrowTotalCost();
		if (player.fatigue + fireBowCost > player.maxFatigue()) {
			outputText("You're too fatigued to fire the ");
			if (player.weaponRangePerk == "Crossbow") outputText("cross");
			outputText("bow!");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
	}
	if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle") {
		player.ammo--;
	}
	if (flags[kFLAGS.ARROWS_ACCURACY] > 0) flags[kFLAGS.ARROWS_ACCURACY] = 0;
	//Amily!
	if (monster.hasStatusEffect(StatusEffects.Concentration)) {
		outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
		enemyAI();
		return;
	}
	if (monster.hasStatusEffect(StatusEffects.Sandstorm) && rand(10) > 1) {
		outputText("Your attack is blown off target by the tornado of sand and wind.  Damn!\n\n");
		enemyAI();
		return;
	}
	//[Bow Response]
	var ammoWord:String = player.weaponRange.ammoWord;
	if (monster.short == "Isabella" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
		if (monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind)) {
			outputText("Isabella hears the shot and turns her shield towards it, completely blocking it with her wall of steel.\n\n");
		}
		else {
			outputText("Your " + ammoWord + " thunks into Isabella's shield, completely blocked by the wall of steel.\n\n");
		}
		if (SceneLib.isabellaFollowerScene.isabellaAccent())
			outputText("\"<i>You remind me of ze horse-people.  They cannot deal vith mein shield either!</i>\" cheers Isabella.\n\n");
		else outputText("\"<i>You remind me of the horse-people.  They cannot deal with my shield either!</i>\" cheers Isabella.\n\n");
		enemyAI();
		return;
	}
	//worms are immune
	if (monster.short == "worms") {
		outputText("The " + ammoWord + " slips between the worms, sticking into the ground.\n\n");
		enemyAI();
		return;
	}
	//Vala miss chance!
	if (monster.short == "Vala" && rand(10) < 7 && !monster.hasStatusEffect(StatusEffects.Stunned)) {
		outputText("Vala flaps her wings and twists her body. Between the sudden gust of wind and her shifting of position, the " + ammoWord + " goes wide.\n\n");
		enemyAI();
		return;
	}
	//Blind miss chance
	if (player.hasStatusEffect(StatusEffects.Blind)) {
		outputText("The " + ammoWord + " hits something, but blind as you are, you don't have a chance in hell of hitting anything with a bow.\n\n");
		enemyAI();
		return;
	}
	if (monster is Lethice && monster.hasStatusEffect(StatusEffects.Shell))
	{
		outputText("Your " + ammoWord + " pings of the side of the shield and spins end over end into the air. Useless.\n\n");
		enemyAI();
		return;
	}
	if (player.weaponRangePerk == "Bow" || player.weaponRangePerk == "Crossbow") {
		if (player.hasStatusEffect(StatusEffects.ResonanceVolley)) outputText("Your bow nudges as you ready the next shot, helping you keep your aimed at [monster name].\n\n");
		multiArrowsStrike();
	}
	if (player.weaponRangePerk == "Throwing") {
		var fc:Number       = oneThrowTotalCost();
		if (player.fatigue + fc > player.maxFatigue()) {
			outputText("You're too fatigued to throw the [weaponrangename]!");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		throwWeapon();
	}
	if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle") shootWeapon();
}

public function multiArrowsStrike():void {
	var accRange:Number = 0;
	accRange += (arrowsAccuracy() / 2);
	if (flags[kFLAGS.ARROWS_ACCURACY] > 0) accRange -= flags[kFLAGS.ARROWS_ACCURACY];
	if (player.weaponRangeName == "Guided bow") accRange = 100;
	fatigue(oneArrowTotalCost());
	var weaponRangePerk:String = player.weaponRangePerk;
	var ammoWord:String;
	switch(weaponRangePerk){
		case "Bow": ammoWord = "arrow"; break;
		case "Crossbow" : ammoWord = "bolt"; break;
	}
	if (rand(100) < accRange) {
		var damage:Number = 0;
		if (weaponRangePerk == "Bow") {
			damage += player.spe;
			damage += player.scalingBonusSpeed() * 0.2;
			if (damage < 10) damage = 10;
		}
		if (weaponRangePerk == "Crossbow") damage += player.weaponRangeAttack * 10;
		if (!player.hasPerk(PerkLib.DeadlyAim)) damage *= (monster.damagePercent() / 100);//jak ten perk o ignorowaniu armora bedzie czy coś to tu dać jak nie ma tego perku to sie dolicza
		//Weapon addition!
		if (player.weaponRangeAttack < 51) damage *= (1 + (player.weaponRangeAttack * 0.03));
		else if (player.weaponRangeAttack >= 51 && player.weaponRangeAttack < 101) damage *= (2.5 + ((player.weaponRangeAttack - 50) * 0.025));
		else if (player.weaponRangeAttack >= 101 && player.weaponRangeAttack < 151) damage *= (3.75 + ((player.weaponRangeAttack - 100) * 0.02));
		else if (player.weaponRangeAttack >= 151 && player.weaponRangeAttack < 201) damage *= (4.75 + ((player.weaponRangeAttack - 150) * 0.015));
		else damage *= (5.5 + ((player.weaponRangeAttack - 200) * 0.01));
		if (damage == 0) {
			if (monster.inte > 0) {
				outputText("[monster A][monster name] shrugs as the " + ammoWord + " bounces off them harmlessly.\n\n");
			}
			else {
				outputText("The " + ammoWord + " bounces harmlessly off [monster a] [monster name].\n\n");
			}
			flags[kFLAGS.ARROWS_SHOT]++;
			bowPerkUnlock();
		}
		if (monster.short == "pod") {
			outputText("The " + ammoWord + " lodges deep into the pod's fleshy wall");
		}
		else if (monster.plural) {
			var textChooser1:int = rand(12);
			if (textChooser1 >= 9) {
				outputText("[monster A][monster name] look down at the " + ammoWord + " that now protrudes from one of [monster his] bodies");
			}
			else if (textChooser1 >= 6 && textChooser1 < 9) {
				outputText("You pull an " + ammoWord + " and fire it at one of [monster a] [monster name]");
			}
			else if (textChooser1 >= 3 && textChooser1 < 6) {
				outputText("With one smooth motion you draw, nock, and fire your deadly " + ammoWord + " at one of your opponents");
			}
			else {
				outputText("You casually fire an " + ammoWord + " at one of [monster a] [monster name] with supreme skill");
			}
		}
		else {
			var textChooser2:int = rand(12);
			if (textChooser2 >= 9) {
				outputText("[monster A][monster name] looks down at the " + ammoWord + " that now protrudes from [monster his] body");
			} else if (textChooser2 >= 6) {
				outputText("You pull an " + ammoWord + " and fire it at [monster a] [monster name]");
			} else if (textChooser2 >= 3) {
				outputText("With one smooth motion you draw, nock, and fire your deadly " + ammoWord + " at your opponent");
			} else {
				outputText("You casually fire an " + ammoWord + " at [monster a] [monster name] with supreme skill");
			}
		}
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.hasPerk(PerkLib.VitalShot) && player.inte >= 50) critChance += 10;
		if (monster.isImmuneToCrits()) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (player.hasPerk(PerkLib.HistoryScout) || player.hasPerk(PerkLib.PastLifeScout)) damage *= 1.1;
		if (player.hasPerk(PerkLib.JobRanger)) damage *= 1.05;
		if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
			if (player.statusEffectv1(StatusEffects.Kelt) < 100) damage *= 1 + (0.01 * player.statusEffectv1(StatusEffects.Kelt));
			else {
				if (player.statusEffectv1(StatusEffects.Kindra) > 0) {
					if (player.statusEffectv1(StatusEffects.Kindra) < 150) damage *= 2 + (0.01 * player.statusEffectv1(StatusEffects.Kindra));
					else damage *= 3.5;
				}
				else damage *= 2;
			}
		}
		if (player.weaponRangeName == "Wild Hunt" && player.level > monster.level) damage *= 1.2;
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
		}
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 0.5;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 0.2;
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 5;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 2;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		if (flags[kFLAGS.ARROWS_SHOT] >= 1) EngineCore.awardAchievement("Arrow to the Knee", kACHIEVEMENTS.COMBAT_ARROW_TO_THE_KNEE);
		if (monster.HP <= 0) {
			if (monster.short == "pod")
				outputText(". ");
			else if (monster.plural)
				outputText(" and [monster he] stagger, collapsing onto each other from the wounds you've inflicted on [monster him]. ");
			else outputText(" and [monster he] staggers, collapsing from the wounds you've inflicted on [monster him]. ");
			outputText("<b>(<font color=\"#800000\">" + String(damage) + "</font>)</b>");
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			outputText("\n\n");
			checkAchievementDamage(damage);
			flags[kFLAGS.ARROWS_SHOT]++;
			bowPerkUnlock();
			doNext(endHpVictory);
			return;
		}
		else {
			if (rand(100) < 15 && player.weaponRangeName == "Artemis" && !monster.hasStatusEffect(StatusEffects.Blind)) {
				monster.createStatusEffect(StatusEffects.Blind, 3, 0, 0, 0);
				outputText(",  your radiant shots blinded [monster he]");
			}
			outputText(".  It's clearly very painful. <b>(<font color=\"#800000\">" + String(damage) + "</font>)</b>");
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			heroBaneProc(damage);
		}
		if (flags[kFLAGS.CUPID_ARROWS] == 1) {
			outputText("  ");
			if(monster.lustVuln == 0) {
				outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.");
			}
			else {
				var lustArrowDmg:Number = monster.lustVuln * (player.inte / 5 * spellMod() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
				if (monster.lust < (monster.maxLust() * 0.3)) outputText("[monster A][monster name] squirms as the magic affects [monster him].  ");
				if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
					if (monster.plural) outputText("[monster A][monster name] stagger, suddenly weak and having trouble focusing on staying upright.  ");
					else outputText("[monster A][monster name] staggers, suddenly weak and having trouble focusing on staying upright.  ");
				}
				if (monster.lust >= (monster.maxLust() * 0.6)) {
					outputText("[monster A][monster name]'");
					if(!monster.plural) outputText("s");
					outputText(" eyes glaze over with desire for a moment.  ");
				}
				lustArrowDmg *= 0.25;
				lustArrowDmg = Math.round(lustArrowDmg);
				monster.lust += lustArrowDmg;
				outputText("<b>(<font color=\"#ff00ff\">" + lustArrowDmg + "</font>)</b>");
				if (monster.lust >= monster.maxLust()) doNext(endLustVictory);
			}
		}
		if (flags[kFLAGS.ENVENOMED_BOLTS] == 1 && player.tailVenom >= 10) {
			outputText("  ");
			if(monster.lustVuln == 0) {
				outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
			}
			if (player.tailType == Tail.BEE_ABDOMEN) {
				outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
				var damageB:Number = 35 + rand(player.lib/10);
				if (player.level < 10) damageB += 20 + (player.level * 3);
				else if (player.level < 20) damageB += 50 + (player.level - 10) * 2;
				else if (player.level < 30) damageB += 70 + (player.level - 20) * 1;
				else damageB += 80;
				damageB *= 0.2;
				monster.teased(monster.lustVuln * damageB);
				if (monster.hasStatusEffect(StatusEffects.NagaVenom))
				{
					monster.addStatusValue(StatusEffects.NagaVenom,3,1);
				}
				else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 1, 0);
				player.tailVenom -= 5;
			}
			if (player.tailType == Tail.SCORPION) {
				outputText("  [monster he] seems to be effected by the poison, its movement turning sluggish.");
				monster.spe -= 2;
				if (monster.spe < 1) monster.spe = 1;
				if (monster.hasStatusEffect(StatusEffects.NagaVenom))
				{
					monster.addStatusValue(StatusEffects.NagaVenom,3,1);
				}
				else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 1, 0);
				player.tailVenom -= 5;
			}
			if (player.tailType == Tail.MANTICORE_PUSSYTAIL) {
				outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
				var lustdamage:Number = 35 + rand(player.lib / 10);
				if (player.level < 10) damage += 20 + (player.level * 3);
				else if (player.level < 20) damage += 50 + (player.level - 10) * 2;
				else if (player.level < 30) damage += 70 + (player.level - 20) * 1;
				else damage += 80;
				lustdamage *= 0.14;
				monster.teased(monster.lustVuln * lustdamage);
				monster.tou -= 2;
				if (monster.tou < 1) monster.tou = 1;
				if (monster.hasStatusEffect(StatusEffects.NagaVenom))
				{
					monster.addStatusValue(StatusEffects.NagaVenom,3,1);
				}
				else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 1, 0);
				player.tailVenom -= 5;
			}
			if (player.faceType == Face.SNAKE_FANGS) {
				outputText("  [monster he] seems to be effected by the poison, its movement turning sluggish.");
				monster.spe -= 0.4;
				monster.spe -= 0.4;
				if (monster.spe < 1) monster.spe = 1;
				if (monster.spe < 1) monster.spe = 1;
				if (monster.hasStatusEffect(StatusEffects.NagaVenom))
				{
					monster.addStatusValue(StatusEffects.NagaVenom,2,0.4);
					monster.addStatusValue(StatusEffects.NagaVenom,1,0.4);
				}
				else monster.createStatusEffect(StatusEffects.NagaVenom, 0.4, 0.4, 0, 0);
				player.tailVenom -= 5;
			}
			if (player.faceType == Face.SPIDER_FANGS) {
				outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
				var lustDmg:int = 6 * monster.lustVuln;
				monster.teased(lustDmg);
				if (monster.lustVuln > 0) {
					monster.lustVuln += 0.01;
					if (monster.lustVuln > 1) monster.lustVuln = 1;
				}
				player.tailVenom -= 5;
			}
			if (monster.lust >= monster.maxLust()) {
				outputText("\n\n");
				checkAchievementDamage(damage);
				flags[kFLAGS.ARROWS_SHOT]++;
				bowPerkUnlock();
				doNext(endLustVictory);
			}
			outputText("\n");
		}
		if (flags[kFLAGS.ENVENOMED_BOLTS] == 1 && player.tailVenom < 10) {
			outputText("  You do not have enough venom to apply on the " + ammoWord + " tip!");
		}
		if (player.weaponRangeName == "Hodr's bow" && !monster.hasStatusEffect(StatusEffects.Blind)) monster.createStatusEffect(StatusEffects.Blind,1,0,0,0);
		outputText("\n");
		flags[kFLAGS.ARROWS_SHOT]++;
		bowPerkUnlock();
	}
	else {
		outputText("The " + ammoWord + " goes wide, disappearing behind your foe");
		if (monster.plural) outputText("s");
		outputText(".\n\n");
	}
	if (monster is Lethice && (monster as Lethice).fightPhase == 3)
	{
		outputText("\n\n<i>“Ouch. Such a cowardly weapon,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your pathetic " + ammoWord + "s?”</i>\n\n");
		monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
	}
	enemyAI();
	if(monster.HP <= 0){ doNext(endHpVictory); return;}
	if(monster.lust >= monster.maxLust()){ doNext(endLustVictory); return;}
}

public function bowPerkUnlock():void {
	if(flags[kFLAGS.ARROWS_SHOT] >= 10 && !player.hasPerk(PerkLib.BowShooting)) {
		outputText("<b>You've become more comfortable with using bow, unlocking the Bow Shooting perk and reducing fatigue cost of shooting arrows by 20%!</b>\n\n");
		player.createPerk(PerkLib.BowShooting,20,0,0,0);
	}
	if(flags[kFLAGS.ARROWS_SHOT] >= 30 && player.perkv1(PerkLib.BowShooting) < 40) {
		outputText("<b>You've become more comfortable with using bow, further reducing cost of shooting arrows by an additional 20%!</b>\n\n");
		player.setPerkValue(PerkLib.BowShooting,1,40);
	}
	if(flags[kFLAGS.ARROWS_SHOT] >= 90 && player.perkv1(PerkLib.BowShooting) < 60) {
		outputText("<b>You've become more comfortable with using bow, further reducing cost of shooting arrows by an additional 20%!</b>\n\n");
		player.setPerkValue(PerkLib.BowShooting,1,60);
	}
	if(flags[kFLAGS.ARROWS_SHOT] >= 270 && player.perkv1(PerkLib.BowShooting) < 80) {
		outputText("<b>You've become more comfortable with using bow, further reducing cost of shooting arrows by an additional 20%!</b>\n\n");
		player.setPerkValue(PerkLib.BowShooting,1,80);	
	}
}

public function throwWeapon():void {
	var fc:Number       = oneThrowTotalCost();
	var accRange:Number = 0;
	accRange += (arrowsAccuracy() / 2);
	if (flags[kFLAGS.ARROWS_ACCURACY] > 0) accRange -= flags[kFLAGS.ARROWS_ACCURACY];
	if (player.weaponRange != weaponsrange.SHUNHAR || player.weaponRange != weaponsrange.KSLHARP || player.weaponRange != weaponsrange.LEVHARP) player.ammo--;
	fatigue(fc);
	if (rand(100) < accRange) {
		var damage:Number = 0;
		damage += player.str;
		damage += player.scalingBonusStrength() * 0.2;
		if (damage < 10) damage = 10;
		//Weapon addition!
		if (player.weaponRangeAttack < 51) damage *= (1 + (player.weaponRangeAttack * 0.03));
		else if (player.weaponRangeAttack >= 51 && player.weaponRangeAttack < 101) damage *= (2.5 + ((player.weaponRangeAttack - 50) * 0.025));
		else if (player.weaponRangeAttack >= 101 && player.weaponRangeAttack < 151) damage *= (3.75 + ((player.weaponRangeAttack - 100) * 0.02));
		else if (player.weaponRangeAttack >= 151 && player.weaponRangeAttack < 201) damage *= (4.75 + ((player.weaponRangeAttack - 150) * 0.015));
		else damage *= (5.5 + ((player.weaponRangeAttack - 200) * 0.01));
		if (player.weaponRange == weaponsrange.KSLHARP) {
			if (monster.cor < 33) damage = Math.round(damage * 1.0);
			else if (monster.cor < 50) damage = Math.round(damage * 1.1);
			else if (monster.cor < 75) damage = Math.round(damage * 1.2);
			else if (monster.cor < 90) damage = Math.round(damage * 1.3);
			else damage = Math.round(damage * 1.4);
		}
		if (player.weaponRange == weaponsrange.LEVHARP) {
			if (monster.cor >= 66) damage = Math.round(damage * 1.0);
			else if (monster.cor >= 50) damage = Math.round(damage * 1.1);
			else if (monster.cor >= 25) damage = Math.round(damage * 1.2);
			else if (monster.cor >= 10) damage = Math.round(damage * 1.3);
			else damage = Math.round(damage * 1.4);
		}
		if (damage == 0) {
			if (monster.inte > 0) {
				outputText("[monster A][monster name] shrugs as the [weaponrangename] bounces off them harmlessly.\n\n");
			}
			else {
				outputText("The [weaponrangename] bounces harmlessly off [monster a] [monster name].\n\n");
			}
		}
		if (monster.short == "pod") {
			outputText("The [weaponrangename] lodges deep into the pod's fleshy wall");
		}
		else if (monster.plural) {
			var textChooser1:int = rand(12);
			if (textChooser1 >= 9) {
				outputText("[monster A][monster name] look down at the mark left by the [weaponrangename] on one of their bodies");
			}
			else if (textChooser1 >= 6 && textChooser1 < 9) {
				outputText("You grasps firmly [weaponrangename] and then throws it at one of [monster a] [monster name]");
			}
			else if (textChooser1 >= 3 && textChooser1 < 6) {
				outputText("With one smooth motion you aim and throws your [weaponrangename] at one of your opponents");
			}
			else {
				outputText("You casually throws [weaponrangename] at one of [monster a] [monster name] with supreme skill");
			}
		}
		else {
			var textChooser2:int = rand(12);
			if (textChooser2 >= 9) {
				outputText("[monster A][monster name] looks down at the mark left by the [weaponrangename] on it body");
			}
			else if (textChooser2 >= 6) {
				outputText("You grasps firmly [weaponrangename] and then throws it at [monster a] [monster name]");
			}
			else if (textChooser2 >= 3) {
				outputText("With one smooth motion you aim and throw your [weaponrangename] at your opponent");
			}
			else {
				outputText("You casually throws [weaponrangename] at [monster a] [monster name] with supreme skill");
			}
		}
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.weaponRangeName == "gnoll throwing axes") critChance += 10;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.hasPerk(PerkLib.VitalShot) && player.inte >= 50) critChance += 10;
		if (monster.isImmuneToCrits()) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (player.hasPerk(PerkLib.HistoryScout) || player.hasPerk(PerkLib.PastLifeScout)) damage *= 1.1;
		if (player.hasPerk(PerkLib.JobRanger)) damage *= 1.05;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
			if (player.statusEffectv1(StatusEffects.Kelt) < 100) damage *= 1 + (0.01 * player.statusEffectv1(StatusEffects.Kelt));
			else {
				if (player.statusEffectv1(StatusEffects.Kindra) > 0) {
					if (player.statusEffectv1(StatusEffects.Kindra) < 150) damage *= 2 + (0.01 * player.statusEffectv1(StatusEffects.Kindra));
					else damage *= 3.5;
				}
				else damage *= 2;
			}
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		if (monster.HP <= 0) {
			if (monster.short == "pod")
				outputText(". ");
			else if (monster.plural)
				outputText(" and [monster he] stagger, collapsing onto each other from the wounds you've inflicted on [monster him]. ");
			else outputText(" and [monster he] staggers, collapsing from the wounds you've inflicted on [monster him]. ");
			outputText("<b>(<font color=\"#800000\">" + String(damage) + "</font>)</b>");
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			outputText("\n\n");
			checkAchievementDamage(damage);
			doNext(endHpVictory);
			return;
		}
		else {
			outputText(".  It's clearly very painful. <b>(<font color=\"#800000\">" + String(damage) + "</font>)</b>");
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			outputText("\n\n");
			heroBaneProc(damage);
		}
		checkAchievementDamage(damage);
	}
	else {
		outputText("The [weaponrangename] goes wide, disappearing behind your foe");
		if (monster.plural) outputText("s");
		outputText(".\n\n");
	}
	if (monster is Lethice && (monster as Lethice).fightPhase == 3)
	{
		outputText("\n\n<i>“Ouch. Such a cowardly weapon,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your pathetic ");
		if (player.weaponRangePerk == "Bow") outputText("arrow");
		if (player.weaponRangePerk == "Crossbow") outputText("bolt");
		outputText("s?”</i>\n\n");
		monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
	}
	if (player.ammo == 0) outputText("\n\n<b>You're out of weapons to throw in this fight.</b>\n\n");
	enemyAI();
}

public function shootWeapon():void {
	var accRange:Number = 0;
	accRange += (arrowsAccuracy() / 2);
	if (rand(100) >= accRange) {
		outputText("The bullet goes wide, disappearing behind your foe");
		if (monster.plural) {
			outputText("s");
		}
		outputText(".\n\n");
	} else {
		var damage: Number = 0;
		if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle") {
			damage += player.weaponRangeAttack * 20;
		}
		if (!player.hasPerk(PerkLib.DeadlyAim)) {
			damage *= (monster.damagePercent() / 100);
		}
		//Weapon addition!
		if (player.weaponRangeAttack < 51) {damage *= (1 + (player.weaponRangeAttack * 0.03));}
		else if (player.weaponRangeAttack >= 51 && player.weaponRangeAttack < 101) {damage *= (2.5 + ((player.weaponRangeAttack - 50) * 0.025));}
		else if (player.weaponRangeAttack >= 101 && player.weaponRangeAttack < 151) {damage *= (3.75 + ((player.weaponRangeAttack - 100) * 0.02));}
		else if (player.weaponRangeAttack >= 151 && player.weaponRangeAttack < 201) {damage *= (4.75 + ((player.weaponRangeAttack - 150) * 0.015));}
		else {damage *= (5.5 + ((player.weaponRangeAttack - 200) * 0.01));}

		if (damage == 0) {
			if (monster.inte > 0) {
				outputText("[monster A][monster name] shrugs as the bullet bounces off them harmlessly.\n\n");
			}
			else {
				outputText("The bullet bounces harmlessly off [monster a] [monster name].\n\n");
			}
		}
		if (monster.short == "pod") {
			outputText("The bullet lodges deep into the pod's fleshy wall");
		}
		else if (monster.plural) {
			outputText(randomChoice(
				"[monster A][monster name] look down at the mark left by the bullet on one of their bodies",
				"You pull the trigger and fire the bullet at one of [monster a] [monster name]",
				"With one smooth motion you aim and fire your deadly bullet at one of your opponents",
				"You casually fire an bullet at one of [monster a] [monster name] with supreme skill"
			));
		}
		else {
			outputText(randomChoice(
				"[monster A][monster name] looks down at the mark left by the bullet on it body",
				"You pull the trigger and fire the bullet at [monster a] [monster name]",
				"With one smooth motion you aim and fire your deadly bullet at your opponent",
				"You casually fire an bullet at [monster a] [monster name] with supreme skill"
			));
		}
		//Determine if critical hit!
		var crit: Boolean = false;
		var critChance: int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) {
				critChance += (player.inte - 50) / 5;
			}
			if (player.inte > 100) {
				critChance += 10;
			}
		}
		if (player.hasPerk(PerkLib.VitalShot) && player.inte >= 50) {
			critChance += 10;
		}
		if (monster.isImmuneToCrits()) {
			critChance = 0;
		}
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (player.hasPerk(PerkLib.HistoryScout) || player.hasPerk(PerkLib.PastLifeScout)) {
			damage *= 1.1;
		}
		if (player.hasPerk(PerkLib.JobRanger)) {
			damage *= 1.05;
		}
		if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
			if (player.statusEffectv1(StatusEffects.Kelt) < 100) {
				damage *= 1 + (0.01 * player.statusEffectv1(StatusEffects.Kelt));
			} else {
				if (player.statusEffectv1(StatusEffects.Kindra) > 0) {
					damage *= Math.min(3.5, 2 + (0.01 * player.statusEffectv1(StatusEffects.Kindra)));
				} else {
					damage *= 2;
				}
			}
		}
		damage = Math.round(damage);
		damage = doDamage(damage);

		if (monster.HP > 0) {
			outputText(".  It's clearly very painful. <b>(<font color=\"#800000\">" + String(damage) + "</font>)</b>");
			if (crit == true) {
				outputText(" <b>*Critical Hit!*</b>");
			}
			outputText("\n\n");
			heroBaneProc(damage);
		} else {
			if (monster.short == "pod") {
				outputText(". ");
			} else if (monster.plural) {
				outputText(" and [monster he] stagger, collapsing onto each other from the wounds you've inflicted on [monster him]. ");
			} else {
				outputText(" and [monster he] staggers, collapsing from the wounds you've inflicted on [monster him]. ");
			}
			outputText("<b>(<font color=\"#800000\">" + String(damage) + "</font>)</b>");
			if (crit == true) {
				outputText(" <b>*Critical Hit!*</b>");
			}
			outputText("\n\n");
			checkAchievementDamage(damage);
			doNext(endHpVictory);
			return;
		}
		checkAchievementDamage(damage);
	}
	if (monster is Lethice && (monster as Lethice).fightPhase == 3)
	{
		outputText("\n\n<i>“Ouch. Such a cowardly weapon,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your pathetic weapon?”</i>\n\n");
		monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
	}
	enemyAI();
}

public function reloadWeapon():void {
	if (player.weaponRangeName == "Ivory inlaid arquebus") player.ammo = 12;
	if (player.weaponRangeName == "blunderbuss rifle") player.ammo = 9;
	if (player.weaponRangeName == "flintlock pistol") player.ammo = 6;
	outputText("You open the magazine of your ");
	if (player.weaponRangeName == "flintlock pistol") outputText("pistol");
	if (player.weaponRangeName == "blunderbuss rifle") outputText("rifle");
	outputText(" to reload the ammunition.  If you too tired it would use up this turn action.\n\n");
	if(player.fatigue + (10 * player.ammo) > player.maxFatigue()) {
		clearOutput();
		outputText("You are too tired to act in this round after reloaing your weapon.");
		enemyAI();
	}
	else {
		fatigue(5 * player.ammo);
		doNext(combatMenu);
	}
}

private function debugInspect():void {
	outputText(monster.generateDebugDescription());
	menu();
	addButton(0, "Next", combatMenu, false);
}

//Fantasize
public function fantasize():void {
	var lustChange:Number = 0;
	doNext(combatMenu);
	clearOutput();
	if (monster.short == "frost giant" && (player.hasStatusEffect(StatusEffects.GiantBoulder))) {
		lustChange = 10 + rand(player.lib / 5 + player.cor / 8);
		dynStats("lus", lustChange, "scale", false);
		(monster as FrostGiant).giantBoulderFantasize();
		enemyAI();
		return;
	}
	if(player.armorName == "goo armor") {
		outputText("As you fantasize, you feel Valeria rubbing her gooey body all across your sensitive skin");
		if(player.gender > 0) outputText(" and genitals");
		outputText(", arousing you even further.\n");
		lustChange = 25 + rand(player.lib/8+player.cor/8)
	}	
	else if(player.balls > 0 && player.ballSize >= 10 && rand(2) == 0) {
		outputText("You daydream about fucking [monster a] [monster name], feeling your balls swell with seed as you prepare to fuck [monster him] full of cum.\n");
		lustChange = 5 + rand(player.lib/8+player.cor/8);
		outputText("You aren't sure if it's just the fantasy, but your [balls] do feel fuller than before...\n");
		player.hoursSinceCum += 50;
	}
	else if(player.biggestTitSize() >= 6 && rand(2) == 0) {
		outputText("You fantasize about grabbing [monster a] [monster name] and shoving [monster him] in between your jiggling mammaries, nearly suffocating [monster him] as you have your way.\n");
		lustChange = 5 + rand(player.lib/8+player.cor/8)
	}
	else if(player.biggestLactation() >= 6 && rand(2) == 0) {
		outputText("You fantasize about grabbing [monster a] [monster name] and forcing [monster him] against a " + nippleDescript(0) + ", and feeling your milk let down.  The desire to forcefeed SOMETHING makes your nipples hard and moist with milk.\n");
		lustChange = 5 + rand(player.lib/8+player.cor/8)
	}
	else {
		clearOutput();
		outputText("You fill your mind with perverted thoughts about [monster a] [monster name], picturing [monster him] in all kinds of perverse situations with you.\n");
		lustChange = 10+rand(player.lib/5+player.cor/8);
	}
	if(lustChange >= 20) outputText("The fantasy is so vivid and pleasurable you wish it was happening now.  You wonder if [monster a] [monster name] can tell what you were thinking.\n\n");
	else outputText("\n");
	dynStats("lus", lustChange, "scale", false);
	if(player.lust >= player.maxLust()) {
		if(monster.short == "pod") {
			outputText("<b>You nearly orgasm, but the terror of the situation reasserts itself, muting your body's need for release.  If you don't escape soon, you have no doubt you'll be too fucked up to ever try again!</b>\n\n");
			player.lust = (player.maxLust() - 1);
			dynStats("lus", -25);
		}
		else {
			doNext(endLustLoss);
			return;
		}
	}
	enemyAI();	
}
public function defendpose():void {
	clearOutput();
	outputText("You decide not to take any offensive action this round preparing for [monster a] [monster name] attack assuming defensive pose.\n\n");
	player.createStatusEffect(StatusEffects.Defend, 0, 0, 0, 0);
	enemyAI();
}
public function seconwindGo():void {
	clearOutput();
	outputText("You enter your second wind, recovering your energy.\n\n");
	fatigue((player.maxFatigue() - player.fatigue) / 2);
	player.createStatusEffect(StatusEffects.SecondWindRegen, 10, 0, 0, 0);
	player.createStatusEffect(StatusEffects.CooldownSecondWind, 0, 0, 0, 0);
	wrathRegeneration();
	fatigueRecovery();
	manaRegeneration();
	kiRegeneration();
	enemyAI();
}
public function surrender():void {
	var remainingLust:Number = (player.maxLust() - player.lust);
	doNext(combatMenu);
	clearOutput();
	outputText("You fill your mind with perverted thoughts about [monster a] [monster name], picturing [monster him] in all kinds of perverse situations with you.\n");
	dynStats("lus", remainingLust, "scale", false);
	doNext(endLustLoss);
}

public function fatigueRecovery():void {
	var fatiguecombatrecovery:Number = 0;
	if (player.hasPerk(PerkLib.StarSphereMastery)) fatiguecombatrecovery += (player.perkv1(PerkLib.StarSphereMastery) * 2);
	if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) fatiguecombatrecovery += 3;
	if (player.hasPerk(PerkLib.EnlightenedNinetails)) fatiguecombatrecovery += 2;
	if (player.hasPerk(PerkLib.CorruptedNinetails)) fatiguecombatrecovery += 2;
	if (player.hasPerk(PerkLib.EnlightenedKitsune)) fatiguecombatrecovery += 1;
	if (player.hasPerk(PerkLib.CorruptedKitsune)) fatiguecombatrecovery += 1;
	if (player.hasPerk(PerkLib.KitsuneThyroidGland)) fatiguecombatrecovery += 1;
	if (player.hasPerk(PerkLib.KitsuneThyroidGlandEvolved)) fatiguecombatrecovery += 1;
	fatigue(-(1 + fatiguecombatrecovery));
}

//ATTACK
public function attack():void {
	if (monster is DriderIncubus) {
		(monster as DriderIncubus).taintedMindAttackAttempt();
		return;
	}
	clearOutput();
	lastAttack = PHYSICAL;
	if(player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 0 && !isWieldingRangedWeapon()) {
		outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  The kitsune's seals have made normal melee attack impossible!  Maybe you could try something else?\n\n");
		enemyAI();
		return;
	}
	if(player.hasStatusEffect(StatusEffects.Sealed2) && player.statusEffectv2(StatusEffects.Sealed2) == 0) {
		outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  Recent enemy attack have made normal melee attack impossible!  Maybe you could try something else?\n\n");
		enemyAI();
		return;
	}
	if(flags[kFLAGS.PC_FETISH] >= 3 && !SceneLib.urtaQuest.isUrta() && !isWieldingRangedWeapon()) {
		outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  Ceraph's piercings have made normal melee attack impossible!  Maybe you could try something else?\n\n");
		enemyAI();
		return;
	}
	//Amily!
	if(monster.hasStatusEffect(StatusEffects.Concentration) && !isWieldingRangedWeapon()) {
		clearOutput();
		outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
		enemyAI();
		return;
	}
	if(monster.hasStatusEffect(StatusEffects.Level) && !player.hasStatusEffect(StatusEffects.FirstAttack) && !isWieldingRangedWeapon()) {
		if (monster is SandTrap) {
			outputText("It's all or nothing!  With a bellowing cry you charge down the treacherous slope and smite the sandtrap as hard as you can!  ");
			(monster as SandTrap).trapLevel(-4);
		}
		if (monster is Alraune) {
			outputText("It’s all or nothing!  If this leafy woman is so keen on pulling you in, you will let her do just that!  You use her own strength against her, using it to increase your momentum as you leap towards her and smash into her with your weapon!  ");
			(monster as Alraune).trapLevel(-6);
		}
	}
	else if(SceneLib.urtaQuest.isUrta()) {
		if(player.hasStatusEffect(StatusEffects.FirstAttack)) {
			player.removeStatusEffect(StatusEffects.FirstAttack);
		}
		else {
			player.createStatusEffect(StatusEffects.FirstAttack,0,0,0,0);
			outputText("Utilizing your skills as a bareknuckle brawler, you make two attacks!\n");
		}
	}
	//Blind
	if(player.hasStatusEffect(StatusEffects.Blind)) {
		outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ");
	}
	if (monster is Basilisk && !player.hasPerk(PerkLib.BasiliskResistance) && !isWieldingRangedWeapon()) {
		if (monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind))
			outputText("Blind basilisk can't use his eyes, so you can actually aim your strikes!  ");
		//basilisk counter attack (block attack, significant speed loss): 
		else if(player.inte/5 + rand(20) < 25) {
			outputText("Holding the basilisk in your peripheral vision, you charge forward to strike it.  Before the moment of impact, the reptile shifts its posture, dodging and flowing backward skillfully with your movements, trying to make eye contact with you. You find yourself staring directly into the basilisk's face!  Quickly you snap your eyes shut and recoil backwards, swinging madly at the lizard to force it back, but the damage has been done; you can see the terrible grey eyes behind your closed lids, and you feel a great weight settle on your bones as it becomes harder to move.");
			player.addCombatBuff('spe', -20);
			player.removeStatusEffect(StatusEffects.FirstAttack);
			combatRoundOver();
			flags[kFLAGS.BASILISK_RESISTANCE_TRACKER] += 2;
			return;
		}
		//Counter attack fails: (random chance if PC int > 50 spd > 60; PC takes small physical damage but no block or spd penalty)
		else {
			outputText("Holding the basilisk in your peripheral vision, you charge forward to strike it.  Before the moment of impact, the reptile shifts its posture, dodging and flowing backward skillfully with your movements, trying to make eye contact with you. You twist unexpectedly, bringing your [weapon] up at an oblique angle; the basilisk doesn't anticipate this attack!  ");
		}
	}
	if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
		(monster as FrostGiant).giantBoulderHit(0);
		enemyAI();
		return;
	}
	//Worms are special
	if(monster.short == "worms") {
		//50% chance of hit (int boost)
		if(rand(100) + player.inte/3 >= 50) {
			var dam:int = int(player.str/5 - rand(5));
			if(dam == 0) dam = 1;
			outputText("You strike at the amalgamation, crushing countless worms into goo, dealing <b><font color=\"#800000\">" + dam + "</font></b> damage.\n\n");
			monster.HP -= dam;
			if(monster.HP <= 0) {
				doNext(endHpVictory);
				return;
			}
		}
		//Fail
		else {
			outputText("You attempt to crush the worms with your reprisal, only to have the collective move its individual members, creating a void at the point of impact, leaving you to attack only empty air.\n\n");
		}
		if(player.hasStatusEffect(StatusEffects.FirstAttack)) {
			attack();
			return;
		}
		enemyAI();
		return;
	}
	
	//Determine if dodged!
	if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
		//Akbal dodges special education
		if(monster.short == "Akbal") outputText("Akbal moves like lightning, weaving in and out of your furious strikes with the speed and grace befitting his jaguar body.\n");
		else if(monster.short == "plain girl") outputText("You wait patiently for your opponent to drop her guard. She ducks in and throws a right cross, which you roll away from before smacking your [weapon] against her side. Astonishingly, the attack appears to phase right through her, not affecting her in the slightest. You glance down to your [weapon] as if betrayed.\n");
		else if(monster.short == "kitsune") {
			//Player Miss:
			outputText("You swing your [weapon] ferociously, confident that you can strike a crushing blow.  To your surprise, you stumble awkwardly as the attack passes straight through her - a mirage!  You curse as you hear a giggle behind you, turning to face her once again.\n\n");
		}
		else {
			if (player.weapon == weapons.HNTCANE && rand(2) == 0) {
				if (rand(2) == 0) outputText("You slice through the air with your cane, completely missing your enemy.");
				else outputText("You lunge at your enemy with the cane.  It glows with a golden light but fails to actually hit anything.");
			}
			if(monster.spe - player.spe < 8) outputText("[monster A][monster name] narrowly avoids your attack!");
			if(monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText("[monster A][monster name] dodges your attack with superior quickness!");
			if(monster.spe - player.spe >= 20) outputText("[monster A][monster name] deftly avoids your slow attack.");
			outputText("\n");
			if(player.hasStatusEffect(StatusEffects.FirstAttack)) {
				attack();
				return;
			}
			else outputText("\n");
		}
		enemyAI();
		return;
	}
	//BLOCKED ATTACK:
	if(monster.hasStatusEffect(StatusEffects.Earthshield) && rand(4) == 0) {
		outputText("Your strike is deflected by the wall of sand, dirt, and rock!  Damn!\n");
		if(player.hasStatusEffect(StatusEffects.FirstAttack)) {
			attack();
			return;
		}
		else outputText("\n");
		enemyAI();
		return;
	}
	meleeDamageAcc();
}
	
public function meleeDamageAcc():void {
	var accMelee:Number = 0;
	accMelee += (meleeAccuracy() / 2);
	if (flags[kFLAGS.ATTACKS_ACCURACY] > 0) accMelee -= flags[kFLAGS.ATTACKS_ACCURACY];
	if (player.weaponName == "Truestrike sword") accMelee = 100;
//	fatigue(oneArrowTotalCost());
	if (rand(100) < accMelee) {
	var damage:Number = 0;
	//------------
	// DAMAGE
	//------------
	//Determine damage
	//BASIC DAMAGE STUFF
	
	damage += player.str;
	damage += player.scalingBonusStrength() * 0.25;
	if (player.hasPerk(PerkLib.HoldWithBothHands) && player.weapon != WeaponLib.FISTS && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) damage *= 1.2;
	if (damage < 10) damage = 10;
	
	//Weapon addition!
	if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.03));
	else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (2.5 + ((player.weaponAttack - 50) * 0.025));
	else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (3.75 + ((player.weaponAttack - 100) * 0.02));
	else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (4.75 + ((player.weaponAttack - 150) * 0.015));
	else damage *= (5.5 + ((player.weaponAttack - 200) * 0.01));
	//Bonus sand trap damage!
	if (monster.hasStatusEffect(StatusEffects.Level) && (monster is SandTrap || monster is Alraune)) damage = Math.round(damage * 1.75);
	//All special weapon effects like...fire/ice
	if (player.weapon == weapons.L_WHIP) {
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
	}
	if (player.haveWeaponForJouster()) {
		if (player.isMeetingNaturalJousterReq()) damage *= 3;
		if (player.isMeetingNaturalJousterMasterGradeReq()) damage *= 5;
	}
	if (player.weapon == weapons.RCLAYMO && player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
	}
	if (player.weapon == weapons.SCLAYMO && player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 0.2;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 5;
	}
	if (player.weapon == weapons.TCLAYMO && player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
		if (monster.hasPerk(PerkLib.DarknessNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.LightningVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.DarknessVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.LightningNature)) damage *= 0.2;
	}
	if (player.weapon == weapons.ACLAYMO && player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
		if (monster.hasPerk(PerkLib.DarknessNature)) damage *= 0.2;
		if (monster.hasPerk(PerkLib.LightningVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.DarknessVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.LightningNature)) damage *= 5;
	}
	if (player.weapon == weapons.NPHBLDE || player.weapon == weapons.MASAMUN || player.weapon == weapons.SESPEAR || player.weapon == weapons.WG_GAXE || player.weapon == weapons.KARMTOU) {
		if (monster.cor < 33) damage = Math.round(damage * 1.0);
		else if (monster.cor < 50) damage = Math.round(damage * 1.1);
		else if (monster.cor < 75) damage = Math.round(damage * 1.2);
		else if (monster.cor < 90) damage = Math.round(damage * 1.3);
		else damage = Math.round(damage * 1.4);
	}
	if (player.weapon == weapons.EBNYBLD || player.weapon == weapons.BLETTER || player.weapon == weapons.DSSPEAR || player.weapon == weapons.DE_GAXE || player.weapon == weapons.YAMARG) {
		if (monster.cor >= 66) damage = Math.round(damage * 1.0);
		else if (monster.cor >= 50) damage = Math.round(damage * 1.1);
		else if (monster.cor >= 25) damage = Math.round(damage * 1.2);
		else if (monster.cor >= 10) damage = Math.round(damage * 1.3);
		else damage = Math.round(damage * 1.4);
	}
	if (player.weapon == weapons.FRTAXE && monster.isFlying()) damage *= 1.5;
	//Determine if critical hit!
	var crit:Boolean = false;
	var critChance:int = 5;
	var critDamage:Number = 1.75;
	if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
		if (player.inte <= 100) critChance += (player.inte - 50) / 5;
		if (player.inte > 100) critChance += 10;
	}
	if (player.hasPerk(PerkLib.JobDervish) && (player.weaponPerk != "Large" || player.weaponPerk != "Staff")) critChance += 10;
	if (player.hasPerk(PerkLib.WeaponMastery) && player.weaponPerk == "Large" && player.str >= 100) critChance += 10;
	if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
	if (player.weapon == weapons.MASAMUN || (player.weapon == weapons.WG_GAXE && monster.cor > 66) || ((player.weapon == weapons.DE_GAXE || player.weapon == weapons.YAMARG) && monster.cor < 33)) critChance += 10;
	if (monster.isImmuneToCrits()) critChance = 0;
	if (rand(100) < critChance) {
		crit = true;
		if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && (player.weaponName == "deadly spear" || player.weaponName == "deadly lance" || player.weaponName == "deadly trident")) critDamage += 0.75;
		if ((player.weapon == weapons.WG_GAXE && monster.cor > 66) || (player.weapon == weapons.DE_GAXE && monster.cor < 33)) critDamage += 0.1;
		damage *= critDamage;
	}
	//Apply AND DONE!
	damage *= (monster.damagePercent(false, true) / 100);
	//Damage post processing!
	//Thunderous Strikes
	if(player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80)
		damage *= 1.2;
		
	if (player.hasPerk(PerkLib.ChiReflowMagic)) damage *= UmasShop.NEEDLEWORK_MAGIC_REGULAR_MULTI;
	if (player.hasPerk(PerkLib.ChiReflowAttack)) damage *= UmasShop.NEEDLEWORK_ATTACK_REGULAR_MULTI;
	if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
	if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
	if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
	if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
	//One final round
	damage = Math.round(damage);
	
	//ANEMONE SHIT
	if(monster.short == "anemone" && !isWieldingRangedWeapon()) {
		//hit successful:
		//special event, block (no more than 10-20% of turns, also fails if PC has >75 corruption):
		if(rand(10) <= 1) {
			outputText("Seeing your [weapon] raised, the anemone looks down at the water, angles her eyes up at you, and puts out a trembling lip.  ");
			if(player.cor < 75) {
				outputText("You stare into her hangdog expression and lose most of the killing intensity you had summoned up for your attack, stopping a few feet short of hitting her.\n");
				damage = 0;
				//Kick back to main if no damage occured!
				if(monster.HP > 0 && monster.lust < monster.maxLust()) {
					if(player.hasStatusEffect(StatusEffects.FirstAttack)) {
						attack();
						return;
					}
					enemyAI();
				}
				else {
					if(monster.HP <= 0) doNext(endHpVictory);
					else doNext(endLustVictory);
				}
				return;
			}
			else outputText("Though you lose a bit of steam to the display, the drive for dominance still motivates you to follow through on your swing.");
		}
	}
	if(monster.short == "sea anemone" && !isWieldingRangedWeapon()) {
		//hit successful:
		//special event, block (no more than 10-20% of turns, also fails if PC has >75 corruption):
		if(rand(10) <= 1) {
			outputText("Seeing your [weapon] raised, the anemone looks down at the ocean, angles her eyes up at you, and puts out a trembling lip.  ");
			if(player.cor < 75) {
				outputText("You stare into her hangdog expression and lose most of the killing intensity you had summoned up for your attack, stopping a few feet short of hitting her.\n");
				damage = 0;
				//Kick back to main if no damage occured!
				if(monster.HP > 0 && monster.lust < monster.maxLust()) {
					if(player.hasStatusEffect(StatusEffects.FirstAttack)) {
						attack();
						return;
					}
					enemyAI();
				}
				else {
					if(monster.HP <= 0) doNext(endHpVictory);
					else doNext(endLustVictory);
				}
				return;
			}
			else outputText("Though you lose a bit of steam to the display, the drive for dominance still motivates you to follow through on your swing.");
		}
	}

	// Have to put it before doDamage, because doDamage applies the change, as well as status effects and shit.
	if (monster is Doppleganger)
	{
		if (!monster.hasStatusEffect(StatusEffects.Stunned))
		{
			if (damage > 0 && player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= 1.1;
			if (damage > 0 && player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
			if (damage > 0 && player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
			if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
			if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
			if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
			if (damage > 0) damage = doDamage(damage, false);
			(monster as Doppleganger).mirrorAttack(damage);
			return;
		}
		
		// Stunning the doppleganger should now "buy" you another round.
	}
	if (player.weapon == weapons.HNTCANE) {
		switch(rand(2)) {
			case 0:
				outputText("You swing your cane through the air. The light wood lands with a loud CRACK that is probably more noisy than painful. ");
				damage *= 0.5;
				break;
			case 1:
				outputText("You brandish your cane like a sword, slicing it through the air. It thumps against your adversary, but doesn’t really seem to harm them much. ");
				damage *= 0.5;
				break;
			default:
		}
	}
	if(damage > 0) {
		var vbladeeffect:Boolean = false;
		var vbladeeffectChance:int = 1;
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= 1.1;
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.weapon == weapons.VBLADE && (rand(100) < vbladeeffectChance)) {
			vbladeeffect = true;
			damage *= 5;
		}
		damage = doDamage(damage);
	}
	if(damage <= 0) {
		damage = 0;
		outputText("Your attacks are deflected or blocked by [monster a] [monster name].");
	}
	else {
		if (flags[kFLAGS.FERAL_COMBAT_MODE] == 1 && (player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon())) outputText("You growl and savagely rend [monster a] [monster name] with your claws. ");
		else if (vbladeeffect == true) outputText("As you strike, the sword shine with a red glow as somehow you aim straight for [monster a] [monster name] throat. ");
		else outputText("You hit [monster a] [monster name]! ");
		if (crit == true) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
	}
	if (player.hasPerk(PerkLib.BrutalBlows) && player.str > 75) {
		if (monster.armorDef > 0) outputText("\nYour hits are so brutal that you damage [monster a] [monster name]'s defenses!");
		if (monster.armorDef - 5 > 0) monster.armorDef -= 5;
		else monster.armorDef = 0;
	}
	//Damage cane.
	if (player.weapon == weapons.HNTCANE) {
		flags[kFLAGS.ERLKING_CANE_ATTACK_COUNTER]++;
		//Break cane
		if (flags[kFLAGS.ERLKING_CANE_ATTACK_COUNTER] >= 10 && rand(20) == 0) {
			outputText("\n<b>The cane you're wielding finally snaps! It looks like you won't be able to use it anymore.</b>");
			player.setWeapon(WeaponLib.FISTS);
		}
	}
	if(damage > 0) {
		//Lust raised by anemone contact!
		if((monster.short == "sea anemone" || monster.short == "anemone") && !isWieldingRangedWeapon()) {
			outputText("\nThough you managed to hit the "+monster.short+", several of the tentacles surrounding her body sent home jolts of venom when your swing brushed past them.");
			//(gain lust, temp lose str/spd)
			(monster as Anemone).applyVenom((1 + rand(2)));
		}
		
		//Lust raising weapon bonuses
		if(monster.lustVuln > 0) {
			if(player.weaponPerk == "Aphrodisiac Weapon" || player.weapon == weapons.DEPRAVA || player.weapon == weapons.ASCENSU) {
				outputText("\n[monster A][monster name] shivers as your weapon's 'poison' goes to work.");
				monster.teased(monster.lustVuln * (5 + player.cor / 10));
			}
			var whipLustDmg:Number = 0;
			var whipCorSelf:Number = 0;
			var whipLustSelf:Number = 0;
			var hasArcaneLash:Boolean = player.hasPerk(PerkLib.ArcaneLash);
			if ((player.weapon == weapons.WHIP || player.weapon == weapons.PWHIP || player.weapon == weapons.NTWHIP) && rand(2) == 0) {
				whipLustDmg = (5 + player.cor / 12) * (hasArcaneLash ? 1.4 : 1); // 5-13.3 (7-18.7 w/perk)
				whipCorSelf = 0;
				whipLustSelf = 0;
			} else if (player.weapon == weapons.SUCWHIP || player.weapon == weapons.PSWHIP) {
				whipLustDmg = (20 + player.cor / 15) * (hasArcaneLash ? 1.8 : 1); // 20-26.7 (36-48 w/perk)
				whipCorSelf = 0.3;
				whipLustSelf = (rand(2) == 0)?0:1; // 50% +1
			} else if (player.weapon == weapons.L_WHIP) {
				whipLustDmg = (10 + player.cor / 5) * (hasArcaneLash ? 2.0 : 1); // 10-30 (20-60 w/perk)
				whipCorSelf = 0.6;
				whipLustSelf = (rand(4) == 0) ? 0 : 1; // 75% +1
			}
			if (whipLustDmg > 0) {
				var s:String = monster.plural?"":"s";
				if (rand(2) == 0) {
					outputText("\n[monster A][monster name] shiver" +s+" and get" +s +" turned on from the whipping.");
				} else {
					outputText("\n[monster A][monster name] shiver" +s +" and moan" +s +" involuntarily from the whip's touches.");
				}
				if(whipCorSelf > 0 && player.cor < 90) dynStats("cor", whipCorSelf);
				monster.teased(monster.lustVuln * whipLustDmg);
				if(whipLustSelf > 0) {
					outputText(" You get a sexual thrill from it. ");
					dynStats("lus", whipLustSelf);
				}
			}
		}
		//Selfcorrupting weapons
		if ((player.weapon == weapons.DEMSCYT || player.weapon == weapons.EBNYBLD) && player.cor < 90) dynStats("cor", 0.3);
		//Selfpurifying and Lust lowering weapons
		if (player.weapon == weapons.NPHBLDE && player.cor > 10) dynStats("cor", -0.3);
		if (player.weapon == weapons.EXCALIB) {
			if (player.cor > 10) dynStats("cor", -0.3);
			var excaliburLustSelf:Number = 0;
			excaliburLustSelf = (rand(2) == 0)?0:1;
			if (excaliburLustSelf > 0) dynStats("lus", -excaliburLustSelf);
		}
		//Weapon Procs!
		//10% Stun chance
		if ((player.weapon == weapons.WARHAMR || player.weapon == weapons.D_WHAM_ || player.weapon == weapons.OTETSU || (player.weapon == weapons.S_GAUNT && !player.hasPerk(PerkLib.MightyFist))) && rand(10) == 0 && !monster.hasPerk(PerkLib.Resolute)) {
			outputText("\n[monster A][monster name] reels from the brutal blow, stunned.");
			if (!monster.hasStatusEffect(StatusEffects.Stunned)) monster.createStatusEffect(StatusEffects.Stunned,rand(2),0,0,0);
		}
		//15% Stun Chance
		if ((player.weapon == weapons.POCDEST || player.weapon == weapons.DOCDEST) && rand(100) < 15 && !monster.hasPerk(PerkLib.Resolute)) {
			outputText("\n[monster A][monster name] reels from the brutal blow, stunned.");
			if (!monster.hasStatusEffect(StatusEffects.Stunned)) monster.createStatusEffect(StatusEffects.Stunned,rand(2),0,0,0);
		}
		//20% Stun chance
		if (player.isFistOrFistWeapon() && player.weapon != weapons.KARMTOU && player.hasPerk(PerkLib.MightyFist) && rand(5) == 0 && !monster.hasPerk(PerkLib.Resolute)) {
			outputText("\n[monster A][monster name] reels from the brutal blow, stunned.");
			if (!monster.hasStatusEffect(StatusEffects.Stunned)) monster.createStatusEffect(StatusEffects.Stunned,rand(2),0,0,0);
		}
		//25% Stun chance
		if (player.weapon != weapons.KARMTOU && player.hasPerk(PerkLib.MightyFist) && rand(4) == 0 && !monster.hasPerk(PerkLib.Resolute)) {
			outputText("\n[monster A][monster name] reels from the brutal blow, stunned.");
			if (!monster.hasStatusEffect(StatusEffects.Stunned)) monster.createStatusEffect(StatusEffects.Stunned,rand(2),0,0,0);
		}
		//30% Stun chance
		if (player.weapon == weapons.ZWNDER && !monster.hasStatusEffect(StatusEffects.Stunned) && rand(10) <= 2 && !monster.hasPerk(PerkLib.Resolute)) {
			outputText("\n[monster A][monster name] reels from the brutal blow, stunned.");
			if (!monster.hasStatusEffect(StatusEffects.Stunned)) monster.createStatusEffect(StatusEffects.Stunned,3,0,0,0);
		}
		//10% Bleed chance
		if (player.weapon == weapons.CLAWS && rand(10) == 0 && !monster.hasStatusEffect(StatusEffects.IzmaBleed))
		{
			if (monster.hasPerk(PerkLib.EnemyConstructType)) {
				if (monster is LivingStatue)
				{
					outputText("Despite the rents you've torn in its stony exterior, the statue does not bleed.");
				}
				else outputText("Despite the rents you've torn in its exterior, [monster a] [monster name] does not bleed.");
			}
			else
			{
				monster.createStatusEffect(StatusEffects.IzmaBleed,3,0,0,0);
				if(monster.plural) outputText("\n[monster A][monster name] bleed profusely from the many bloody gashes your [weapon] leave behind.");
				else outputText("\n[monster A][monster name] bleeds profusely from the many bloody gashes your [weapon] leave behind.");
			}
		}
		//25% Bleed chance
		if ((player.weapon == weapons.H_GAUNT || player.weapon == weapons.CNTWHIP) && rand(4) == 0 && !monster.hasStatusEffect(StatusEffects.IzmaBleed))
		{
			if (monster.hasPerk(PerkLib.EnemyConstructType)) {
				if (monster is LivingStatue)
				{
					outputText("Despite the rents you've torn in its stony exterior, the statue does not bleed.");
				}
				else outputText("Despite the rents you've torn in its exterior, [monster a] [monster name] does not bleed.");
			}
			else
			{
				monster.createStatusEffect(StatusEffects.IzmaBleed,3,0,0,0);
				if(monster.plural) outputText("\n[monster A][monster name] bleed profusely from the many bloody gashes your [weapon] leave behind.");
				else outputText("\n[monster A][monster name] bleeds profusely from the many bloody gashes your [weapon] leave behind.");
			}
		}
	}
	if (player.weapon == weapons.DSSPEAR) {
	monster.str -= 2;
	monster.spe -= 2;
	if(monster.str < 1) monster.str = 1;
	if(monster.spe < 1) monster.spe = 1;
	if(monster.hasStatusEffect(StatusEffects.NagaVenom))
	{
		monster.addStatusValue(StatusEffects.NagaVenom,2,2);
		monster.addStatusValue(StatusEffects.NagaVenom,1,2);
	}
	else monster.createStatusEffect(StatusEffects.NagaVenom, 2, 2, 0, 0);
	}
	
	if (monster is JeanClaude && !player.hasStatusEffect(StatusEffects.FirstAttack))
	{
		if (monster.HP < 1 || monster.lust > monster.maxLust())
		{
			// noop
		}
		if (player.lust <= 30)
		{
			outputText("\n\nJean-Claude doesn’t even budge when you wade into him with your [weapon].");

			outputText("\n\n“<i>Why are you attacking me, slave?</i>” he says. The basilisk rex sounds genuinely confused. His eyes pulse with hot, yellow light, reaching into you as he opens his arms, staring around as if begging the crowd for an explanation. “<i>You seem lost, unable to understand, lashing out at those who take care of you. Don’t you know who you are? Where you are?</i>” That compulsion in his eyes, that never-ending heat, it’s... it’s changing things. You need to finish this as fast as you can.");
		}
		else if (player.lust <= 50)
		{
			outputText("\n\nAgain your [weapon] thumps into Jean-Claude. Again it feels wrong. Again it sends an aching chime through you, that you are doing something that revolts your nature.");

			outputText("\n\n“<i>Why are you fighting your master, slave?</i>” he says. He is bigger than he was before. Or maybe you are smaller. “<i>You are confused. Put your weapon down- you are no warrior, you only hurt yourself when you flail around with it. You have forgotten what you were trained to be. Put it down, and let me help you.</i>” He’s right. It does hurt. Your body murmurs that it would feel so much better to open up and bask in the golden eyes fully, let it move you and penetrate you as it may. You grit your teeth and grip your [weapon] harder, but you can’t stop the warmth the hypnotic compulsion is building within you.");
		}
		else if (player.lust <= 80)
		{
			outputText("\n\n“<i>Do you think I will be angry at you?</i>” growls Jean-Claude lowly. Your senses feel intensified, his wild, musky scent rich in your nose. It’s hard to concentrate... or rather it’s hard not to concentrate on the sweat which runs down his hard, defined frame, the thickness of his bulging cocks, the assured movement of his powerful legs and tail, and the glow, that tantalizing, golden glow, which pulls you in and pushes so much delicious thought and sensation into your head…  “<i>I am not angry. You will have to be punished, yes, but you know that is only right, that in the end you will accept and enjoy being corrected. Come now, slave. You only increase the size of the punishment with this silliness.</i>”");
		}
		else
		{
			outputText("\n\nYou can’t... there is a reason why you keep raising your weapon against your master, but what was it? It can’t be that you think you can defeat such a powerful, godly alpha male as him. And it would feel so much better to supplicate yourself before the glow, lose yourself in it forever, serve it with your horny slut body, the only thing someone as low and helpless as you could possibly offer him. Master’s mouth is moving but you can no longer tell where his voice ends and the one in your head begins... only there is a reason you cling to like you cling onto your [weapon], whatever it is, however stupid and distant it now seems, a reason to keep fighting...");
		}
		
		dynStats("lus", 25);
	}
	outputText("\n");
	checkAchievementDamage(damage);
	WrathWeaponsProc();
	heroBaneProc(damage);
	}
	else {
		
	}
	if(monster.HP <= 0){doNext(endHpVictory); return;}
	if(monster.lust >= monster.maxLust()){doNext(endLustVictory); return;}
	if(player.hasStatusEffect(StatusEffects.FirstAttack)) {
		attack();
		return;
	}
	outputText("\n");
	wrathRegeneration();
	fatigueRecovery();
	manaRegeneration();
	kiRegeneration();
	enemyAI();
}

public function WrathWeaponsProc():void {
	if (player.weapon == weapons.BLETTER) {
		player.takePhysDamage(player.maxHP() * 0.02);
		if (player.HP < 1) {
			doNext(endHpLoss);
			return;
		}
	}
	if (player.isLowGradeWrathWeapon()) {
		if (player.hasPerk(PerkLib.PrestigeJobBerserker) && player.wrath >= 10) player.wrath -= 10;
		else {
			player.takePhysDamage(100);
			if (player.HP < 1) {
				doNext(endHpLoss);
				return;
			}
		}
	}
	if (player.isDualLowGradeWrathWeapon()) {
		if (player.hasPerk(PerkLib.PrestigeJobBerserker) && player.wrath >= 20) player.wrath -= 20;
		else {
			player.takePhysDamage(200);
			if (player.HP < 1) {
				doNext(endHpLoss);
				return;
			}
		}
	}
}

public function heroBaneProc(damage:int = 0):void {
	if (player.hasStatusEffect(StatusEffects.HeroBane)) {
		if(damage > 0){
			outputText("\nYou feel [monster a] [monster name] wounds as well as your owns as the link mirrors the pain back to you for " + damage + " damage!\n");
			player.takePhysDamage(damage);
		}
		if (player.HP < 1) {
			doNext(endHpLoss);
		}
	}
}

public function combatMiss():Boolean {
	return player.spe - monster.spe > 0 && int(Math.random() * (((player.spe - monster.spe) / 4) + 80)) > 80;
}
public function combatParry():Boolean {
	var parryChance:int = 0;
	if (player.hasPerk(PerkLib.Parry) && player.spe >= 50 && player.str >= 50 && player.weapon != WeaponLib.FISTS) {
		if (player.spe <= 100) parryChance += (player.spe - 50) / 5;
		else parryChance += 10;
	}
	if (player.hasPerk(PerkLib.DexterousSwordsmanship)) parryChance += 10;
	if (player.hasPerk(PerkLib.CatchTheBlade) && player.spe >= 50 && player.shieldName == "nothing" && player.isFistOrFistWeapon()) parryChance += 15;
	return rand(100) <= parryChance;
//	trace("Parried!");
}
public function combatCritical():Boolean {
	var critChance:int = 4;
	if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
		if (player.inte <= 100) critChance += (player.inte - 50) / 50;
		if (player.inte > 100) critChance += 1;
	}
	if (player.hasPerk(PerkLib.Blademaster) && (player.weaponVerb == "slash" || player.weaponVerb == "cleave" || player.weaponVerb == "keen cut")) critChance += 5;
	return rand(100) <= critChance;
}

public function combatBlock(doFatigue:Boolean = false):Boolean {
	//Set chance
	var blockChance:int = 20 + player.shieldBlock + Math.floor((player.str - monster.str) / 5);
	if (player.hasPerk(PerkLib.ShieldMastery) && player.tou >= 50) {
		if (player.tou < 100) blockChance += (player.tou - 50) / 5;
		else blockChance += 10;
	}
	if (blockChance < 10) blockChance = 10;
	//Fatigue limit
	var fatigueLimit:int = player.maxFatigue() - physicalCost(10);
	if (blockChance >= (rand(100) + 1) && player.fatigue <= fatigueLimit && player.shieldName != "nothing") {
		if (doFatigue) {
			fatigue(10);
		}
		return true;
	}
	else return false;
}
public function isWieldingRangedWeapon():Boolean {
	return player.weaponName.indexOf("staff") != -1 && player.hasPerk(PerkLib.StaffChanneling);
}

//DEAL DAMAGE
public function doDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
	if (player.hasPerk(PerkLib.Sadist)) {
		damage *= 1.2;
		dynStats("lus", 3);
	}
	if (monster.hasStatusEffect(StatusEffects.DefendMonsterVer)) damage *= (1 - monster.statusEffectv2(StatusEffects.DefendMonsterVer));
	if (monster.HP - damage <= 0) {
		/* No monsters use this perk, so it's been removed for now
		if(monster.hasPerk(PerkLib.LastStrike)) doNext(monster.perk(monster.findPerk(PerkLib.LastStrike)).value1);
		else doNext(endHpVictory);
		*/
		doNext(endHpVictory);
	}
	// Uma's Massage Bonuses
	var sac:StatusEffectClass = player.statusEffectByType(StatusEffects.UmasMassage);
	if (sac)
	{
		if (sac.value1 == UmasShop.MASSAGE_POWER)
		{
			damage *= sac.value2;
		}
	}
	damage = Math.round(damage);
	if (damage < 0) damage = 1;
	if (apply) {
		monster.HP -= damage;
		monster.wrath += Math.round(damage / 10);
		if (monster.wrath > monster.maxWrath()) monster.wrath = monster.maxWrath();
	}
	if (display) {
		if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>"); //Damage
		else if (damage == 0) outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>"); //Miss/block
		else if (damage < 0) outputText("<b>(<font color=\"#008000\">" + damage + "</font>)</b>"); //Heal
	}
	//Isabella gets mad
	if (monster.short == "Isabella") {
		flags[kFLAGS.ISABELLA_AFFECTION]--;
		//Keep in bounds
		if(flags[kFLAGS.ISABELLA_AFFECTION] < 0) flags[kFLAGS.ISABELLA_AFFECTION] = 0;
	}
	//Interrupt gigaflare if necessary.
	if (monster.hasStatusEffect(StatusEffects.Gigafire)) monster.addStatusValue(StatusEffects.Gigafire, 1, damage);
	//Keep shit in bounds.
	if (monster.HP < 0) monster.HP = 0;
	return damage;
}
	
	public static const USEMANA_NORMAL:int = 0;
	public static const USEMANA_MAGIC:int = 1;
	public static const USEMANA_PHYSICAL:int = 2;
	public static const USEMANA_MAGIC_NOBM:int = 3;
	public static const USEMANA_BOW:int = 4;
	public static const USEMANA_WHITE:int = 5;
	public static const USEMANA_BLACK:int = 6;
	public static const USEMANA_WHITE_NOBM:int = 7;
	public static const USEMANA_BLACK_NOBM:int = 8;
	public static const USEMANA_MAGIC_HEAL:int = 9;
	public static const USEMANA_WHITE_HEAL:int = 10;
	public static const USEMANA_BLACK_HEAL:int = 11;
	//Modify mana (mod>0 - subtract, mod<0 - regen)
	public function useManaImpl(mod:Number,type:int=USEMANA_NORMAL):void {
		//Spell reductions
		switch (type) {
			case USEMANA_MAGIC:
			case USEMANA_MAGIC_NOBM:
				mod = spellCost(mod);
				break;
			case USEMANA_WHITE:
			case USEMANA_WHITE_NOBM:
				mod = spellCostWhite(mod);
				break;
			case USEMANA_BLACK:
			case USEMANA_BLACK_NOBM:
				mod = spellCostBlack(mod);
				break;
			case USEMANA_MAGIC_HEAL:
				mod = healCost(mod);
				break;
			case USEMANA_WHITE_HEAL:
				mod = healCostWhite(mod);
				break;
			case USEMANA_BLACK_HEAL:
				mod = healCostBlack(mod);
				break;
		}
		//Blood mages use HP for spells
		if (player.hasPerk(PerkLib.BloodMage)
			&& (type == USEMANA_MAGIC || type == USEMANA_WHITE || type == USEMANA_BLACK)) {
			player.takePhysDamage(mod);
			statScreenRefresh();
			return;
		}
		//Mana restoration buffs!
		if (mod < 0) {
			mod *= manaRecoveryMultiplier();
		}
		player.mana = boundFloat(0, player.mana - mod, player.maxMana());
		if(mod < 0) {
			mainView.statsView.showStatUp( 'mana' );
		}
		if(mod > 0) {
			mainView.statsView.showStatDown( 'mana' );
		}
		statScreenRefresh();
	}
	public function manaRecoveryMultiplier():Number {
		var multi:Number = 1;
		if (player.hasPerk(PerkLib.ControlledBreath) && player.cor < (30 + player.corruptionTolerance())) multi += 0.3;
		if (player.alicornScore() >= 6) multi += 0.1;
		if (player.kitsuneScore() >= 5) {
			if (player.kitsuneScore() >= 10) multi += 1;
			else multi += 0.5;
		}
		if (player.unicornScore() >= 5) multi += 0.05;
		return multi;
	}
	public function fatigueCost(mod:Number,type:Number = USEFATG_NORMAL):Number {
		switch (type) {
			//Spell reductions
			case USEFATG_MAGIC:
			case USEFATG_MAGIC_NOBM:
				return spellCost(mod);
			case USEFATG_WHITE:
			case USEFATG_WHITE_NOBM:
				return spellCostWhite(mod);
			case USEFATG_BLACK:
			case USEFATG_BLACK_NOBM:
				return spellCostBlack(mod);
			case USEFATG_PHYSICAL:
				return physicalCost(mod);
			case USEFATG_BOW:
				return bowCost(mod);
			default:
				return mod;
		}
	}
//Modify fatigue (mod>0 - subtract, mod<0 - regen)//types:
public function fatigueImpl(mod:Number,type:Number  = USEFATG_NORMAL):void {
	mod = fatigueCost(mod,type);
	if (type === USEFATG_MAGIC || type === USEFATG_WHITE || type === USEFATG_BLACK) {
		//Blood mages use HP for spells
		if (player.hasPerk(PerkLib.BloodMage)) {
			player.takePhysDamage(mod);
			statScreenRefresh();
			return;
		}
	}
	if(player.fatigue >= player.maxFatigue() && mod > 0) return;
	if(player.fatigue <= 0 && mod < 0) return;
	//Fatigue restoration buffs!
	if (mod < 0) {
		mod *= fatigueRecoveryMultiplier();
	}
	player.fatigue += mod;
	if(mod < 0) {
		mainView.statsView.showStatUp( 'fatigue' );
	}
	if(mod > 0) {
		mainView.statsView.showStatDown( 'fatigue' );
	}
	dynStats("lus", 0, "scale", false); //Force display fatigue up/down by invoking zero lust change.
	if(player.fatigue > player.maxFatigue()) player.fatigue = player.maxFatigue();
	if(player.fatigue < 0) player.fatigue = 0;
	statScreenRefresh();
}
	public function fatigueRecoveryMultiplier():Number {
		var multi:Number = 1;
		if (player.hasPerk(PerkLib.HistorySlacker) || player.hasPerk(PerkLib.PastLifeSlacker)) multi += 0.2;
		if (player.hasPerk(PerkLib.ControlledBreath) && player.cor < (30 + player.corruptionTolerance())) multi += 0.2;
		if (player.hasPerk(PerkLib.SpeedyRecovery)) multi += 1;
		return multi;
	}
//ENEMYAI!
public function enemyAIImpl():void {
	if(monster.HP < 1) {
		doNext(endHpVictory);
		return;
	}
	monster.doAI();
	if (player.hasStatusEffect(StatusEffects.TranceTransformation)) player.ki -= 50;
	if (player.hasStatusEffect(StatusEffects.CrinosShape)) player.wrath -= mspecials.crinosshapeCost();
	combatRoundOver();
}
public function finishCombat():void
{
	var hpVictory:Boolean = monster.HP < 1;
	clearOutput();
	if (hpVictory) {
		outputText("You defeat [monster a] [monster name].\n");
	} else {
		outputText("You smile as [monster a] [monster name] collapses and begins masturbating feverishly.");
	}
	cleanupAfterCombat();
}
public function dropItem(monster:Monster, nextFunc:Function = null):void {
	if (nextFunc == null) nextFunc = camp.returnToCampUseOneHour;
	if(monster.hasStatusEffect(StatusEffects.NoLoot)) {
		return;
	}
	var itype:ItemType = monster.dropLoot();
	if(!CoC.instance.plotFight){
		//Chance of armor if at level 1 pierce fetish
		if(!(monster is Ember) && !(monster is Kiha) && !(monster is Hel) && !(monster is Isabella)
			&& flags[kFLAGS.PC_FETISH] == 1 && rand(10) == 0 && !player.hasItem(armors.SEDUCTA, 1) && !SceneLib.ceraphFollowerScene.ceraphIsFollower()) {
			itype = armors.SEDUCTA;
		}

		if(rand(200) == 0 && player.level >= 7) itype = consumables.BROBREW;
		if(rand(200) == 0 && player.level >= 7) itype = consumables.BIMBOLQ;
		if(rand(1000) == 0 && player.level >= 7) itype = consumables.RAINDYE;
		//Chance of eggs if Easter!
		if(rand(6) == 0 && isEaster()) {
			itype = randomChoice(
				consumables.BROWNEG,
				consumables.L_BRNEG,
				consumables.PURPLEG,
				consumables.L_PRPEG,
				consumables.BLUEEGG,
				consumables.L_BLUEG,
				consumables.PINKEGG,
				consumables.NPNKEGG,
				consumables.L_PNKEG,
				consumables.L_WHTEG,
				consumables.WHITEEG,
				consumables.BLACKEG,
				consumables.L_BLKEG
			);
		}
	}
	//Bonus loot overrides others
	if (flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] != "") {
		itype = ItemType.lookupItem(flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID]);
	}
	monster.handleAwardItemText(itype); //Each monster can now override the default award text
	if (itype != null) {
		if (inDungeon) {
			inventory.takeItem(itype, playerMenu);
		} else {
			inventory.takeItem(itype, nextFunc);
		}
	}
}
public function awardPlayer(nextFunc:Function = null):void
{
	if (nextFunc == null) nextFunc = camp.returnToCampUseOneHour; //Default to returning to camp.
	if (player.countCockSocks("gilded") > 0) {
		//trace( "awardPlayer found MidasCock. Gems bumped from: " + monster.gems );
		
		var bonusGems:int = monster.gems * 0.15 + 5 * player.countCockSocks("gilded"); // int so AS rounds to whole numbers
		monster.gems += bonusGems;
		//trace( "to: " + monster.gems )
	}
	if (player.hasPerk(PerkLib.HistoryFortune) || player.hasPerk(PerkLib.PastLifeFortune)) {
		var bonusGems2:int = monster.gems * 0.15;
		monster.gems += bonusGems2;
	}
	if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) {
		var bonusGems3:int = (monster.gems * 0.04) * (player.teaseLevel * 0.2);
		if (monster.lust >= monster.maxLust()) monster.gems += bonusGems3;
	}
	if (player.hasPerk(PerkLib.AscensionFortune)) {
		monster.gems *= 1 + (player.perkv1(PerkLib.AscensionFortune) * 0.1);
		monster.gems = Math.round(monster.gems);
	}
	monster.handleAwardText(); //Each monster can now override the default award text
	if (!inDungeon && !inRoomedDungeon && !prison.inPrison) { //Not in dungeons
		if (nextFunc != null) doNext(nextFunc);
		else doNext(playerMenu);
	}
	else {
		if (nextFunc != null) doNext(nextFunc);
		else doNext(playerMenu);
	}
	dropItem(monster, nextFunc);
	inCombat = false;
	player.gems += monster.gems;
	player.XP += monster.XP;
	mainView.statsView.showStatUp('xp');
	dynStats("lust", 0, "scale", false); //Forces up arrow.
}

//Update combat status effects
private function combatStatusesUpdate():void {
	//old outfit used for fetish cultists
	var oldOutfit:String = "";
	var changed:Boolean = false;
	//Reset menuloc
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
	hideUpDown();
	if (player.hasStatusEffect(StatusEffects.MinotaurKingMusk))
	{
		dynStats("lus+", 3);
	}
	/**
	 * [StatusEffectType effect, int statValue, int changeBy, String onRemove, String onUpdate]
	 */
	var statuses:Array = [
		[StatusEffects.Sealed, 1, -1, "", "<b>One of your combat abilities is currently sealed by magic!</b>\n\n"],
		[StatusEffects.Sealed2, 1, -1, "", "<b>One of your combat abilities is currently disabled as aftereffect of recent enemy attack!</b>\n\n"],
		[StatusEffects.WhipSilence, 1, -1, "<b>The constricting cords encircling your neck fall away, their flames guttering into nothingness. It seems even a Demon Queen’s magic has an expiration date.</b>\n\n", ""],
		[StatusEffects.TaintedMind, 1, 1, "Some of the drider’s magic fades, and you heft your [weapon] with a grin. No more of this ‘fight like a demon’ crap!\n\n","There is a thin film of filth layered upon your mind, latent and waiting. The drider said something about fighting like a demon. Is this supposed to interfere with your ability to fight?\n\n"],
		[StatusEffects.ThroatPunch, 1, -1, "Your wind-pipe recovers from Isabella's brutal hit.  You'll be able to focus to cast spells again!\n\n", "Thanks to Isabella's wind-pipe crushing hit, you're having trouble breathing and are <b>unable to cast spells as a consequence.</b>\n\n"],
		[StatusEffects.HeroBane, 1, -1, "<b>You feel your body lighten as the curse linking your vitality to that of the omnibus ends.</b>\n\n"],
		[StatusEffects.Berzerking, 1, -1, "<b>Berserker effect wore off!</b>\n\n", ""],
		[StatusEffects.Lustzerking, 1, -1, "<b>Lustzerker effect wore off!</b>\n\n", ""],
		[StatusEffects.OniRampage, 1, -1, "<b>Your rage wear off.</b>\n\n", ""],
		[StatusEffects.Maleficium, 1, -1, "<b>Maleficium effect wore off!</b>\n\n", ""],
		[StatusEffects.ChargeWeapon, 2, -1, "<b>Charged Weapon effect wore off!</b>\n\n", ""],
		[StatusEffects.ChargeArmor, 2, -1, "<b>Charged Armor effect wore off!</b>\n\n", ""],
		[StatusEffects.EverywhereAndNowhere, 1, -1, "<b>Everywhere and nowhere effect ended!</b>\n\n", ""],
		[StatusEffects.CooldownInkSpray, 1, -1, "", ""],
		[StatusEffects.CooldownEveryAndNowhere, 1, -1, "", ""],
		[StatusEffects.CooldownTailSmack, 1, -1, "", ""],
		[StatusEffects.CooldownStoneClaw, 1, -1, "", ""],
		[StatusEffects.CooldownTailSlam, 1, -1, "", ""],
		[StatusEffects.CooldownWingBuffet, 1, -1, "", ""],
		[StatusEffects.CooldownKick, 1, -1, "", ""],
		[StatusEffects.CooldownFreezingBreath, 1, -1, "", ""],
		[StatusEffects.CooldownFreezingBreathYeti, 1, -1, "", ""],
		[StatusEffects.CooldownPhoenixFireBreath, 1, -1, "", ""],
		[StatusEffects.CooldownIllusion, 1, -1, "", ""],
		[StatusEffects.Illusion, 1, -1, "", ""],
		[StatusEffects.CooldownTerror, 1, -1, "", ""],
		[StatusEffects.CooldownFascinate, 1, -1, "", ""],
		[StatusEffects.CooldownCompellingAria, 1, -1, "", ""],
		[StatusEffects.CooldownOniRampage, 1, -1, "", ""],
		[StatusEffects.WindWall, 2, -1, "<b>Wind Wall effect wore off!</b>\n\n", ""],
		[StatusEffects.StoneSkin, 2, -1, "<b>Stone Skin effect wore off!</b>\n\n", ""],
		[StatusEffects.BarkSkin, 2, -1, "<b>Bark Skin effect wore off!</b>\n\n", ""],
		[StatusEffects.MetalSkin, 2, -1, "<b>Metal Skin effect wore off!</b>\n\n", ""],
		[StatusEffects.HurricaneDance, 1, -1, "<b>Hurricane Dance effect wore off!</b>\n\n", ""],
		[StatusEffects.CooldownEclipsingShadow, 1, -1, ""],
		[StatusEffects.CooldownSonicScream, 1, -1, "", ""],
		[StatusEffects.CooldownTornadoStrike, 1, -1, "", ""],
		[StatusEffects.SecondWindRegen, 2, -1, "", ""],
		[StatusEffects.Flying, 1, -1, "<b>You land to tired to keep flying.</b>\n\n", "<b>You keep making circles in the air around your opponent.</b>\n\n"],
		[StatusEffects.Blizzard, 1, -1, "<b>Blizzard spell exhausted all of it power and need to be casted again to provide protection from the fire attacks again!</b>\n\n", "<b>Surrounding your blizzard slowly loosing it protective power.</b>\n\n"],
		[StatusEffects.EarthStance, 1, -1, "<b>Earth Stance effect wore off!</b>\n\n", ""]
	];
	for each(var st:Array in statuses){
		if(player.hasStatusEffect(st[0])){
			player.addStatusValue(st[0], st[1], st[2]);
			var se:StatusEffectClass = player.statusEffectByType(st[0]);
			if(se["value"+st[1]] <= 0){
				player.removeStatusEffect(st[0]);
				outputText(st[3]);
			} else {
				outputText(st[4]);
			}
		}
	}
	if (player.hasStatusEffect(StatusEffects.PigbysHands))
	{
		dynStats("lus", 5);
	}
	if (player.hasStatusEffect(StatusEffects.PurpleHaze)) {
		player.addStatusValue(StatusEffects.PurpleHaze, 1, -1);
		if (player.statusEffectv1(StatusEffects.PurpleHaze) <= 0)
		{
			player.removeStatusEffect(StatusEffects.PurpleHaze);
			player.removeStatusEffect(StatusEffects.Blind);
			outputText("The swirling mists that once obscured your vision part, allowing you to see your foe once more! <b>You are no longer blinded!</b>\n\n");
		}
		else
		{
			outputText("Your vision is still clouded by swirling purple mists bearing erotic shapes. You are effectively blinded and a little turned on by the display.\n\n");
		}
	}
	if (player.hasStatusEffect(StatusEffects.LethicesRapeTentacles))
	{
		player.addStatusValue(StatusEffects.LethicesRapeTentacles, 1, -1);

		if (player.statusEffectv3(StatusEffects.LethicesRapeTentacles) != 0)
		{
			player.addStatusValue(StatusEffects.LethicesRapeTentacles, 2, 1);

			var tentaround:Number = player.statusEffectv2(StatusEffects.LethicesRapeTentacles);

			if (tentaround == 1)
			{
				outputText("Taking advantage of your helpless state, the tentacles wind deeper under your [armor], caressing your [nipples] and coating your [butt] in slippery goo. One even seeks out your crotch, none-too-gently prodding around for weak points.\n\n");
				dynStats("lus", 5);
			}
			else if (tentaround == 2)
			{
				outputText("Now that they’ve settled in, the tentacles go to work on your body, rudely molesting every sensitive place they can find.");
				if (player.hasCock()) outputText(" They twirl and writhe around your [cocks].");
				if (player.hasVagina()) outputText(" One flosses your nether-lips, rubbing slippery bumps maddenly against your [clit].");
				outputText(" " + num2Text(player.totalNipples()) + " tendrils encircle your [nipples]");
				if (player.hasFuckableNipples()) outputText(", threatening to slide inside them at a moment’s notice");
				else
				{
					outputText(", pinching and tugging them");
					if (player.isLactating()) outputText(", squeezing out small jets of milk");
				}
				outputText(". Worst of all is the tentacle slithering between your buttcheeks. It keeps stopping to rub around the edge of your [asshole]. You really ought to break free...\n\n");
				dynStats("lus", 5);
			}
			else if (tentaround == 3)
			{
				outputText("Another inky length rises up from the floor and slaps against your face, inexpertly attempting to thrust itself inside your mouth. Resenting its temerity, you steadfastly hold your lips closed and turn your head away. The corrupt magics powering this spell won’t let you get off so easily, though. The others redouble their efforts, inundating you with maddening pleasure. You can’t help but gasp and moan, giving the oiled feeler all the opening it needs to enter your maw.\n\n");
				dynStats("lus", 5);
			}
			else if (tentaround == 4)
			{
				outputText("If you thought having one tentacle in your mouth was bad, then the two floating in front of you are potentially terrifying. Unfortunately, they turn out to be mere distractions. The tendril plying your buns rears back and stabs inside, splitting your sphincter");
				if (player.hasVagina())
				{
					outputText(" while its brother simultaneously pierces your tender folds, rapaciously double-penetrating you");
					if (player.hasVirginVagina()) outputText(" <b>You've come all this way only to lose your virginity to these things!</b>");
				}
				outputText(".");
				if (player.hasFuckableNipples()) outputText(" Your [nipples] are similarly entered.");
				if (player.hasCock()) outputText(" And [eachCock] is suddenly coated in slimy, extraplanar oil and pumped with rapid, sure strokes.");
				outputText(" There’s too much. If you don’t break free, you’re going to wind up losing to a simple spell!\n\n");
				dynStats("lus", 10);
			}
			else
			{
				outputText("You’ve really fucked up now. An entire throne room full of demons is watching a bunch of summoned tentacles rape you in every hole, bouncing your body back and forth with the force of their thrusts, repeatedly spilling their corruptive payloads into your receptive holes. The worst part is");
				if (player.cor >= 50) outputText(" how much of a bitch it makes you look like... and how good it feels to be Lethice’s bitch.");
				else outputText(" how dirty it makes you feel... and how good it feels to be dirty.\n\n");
				dynStats("lus", 10, "cor", 1);
			}
		}
		else
		{
			outputText("The tentacles grab at you again!");
			if (player.canFly()) outputText(" No matter how they strain, they can’t reach you.\n\n");
			else if (combatMiss() || player.hasPerk(PerkLib.Evade) || player.hasPerk(PerkLib.Flexibility)) outputText(" You twist out of their slick, bizarrely sensuous grasp for now.\n\n");
			else
			{
				outputText(" Damn, they got you! They yank your arms and [legs] taut, holding you helpless in the air for their brothers to further violate. You can already feel a few oily tendrils sneaking under your [armor].\n\n");
				player.changeStatusValue(StatusEffects.LethicesRapeTentacles, 3, 1);
				dynStats("lus", 5);
			}
		}
		if (player.statusEffectv1(StatusEffects.LethicesRapeTentacles) <= 0)
		{
			if (player.statusEffectv3(StatusEffects.LethicesRapeTentacles) != 0)
			{
				outputText("The tentacles in front of you suddenly pop like balloons of black smoke, leaving a greasy mist in their wake. A breeze from nowhere dissipates the remnants of the rapacious tendrils, their magic expended.\n\n");
			}
			else
			{
				outputText("The tentacles holding you abruptly let go, dropping you to the ground. Climbing up, you look around in alarm, but the tendrils have faded into puffs of black smoke. A breeze from nowhere blows them away, their magic expended.\n\n");
			}
			player.removeStatusEffect(StatusEffects.LethicesRapeTentacles);
		}
	}
	monster.combatRoundUpdate();
	//[Silence warning]
	if(player.hasStatusEffect(StatusEffects.GooArmorSilence)) {
		if(player.statusEffectv1(StatusEffects.GooArmorSilence) >= 2 || rand(20) + 1 + player.str / 10 >= 15) {
			//if passing str check, output at beginning of turn
			outputText("<b>The sticky slop covering your mouth pulls away reluctantly, taking more force than you would expect, but you've managed to free your mouth enough to speak!</b>\n\n");
			player.removeStatusEffect(StatusEffects.GooArmorSilence);
		}
		else {
			outputText("<b>Your mouth is obstructed by sticky goo!  You are silenced!</b>\n\n");
			player.addStatusValue(StatusEffects.GooArmorSilence,1,1);
		}
	}
	if(player.hasStatusEffect(StatusEffects.LustStones)) {
		//[When witches activate the stones for goo bodies]
		if(player.isGoo()) {
			outputText("<b>The stones start vibrating again, making your liquid body ripple with pleasure.  The witches snicker at the odd sight you are right now.\n\n</b>");
		}
		//[When witches activate the stones for solid bodies]
		else {
			outputText("<b>The smooth stones start vibrating again, sending another wave of teasing bliss throughout your body.  The witches snicker at you as you try to withstand their attack.\n\n</b>");
		}
		dynStats("lus", player.statusEffectv1(StatusEffects.LustStones) + 4);
	}
	if(player.hasStatusEffect(StatusEffects.WebSilence)) {
		if(player.statusEffectv1(StatusEffects.WebSilence) >= 2 || rand(20) + 1 + player.str / 10 >= 15) {
			outputText("You rip off the webbing that covers your mouth with a cry of pain, finally able to breathe normally again!  Now you can cast spells!\n\n");
			player.removeStatusEffect(StatusEffects.WebSilence);
		}
		else {
			outputText("<b>Your mouth and nose are obstructed by sticky webbing, making it difficult to breathe and impossible to focus on casting spells.  You try to pull it off, but it just won't work!</b>\n\n");
			player.addStatusValue(StatusEffects.WebSilence,1,1);
		}
	}
	if(player.hasStatusEffect(StatusEffects.HolliConstrict)) {
		outputText("<b>You're tangled up in Holli's verdant limbs!  All you can do is try to struggle free...</b>\n\n");
	}
	if(player.hasStatusEffect(StatusEffects.UBERWEB))
		outputText("<b>You're pinned under a pile of webbing!  You should probably struggle out of it and get back in the fight!</b>\n\n");
	if (player.hasStatusEffect(StatusEffects.Blind) && !monster.hasStatusEffect(StatusEffects.Sandstorm) && !player.hasStatusEffect(StatusEffects.PurpleHaze))
	{
		if (player.hasStatusEffect(StatusEffects.SheilaOil))
		{
			if(player.statusEffectv1(StatusEffects.Blind) <= 0) {
				outputText("<b>You finish wiping the demon's tainted oils away from your eyes; though the smell lingers, you can at least see.  Sheila actually seems happy to once again be under your gaze.</b>\n\n");
				player.removeStatusEffect(StatusEffects.Blind);
			}
			else {
				outputText("<b>You scrub at the oily secretion with the back of your hand and wipe some of it away, but only smear the remainder out more thinly.  You can hear the demon giggling at your discomfort.</b>\n\n");
				player.addStatusValue(StatusEffects.Blind,1,-1);
			}
		}
		else
		{
			//Remove blind if countdown to 0
			if (player.statusEffectv1(StatusEffects.Blind) == 0)
			{
				player.removeStatusEffect(StatusEffects.Blind);
				//Alert PC that blind is gone if no more stacks are there.
				if (!player.hasStatusEffect(StatusEffects.Blind))
				{
					if (monster is Lethice && (monster as Lethice).fightPhase == 2)
					{
						outputText("<b>You finally blink away the last of the demonic spooge from your eyes!</b>\n\n");
					}
					else
					{
						outputText("<b>Your eyes have cleared and you are no longer blind!</b>\n\n");
					}
				}
				else outputText("<b>You are blind, and many physical attacks will miss much more often.</b>\n\n");
			}
			else
			{
				player.addStatusValue(StatusEffects.Blind,1,-1);
				outputText("<b>You are blind, and many physical attacks will miss much more often.</b>\n\n");
			}
		}
	}
	//Basilisk compulsion
	if(player.hasStatusEffect(StatusEffects.BasiliskCompulsion)) {
		player.addCombatBuff('spe', -15);
		//Continuing effect text:
		outputText("<b>You still feel the spell of those grey eyes, making your movements slow and difficult, the remembered words tempting you to look into its eyes again. You need to finish this fight as fast as your heavy limbs will allow.</b>\n\n");
		flags[kFLAGS.BASILISK_RESISTANCE_TRACKER]++;
	}
	if(player.hasStatusEffect(StatusEffects.IzmaBleed)) {
		player.addStatusValue(StatusEffects.IzmaBleed,1,-1);
		if(player.statusEffectv1(StatusEffects.IzmaBleed) <= 0) {
			player.removeStatusEffect(StatusEffects.IzmaBleed);
			outputText("<b>You sigh with relief; your bleeding has slowed considerably.</b>\n\n");
		}
		//Bleed effect:
		else {
			var bleed:Number = (4 + rand(7))/100;
			bleed *= player.HP;
			bleed = player.takePhysDamage(bleed);
			outputText("<b>You gasp and wince in pain, feeling fresh blood pump from your wounds. (<font color=\"#800000\">" + bleed + "</font>)</b>\n\n");
		}
	}
	if(player.hasStatusEffect(StatusEffects.Hemorrhage)) {
		player.addStatusValue(StatusEffects.Hemorrhage,1,-1);
		if(player.statusEffectv1(StatusEffects.Hemorrhage) <= 0) {
			player.removeStatusEffect(StatusEffects.Hemorrhage);
			outputText("<b>You sigh with relief; your hemorrhage has slowed considerably.</b>\n\n");
		}
		//Hemorrhage effect:
		else {
			var hemorrhage:Number = 0;
			hemorrhage += player.maxHP() * player.statusEffectv2(StatusEffects.Hemorrhage);
			hemorrhage = player.takePhysDamage(hemorrhage);
			outputText("<b>You gasp and wince in pain, feeling fresh blood pump from your wounds. (<font color=\"#800000\">" + hemorrhage + "</font>)</b>\n\n");
		}
	}
	if (player.hasStatusEffect(StatusEffects.Disarmed)) {
		player.addStatusValue(StatusEffects.Disarmed,1,-1);
		if (player.statusEffectv1(StatusEffects.Hemorrhage) <= 0) {
			player.removeStatusEffect(StatusEffects.Disarmed);
			if (player.weapon == WeaponLib.FISTS) {
				player.setWeapon(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon);
			}
			else {
				flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID];
			}
			outputText("You manage to grab your weapon back!\n\n");
		}
	}
	if(player.hasStatusEffect(StatusEffects.UnderwaterOutOfAir)) {
		var deoxigen:Number = 0;
		deoxigen += (player.maxHP() * 0.05);
		deoxigen = player.takePhysDamage(deoxigen);
		outputText("<b>You are running out of oxygen you need to finish this fight and fast before you lose consciousness. <b>(<font color=\"#800000\">" + deoxigen + "</font>)</b></b>\n\n");
	}
	if(player.hasStatusEffect(StatusEffects.AcidSlap)) {
		var slap:Number = 3 + (player.maxHP() * 0.02);
		outputText("<b>Your muscles twitch in agony as the acid keeps burning you. <b>(<font color=\"#800000\">" + slap + "</font>)</b></b>\n\n");
	}
	if(player.hasPerk(PerkLib.ArousingAura) && monster.lustVuln > 0 && player.cor >= 70) {
		if(monster.lust < (monster.maxLust() * 0.5)) outputText("Your aura seeps into [monster a] [monster name] but does not have any visible effects just yet.\n\n");
		else if(monster.lust < (monster.maxLust() * 0.6)) {
			if(!monster.plural) outputText("[monster A][monster name] starts to squirm a little from your unholy presence.\n\n");
			else outputText("[monster A][monster name] start to squirm a little from your unholy presence.\n\n");
		}
		else if(monster.lust < (monster.maxLust() * 0.75)) outputText("Your arousing aura seems to be visibly affecting [monster a] [monster name], making [monster him] squirm uncomfortably.\n\n");
		else if(monster.lust < (monster.maxLust() * 0.85)) {
			if(!monster.plural) outputText("[monster A][monster name]'s skin colors red as [monster he] inadvertently basks in your presence.\n\n");
			else outputText("[monster A][monster name]' skin colors red as [monster he] inadvertently bask in your presence.\n\n");
		}
		else {
			if(!monster.plural) outputText("The effects of your aura are quite pronounced on [monster a] [monster name] as [monster he] begins to shake and steal glances at your body.\n\n");
			else outputText("The effects of your aura are quite pronounced on [monster a] [monster name] as [monster he] begin to shake and steal glances at your body.\n\n");
		}
		if (player.hasPerk(PerkLib.ArouseTheAudience) && player.hasPerk(PerkLib.EnemyGroupType)) monster.lust += monster.lustVuln * 1.2 * (2 + rand(4));
		else monster.lust += monster.lustVuln * (2 + rand(4));
	}
	if(player.hasStatusEffect(StatusEffects.AlraunePollen) && monster.lustVuln > 0) {
		if(monster.lust < (monster.maxLust() * 0.5)) outputText("[monster A][monster name] breaths in your pollen but does not have any visible effects just yet.\n\n");
		else if(monster.lust < (monster.maxLust() * 0.6)) {
			if(!monster.plural) outputText("[monster A][monster name] starts to squirm a little from your pollen.\n\n");
			else outputText("[monster A][monster name] start to squirm a little from your pollen.\n\n");
		}
		else if(monster.lust < (monster.maxLust() * 0.75)) outputText("Your pollen seems to be visibly affecting [monster a] [monster name], making [monster him] squirm uncomfortably.\n\n");
		else if(monster.lust < (monster.maxLust() * 0.85)) {
			if(!monster.plural) outputText("[monster A][monster name]'s skin colors red as [monster he] inadvertently breths in your pollen.\n\n");
			else outputText("[monster A][monster name]' skin colors red as [monster he] inadvertently breths in your pollen.\n\n");
		}
		else {
			if(!monster.plural) outputText("The effects of your pollen are quite pronounced on [monster a] [monster name] as [monster he] begins to shake and steal glances at your body.\n\n");
			else outputText("The effects of your pollen are quite pronounced on [monster a] [monster name] as [monster he] begin to shake and steal glances at your body.\n\n");
		}
		if (player.hasPerk(PerkLib.ArouseTheAudience) && player.hasPerk(PerkLib.EnemyGroupType)) monster.lust += monster.lustVuln * 1.2 * (2 + rand(4));
		else monster.lust += monster.lustVuln * (2 + rand(4));
	}
	if(player.hasStatusEffect(StatusEffects.Bound) && flags[kFLAGS.PC_FETISH] >= 2) {
		outputText("The feel of tight leather completely immobilizing you turns you on more and more.  Would it be so bad to just wait and let her play with you like this?\n\n");
		dynStats("lus", 3);
	}
	if(player.hasStatusEffect(StatusEffects.GooArmorBind)) {
		if(flags[kFLAGS.PC_FETISH] >= 2) {
			outputText("The feel of the all-encapsulating goo immobilizing your helpless body turns you on more and more.  Maybe you should just wait for it to completely immobilize you and have you at its mercy.\n\n");
			dynStats("lus", 3);
		}
		else outputText("You're utterly immobilized by the goo flowing around you.  You'll have to struggle free!\n\n");
	}
	if(player.hasStatusEffect(StatusEffects.HarpyBind)) {
		if(flags[kFLAGS.PC_FETISH] >= 2) {
			outputText("The harpies are holding you down and restraining you, making the struggle all the sweeter!\n\n");
			dynStats("lus", 3);
		}
		else outputText("You're restrained by the harpies so that they can beat on you with impunity.  You'll need to struggle to break free!\n\n");
	}
	if((player.hasStatusEffect(StatusEffects.NagaBind) || player.hasStatusEffect(StatusEffects.ScyllaBind)) && flags[kFLAGS.PC_FETISH] >= 2) {
		outputText("Coiled tightly by [monster a] [monster name] and utterly immobilized, you can't help but become aroused thanks to your bondage fetish.\n\n");
		dynStats("lus", 5);
	}
	if(player.hasStatusEffect(StatusEffects.TentacleBind)) {
		outputText("You are firmly trapped in the tentacle's coils.  <b>The only thing you can try to do is struggle free!</b>\n\n");
		if(flags[kFLAGS.PC_FETISH] >= 2) {
			outputText("Wrapped tightly in the tentacles, you find it hard to resist becoming more and more aroused...\n\n");
			dynStats("lus", 3);
		}
	}
	if(player.hasStatusEffect(StatusEffects.DriderKiss)) {
		//(VENOM OVER TIME: WEAK)
		if(player.statusEffectv1(StatusEffects.DriderKiss) == 0) {
			outputText("Your heart hammers a little faster as a vision of the drider's nude, exotic body on top of you assails you.  It'll only get worse if she kisses you again...\n\n");
			dynStats("lus", 8);
		}
		//(VENOM OVER TIME: MEDIUM)
		else if(player.statusEffectv1(StatusEffects.DriderKiss) == 1) {
			outputText("You shudder and moan, nearly touching yourself as your ");
			if(player.gender > 0) outputText("loins tingle and leak, hungry for the drider's every touch.");
			else outputText("asshole tingles and twitches, aching to be penetrated.");
			outputText("  Gods, her venom is getting you so hot.  You've got to end this quickly!\n\n");
			dynStats("lus", 15);
		}
		//(VENOM OVER TIME: MAX)
		else {
			outputText("You have to keep pulling your hands away from your crotch - it's too tempting to masturbate here on the spot and beg the drider for more of her sloppy kisses.  Every second that passes, your arousal grows higher.  If you don't end this fast, you don't think you'll be able to resist much longer.  You're too turned on... too horny... too weak-willed to resist much longer...\n\n");
			dynStats("lus", 25);
		}
	}
	//Harpy lip gloss
	if(player.hasCock() && player.hasStatusEffect(StatusEffects.Luststick) && (monster.short == "harpy" || monster.short == "Sophie")) {
		if(rand(5) == 0) {
			if(rand(2) == 0) outputText("A fantasy springs up from nowhere, dominating your thoughts for a few moments.  In it, you're lying down in a soft nest.  Gold-rimmed lips are noisily slurping around your [cock], smearing it with her messy aphrodisiac until you're completely coated in it.  She looks up at you knowingly as the two of you get ready to breed the night away...\n\n");
			else outputText("An idle daydream flutters into your mind.  In it, you're fucking a harpy's asshole, clutching tightly to her wide, feathery flanks as the tight ring of her pucker massages your [cock].  She moans and turns around to kiss you on the lips, ensuring your hardness.  Before long her feverish grunts of pleasure intensify, and you feel the egg she's birthing squeezing against you through her internal walls...\n\n");
			dynStats("lus", 20);
		}
	}
	if(player.hasStatusEffect(StatusEffects.StoneLust)) {
		if(player.vaginas.length > 0) {
			if(player.lust < 40) outputText("You squirm as the smooth stone orb vibrates within you.\n\n");
			if(player.lust >= 40 && player.lust < 70) outputText("You involuntarily clench around the magical stone in your twat, in response to the constant erotic vibrations.\n\n");
			if(player.lust >= 70 && player.lust < 85) outputText("You stagger in surprise as a particularly pleasant burst of vibrations erupt from the smooth stone sphere in your " + vaginaDescript(0) + ".\n\n");
			if(player.lust >= 85) outputText("The magical orb inside of you is making it VERY difficult to keep your focus on combat, white-hot lust suffusing your body with each new motion.\n\n");
		}
		else {
			outputText("The orb continues vibrating in your ass, doing its best to arouse you.\n\n");
		}
		dynStats("lus", 7 + int(player.sens)/10);
	}
	if(player.hasStatusEffect(StatusEffects.RaijuStaticDischarge)) {
		outputText("The raiju electricity stored in your body continuously tingle around your genitals!\n\n");
		dynStats("lus", 14 + int(player.sens)/8);
	}
	if(player.hasStatusEffect(StatusEffects.KissOfDeath)) {
		//Effect
		outputText("Your lips burn with an unexpected flash of heat.  They sting and burn with unholy energies as a puff of ectoplasmic gas escapes your lips.  That puff must be a part of your soul!  It darts through the air to the succubus, who slurps it down like a delicious snack.  You feel feverishly hot and exhausted...\n\n");
		dynStats("lus", 5);
		player.takePhysDamage(15);
	}
	if(player.hasStatusEffect(StatusEffects.DemonSeed)) {
		outputText("You feel something shift inside you, making you feel warm.  Finding the desire to fight this... hunk gets harder and harder.\n\n");
		dynStats("lus", (player.statusEffectv1(StatusEffects.DemonSeed) + int(player.sens / 30) + int(player.lib / 30) + int(player.cor / 30)));
	}
	if(player.inHeat && player.vaginas.length > 0 && monster.cockTotal() > 0) {
		dynStats("lus", (rand(player.lib/5) + 3 + rand(5)));
		outputText("Your " + vaginaDescript(0) + " clenches with an instinctual desire to be touched and filled.  ");
		outputText("If you don't end this quickly you'll give in to your heat.\n\n");
	}
	if(player.inRut && player.cockTotal() > 0 && monster.hasVagina()) {
		dynStats("lus", (rand(player.lib/5) + 3 + rand(5)));
		if(player.cockTotal() > 1) outputText("Each of y");
		else outputText("Y");
		if(monster.plural) outputText("our [cocks] dribbles pre-cum as you think about plowing [monster a] [monster name] right here and now, fucking [monster his] " + monster.vaginaDescript() + "s until they're totally fertilized and pregnant.\n\n");
		else outputText("our [cocks] dribbles pre-cum as you think about plowing [monster a] [monster name] right here and now, fucking [monster his] " + monster.vaginaDescript() + " until it's totally fertilized and pregnant.\n\n");
	}
	if(player.hasStatusEffect(StatusEffects.NagaVenom)) {
		if(player.spe > 3) {
			player.addStatusValue(StatusEffects.NagaVenom,1,2);
			player.spe -= 2;
		}
		else player.takePhysDamage(5);
		outputText("You wince in pain and try to collect yourself, [monster a] [monster name]'s venom still plaguing you.\n\n");
		player.takePhysDamage(2);
	}
	if(player.hasStatusEffect(StatusEffects.MedusaVenom)) {
		if (player.str <= 5 && player.tou <= 5 && player.spe <= 5 && player.inte <= 5) player.takePhysDamage(5);
		else {
			if(player.str > 5) {
			player.addStatusValue(StatusEffects.MedusaVenom,1,1);
			player.str -= 1;
			}
			if(player.tou > 5) {
			player.addStatusValue(StatusEffects.MedusaVenom,2,1);
			player.tou -= 1;
			}
			if(player.spe > 5) {
			player.addStatusValue(StatusEffects.MedusaVenom,3,1);
			player.spe -= 1;
			}
			if(player.inte > 5) {
			player.addStatusValue(StatusEffects.MedusaVenom,4,1);
			player.inte -= 1;
			}
		}
		outputText("You wince in pain and try to collect yourself, [monster a] [monster name]'s venom still plaguing you.\n\n");
		player.takePhysDamage(2);
	}
	else if(player.hasStatusEffect(StatusEffects.TemporaryHeat)) {
		dynStats("lus", (player.lib/12 + 5 + rand(5)) * player.statusEffectv2(StatusEffects.TemporaryHeat));
		if(player.hasVagina()) {
			outputText("Your " + vaginaDescript(0) + " clenches with an instinctual desire to be touched and filled.  ");
		}
		else if(player.cockTotal() > 0) {
			outputText("Your [cock] pulses and twitches, overwhelmed with the desire to breed.  ");
		}
		if(player.gender == 0) {
			outputText("You feel a tingle in your " + assholeDescript() + ", and the need to touch and fill it nearly overwhelms you.  ");
		}
		outputText("If you don't finish this soon you'll give in to this potent drug!\n\n");
	}
	//Poison
	if(player.hasStatusEffect(StatusEffects.Poison)) {
		//Chance to cleanse!
		outputText("The poison continues to work on your body, wracking you with pain!\n\n");
		player.takePhysDamage(8+rand(player.maxHP()/20) * player.statusEffectv2(StatusEffects.Poison));
	}
	//Bondage straps + bondage fetish
	if(flags[kFLAGS.PC_FETISH] >= 2 && player.armorName == "barely-decent bondage straps") {
		outputText("The feeling of the tight, leather straps holding tightly to your body while exposing so much of it turns you on a little bit more.\n\n");
		dynStats("lus", 2);
	}
	// Drider incubus venom
	if (player.hasStatusEffect(StatusEffects.DriderIncubusVenom))
	{
		player.addStatusValue(StatusEffects.DriderIncubusVenom, 1, -1);
		if (player.statusEffectv1(StatusEffects.DriderIncubusVenom) <= 0)
		{
			player.str += player.statusEffectv2(StatusEffects.DriderIncubusVenom);
			player.removeStatusEffect(StatusEffects.DriderIncubusVenom);
			CoC.instance.mainView.statsView.showStatUp('str');
			outputText("The drider incubus’ venom wanes, the effects of the poision weakening as strength returns to your limbs!\n\n");
		}
		else
		{
			outputText("The demonic drider managed to bite you, infecting you with his strength-draining poison!\n\n");
		}
	}
	if (monster.hasStatusEffect(StatusEffects.OnFire))
	{
		var damage:Number = 20 + rand(5);
		monster.HP -= damage;
		monster.addStatusValue(StatusEffects.OnFire, 1, -1);
		if (monster.statusEffectv1(StatusEffects.OnFire) <= 0)
		{
			monster.removeStatusEffect(StatusEffects.OnFire);
			outputText("\n\nFlames lick at the horde of demons before finally petering out!");
		}
		else
		{
			outputText("\n\nFlames continue to lick at the horde of demons!");
		}
	}
	//Giant boulder
	if (player.hasStatusEffect(StatusEffects.GiantBoulder)) {
		outputText("<b>There is a large boulder coming your way. If you don't avoid it in time, you might take some serious damage.</b>\n\n");
	}
	//Berzerker/Lustzerker/Dwarf Rage/Oni Rampage/Maleficium
	if (player.hasStatusEffect(StatusEffects.DwarfRage)) {
		if (player.statusEffectv3(StatusEffects.DwarfRage) <= 0) {
			player.dynStats("str", -player.statusEffectv1(StatusEffects.DwarfRage),"tou", -player.statusEffectv2(StatusEffects.DwarfRage),"spe", -player.statusEffectv2(StatusEffects.DwarfRage), "scale", false);
			player.removeStatusEffect(StatusEffects.DwarfRage);
			outputText("<b>Dwarf Rage effect wore off!</b>\n\n");
		}
		else player.addStatusValue(StatusEffects.DwarfRage,3,-1);
	}
	//Spell buffs
	if (player.hasStatusEffect(StatusEffects.Might)) {
		if (player.statusEffectv3(StatusEffects.Might) <= 0) {
			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) player.dynStats("int", -player.statusEffectv1(StatusEffects.Might), "scale", false);
			else player.dynStats("str", -player.statusEffectv1(StatusEffects.Might), "scale", false);
			player.dynStats("tou", -player.statusEffectv2(StatusEffects.Might), "scale", false);
			player.removeStatusEffect(StatusEffects.Might);
			outputText("<b>Might effect wore off!</b>\n\n");
		}
		else player.addStatusValue(StatusEffects.Might,3,-1);
	}
	if (player.hasStatusEffect(StatusEffects.Blink)) {
		if (player.statusEffectv3(StatusEffects.Blink) <= 0) {
			player.dynStats("spe", -player.statusEffectv1(StatusEffects.Blink), "scale", false);
			player.removeStatusEffect(StatusEffects.Blink);
			outputText("<b>Blink effect wore off!</b>\n\n");
		}
		else player.addStatusValue(StatusEffects.Blink,3,-1);
	}
	//Violet Pupil Transformation
	if (player.hasStatusEffect(StatusEffects.VioletPupilTransformation)) {
		if (player.ki < 100) {
			player.removeStatusEffect(StatusEffects.VioletPupilTransformation);
			outputText("<b>Your ki is too low to continue using Violet Pupil Transformation so ki power deactivated itself!  As long you can recover some ki before end of the fight you could then reactivate this skill.</b>\n\n");
		}
		else {
			var kicost:int = 100;
			player.ki -= kicost;
			var hpChange1:int = 200;
			if (player.unicornScore() >= 5) hpChange1 += ((player.unicornScore() - 4) * 25);
			if (player.alicornScore() >= 6) hpChange1 += ((player.alicornScore() - 5) * 25);
			outputText("<b>As your ki is drained you can feel Violet Pupil Transformation regenerative power spreading in your body. (<font color=\"#008000\">+" + hpChange1 + "</font>)</b>\n\n");
			HPChange(hpChange1,false);
		}
	}
	//Regenerate
	if (player.hasStatusEffect(StatusEffects.PlayerRegenerate)) {
		if (player.statusEffectv1(StatusEffects.PlayerRegenerate) <= 0) {
			player.removeStatusEffect(StatusEffects.PlayerRegenerate);
			outputText("<b>Regenerate effect wore off!</b>\n\n");
		}
		else {
			player.addStatusValue(StatusEffects.PlayerRegenerate, 1, -1);
			var hpChange2:int = player.inte;
			hpChange2 *= healModBlack();
			if (player.unicornScore() >= 5) hpChange2 *= ((player.unicornScore() - 4) * 0.5);
			if (player.alicornScore() >= 6) hpChange2 *= ((player.alicornScore() - 5) * 0.5);
			if (player.armorName == "skimpy nurse's outfit") hpChange2 *= 1.2;
			if (player.weaponName == "unicorn staff") hpChange2 *= 1.5;
			outputText("<b>Regenerate healing power spreading in your body. (<font color=\"#008000\">+" + hpChange2 + "</font>)</b>\n\n");
			HPChange(hpChange2,false);
		}
	}
	//Trance Transformation
	if (player.hasStatusEffect(StatusEffects.TranceTransformation)) {
		if (player.ki < 50) {
			player.dynStats("str", -player.statusEffectv1(StatusEffects.TranceTransformation));
			player.dynStats("tou", -player.statusEffectv1(StatusEffects.TranceTransformation));
			player.removeStatusEffect(StatusEffects.TranceTransformation);
			outputText("<b>The flow of power through you suddenly stops, as you no longer have the soul energy to sustain it.  You drop roughly to the floor, the crystal coating your [skin] cracking and fading to nothing.</b>\n\n");
		}
	//	else {
	//		outputText("<b>As your ki is drained you can feel Violet Pupil Transformation regenerative power spreading in your body.</b>\n\n");
	//	}
	}
	//Crinos Shape
	if (player.hasStatusEffect(StatusEffects.CrinosShape)) {
		if (player.wrath < mspecials.crinosshapeCost()) {
			player.dynStats("str", -player.statusEffectv1(StatusEffects.CrinosShape));
			player.dynStats("tou", -player.statusEffectv2(StatusEffects.CrinosShape));
			player.dynStats("spe", -player.statusEffectv3(StatusEffects.CrinosShape));
			player.removeStatusEffect(StatusEffects.CrinosShape);
			outputText("<b>The flow of power through you suddenly stops, as you no longer have the wrath to sustain it.  You drop roughly to the floor, the bestial chanches slowly fading away leaving you in your normal form.</b>\n\n");
		}
	//	else {
	//		outputText("<b>As your ki is drained you can feel Violet Pupil Transformation regenerative power spreading in your body.</b>\n\n");
	//	}
	}
	if (player.hasStatusEffect(StatusEffects.BladeDance)) player.removeStatusEffect(StatusEffects.BladeDance);
	if (player.hasStatusEffect(StatusEffects.ResonanceVolley)) player.removeStatusEffect(StatusEffects.ResonanceVolley);
	if (player.hasStatusEffect(StatusEffects.Defend)) player.removeStatusEffect(StatusEffects.Defend);
	regeneration(true);
	if(player.lust >= player.maxLust()) doNext(endLustLoss);
	if(player.HP <= 0) doNext(endHpLoss);
}

public function regeneration(combat:Boolean = true):void {
	var healingPercent:Number = 0;
	if (combat) {
		//Regeneration
		healingPercent = 0;
		if (player.hunger >= 25 || flags[kFLAGS.HUNGER_ENABLED] <= 0)
		{
			if (player.hasPerk(PerkLib.Regeneration)) healingPercent += 0.5;
		}
		if (player.armor == armors.NURSECL) healingPercent += 0.5;
		if (player.armor == armors.GOOARMR) healingPercent += (SceneLib.valeria.valeriaFluidsEnabled() ? (flags[kFLAGS.VALERIA_FLUIDS] < 50 ? flags[kFLAGS.VALERIA_FLUIDS] / 25 : 2) : 2);
		if (player.weapon == weapons.SESPEAR) healingPercent += 2;
		if (player.hasPerk(PerkLib.LustyRegeneration)) healingPercent += 0.5;
		if (player.hasPerk(PerkLib.LizanRegeneration)) healingPercent += 1.5;
		if (player.hasPerk(PerkLib.LizanMarrow)) healingPercent += 0.5;
		if (player.hasPerk(PerkLib.LizanMarrowEvolved)) healingPercent += 0.5;
		if (player.hasStatusEffect(StatusEffects.CrinosShape)) healingPercent += 2;
		if (player.perkv1(PerkLib.Sanctuary) == 1) healingPercent += ((player.corruptionTolerance() - player.cor) / (100 + player.corruptionTolerance()));
		if (player.perkv1(PerkLib.Sanctuary) == 2) healingPercent += player.cor / (100 + player.corruptionTolerance());
		if ((player.internalChimeraRating() >= 1 && player.hunger < 1 && flags[kFLAGS.HUNGER_ENABLED] > 0) || (player.internalChimeraRating() >= 1 && flags[kFLAGS.HUNGER_ENABLED] <= 0)) healingPercent -= (0.5 * player.internalChimeraRating());
		if (player.hasStatusEffect(StatusEffects.SecondWindRegen)) healingPercent += 5;
		if (player.hasStatusEffect(StatusEffects.Overlimit)) healingPercent -= 10;
		if (healingPercent > maximumRegeneration()) healingPercent = maximumRegeneration();
		HPChange(Math.round((player.maxHP() * healingPercent / 100) + nonPercentBasedRegeneration()), false);
	}
	else {
		//Regeneration
		healingPercent = 0;
		if (player.hunger >= 25 || flags[kFLAGS.HUNGER_ENABLED] <= 0)
		{
			if (player.hasPerk(PerkLib.Regeneration)) healingPercent += 1;
		}
		if (player.armorName == "skimpy nurse's outfit") healingPercent += 1;
		if (player.armor == armors.NURSECL) healingPercent += 1;
		if (player.armor == armors.GOOARMR) healingPercent += (SceneLib.valeria.valeriaFluidsEnabled() ? (flags[kFLAGS.VALERIA_FLUIDS] < 50 ? flags[kFLAGS.VALERIA_FLUIDS] / 16 : 3) : 3);
		if (player.weapon == weapons.SESPEAR) healingPercent += 4;
		if (player.hasPerk(PerkLib.LustyRegeneration)) healingPercent += 1;
		if (player.hasPerk(PerkLib.LizanRegeneration)) healingPercent += 3;
		if (player.hasPerk(PerkLib.LizanMarrow)) healingPercent += 1;
		if (player.hasPerk(PerkLib.LizanMarrowEvolved)) healingPercent += 1;
		if ((player.internalChimeraRating() >= 1 && player.hunger < 1 && flags[kFLAGS.HUNGER_ENABLED] > 0) || (player.internalChimeraRating() >= 1 && flags[kFLAGS.HUNGER_ENABLED] <= 0)) healingPercent -= player.internalChimeraRating();
		if (healingPercent > (maximumRegeneration() * 2)) healingPercent = (maximumRegeneration() * 2);
		HPChange(Math.round((player.maxHP() * healingPercent / 100) + (nonPercentBasedRegeneration() * 2)), false);
	}
}

public function kiRegeneration(combat:Boolean = true):void {
	var gainedki:Number = 0;
	if (combat) {
		if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1) gainedki *= 2;
		EngineCore.KiChange(gainedki, false);
	}
	else {
		EngineCore.KiChange(gainedki, false);
	}
}

public function manaRegeneration(combat:Boolean = true):void {
	var gainedmana:Number = 0;
	if (combat) {
		if (player.hasPerk(PerkLib.JobSorcerer)) gainedmana += 10;
		gainedmana *= manaRecoveryMultiplier();
		if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1) gainedmana *= 2;
		EngineCore.ManaChange(gainedmana, false);
	}
	else {
		if (player.hasPerk(PerkLib.JobSorcerer)) gainedmana += 20;
		gainedmana *= manaRecoveryMultiplier();
		EngineCore.ManaChange(gainedmana, false);
	}
}

public function wrathRegeneration(combat:Boolean = true):void {
	var gainedwrath:Number = 0;
	if (combat) {
		if (player.hasPerk(PerkLib.Berzerker)) gainedwrath += 2;
		if (player.hasPerk(PerkLib.Lustzerker)) gainedwrath += 2;
		if (player.hasPerk(PerkLib.Rage)) gainedwrath += 2;
		if (player.hasStatusEffect(StatusEffects.Berzerking)) gainedwrath += 3;
		if (player.hasStatusEffect(StatusEffects.Lustzerking)) gainedwrath += 3;
		if (player.hasStatusEffect(StatusEffects.Rage)) gainedwrath += 3;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) gainedwrath += 6;
		if (player.hasStatusEffect(StatusEffects.CrinosShape)) {
			gainedwrath += 1;
		}
		EngineCore.WrathChange(gainedwrath, false);
	}
	else {
		if (player.hasPerk(PerkLib.PrimalFury)) gainedwrath += 1;
		if (player.hasPerk(PerkLib.Berzerker)) gainedwrath += 1;
		if (player.hasPerk(PerkLib.Lustzerker)) gainedwrath += 1;
		if (player.hasPerk(PerkLib.Rage)) gainedwrath += 1;
		EngineCore.WrathChange(gainedwrath, false);
	}
}

public function maximumRegeneration():Number {
	var maxRegen:Number = 2;
	if (player.newGamePlusMod() >= 1) maxRegen += 1;
	if (player.newGamePlusMod() >= 2) maxRegen += 1;
	if (player.newGamePlusMod() >= 3) maxRegen += 1;
	if (player.newGamePlusMod() >= 4) maxRegen += 1;
	if (player.newGamePlusMod() >= 5) maxRegen += 1;
	if (player.hasPerk(PerkLib.LizanRegeneration)) maxRegen += 1.5;
	if (player.hasPerk(PerkLib.LizanMarrow)) maxRegen += 0.5;
	if (player.hasPerk(PerkLib.LizanMarrowEvolved)) maxRegen += 0.5;
	if (player.hasStatusEffect(StatusEffects.CrinosShape)) maxRegen += 2;
	return maxRegen;
}

public function nonPercentBasedRegeneration():Number {
	var maxNonPercentRegen:Number = 0;
	return maxNonPercentRegen;
}

internal var combatRound:int = 0;
public function startCombatImpl(monster_:Monster, plotFight_:Boolean = false, immediate:Boolean = false):void {
	combatRound = 0;
	CoC.instance.plotFight = plotFight_;
	mainView.hideMenuButton( MainView.MENU_DATA );
	mainView.hideMenuButton( MainView.MENU_APPEARANCE );
	mainView.hideMenuButton( MainView.MENU_LEVEL );
	mainView.hideMenuButton( MainView.MENU_PERKS );
	mainView.hideMenuButton( MainView.MENU_STATS );
	showStats();
	//Flag the game as being "in combat"
	inCombat = true;
	monster = monster_;
	if(monster.imageName != ""){
		var monsterName:String = "monster-"+monster.imageName;
		imageText = images.showImage(monsterName);
	} else {
		imageText = "";
	}
	monster.prepareForCombat();

	//Reduce enemy def if player has precision!
	if(player.hasPerk(PerkLib.Precision) && player.inte >= 25) {
		if(monster.armorDef <= 10) monster.armorDef = 0;
		else monster.armorDef -= 10;
	}
	if (player.hasPerk(PerkLib.WellspringOfLust)) {
		if (player.lust < 50) player.lust = 50;
	}
	magic.applyAutocast();
	if (player.weaponRangeName == "gnoll throwing spear") player.ammo = 20;
	if (player.weaponRangeName == "gnoll throwing axes") player.ammo = 10;
	if (player.weaponRangeName == "training javelins") player.ammo = 10;
	if (player.weaponRangeName == "Ivory inlaid arquebus") player.ammo = 12;
	if (player.weaponRangeName == "blunderbuss") player.ammo = 9;
	if (player.weaponRangeName == "flintlock pistol") player.ammo = 6;
	if (player.weaponRange == weaponsrange.SHUNHAR || player.weaponRange == weaponsrange.KSLHARP || player.weaponRange == weaponsrange.LEVHARP) player.ammo = 1;
	if (prison.inPrison && prison.prisonCombatAutoLose) {
		dynStats("lus", player.maxLust(), "scale", false);
		doNext(endLustLoss);
		return;
	}
	if(immediate){
		playerMenu();
	} else {
		doNext(playerMenu);
	}
}
public function startCombatImmediateImpl(monster_:Monster, _plotFight:Boolean):void
{
	startCombatImpl(monster_, _plotFight, true);
}
public function display():void {
	if (!monster.checkCalled){
		outputText("[b: /!\\BUG! Monster.checkMonster() is not called! Calling it now...]\n");
		monster.checkMonster();
	}
	if (monster.checkError != ""){
		outputText("[b: /!\\BUG! Monster is not correctly initialized!] "+
				monster.checkError+"</u></b>\n");
	}
	//imageText set in startCombat()
	outputText(imageText);

	outputText("[b: You are fighting [monster a][monster name]:]\n");
	if (player.hasStatusEffect(StatusEffects.Blind)) {
		outputText("It's impossible to see anything!\n");
	}
	else {
		monster.showCBtext();
		var generalTypes:/*String*/Array = monster.getGeneralTypes(player.sens);
		var elementalTypes:/*String*/Array = monster.getElementalTypes(player.sens);
		mainView.monsterStatsView.setMonsterTypes(generalTypes,elementalTypes);
	}
	if (debug){
		outputText("\n----------------------------\n");
		outputText(monster.generateDebugDescription());
	}
}

// This is a bullshit work around to get the parser to do what I want without having to fuck around in it's code.
public function teaseText():String
{
	tease(true);
	return "";
}

// Just text should force the function to purely emit the test text to the output display, and not have any other side effects
public function tease(justText:Boolean = false):void {
	teases.tease(justText);
}

public function teaseXP(XP:Number = 0):void {
	teases.teaseXP(XP);
}

//VICTORY OR DEATH?
	// Called after the monster's action. Increments round counter. Setups doNext to win/loss/combat menu
public function combatRoundOver():void {
	combatRound++;
	statScreenRefresh();
	flags[kFLAGS.ENEMY_CRITICAL] = 0;
	combatIsOver();
}

// Returns true if combat is over. Setups doNext to win/loss/combat menu
public function combatIsOver():Boolean {
	if (!inCombat) {
		return false;
	}
	var mon:Function = monster.endRoundChecks();
	if (mon != null) {
		mon();
		return true;
	}
	if (player.HP < 1) {
		doNext(endHpLoss);
		return true;
	}
	if (player.lust >= player.maxLust()) {
		doNext(endLustLoss);
		return true;
	}
	doNext(playerMenu); //This takes us back to the combatMenu and a new combat round
	return false;
}


public function ScyllaSqueeze():void {
	clearOutput();
	if (monster.plural) {
		if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
			outputText("You are too tired to squeeze [monster a] [monster name].");
			addButton(0, "Next", combatMenu, false);
			return;
		}
	}
	else {
		if (player.fatigue + physicalCost(20) > player.maxFatigue()) {
			outputText("You are too tired to squeeze [monster a] [monster name].");
			addButton(0, "Next", combatMenu, false);
			return;
		}
	}
	if (monster.plural) {
		fatigue(50, USEFATG_PHYSICAL);
	}
	else fatigue(20, USEFATG_PHYSICAL);
	var damage:int = monster.maxHP() * (.10 + rand(15) / 100) * 1.5;
	if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
	if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
	if (monster.plural == true) damage *= 5;
	//Squeeze -
	outputText("You start squeezing your");
	if (monster.plural) {
		outputText(" foes");
	}
	else {
		outputText(" foe");
	}
	outputText(" with your");
	if (monster.plural) {
		outputText(" tentacles");
	}
	else {
		outputText(" tentacle");
	}
	outputText(", leaving [monster him] short of breath. You can feel it in your tentacles as [monster his] struggles are briefly intensified. ");
	damage = doDamage(damage);
	outputText("\n\n[monster A][monster name] takes <b><font color=\"#800000\">" + damage + "</font></b> damage.");
	//Enemy faints -
	if(monster.HP < 1) {
		outputText("\n\nYou can feel [monster a] [monster name]'s life signs beginning to fade, and before you crush all the life from [monster him], you let go, dropping [monster him] to the floor, unconscious but alive.  In no time, [monster his]'s eyelids begin fluttering, and you've no doubt they'll regain consciousness soon.  ");
		if(monster.short == "demons")
			outputText("The others quickly back off, terrified at the idea of what you might do to them.");
		outputText("\n\n");
		doNext(endHpVictory);
		return;
	}
	outputText("\n\n");
	enemyAI();
}
public function ScyllaTease():void {
	clearOutput();
	//(if poisoned)
	if(monster.hasStatusEffect(StatusEffects.NagaVenom))
	{
		outputText("You casualy caress your opponent with a free hand as you use one of your tentacle to expertly molest its bottom half.\n\n");
	}
	else if(monster.gender == 0)
	{
		outputText("You look over [monster a] [monster name], but can't figure out how to tease such an unusual foe.\n\n");
	}
	if(monster.lustVuln == 0) {
		outputText("You casualy caress your opponent with a free hand as you use one of your tentacle to expertly molest its bottom half, but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
		enemyAI();
		return;
	}
	//(Otherwise)
	else {
		wrathRegeneration();
		fatigueRecovery();
		manaRegeneration();
		kiRegeneration();
		var damage:Number = 0;
		var chance:Number= 0;
		var bimbo:Boolean = false;
		var bro:Boolean = false;
		var futa:Boolean = false;
		var choices:Array = new Array();
		var select:Number = 0;
		//Tags used for bonus damage and chance later on
		var breasts:Boolean = false;
		var penis:Boolean = false;
		var balls:Boolean = false;
		var vagina:Boolean = false;
		var anus:Boolean = false;
		var ass:Boolean = false;
		//If auto = true, set up bonuses using above flags
		var auto:Boolean = true;
		//==============================
		//Determine basic success chance.
		//==============================
		chance = 60;
		//1% chance for each tease level.
		chance += player.teaseLevel;
		//10% for seduction perk
		if(player.hasPerk(PerkLib.Seduction)) chance += 10;
		//10% for sexy armor types
		if(player.hasPerk(PerkLib.SluttySeduction) || player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) chance += 10;
		//10% for bimbo shits
		if(player.hasPerk(PerkLib.BimboBody)) {
			chance += 10;
			bimbo = true;
		}
		if(player.hasPerk(PerkLib.BroBody)) {
			chance += 10;
			bro = true;
		}
		if(player.hasPerk(PerkLib.FutaForm)) {
			chance += 10;
			futa = true;
		}
		//2 & 2 for seductive valentines!
		if(player.hasPerk(PerkLib.SensualLover)) {
			chance += 2;
		}
		//==============================
		//Determine basic damage.
		//==============================
		damage = 6 + rand(3);
		if(player.hasPerk(PerkLib.SensualLover)) {
			damage += 2;
		}
		if(player.hasPerk(PerkLib.Seduction)) damage += 5;
		//+ slutty armor bonus
		if(player.hasPerk(PerkLib.SluttySeduction)) damage += player.perkv1(PerkLib.SluttySeduction);
		if(player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) damage += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
		//10% for bimbo shits
		if(bimbo || bro || futa) {
			damage += 5;
			bimbo = true;
		}
		damage += player.scalingBonusLibido() * 0.1;
		damage += player.teaseLevel;
		damage += rand(7);
		//partial skins bonuses
		switch (player.coatType()) {
			case Skin.FUR:
				damage += (1 + player.newGamePlusMod());
				break;
			case Skin.SCALES:
				damage += (2 * (1 + player.newGamePlusMod()));
				break;
			case Skin.CHITIN:
				damage += (3 * (1 + player.newGamePlusMod()));
				break;
			case Skin.BARK:
				damage += (4 * (1 + player.newGamePlusMod()));
				break;
		}
		chance += 2;
		//Specific cases for slimes and demons, as the normal ones would make no sense
		if(monster.short == "demons") {
			outputText("As you stimulate one of their brethren, the other demons can't help but to feel more aroused by this sight, all wishing to touch and feel the contact of your smooth, scaly body.");
		}
		else if(monster.short == "slime") {
			outputText("You attempt to stimulate the slime despite its lack of any sex organs. Somehow, it works!");
		}
		//Normal cases for other monsters
		else {
			if(monster.gender == 1)
			{
				outputText("Your nimble tentacle begins to gently stroke his " + monster.cockDescriptShort(0) + ", and you can see it on his face as he tries to hold back the fact that it feels good.");
			}
			if(monster.gender == 2)
			{
				outputText("Your nimble tentacle manages to work its way between her legs, grinding your tentacle's slippery skin against her clit. She appears to enjoy it, but it is obvious she is trying to hide it from you.");
			}
			if(monster.gender == 3)
			{
				outputText("Your nimble tentacle manages to work its way between [monster his] legs, gaining access to both sets of genitals. As your slippery skin rubs past [monster his] clit, your tentacle gently begins to stroke [monster his] cock. The repressed expression on [monster his] face betrays [monster his] own enjoyment of this kind of treatment.");
			}
		}
		//Land the hit!
		if(rand(100) <= chance) {
			//NERF TEASE DAMAGE
			damage *= .9;
			if(player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) {
				damage *= 1.15;
			}
			if (player.hasPerk(PerkLib.DazzlingDisplay) && rand(100) < 10) damage *= 1.2;
			//Determine if critical tease!
			var crit:Boolean = false;
			var critChance:int = 5;
			if (player.hasPerk(PerkLib.CriticalPerformance)) {
				if (player.lib <= 100) critChance += player.lib / 5;
				if (player.lib > 100) critChance += 20;
			}
			if (monster.isImmuneToCrits()) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			monster.teased(monster.lustVuln * damage);
			if (crit == true) outputText(" <b>Critical!</b>");
			teaseXP(1);
		}
		//Nuttin honey
		else {
			teaseXP(5);
			outputText("\n[monster A][monster name] seems unimpressed.");
		}
		outputText("\n\n");
		if(monster.lust >= monster.maxLust()) {
			doNext(endLustVictory);
			return;
		}
	}
	enemyAI();
}
public function ScyllaLeggoMyEggo():void {
	clearOutput();
	outputText("You release [monster a] [monster name] from [monster his] bonds, and [monster he] drops to the ground, catching [monster his] breath before [monster he] stands back up, apparently prepared to fight some more.");
	outputText("\n\n");
	monster.removeStatusEffect(StatusEffects.ConstrictedScylla);
	enemyAI();
}

public function GooTease():void {
	clearOutput();
	//(if poisoned)
	if(monster.hasStatusEffect(StatusEffects.NagaVenom))
	{
		outputText("You casualy caress your opponent with a free hand as you use one of your tentacle to expertly molest its bottom half.\n\n");
	}
	else if(monster.gender == 0)
	{
		outputText("You look over [monster a] [monster name], but can't figure out how to tease such an unusual foe.\n\n");
	}
	if(monster.lustVuln == 0) {
		outputText("You casualy caress your opponent with a free hand as you use one of your tentacle to expertly molest its bottom half, but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
		enemyAI();
		return;
	}
	//(Otherwise)
	else {
		wrathRegeneration();
		fatigueRecovery();
		manaRegeneration();
		kiRegeneration();
		var damage:Number = 0;
		var chance:Number= 0;
		var bimbo:Boolean = false;
		var bro:Boolean = false;
		var futa:Boolean = false;
		var choices:Array = new Array();
		var select:Number = 0;
		//Tags used for bonus damage and chance later on
		var breasts:Boolean = false;
		var penis:Boolean = false;
		var balls:Boolean = false;
		var vagina:Boolean = false;
		var anus:Boolean = false;
		var ass:Boolean = false;
		//If auto = true, set up bonuses using above flags
		var auto:Boolean = true;
		//==============================
		//Determine basic success chance.
		//==============================
		chance = 60;
		//1% chance for each tease level.
		chance += player.teaseLevel;
		//10% for seduction perk
		if(player.hasPerk(PerkLib.Seduction)) chance += 10;
		//10% for sexy armor types
		if(player.hasPerk(PerkLib.SluttySeduction) || player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) chance += 10;
		//10% for bimbo shits
		if(player.hasPerk(PerkLib.BimboBody)) {
			chance += 10;
			bimbo = true;
		}
		if(player.hasPerk(PerkLib.BroBody)) {
			chance += 10;
			bro = true;
		}
		if(player.hasPerk(PerkLib.FutaForm)) {
			chance += 10;
			futa = true;
		}
		//2 & 2 for seductive valentines!
		if(player.hasPerk(PerkLib.SensualLover)) {
			chance += 2;
		}
		//==============================
		//Determine basic damage.
		//==============================
		damage = 6 + rand(3);
		if(player.hasPerk(PerkLib.SensualLover)) {
			damage += 2;
		}
		if(player.hasPerk(PerkLib.Seduction)) damage += 5;
		//+ slutty armor bonus
		if(player.hasPerk(PerkLib.SluttySeduction)) damage += player.perkv1(PerkLib.SluttySeduction);
		if(player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) damage += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
		//10% for bimbo shits
		if(bimbo || bro || futa) {
			damage += 5;
			bimbo = true;
		}
		damage += player.scalingBonusLibido() * 0.1;
		damage += player.teaseLevel;
		damage += rand(7);
		//partial skins bonuses
		switch (player.coatType()) {
			case Skin.FUR:
				damage += (1 + player.newGamePlusMod());
				break;
			case Skin.SCALES:
				damage += (2 * (1 + player.newGamePlusMod()));
				break;
			case Skin.CHITIN:
				damage += (3 * (1 + player.newGamePlusMod()));
				break;
			case Skin.BARK:
				damage += (4 * (1 + player.newGamePlusMod()));
				break;
		}
		chance += 2;
		//Land the hit!
		if(rand(100) <= chance) {
			outputText("You start to play with [monster a] [monster name] body ");
			if(monster.gender == 1)
			{
				outputText("stroking his " + monster.cockDescriptShort(0) + " from inside of you to feast on his precum.");
			}
			if(monster.gender == 2)
			{
				outputText("forcefully filling her pussy and ass with your fluid form as you molest her breast.");
			}
			if(monster.gender == 3)
			{
				outputText("forcefully filling her pussy and ass with your fluid form as you molest her breast. Unsatisfied with her female parts you also stroke her cock to feast on her precum.");
			}
			outputText(" This feels very pleasurable to you but not as much as to your opponent who start to drool at your ministration.");
			//NERF TEASE DAMAGE
			damage += player.scalingBonusLibido();
			damage *= 0.25;
			damage = Math.round(damage);
			if(player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) {
				damage *= 1.15;
			}
			if (player.hasPerk(PerkLib.DazzlingDisplay) && rand(100) < 10) damage *= 1.2;
			//Determine if critical tease!
			var crit:Boolean = false;
			var critChance:int = 5;
			if (player.hasPerk(PerkLib.CriticalPerformance)) {
				if (player.lib <= 100) critChance += player.lib / 5;
				if (player.lib > 100) critChance += 20;
			}
			if (monster.isImmuneToCrits()) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			monster.teased(monster.lustVuln * damage);
			if (crit == true) outputText(" <b>Critical!</b>");
			teaseXP(1);
		}
		//Nuttin honey
		else {
			teaseXP(5);
			outputText("\n[monster A][monster name] seems unimpressed.");
		}
		outputText("\n\n");
		if(monster.lust >= monster.maxLust()) {
			doNext(endLustVictory);
			return;
		}
	}
	enemyAI();
}
public function GooLeggoMyEggo():void {
	clearOutput();
	outputText("You release [monster a] [monster name] from your body and [monster he] drops to the ground, catching [monster his] breath before [monster he] stands back up, apparently prepared to fight some more.");
	outputText("\n\n");
	monster.removeStatusEffect(StatusEffects.GooEngulf);
	enemyAI();
}

//Vampiric bite
public function VampiricBite():void {
	fatigue(20, USEFATG_PHYSICAL);
	if (monster.hasPerk(PerkLib.EnemyConstructType) || monster.hasPerk(PerkLib.EnemyPlantType)) {
		outputText("You gleefully bite in your foe but ");
		if (monster.hasPerk(PerkLib.EnemyConstructType)) {
			outputText("yelp in pain. This thing skin is hard as rock which comes as true since golems do are made of solid stones.");
		}
		if (monster.hasPerk(PerkLib.EnemyPlantType)) {
			outputText("almost instantly spit it out. Ewwww what manner of disgusting blood is this? Saps?");
		}
		outputText(" Your opponent makes use of your confusion to free itself.");
		HPChange((-100 * (1 + player.newGamePlusMod())),false);
		monster.removeStatusEffect(StatusEffects.EmbraceVampire);
		enemyAI();
		return;
	}
	outputText("You bite [monster a] [monster name] drinking deep of [monster his] blood ");
	var damage:int = player.maxHP() * 0.05;
	damage = Math.round(damage);
	doDamage(damage, true, true);
	player.HP += damage;
	if (player.HP > player.maxHP()) player.HP = player.maxHP();
	outputText(" damage. You feel yourself grow stronger with each drop. ");
	var thirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
	thirst.drink(1);
	if (monster.gender != 0 && monster.lustVuln != 0) {
		var lustDmg:int = (10 + (player.lib * 0.1)) * monster.lustVuln;
		outputText(" [monster he] can’t help but moan, aroused from the aphrodisiac in your saliva for ");
		monster.teased(lustDmg);
		outputText(".");
	}
	//Enemy faints -
	if(monster.HP < 1) {
		outputText("You can feel [monster a] [monster name]'s life signs beginning to fade, and before you crush all the life from [monster him], you let go, dropping [monster him] to the floor, unconscious but alive.  In no time, [monster his] eyelids begin fluttering, and you've no doubt they'll regain consciousness soon.  ");
		if(monster.short == "demons")
			outputText("The others quickly back off, terrified at the idea of what you might do to them.");
		outputText("\n\n");
		doNext(combat.endHpVictory);
		return;
	}
	outputText("\n\n");
	enemyAI();
}
public function VampireLeggoMyEggo():void {
	clearOutput();
	outputText("You let your opponent free ending your embrace.");
	outputText("\n\n");
	monster.removeStatusEffect(StatusEffects.EmbraceVampire);
	enemyAI();
}

//Claws Rend
public function clawsRend():void {
	fatigue(20, USEFATG_PHYSICAL);
	outputText("You rend [monster a] [monster name] with your claws. ");
	var damage:int = player.str;
	damage += player.scalingBonusStrength() * 0.5;
	damage = Math.round(damage);
	doDamage(damage, true, true);
	if(monster.HP < 1) {
		doNext(combat.endHpVictory);
		return;
	}
	outputText("\n\n");
	enemyAI();
}
public function PussyLeggoMyEggo():void {
	clearOutput();
	outputText("You let your opponent free ending your embrace.");
	outputText("\n\n");
	monster.removeStatusEffect(StatusEffects.Pounce);
	enemyAI();
}

	//Todo @Oxdeception move the run methods?
	/**
	 * Handles a successful run attempt: Shows text, and a next button that returns to camp
	 * Also stops combat and clears combat statuses from the player
	 * @param text The text to display
	 */
	public function runSucceed(text:String = ""):void {
		outputText(text);
		inCombat = false;
		clearStatuses(false);
		doNext(camp.returnToCampUseOneHour);
	}

	/**
	 * Handles a failed run attempt: Shows text, and a next button that returns to combat
	 * @param text The text to display
	 * @param doAi True to have the monster take its turn, false to return to menu without finishing the round
	 */
	public function runFail(text:String = "", doAi:Boolean = false):void {
		outputText(text);
		if(doAi){
			return enemyAI();
		}
		doNext(curry(combatMenu,false));
	}

	/**
	 * Checks if a basic run attempt has been successful
	 * Does NOT check the Runner perk
	 * @return true if successful
	 */
	public function runCheckEscaped():Boolean{
		//Calculations
		var escapeMod:Number = 20 + monster.level * 3;
		if(debug) escapeMod -= 300;
		if(player.canFly()) escapeMod -= 20;
		if(player.tailType == Tail.RACCOON && player.ears.type == Ears.RACCOON && player.hasPerk(PerkLib.Runner)) escapeMod -= 25;
		if(monster.hasStatusEffect(StatusEffects.Stunned)) escapeMod -= 50;

		//Big tits doesn't matter as much if ya can fly!
		else {
			if(player.biggestTitSize() >= 35) escapeMod += 5;
			if(player.biggestTitSize() >= 66) escapeMod += 10;
			if(player.hips.type >= 20) escapeMod += 5;
			if(player.butt.type >= 20) escapeMod += 5;
			if(player.balls > 0){
				if(player.ballSize >= 24) escapeMod += 5;
				if(player.ballSize >= 48) escapeMod += 10;
				if(player.ballSize >= 120) escapeMod += 10;
			}
		}
		return player.spe > rand(monster.spe + escapeMod);
	}

	/**
	 * Checks if the player made a successful run attempt using the Runner Perk
	 * @return true if successful
	 */
	public function runCheckRunner():Boolean {
		return player.hasPerk(PerkLib.Runner) && rand(100) < 50;
	}

	/**
	 *  The default run failure display.
	 *  This function is for monsters overriding runAway that don't need to change failure texts
	 */
	public function runFailDefault():void {
		var text:String = "";
		//Flyers get special failure message.
		if(player.canFly()) {
			text = ("[monster A][monster name] manage"+(monster.plural? "s":"")+" to grab your [legs] and drag you back to the ground before you can fly away!");
		} else if(player.tailType == Tail.RACCOON && player.ears.type == Ears.RACCOON && player.hasPerk(PerkLib.Runner)){
			text = "Using your running skill, you build up a head of steam and jump, but before you can clear the ground more than a foot, your opponent latches onto you and drags you back down with a thud!";
		} else {
			//Huge balls messages
			if(player.balls > 0 && player.ballSize >= 24) {
				text += "With your [balls] " + (player.ballSize < 48 ? "swinging ponderously beneath you" : "dragging along the ground") + ", getting away is far harder than it should be.  ";
			}
			//FATASS BODY MESSAGES
			var largeButt: Boolean = player.butt.type >= 20;
			var largeHips: Boolean = player.hips.type >= 20;
			var largeTits: Boolean = player.biggestTitSize() >= 35;
			var hugeTits : Boolean = player.biggestTitSize() >= 66;

			if (hugeTits) { //FOR PLAYERS WITH MASSIVE BREASTS
				text += "Your [chest] nearly drag along the ground";
				if (largeHips) {
					text += " while your [hips] swing side to side";
					if (largeButt) {
						text += " causing the fat of your [skintone][butt] to wobble heavily,";
					}
				} else {
					text += largeButt? " while the fat of your [skintone][butt] wobbles heavily from side to side," : ",";
				}
				text += " forcing your body off balance and preventing you from moving quick enough to escape."
			}
			else if (largeTits) { //FOR PLAYERS WITH GIANT BREASTS
				if (largeHips) {
					text += "Your [hips] forces your gait to lurch slightly side to side, which causes the fat of your [skintone] ";
					if (largeButt) {
						text += "[butt] and ";
					}
					text += "[chest] to wobble immensely, throwing you off balance and preventing you from moving quick enough to escape.";
				} else if (largeButt) {
					text += "Your [skintone][butt] and [chest] wobble and bounce heavily, throwing you off balance and preventing you from moving quick enough to escape.";
				} else {
					text += "Your [chest] jiggle and wobble side to side like the [skintone] sacks of milky fat they are, with such force as to constantly throw you off balance, preventing you from moving quick enough to escape.";
				}
			}
			else if (largeHips) { //FOR PLAYERS WITH EITHER GIANT HIPS OR BUTT BUT NOT THE BREASTS
				text += "Your [hips] swing heavily from side to side ";
				if (largeButt) {
					text += "causing your [skintone][butt] to wobble obscenely ";
				}
				text += "forcing your body into an awkward gait that slows you down, preventing you from escaping.";
			}
			else if (largeButt) { //JUST DA BOOTAH
				text += ("Your [skintone][butt] wobbles so heavily that you're unable to move quick enough to escape.");
			}
			else { //NORMAL RUN FAIL MESSAGE
				text += ("[monster A][monster name] stay"+(monster.plural? "s" : "")+" hot on your heels, denying you a chance at escape!");
			}
		}
		runFail(text,true);
	}

	/**
	 * The default run success display
	 * This function for monsters overriding runAway that don't need to change success texts
	 * @param runner if the runner perk caused the run success
	 */
	public function runSucceedDefault(runner:Boolean = false):void{
		var text:String = "";
		if(runner) {
			if(player.tailType == Tail.RACCOON && player.ears.type == Ears.RACCOON) { //sekrit benefit: if you have coon ears, coon tail, and Runner perk, change normal Runner escape to flight-type escape
				text += "Using your running skill, you build up a head of steam and jump, then spread your arms and flail your tail wildly; your opponent dogs you as best [monster he] can, but stops and stares dumbly as your spastic tail slowly propels you several meters into the air!  You leave [monster him] behind with your clumsy, jerky, short-range flight.";
			} else {
				text += "Thanks to your talent for running, you manage to escape.";
			}
		} else {
			if(player.canFly()) {
				text += "[monster A][monster name] can't catch you.";
			}
			else {
				text += ("[monster A][monster name] rapidly disappears into the shifting landscape behind you.");
			}
		}
		//fixme @Oxdeception Izma specific run text should be moved to Izma
		if(monster.short == "Izma") {
			text += "\n\nAs you leave the tigershark behind, her taunting voice rings out after you.  \"<i>Oooh, look at that fine backside!  Are you running or trying to entice me?  Haha, looks like we know who's the superior specimen now!  Remember: next time we meet, you owe me that ass!</i>\"  Your cheek tingles in shame at her catcalls.";
		}
		runSucceed(text);
	}

/**
 * The player [run] option
 * @param callHook set false to bypass monster overrides
 */
public function runAway(callHook:Boolean = true):void {
	clearOutput();
	if (callHook && monster.onPcRunAttempt != null){
		monster.onPcRunAttempt();
		return;
	}
	if (inCombat && player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 4) {
		return runFail("You try to run, but you just can't seem to escape.  <b>Your ability to run was sealed, and now you've wasted a chance to attack!</b>\n\n",true);
	}
	//Rut doesnt let you run from dicks.
	if(player.inRut && monster.cockTotal() > 0) {
		return runFail("The thought of another male in your area competing for all the pussy infuriates you!  No way will you run!");
	}
	if(SceneLib.urtaQuest.isUrta()) {
		return runFail("You can't escape from this fight!");
	}
	if(inDungeon || inRoomedDungeon) {
		return runFail("You're trapped in your foe's home turf - there is nowhere to run!\n\n",true);
	}
	//Attempt texts!
	if(player.canFly()) outputText("Gritting your teeth with effort, you beat your wings quickly and lift off!  ");
	else {
		//Stuck!
		if(player.hasStatusEffect(StatusEffects.NoFlee)) {
			if(monster.short == "goblin") outputText("You try to flee but get stuck in the sticky white goop surrounding you.\n\n");
			return runFail("You put all your skills at running to work and make a supreme effort to escape, but are unable to get away!\n\n", true);
		}
		//Nonstuck!
		outputText("You turn tail and attempt to flee!  ");
	}

	if (runCheckEscaped()) { //SUCCESSFUL FLEE
		runSucceedDefault()
	} else if(runCheckRunner()) { //Runner Perk Chance
		runSucceedDefault(true)
	} else {
		runFailDefault();
	}
}

public function takeFlight():void {
	clearOutput();
	outputText("You open you wing taking flight.\n\n");
	player.createStatusEffect(StatusEffects.Flying, 7, 0, 0, 0);
	if (!player.hasPerk(PerkLib.Resolute)) {
		player.createStatusEffect(StatusEffects.FlyingNoStun, 0, 0, 0, 0);
		player.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
	}
	monster.createStatusEffect(StatusEffects.MonsterAttacksDisabled, 0, 0, 0, 0);
	enemyAI();
}

public function greatDive():void {
	lastAttack = HPSPELL;
	clearOutput();
	if(player.fatigue + physicalCost(50) > player.maxFatigue()) {
		clearOutput();
		outputText("You are too tired to perform a great dive attack.");
		doNext(combatMenu);
		return;
	}
	doNext(combatMenu);
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
	fatigue(50, USEFATG_MAGIC);
	var damage:Number = unarmedAttack();
	damage += player.str;
	damage += player.spe * 2;
	if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
	if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
	outputText("You focus on [monster A][monster name] fold your wing and dive down using gravity to increase the impact");
	if (player.lowerBody == LowerBody.HARPY) {
		outputText("making a bloody trail with your talons");
		damage *= 1.5;
	}
	else outputText(" hitting your target with violence");
	damage = Math.round(damage);
	damage = doDamage(damage);
	checkAchievementDamage(damage);
	outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>).\n\n");
	if (player.isFlying()) player.removeStatusEffect(StatusEffects.Flying);
	if (player.hasStatusEffect(StatusEffects.FlyingNoStun)) {
		player.removeStatusEffect(StatusEffects.FlyingNoStun);
		player.removePerk(PerkLib.Resolute);
	}
	monster.removeStatusEffect(StatusEffects.MonsterAttacksDisabled);
	enemyAI();
}
}
}
