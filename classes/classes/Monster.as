﻿package classes
{
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Beard;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Items.ArmorLib;
import classes.Items.ConsumableLib;
import classes.Items.JewelryLib;
import classes.Items.ShieldLib;
import classes.Items.UndergarmentLib;
import classes.Items.UseableLib;
import classes.Items.WeaponLib;
import classes.Items.WeaponRangeLib;
import classes.Scenes.Areas.Forest.Alraune;
import classes.Scenes.Areas.Ocean.UnderwaterSharkGirl;
import classes.Scenes.Areas.Ocean.UnderwaterTigersharkGirl;
	import classes.Scenes.Combat.Combat;
	import classes.Scenes.Dungeons.DenOfDesire.HeroslayerOmnibus;
import classes.Scenes.Dungeons.Factory.OmnibusOverseer;
import classes.Scenes.Dungeons.Factory.SecretarialSuccubus;
import classes.Scenes.NPCs.ChiChi;
import classes.Scenes.Quests.UrtaQuest.MilkySuccubus;
import classes.Scenes.SceneLib;
import classes.internals.ChainedDrop;
import classes.internals.RandomDrop;
import classes.internals.Utils;
import classes.internals.WeightedDrop;
import classes.lists.Gender;

import flash.utils.getQualifiedClassName;

/**
	 * ...
	 * @author Yoffy, Fake-Name, aimozg
	 */
	public class Monster extends Creature
	{

		protected final function get player():Player
		{
			return game.player;
		}

		//Weapon melee
		private var _weaponName:String = "";
		private var _weaponVerb:String = "";
		private var _weaponAttack:Number = 0;
		private var _weaponPerk:String = "";
		private var _weaponValue:Number = 0;
		override public function get weaponName():String { return _weaponName; }
		override public function get weaponVerb():String { return _weaponVerb; }
		override public function get weaponAttack():Number { return _weaponAttack; }
		override public function get weaponPerk():String { return _weaponPerk; }
		override public function get weaponValue():Number { return _weaponValue; }
		public function set weaponName(value:String):void { _weaponName = value; }
		public function set weaponVerb(value:String):void { _weaponVerb = value; }
		public function set weaponAttack(value:Number):void { _weaponAttack = value; }
		public function set weaponPerk(value:String):void { _weaponPerk = value; }
		public function set weaponValue(value:Number):void { _weaponValue = value; }
		//Weapon range
		private var _weaponRangeName:String = "";
		private var _weaponRangeVerb:String = "";
		private var _weaponRangeAttack:Number = 0;
		private var _weaponRangePerk:String = "";
		private var _weaponRangeValue:Number = 0;
		override public function get weaponRangeName():String { return _weaponRangeName; }
		override public function get weaponRangeVerb():String { return _weaponRangeVerb; }
		override public function get weaponRangeAttack():Number { return _weaponRangeAttack; }
		override public function get weaponRangePerk():String { return _weaponRangePerk; }
		override public function get weaponRangeValue():Number { return _weaponRangeValue; }
		public function set weaponRangeName(value:String):void { _weaponRangeName = value; }
		public function set weaponRangeVerb(value:String):void { _weaponRangeVerb = value; }
		public function set weaponRangeAttack(value:Number):void { _weaponRangeAttack = value; }
		public function set weaponRangePerk(value:String):void { _weaponRangePerk = value; }
		public function set weaponRangeValue(value:Number):void { _weaponRangeValue = value; }
		//Clothing/Armor
		private var _armorName:String = "";
		private var _armorDef:Number = 0;
		private var _armorPerk:String = "";
		private var _armorValue:Number = 0;
		override public function get armorName():String { return _armorName; }
		override public function get armorDef():Number { return _armorDef; }
		override public function get armorPerk():String { return _armorPerk; }
		override public function get armorValue():Number { return _armorValue; }
		public function set armorValue(value:Number):void { _armorValue = value; }
		public function set armorName(value:String):void { _armorName = value; }
		public function set armorDef(value:Number):void { _armorDef = value; }
		public function set armorPerk(value:String):void { _armorPerk = value; }
		//Jewelry!
		private var _jewelryName:String = "";
		private var _jewelryEffectId:Number = 0;
		private var _jewelryEffectMagnitude:Number = 0;
		private var _jewelryPerk:String = "";
		private var _jewelryValue:Number = 0;
		override public function get jewelryName():String { return _jewelryName; }
		override public function get jewelryEffectId():Number { return _jewelryEffectId; }
		override public function get jewelryEffectMagnitude():Number { return _jewelryEffectMagnitude; }
		override public function get jewelryPerk():String { return _jewelryPerk; }
		override public function get jewelryValue():Number { return _jewelryValue; }
		public function set jewelryValue(value:Number):void { _jewelryValue = value; }
		public function set jewelryName(value:String):void { _jewelryName = value; }
		public function set jewelryEffectId(value:Number):void { _jewelryEffectId = value; }
		public function set jewelryEffectMagnitude(value:Number):void { _jewelryEffectId = value; }
		public function set jewelryPerk(value:String):void { _jewelryPerk = value; }
		//Shield!
		private var _shieldName:String = "";
		private var _shieldBlock:Number = 0;
		private var _shieldPerk:String = "";
		private var _shieldValue:Number = 0;
		override public function get shieldName():String { return _shieldName; }
		override public function get shieldBlock():Number { return _shieldBlock; }
		override public function get shieldPerk():String { return _shieldPerk; }
		override public function get shieldValue():Number { return _shieldValue; }
		public function set shieldValue(value:Number):void { _shieldValue = value; }
		public function set shieldName(value:String):void { _shieldName = value; }
		public function set shieldBlock(value:Number):void { _shieldBlock = value; }
		public function set shieldPerk(value:String):void { _shieldPerk = value; }
		//Undergarments!
		private var _upperGarmentName:String = "";
		private var _upperGarmentPerk:String = "";
		private var _upperGarmentValue:Number = 0;
		override public function get upperGarmentName():String { return _upperGarmentName; }
		override public function get upperGarmentPerk():String { return _upperGarmentPerk; }
		override public function get upperGarmentValue():Number { return _upperGarmentValue; }
		public function set upperGarmentName(value:String):void { _upperGarmentName = value; }
		public function set upperGarmentPerk(value:String):void { _upperGarmentPerk = value; }
		public function set upperGarmentValue(value:Number):void { _upperGarmentValue = value; }

		private var _lowerGarmentName:String = "";
		private var _lowerGarmentPerk:String = "";
		private var _lowerGarmentValue:Number = 0;
		override public function get lowerGarmentName():String { return _lowerGarmentName; }
		override public function get lowerGarmentPerk():String { return _lowerGarmentPerk; }
		override public function get lowerGarmentValue():Number { return _lowerGarmentValue; }
		public function set lowerGarmentName(value:String):void { _lowerGarmentName = value; }
		public function set lowerGarmentPerk(value:String):void { _lowerGarmentPerk = value; }
		public function set lowerGarmentValue(value:Number):void { _lowerGarmentValue = value; }



        public function newGamePlusMod():int {
            return player.newGamePlusMod();
        }
		protected final function outputText(text:String,clear:Boolean=false):void{
			if (clear) EngineCore.clearOutputTextOnly();
			EngineCore.outputText(text);
		}
		protected final function cleanupAfterCombat():void
		{
			SceneLib.combat.cleanupAfterCombatImpl();
		}
		protected static function showStatDown(a:String):void{
			CoC.instance.mainView.statsView.showStatDown(a);
		}
		protected final function statScreenRefresh():void {
			EngineCore.statScreenRefresh();
		}
		protected final function doNext(eventNo:Function):void { //Now typesafe
			EngineCore.doNext(eventNo);
		}
		protected final function combatMiss():Boolean {
			return SceneLib.combat.combatMiss();
		}
		protected final function combatParry():Boolean {
			return SceneLib.combat.combatParry();
		}
		protected final function combatBlock(doFatigue:Boolean = false):Boolean {
			return SceneLib.combat.combatBlock(doFatigue);
		}
		protected function get consumables():ConsumableLib{
			return game.consumables;
		}
		protected function get useables():UseableLib{
			return game.useables;
		}
		protected function get weapons():WeaponLib{
			return game.weapons;
		}
		protected function get weaponsrange():WeaponRangeLib{
			return game.weaponsrange;
		}
		protected function get shields():ShieldLib{
			return game.shields;
		}
		protected function get armors():ArmorLib{
			return game.armors;
		}
		protected function get jewelries():JewelryLib{
			return game.jewelries;
		}
		protected function get undergarments():UndergarmentLib{
			return game.undergarments;
		}
		//For enemies
		public var bonusHP:Number = 0;
		public var bonusLust:Number = 0;
		public var bonusKi:Number = 0;
		public var bonusWrath:Number = 0;
		public var bonusMana:Number = 0;
		public var bonusStr:Number = 0;
		public var bonusTou:Number = 0;
		public var bonusSpe:Number = 0;
		public var bonusInte:Number = 0;
		public var bonusWis:Number = 0;
		public var bonusLib:Number = 0;
		protected var bonusAscStr:Number = 0;
		protected var bonusAscTou:Number = 0;
		protected var bonusAscSpe:Number = 0;
		protected var bonusAscInt:Number = 0;
		protected var bonusAscWis:Number = 0;
		protected var bonusAscLib:Number = 0;
		protected var bonusAscSen:Number = 0;
		protected var bonusAscMaxHP:Number = 0;
		private var _long:String = "<b>You have encountered an unitialized  Please report this as a bug</b>.";
		public function get long():String
		{
			return _long;
		}
		public function set long(value:String):void
		{
			initsCalled.long = true;
			_long = value;
		}


		//Is a creature a 'plural' encounter - mob, etc.
		public var plural:Boolean = false;
		public function isare():String{
			if(plural){
				return "are";
			}
			return "is";
		}


		public var imageName:String = "";

		//Lust vulnerability
		public var lustVuln:Number = 1;

		public static const TEMPERMENT_AVOID_GRAPPLES:int = 0;
		public static const TEMPERMENT_LUSTY_GRAPPLES:int = 1;
		public static const TEMPERMENT_RANDOM_GRAPPLES:int = 2;
		public static const TEMPERMENT_LOVE_GRAPPLES:int = 3;
		/**
		 * temperment - used for determining grapple behaviors
		 * 0 - avoid grapples/break grapple
		 * 1 - lust determines > 50 grapple
		 * 2 - random
		 * 3 - love grapples
		*/
		public var temperment:Number = TEMPERMENT_AVOID_GRAPPLES;

		//Used for special attacks.
		public var special1:Function = null;
		public var special2:Function = null;
		public var special3:Function = null;

		//he
		public var pronoun1:String = "";
		public function get Pronoun1():String{
			if (pronoun1=="") return "";
			return pronoun1.substr(0,1).toUpperCase()+pronoun1.substr(1);
		}
		//him
		public var pronoun2:String = "";
		public function get Pronoun2():String{
			if (pronoun2=="") return "";
			return pronoun2.substr(0,1).toUpperCase()+pronoun2.substr(1);
		}
		//3: Possessive his
		public var pronoun3:String = "";
		public function get Pronoun3():String{
			if (pronoun3=="") return "";
			return pronoun3.substr(0,1).toUpperCase()+pronoun3.substr(1);
		}

		private var _drop:RandomDrop = new ChainedDrop();
		public function get drop():RandomDrop { return _drop; }
		public function set drop(value:RandomDrop):void
		{
			_drop = value;
			initedDrop = true;
		}

		protected override function maxHP_base():Number {
			//Base HP
			var temp:Number = 100 + this.level * 15 + this.bonusHP;
			temp += (this.tou);
			if (this.tou >= 21) temp += (this.tou*2);
			if (this.tou >= 41) temp += (this.tou*3);
			if (this.tou >= 61) temp += (this.tou*4);
			if (this.tou >= 81) temp += (this.tou*5);
			if (this.tou >= 101) temp += (this.tou*6);
			if (this.tou >= 151) temp += (this.tou*8);
			if (this.tou >= 201) temp += (this.tou*10);
			if (this.tou >= 251) temp += (this.tou*12);
			if (this.tou >= 301) temp += (this.tou*14);
			if (this.tou >= 351) temp += (this.tou*16);
			if (this.tou >= 401) temp += (this.tou*18);
			if (this.tou >= 451) temp += (this.tou*20);
			if (this.tou >= 501) temp += (this.tou*22);
			if (this.tou >= 551) temp += (this.tou*24);
			if (this.tou >= 601) temp += (this.tou*26);
			if (this.tou >= 651) temp += (this.tou*28);
			if (this.tou >= 701) temp += (this.tou*30);
			if (this.tou >= 751) temp += (this.tou*32);
			if (this.tou >= 801) temp += (this.tou*34);
			if (this.tou >= 851) temp += (this.tou*36);
			if (this.tou >= 901) temp += (this.tou*38);
			if (this.tou >= 951) temp += (this.tou*40);
			//Apply NG+, NG++, NG+++, etc.
			temp += this.bonusAscMaxHP * newGamePlusMod();
			//Apply perks
			if (hasPerk(PerkLib.Tank)) temp += ((this.tou*3) * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.JobGuardian)) temp += 30;
			return temp;
		}
		protected override function maxHP_mult():Number {
			var temp:Number = 1.0;
			if (hasPerk(PerkLib.ShieldWielder)) temp *= 1.5;
			if (hasPerk(PerkLib.EnemyBossType)) temp *= 2;
			if (hasPerk(PerkLib.EnemyGigantType)) temp *= 3;
			if (hasPerk(PerkLib.EnemyGroupType)) temp *= 5;
			//Apply difficulty
			if (flags[kFLAGS.GAME_DIFFICULTY] <= 0) temp *= 1.0;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 1) temp *= 1.25;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) temp *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) temp *= 2.0;
			else temp *= 3.0;
			return temp;
		}
		public override function maxHP():Number {
            return Math.round(maxHP_base()*maxHP_mult());
        }

		public function addHP(hp:Number):void{
			this.HP += hp;
			if (this.HP<0) this.HP = 0;
			else if (this.HP > maxHP()) this.HP = maxHP();
		}

		protected override function maxLust_base():Number {
			//Base lust
			var temp:Number = 70 + this.bonusLust;
			//Apply perks
			if (hasPerk(PerkLib.JobCourtesan)) temp += 20;
			if (hasPerk(PerkLib.JobSeducer)) temp += 10;
			//Apply NG+, NG++, NG+++, etc.
			temp += this.bonusLust * newGamePlusMod();
			temp += this.level * 2;
			if (this.level >= 24) temp += (this.level - 23) * 3;
			if (this.level >= 42) temp += (this.level - 42) * 5;
			if (this.level >= 72) temp += (this.level - 72) * 10;
			if (this.level >= 102) temp += (this.level - 102) * 20;
			return temp;
		}
		
		public override function maxFatigue():Number
		{
			//Base fatigue
			var temp:Number = 100 + this.level * 5;
			//Apply perks
			if (hasPerk(PerkLib.JobHunter)) temp += 50;
			if (hasPerk(PerkLib.JobRanger)) temp += 5;
			if (hasPerk(PerkLib.PrestigeJobArcaneArcher)) temp += 600;
			return temp;
		}
		
		public override function maxKi():Number
		{
			//Base ki
			var temp:Number = 50 + this.bonusKi;
			if (hasPerk(PerkLib.EnemyTrueDemon)) temp = 0;
			return temp;
		}
		
		public override function maxWrath():Number
		{
			//Base wrath
			var temp:Number = 250 + this.bonusWrath;
			if (hasPerk(PerkLib.PrimalFury)) temp += (10 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.FeralArmor)) temp += 20;
			if (hasPerk(PerkLib.JobDervish)) temp += 20;
			if (hasPerk(PerkLib.JobWarrior)) temp += 10;
			if (hasPerk(PerkLib.Berzerker)) temp += 100;
			if (hasPerk(PerkLib.Lustzerker)) temp += 100;
			if (hasPerk(PerkLib.PrestigeJobBerserker)) temp += 200;
			if (hasPerk(PerkLib.Rage)) temp += 300;
			return temp;
		}
		
		public override function maxMana():Number
		{
			//Base mana
			var temp:Number = 100 + this.level * 10 + this.bonusMana;
			if (hasPerk(PerkLib.Spellpower) && inte >= 50) temp += 15;
			if (hasPerk(PerkLib.JobSorcerer)) temp += 15;
			return temp;
		}

		/**
		 * @return HP/eMaxHP()
		 */
		public function HPRatio():Number{
			return HP / maxHP();
		}

		/**
		 * @return damage not reduced by player stats
		 */
		public function eBaseDamage():Number {
			var damage:Number = 0;
			damage += str + (scalingBonusStrength() * 0.25);
			if (str < 10) damage = 10;
			//weapon bonus
			if (weaponAttack < 51) damage *= (1 + (weaponAttack * 0.03));
			else if (weaponAttack >= 51 && weaponAttack < 101) damage *= (2.5 + ((weaponAttack - 50) * 0.025));
			else if (weaponAttack >= 101 && weaponAttack < 151) damage *= (3.75 + ((weaponAttack - 100) * 0.02));
			else if (weaponAttack >= 151 && weaponAttack < 201) damage *= (4.75 + ((weaponAttack - 150) * 0.015));
			else damage *= (5.5 + ((weaponAttack - 200) * 0.01));
			if (hasStatusEffect(StatusEffects.PunishingKick)) damage *= 0.5;
			//monster exclusive perks bonus
			if (hasPerk(PerkLib.EnemyBossType)) damage *= 2;
			if (hasPerk(PerkLib.EnemyGigantType)) damage *= 3;
			//other
			if (hasStatusEffect(StatusEffects.Bloodlust)) damage *= (1 + (0.1 * statusEffectv2(StatusEffects.Bloodlust)));
			if (!hasPerk(PerkLib.JobWarrior) && wrath >= 200) {
				wrath -= 200;
				damage *= 2;
			}
			if (hasPerk(PerkLib.JobWarrior) && wrath >= 100) {
				if (rand(2) == 0) {
					wrath -= 100;
					damage *= 3;
				}
				else {
					wrath -= 50;
					damage *= 2;
				}
			}
			damage = Math.round(damage);
			return damage;
		}

		public function eBaseStrengthDamage():Number {
			var damage:Number = 0;
			damage += str + scalingBonusStrength();
			if (hasStatusEffect(StatusEffects.PunishingKick)) damage *= 0.5;
			//monster exclusive perks bonus
			if (hasPerk(PerkLib.EnemyBossType)) damage *= 2;
			if (hasPerk(PerkLib.EnemyGigantType)) damage *= 3;
			damage = Math.round(damage);
			return damage;
		}

		public function eBaseToughnessDamage():Number {
			var damage:Number = 0;
			damage += tou + scalingBonusToughness();
			if (hasStatusEffect(StatusEffects.PunishingKick)) damage *= 0.5;
			//monster exclusive perks bonus
			if (hasPerk(PerkLib.EnemyBossType)) damage *= 2;
			if (hasPerk(PerkLib.EnemyGigantType)) damage *= 3;
			damage = Math.round(damage);
			return damage;
		}

		public function eBaseSpeedDamage():Number {
			var damage:Number = 0;
			damage += spe + scalingBonusSpeed();
			if (hasStatusEffect(StatusEffects.PunishingKick)) damage *= 0.5;
			//monster exclusive perks bonus
			if (hasPerk(PerkLib.EnemyBossType)) damage *= 2;
			if (hasPerk(PerkLib.EnemyGigantType)) damage *= 3;
			damage = Math.round(damage);
			return damage;
		}

		public function eBaseIntelligenceDamage():Number {
			var damage:Number = 0;
			damage += inte + scalingBonusIntelligence();
			//monster exclusive perks bonus
			if (hasPerk(PerkLib.EnemyBossType)) damage *= 2;
			if (hasPerk(PerkLib.EnemyGigantType)) damage *= 3;
			damage = Math.round(damage);
			return damage;
		}

		public function eBaseWisdomDamage():Number {
			var damage:Number = 0;
			damage += wis + scalingBonusWisdom();
			//monster exclusive perks bonus
			if (hasPerk(PerkLib.EnemyBossType)) damage *= 2;
			if (hasPerk(PerkLib.EnemyGigantType)) damage *= 3;
			damage = Math.round(damage);
			return damage;
		}

		/**
		 * @return randomized damage reduced by player stats
		 */
		public function calcDamage():int{
			return player.reduceDamage(eBaseDamage());
		}

		public function totalXP(playerLevel:Number=-1):Number
		{
			var multiplier:Number = 1;
			multiplier += game.player.perkv1(PerkLib.AscensionWisdom) * 0.1;
			if (playerLevel == -1) playerLevel = game.player.level;
			// 1) Nerf xp gains by 10% per level after first one level difference up to 90% at 10 lvl diff!
			// 2) Bonuses for underlevel all the way to 20 lvl's below enemy! Above 20 lvl diff bonus is fixed at 300%! With underdog it increase to 40 lvl diff and caps at 900%!
			// 3) Super high level folks (over 10 levels) only get 1 xp!
			var difference:Number = 1;
			var diff2:Number = this.level - playerLevel;
			if (game.player.hasPerk(PerkLib.AscensionUnderdog)) {
				if (diff2 >= 40) difference += 8;
				if (diff2 >= 1 && diff2 < 40) difference += diff2 * 0.2;
			}
			else {
				if (diff2 >= 20) difference += 2;
				if (diff2 >= 1 && diff2 < 20) difference += diff2 * 0.1;
			}
			if (diff2 == -2) difference -= 0.1;
			if (diff2 == -3) difference -= 0.2;
			if (diff2 == -4) difference -= 0.3;
			if (diff2 == -5) difference -= 0.4;
			if (diff2 == -6) difference -= 0.5;
			if (diff2 == -7) difference -= 0.6;
			if (diff2 == -8) difference -= 0.7;
			if (diff2 == -9) difference -= 0.8;
			if (diff2 == -10) difference -= 0.9;
			if (diff2 < -10) {
				var minXP:Number = 1;
				if (hasPerk(PerkLib.EnemyBossType)) minXP *= 2;
				if (hasPerk(PerkLib.EnemyGigantType)) minXP *= 3;
				if (hasPerk(PerkLib.EnemyGroupType)) minXP *= 5;
				return minXP;
			}
			return Math.round((this.additionalXP + this.baseXP()) * this.bonusXP() * difference * multiplier);
		}
		protected function baseXP():Number
		{
			var baseMonXP:Number = this.level * 5;
			if (this.level < 7) baseMonXP += (this.level * 5) + rand(this.level * 5);
			else baseMonXP += rand(this.level * 5);
			return baseMonXP;
		}
		protected function bonusXP():Number
		{
			var specENtypes:Number = 1;
			if (hasPerk(PerkLib.ShieldWielder)) specENtypes *= 1.5;
			if (hasPerk(PerkLib.EnemyBossType)) specENtypes *= 2;
			if (hasPerk(PerkLib.EnemyGigantType)) specENtypes *= 3;
			if (hasPerk(PerkLib.EnemyGroupType)) specENtypes *= 5;
			return specENtypes;
		}

		public function Monster()
		{
			// trace("Generic Monster Constructor!");

			//// INSTRUCTIONS
			//// Copy-paste remaining code to the new monster constructor
			//// Uncomment and replace placeholder values with your own
			//// See existing monsters for examples

			// super(mainClassPtr);

			//// INIITIALIZERS
			//// If you want to skip something that is REQUIRED, you shoud set corresponding
			//// this.initedXXX property to true, e.g. this.initedGenitals = true;

			//// 1. Names and plural/singular
			///*REQUIRED*/ this.a = "a";
			///*REQUIRED*/ this.short = "short";
			///*OPTIONAL*/ // this.imageName = "imageName"; // default ""
			///*REQUIRED*/ this.long = "long";
			///*OPTIONAL*/ //this.plural = true|false; // default false

			//// 2. Gender, genitals, and pronouns (also see "note for 2." below)
			//// 2.1. Male
			///*REQUIRED*/ this.createCock(length,thickness,type); // defaults 5.5,1,human; could be called multiple times
			///*OPTIONAL*/ //this.balls = numberOfBalls; // default 0
			///*OPTIONAL*/ //this.ballSize = ; // default 0. should be set if balls>0
			///*OPTIONAL*/ //this.cumMultiplier = ; // default 1
			///*OPTIONAL*/ //this.hoursSinceCum = ; // default 0
			//// 2.2. Female
			///*REQUIRED*/ this.createVagina(virgin=true|false,VAGINA_WETNESS_,VAGINA_LOOSENESS_); // default true,normal,tight
			///*OPTIONAL*/ //this.createStatusEffect(StatusEffects.BonusVCapacity, bonus, 0, 0, 0);
			//// 2.3. Hermaphrodite
			//// Just create cocks and vaginas. Last call determines pronouns.
			//// 2.4. Genderless
			///*REQUIRED*/ initGenderless(); // this functions removes genitals!

			//// Note for 2.: during initialization pronouns are set in:
			//// * createCock: he/him/his
			//// * createVagina: she/her/her
			//// * initGenderless: it/it/its
			//// If plural=true, they are replaced with: they/them/their
			//// If you want to customize pronouns:
			///*OPTIONAL*/ //this.pronoun1 = "he";
			///*OPTIONAL*/ //this.pronoun2 = "him";
			///*OPTIONAL*/ //this.pronoun3 = "his";
			//// Another note for 2.: gender is automatically calculated in createCock,
			//// createVagina, initGenderless. If you want to change it, set this.gender
			//// after these method calls.

			//// 3. Breasts
			///*REQUIRED*/ this.createBreastRow(size,nipplesPerBreast); // default 0,1
			//// Repeat for multiple breast rows
			//// You can call just `this.createBreastRow();` for flat breasts
			//// Note useful method: this.createBreastRow(Appearance.breastCupInverse("C")); // "C" -> 3

			//// 4. Ass
			///*OPTIONAL*/ //this.ass.analLooseness = ANAL_LOOSENESS_; // default TIGHT
			///*OPTIONAL*/ //this.ass.analWetness = ANAL_WETNESS_; // default DRY
			///*OPTIONAL*/ //this.createStatusEffect(StatusEffects.BonusACapacity, bonus, 0, 0, 0);
			//// 5. Body
			///*REQUIRED*/ this.tallness = ;
			///*OPTIONAL*/ //this.hips.type = HIP_RATING_; // default boyish
			///*OPTIONAL*/ //this.butt.type = BUTT_RATING_; // default buttless
			///*OPTIONAL*/ //this.lowerBody = LOWER_BODY_; //default human
			///*OPTIONAL*/ //this.arms.type = ARM_TYPE_; // default human

			//// 6. Skin
			///*OPTIONAL*/ //this.skinTone = "skinTone"; // default "albino"
			///*OPTIONAL*/ //this.skinType = SKIN_TYPE_; // default PLAIN
			///*OPTIONAL*/ //this.skinDesc = "skinDesc"; // default "skin" if this.skinType is not set, else Skin.Types[skinType].name
			///*OPTIONAL*/ //this.skinAdj = "skinAdj"; // default ""

			//// 7. Hair
			///*OPTIONAL*/ //this.hairColor = ; // default "no"
			///*OPTIONAL*/ //this.hairLength = ; // default 0
			///*OPTIONAL*/ //this.hairType = HAIR_; // default NORMAL

			//// 8. Face
			///*OPTIONAL*/ //this.faceType = FACE_; // default HUMAN
			///*OPTIONAL*/ //this.earType = EARS_; // default HUMAN
			///*OPTIONAL*/ //this.tongue.type = TONGUE_; // default HUMAN
			///*OPTIONAL*/ //this.eyes.type = EYES_; // default HUMAN

			//// 9. Primary stats.
			///*REQUIRED*/ initStrTouSpeInte(,,,);
			///*REQUIRED*/ initLibSensCor(,,);

			//// 10. Weapon
			///*REQUIRED*/ this.weaponName = "weaponName";
			///*REQUIRED*/ this.weaponVerb = "weaponVerb";
			///*OPTIONAL*/ //this.weaponAttack = ; // default 0
			///*OPTIONAL*/ //this.weaponPerk = "weaponPerk"; // default ""
			///*OPTIONAL*/ //this.weaponValue = ; // default 0

			//// 11. Armor
			///*REQUIRED*/ this.armorName = "armorName";
			///*OPTIONAL*/ //this.armorDef = ; // default 0
			///*OPTIONAL*/ //this.armorPerk = "armorPerk"; // default ""
			///*OPTIONAL*/ //this.armorValue = ; // default 0

			//// 12. Combat
			///*OPTIONAL*/ //this.bonusHP = ; // default 0
			///*OPTIONAL*/ //this.bonusLust = ; // default 0
			///*OPTIONAL*/ //this.lust = ; // default 0
			///*OPTIONAL*/ //this.lustVuln = ; // default 1
			///*OPTIONAL*/ //this.temperment = TEMPERMENT; // default AVOID_GRAPPLES
			///*OPTIONAL*/ //this.fatigue = ; // default 0

			//// 13. Level
			///*REQUIRED*/ this.level = ;
			///*REQUIRED*/ this.gems = ;
			///*OPTIONAL*/ //this.additionalXP = ; // default 0

			//// 14. Drop
			//// 14.1. No drop
			///*REQUIRED*/ this.drop = NO_DROP;
			//// 14.2. Fixed drop
			///*REQUIRED*/ this.drop = new WeightedDrop(dropItemType);
			//// 14.3. Random weighted drop
			///*REQUIRED*/ this.drop = new WeightedDrop()...
			//// Append with calls like:
			//// .add(itemType,itemWeight)
			//// .addMany(itemWeight,itemType1,itemType2,...)
			//// Example:
			//// this.drop = new WeightedDrop()
			//// 		.add(A,2)
			//// 		.add(B,10)
			//// 		.add(C,1)
			//// 	will drop B 10 times more often than C, and 5 times more often than A.
 			//// 	To be precise, \forall add(A_i,w_i): P(A_i)=w_i/\sum_j w_j
			//// 14.4. Random chained check drop
			///*REQUIRED*/ this.drop = new ChainedDrop(optional defaultDrop)...
			//// Append with calls like:
			//// .add(itemType,chance)
			//// .elseDrop(defaultDropItem)
			////
			//// Example 1:
			//// init14ChainedDrop(A)
			//// 		.add(B,0.01)
			//// 		.add(C,0.5)
			//// 	will FIRST check B vs 0.01 chance,
			//// 	if it fails, C vs 0.5 chance,
			//// 	else A
			////
			//// 	Example 2:
			//// 	init14ChainedDrop()
			//// 		.add(B,0.01)
			//// 		.add(C,0.5)
			//// 		.elseDrop(A)
			//// 	for same result

			//// 15. Special attacks. No need to set them if the monster has custom AI.
			//// Values are either combat event numbers (5000+) or function references
			///*OPTIONAL*/ //this.special1 = ; //default 0
			///*OPTIONAL*/ //this.special2 = ; //default 0
			///*OPTIONAL*/ //this.special3 = ; //default 0

			//// 16. Tail
			///*OPTIONAL*/ //this.tailType = TAIL_TYPE_; // default NONE
			///*OPTIONAL*/ //this.tailCount = ; // default 0
			///*OPTIONAL*/ //this.tailVenom = ; // default 0
			///*OPTIONAL*/ //this.tailRecharge = ; // default 5

			//// 17. Horns
			///*OPTIONAL*/ //this.horns.type = HORNS_; // default NONE
			///*OPTIONAL*/ //this.horns = numberOfHorns; // default 0

			//// 18. Wings
			///*OPTIONAL*/ //this.wings.type = WING_TYPE_; // default NONE
			///*OPTIONAL*/ //this.wings.desc = ; // default Appearance.DEFAULT_WING_DESCS[wings.type]

			//// 19. Antennae
			///*OPTIONAL*/ //this.antennae.type = ANTENNAE_; // default NONE

			//// REQUIRED !!!
			//// In debug mode will throw an error for uninitialized monster
			//checkMonster();
		}

		private var _checkCalled:Boolean = false;
		public function get checkCalled():Boolean { return _checkCalled; }
		public var checkError:String = "";
		public var initsCalled:Object = {
			a:false,
			short:false,
			long:false,
			genitals:false,
			breasts:false,
			tallness:false,
			str_tou_spe_inte:false,
			wis_lib_sens_cor:false,
			drop:false
		};
		// MONSTER INITIALIZATION HELPER FUNCTIONS
		protected function set initedGenitals(value:Boolean):void{
			initsCalled.genitals = value;
		}
		protected function set initedBreasts(value:Boolean):void{
			initsCalled.breasts = value;
		}
		protected function set initedDrop(value:Boolean):void{
			initsCalled.drop = value;
		}
		protected function set initedStrTouSpeInte(value:Boolean):void{
			initsCalled.str_tou_spe_inte = value;
		}
		protected function set initedWisLibSensCor(value:Boolean):void{
			initsCalled.wis_lib_sens_cor = value;
		}
		protected const NO_DROP:WeightedDrop = new WeightedDrop();

		public function isFullyInit():Boolean {
			for each (var phase:Object in initsCalled) {
				if (phase is Boolean && phase == false) return false;
			}
			return true;
		}
		public function missingInits():String{
			var result:String = "";
			for (var phase:String in initsCalled){
				if (initsCalled[phase] is Boolean && initsCalled[phase] == false){
					if (result == "") result = phase;
					else result+=", "+phase;
				}
			}
			return result;
		}

		override public function set a(value:String):void {
			initsCalled.a = true;
			super.a = value;
		}

		override public function set short(value:String):void {
			initsCalled.short = true;
			super.short = value;
		}

		override public function createCock(clength:Number = 5.5, cthickness:Number = 1, ctype:CockTypesEnum = null):Boolean
		{
			initedGenitals = true;
			if (!_checkCalled) {
				if (plural) {
					this.pronoun1 = "they";
					this.pronoun2 = "them";
					this.pronoun3 = "their";
				} else {
					this.pronoun1 = "he";
					this.pronoun2 = "him";
					this.pronoun3 = "his";
				}
			}
			var result:Boolean = super.createCock(clength, cthickness, ctype);
			return result;
		}

		override public function createVagina(virgin:Boolean = true, vaginalWetness:Number = 1, vaginalLooseness:Number = 0):Boolean
		{
			initedGenitals = true;
			if (!_checkCalled) {
				if (plural) {
					this.pronoun1 = "they";
					this.pronoun2 = "them";
					this.pronoun3 = "their";
				} else {
					this.pronoun1 = "she";
					this.pronoun2 = "her";
					this.pronoun3 = "her";
				}
			}
			var result:Boolean = super.createVagina(virgin, vaginalWetness, vaginalLooseness);
			return result;
		}

		protected function initGenderless():void
		{
			this.cocks = [];
			this.vaginas = new <VaginaClass>[];
			initedGenitals = true;
			if (plural) {
				this.pronoun1 = "they";
				this.pronoun2 = "them";
				this.pronoun3 = "their";
			} else {
				this.pronoun1 = "it";
				this.pronoun2 = "it";
				this.pronoun3 = "its";
			}
		}

		override public function createBreastRow(size:Number = 0, nipplesPerBreast:Number = 1):Boolean
		{
			initedBreasts = true;
			return super.createBreastRow(size, nipplesPerBreast);
		}

		override public function set tallness(value:Number):void
		{
			initsCalled.tallness = true;
			super.tallness = value;
		}

		protected function initStrTouSpeInte(str:Number, tou:Number, spe:Number, inte:Number):void
		{
			this.str = str;
			this.tou = tou;
			this.spe = spe;
			this.inte = inte;
			initedStrTouSpeInte = true;
		}

		protected function initWisLibSensCor(wis:Number, lib:Number, sens:Number, cor:Number):void
		{
			this.wis = wis;
			this.lib = lib;
			this.sens = sens;
			this.cor = cor;
			initedWisLibSensCor = true;
		}

		override public function validate():String
		{
			var error:String = "";
			// 1. Required fields must be set
			if (!isFullyInit()) {
				error += "Missing phases: "+missingInits()+". ";
			}
			this.HP = maxHP();
			this.XP = totalXP();
			error += super.validate();
			error += Utils.validateNonNegativeNumberFields(this, "Monster.validate",[
					"lustVuln", "temperment"
			]);
			return error;
		}

		public function checkMonster():Boolean
		{
			_checkCalled = true;
			if(this.wings.type != Wings.NONE && this.wings.desc == "non-existant"){
				this.wings.desc = Appearance.DEFAULT_WING_DESCS[this.wings.type]
			}
			checkError = validate();
			if (checkError.length>0) CoC_Settings.error("Monster not initialized:"+checkError);
			return checkError.length == 0;
		}

		/**
		 * try to hit, apply damage
		 * @return damage
		 */
		public function eOneAttack():int
		{
			//Determine damage - str modified by enemy toughness!
			var damage:int = calcDamage();
			if (damage > 0) damage = player.takePhysDamage(damage);
			return damage;
		}

		/**
		 * return true if we land a hit
		 */
		protected function attackSucceeded():Boolean
		{
			var attack:Boolean = true;
			//Blind dodge change
			if (hasStatusEffect(StatusEffects.Blind)) {
				attack &&= handleBlind();
			}
			attack &&= !playerDodged();
			
			return attack;
		}

		public function eAttack():void {
			if (game.player.hasStatusEffect(StatusEffects.Hemorrhage)) {
				if (hasStatusEffect(StatusEffects.Bloodlust)) addStatusValue(StatusEffects.Bloodlust,1,10);
				else createStatusEffect(StatusEffects.Bloodlust,10,0,0,0);
			}
			if (hasStatusEffect(StatusEffects.Bloodlust) && !game.player.hasStatusEffect(StatusEffects.Hemorrhage)) {
				if (statusEffectv1(StatusEffects.Bloodlust) <= 10) {
					removeStatusEffect(StatusEffects.Bloodlust);
				}
				else {
					addStatusValue(StatusEffects.Bloodlust,1,-10);
				}
			}
			var attacks:int = statusEffectv1(StatusEffects.Attacks);
			if (attacks == 0) attacks = 1;
			while (attacks>0){
				if (attackSucceeded()){
				    var damage:int = eOneAttack();
					outputAttack(damage);
					postAttack(damage);
					EngineCore.statScreenRefresh();
					outputText("\n");
				}
				if (statusEffectv1(StatusEffects.Attacks) >= 0) {
					addStatusValue(StatusEffects.Attacks, 1, -1);
				}
				attacks--;
			}
			removeStatusEffect(StatusEffects.Attacks);
		}

		/**
		 * Called no matter of success of the attack
		 * @param damage damage received by player
		 */
		protected function postAttack(damage:int):void
		{
			if (damage > 0) {
				if (lustVuln > 0 && player.armorName == "barely-decent bondage straps") {
					if (!plural) outputText("\n" + capitalA + short + " brushes against your exposed skin and jerks back in surprise, coloring slightly from seeing so much of you revealed.");
					else outputText("\n" + capitalA + short + " brush against your exposed skin and jerk back in surprise, coloring slightly from seeing so much of you revealed.");
					lust += 5 * lustVuln;
				}
			}
		}

		public function outputAttack(damage:int):void
		{
			if (damage <= 0) {
				//Due to toughness or amor...
				if (rand(player.armorDef + player.tou) < player.armorDef) outputText("You absorb and deflect every " + weaponVerb + " with your " + (player.armor != ArmorLib.NOTHING ? player.armor.name : player.armorName) + ".");
				else {
					if (plural) outputText("You deflect and block every " + weaponVerb + " " + a + short + " throw at you. ");
					else outputText("You deflect and block every " + weaponVerb + " " + a + short + " throws at you. ");
				}
			}
			else if (damage < 6) outputText("You are struck a glancing blow by " + a + short + "! ");
			else if (damage < 11) {
				outputText(capitalA + short + " wound");
				if (!plural) outputText("s");
				outputText(" you! ");
			}
			else if (damage < 21) {
				outputText(capitalA + short + " stagger");
				if (!plural) outputText("s");
				outputText(" you with the force of " + pronoun3 + " " + weaponVerb + "! ");
			}
			else if (damage > 20) {
				outputText(capitalA + short + " <b>mutilate");
				if (!plural) outputText("s");
				outputText("</b> you with " + pronoun3 + " powerful " + weaponVerb + "! ");
			}
			if (damage > 0) {
				if (flags[kFLAGS.ENEMY_CRITICAL] > 0) outputText("<b>Critical hit! </b>");
				outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
		}

		/**
		 * @return true if continue with attack
		 */
		protected function handleBlind():Boolean
		{
			if (rand(3) < 2) {
				if (weaponVerb == "tongue-slap") outputText(capitalA + short + " completely misses you with a thrust from "+pronoun3+" tongue!\n");
				else outputText(capitalA + short + " completely misses you with a blind attack!\n");
				return false;
			}
			return true;
		}

		/**
		 * print something about how we miss the player
		 */
		protected function outputPlayerDodged(dodge:int):void
		{
			if (dodge==1) outputText("You narrowly avoid " + a + short + "'s " + weaponVerb + "!\n");
			else if (dodge==2) outputText("You dodge " + a + short + "'s " + weaponVerb + " with superior quickness!\n");
			else {
				outputText("You deftly avoid " + a + short);
				if (plural) outputText("'");
				else outputText("'s");
				outputText(" slow " + weaponVerb + ".\n");
			}
		}

		private function playerDodged():Boolean
		{
			//Determine if dodged!
			var dodge:int = player.speedDodge(this);
			if (dodge>0) {
				outputPlayerDodged(dodge);
				return true;
			}
			var evasionResult:String = player.getEvasionReason(false); // use separate function for speed dodge for expanded dodge description
			//Determine if evaded
			if (evasionResult == EVASION_EVADE) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'");
				if (!plural) outputText("s");
				outputText(" attack.\n");
				return true;
			}
			//("Misdirection"
			if (evasionResult == EVASION_MISDIRECTION) {
				outputText("Using Raphael's teachings, you anticipate and sidestep " + a + short + "' attacks.\n");
				return true;
			}
			//Determine if cat'ed
			if (evasionResult == EVASION_FLEXIBILITY) {
				outputText("With your incredible flexibility, you squeeze out of the way of " + a + short + "");
				if (plural) outputText("' attacks.\n");
				else outputText("'s attack.\n");
				return true;
			}
			if (evasionResult != null) { // Failsafe fur unhandled
				outputText("Using your superior combat skills you manage to avoid attack completely.\n");
				return true;
			}
			//Parry with weapon
			if (combatParry()) {
				outputText("You manage to block " + a + short + "");
				if (plural) outputText("' attacks ");
				else outputText("'s attack ");
				outputText("with your [weapon].\n");
				return true;
			}
			//Block with shield
			if (combatBlock(true)) {
				outputText("You block " + a + short + "'s " + weaponVerb + " with your [shield]! ");
				return true;
			}
			return false;
		}

		public function doAI():void
		{
			if (hasStatusEffect(StatusEffects.Stunned) || hasStatusEffect(StatusEffects.FreezingBreathStun) || hasStatusEffect(StatusEffects.StunnedTornado)) {
				if (!handleStun()) return;
			}
			if (hasStatusEffect(StatusEffects.Fear)) {
				if (!handleFear()) return;
			}
			//Exgartuan gets to do stuff!
			if (game.player.hasStatusEffect(StatusEffects.Exgartuan) && game.player.statusEffectv2(StatusEffects.Exgartuan) == 0 && rand(3) == 0) {
				if (SceneLib.exgartuan.exgartuanCombatUpdate()) EngineCore.outputText("\n\n");
			}
			if (hasStatusEffect(StatusEffects.Constricted) || hasStatusEffect(StatusEffects.ConstrictedScylla) || hasStatusEffect(StatusEffects.GooEngulf) || hasStatusEffect(StatusEffects.EmbraceVampire) || hasStatusEffect(StatusEffects.Pounce)) {
				if (!handleConstricted()) return;
			}
			if (hasStatusEffect(StatusEffects.AbilityCooldown1) ) {
				if (statusEffectv1(StatusEffects.AbilityCooldown1) <= 0) {
					removeStatusEffect(StatusEffects.AbilityCooldown1);
				}
				else {
					addStatusValue(StatusEffects.AbilityCooldown1,1,-1);
				}
			}
			//If grappling... TODO implement grappling
//			if (game.gameState == 2) {
//				game.gameState = 1;
				//temperment - used for determining grapple behaviors
				//0 - avoid grapples/break grapple
				//1 - lust determines > 50 grapple
				//2 - random
				//3 - love grapples
				/*
				 //		if(temperment == 0) eGrappleRetreat();
				 if (temperment == 1) {
				 //			if(lust < 50) eGrappleRetreat();
				 mainClassPtr.doNext(3);
				 return;
				 }
				 mainClassPtr.outputText("Lust Placeholder!!");
				 mainClassPtr.doNext(3);
				 return;*/
//			}
			performCombatAction();
		}

		/**
		 * Called if monster is constricted. Should return true if constriction is ignored and need to proceed with ai
		 */
		protected function handleConstricted():Boolean
		{
			if (hasStatusEffect(StatusEffects.Pounce)) {
			EngineCore.outputText("" + capitalA + short + " struggle to get free.");
			if (statusEffectv1(StatusEffects.Pounce) <= 0) {
				EngineCore.outputText("" + capitalA + short + " struggle to get free and manage to shove you off.");
				removeStatusEffect(StatusEffects.Pounce);
			}
			addStatusValue(StatusEffects.Pounce, 1, -1);
			return false;
			}
			else if (player.lowerBody == 26) {
			EngineCore.outputText("Your prey pushes at your tentacles, twisting and writhing in an effort to escape from your tentacle's tight bonds.");
			if (statusEffectv1(StatusEffects.ConstrictedScylla) <= 0) {
				EngineCore.outputText("  " + capitalA + short + " proves to be too much for your tentacles to handle, breaking free of your tightly bound coils.");
				removeStatusEffect(StatusEffects.ConstrictedScylla);
			}
			addStatusValue(StatusEffects.ConstrictedScylla, 1, -1);
			return false;
			}
			else if (player.lowerBody == 8) {
			EngineCore.outputText("" + capitalA + short + " struggle in your fluid form kicking and screaming to try and get out.");
			if (statusEffectv1(StatusEffects.GooEngulf) <= 0) {
				EngineCore.outputText("  " + capitalA + short + " proves to be too much for your tentacles to handle, breaking free of your tightly bound coils.");
				removeStatusEffect(StatusEffects.GooEngulf);
			}
			addStatusValue(StatusEffects.GooEngulf, 1, -1);
			return false;
			}
			else if (hasStatusEffect(StatusEffects.EmbraceVampire)) {
			if (statusEffectv1(StatusEffects.EmbraceVampire) <= 0) {
				EngineCore.outputText("You try to maintain your grip but " + a + short + " shove you off escaping your embrace!");
				removeStatusEffect(StatusEffects.EmbraceVampire);
			}
			else EngineCore.outputText("" + capitalA + short + " struggle but you manage to maintain the embrace.");
			addStatusValue(StatusEffects.EmbraceVampire, 1, -1);
			return false;
			}
			else {
			EngineCore.outputText("Your prey pushes at your tail, twisting and writhing in an effort to escape from your tail's tight bonds.");
			if (statusEffectv1(StatusEffects.Constricted) <= 0) {
				EngineCore.outputText("  " + capitalA + short + " proves to be too much for your tail to handle, breaking free of your tightly bound coils.");
				removeStatusEffect(StatusEffects.Constricted);
			}
			addStatusValue(StatusEffects.Constricted, 1, -1);
			return false;
			}
		}

		/**
		 * Called if monster is under fear. Should return true if fear ignored and need to proceed with ai
		 */
		protected function handleFear():Boolean
		{
			if (statusEffectv1(StatusEffects.Fear) == 0) {
				if (plural) {
					removeStatusEffect(StatusEffects.Fear);
					EngineCore.outputText("Your foes shake free of their fear and ready themselves for battle.");
				}
				else {
					removeStatusEffect(StatusEffects.Fear);
					EngineCore.outputText("Your foe shakes free of its fear and readies itself for battle.");
				}
			}
			else {
				addStatusValue(StatusEffects.Fear, 1, -1);
				if (plural) EngineCore.outputText(capitalA + short + " are too busy shivering with fear to fight.");
				else EngineCore.outputText(capitalA + short + " is too busy shivering with fear to fight.");
			}
			return false;
		}

		/**
		 * Called if monster is stunned. Should return true if stun is ignored and need to proceed with ai.
		 */
		protected function handleStun():Boolean
		{
			if (statusEffectv1(StatusEffects.Stunned) <= 0) removeStatusEffect(StatusEffects.Stunned);
			else addStatusValue(StatusEffects.Stunned, 1, -1);
			if (statusEffectv1(StatusEffects.StunnedTornado) <= 0) removeStatusEffect(StatusEffects.StunnedTornado);
			else {
				EngineCore.outputText(capitalA + short + " is still caught in the tornado.");
				addStatusValue(StatusEffects.StunnedTornado, 1, -1);
			}
			if (hasStatusEffect(StatusEffects.InkBlind)) {
				if (plural) EngineCore.outputText("Your foes are busy trying to remove the ink and therefore does no other action then flay their hand about its faces.");
				else EngineCore.outputText("Your foe is busy trying to remove the ink and therefore does no other action then flay its hand about its face.");
			}
			else if (hasStatusEffect(StatusEffects.FreezingBreathStun)) {
				if (plural) EngineCore.outputText("Your foes are too busy trying to break out of their icy prison to fight back.");
				else EngineCore.outputText("Your foe is too busy trying to break out of his icy prison to fight back.");
			}
			else if (hasStatusEffect(StatusEffects.MonsterAttacksDisabled)) EngineCore.outputText(capitalA + short + " try to hit you but is unable to reach you!");
			else {
				if (plural) EngineCore.outputText("Your foes are too dazed from your last hit to strike back!");
				else EngineCore.outputText("Your foe is too dazed from your last hit to strike back!");
			}
			return false;
		}

		/**
		 * This method is called after all stun/fear/constricted checks.
		 * Default: Equal chance to do physical or special (if any) attack
		 */
		protected function performCombatAction():void
		{
			var actions:Array = [eAttack,special1,special2,special3].filter(
					function(special:Function, idx:int, array:Array):Boolean {
						return special != null;
					}
			);
			var rando:int = int(Math.random() * (actions.length));
			var action:Function = actions[rando];
			action();
		}

		/**
		 * All branches of this method and all subsequent scenes should end either with
         * 'cleanupAfterCombat', 'awardPlayer' or 'finishCombat'. The latter also displays
		 * default message like "you defeat %s" or "%s falls and starts masturbating"
		 */
		public function defeated(hpVictory:Boolean):void
		{
			SceneLib.combat.finishCombat();
		}

		/**
		 * All branches of this method and all subsequent scenes should end with
         * 'cleanupAfterCombat'.
		 */
		public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			if (hpVictory){
				player.HP = 1;
				outputText("Your wounds are too great to bear, and you fall unconscious.", true);
			} else {
				outputText("Your desire reaches uncontrollable levels, and you end up openly masturbating.\n\nThe lust and pleasure cause you to black out for hours on end.", true);
				player.lust = 0;
			}
			game.inCombat = false;
            game.player.clearStatuses(false);
            var temp:Number = rand(10) + 1;
			if(temp > player.gems) temp = player.gems;
			outputText("\n\nYou'll probably wake up in eight hours or so, missing " + temp + " gems.");
			player.gems -= temp;
			EngineCore.doNext(SceneLib.camp.returnToCampUseEightHours);
		}

		/**
		 * Function(hpVictory) to call INSTEAD of default defeated(). Call it or finishCombat() manually
		 */
		public var onDefeated:Function = null;
		/**
		 * Function(hpVictory,pcCameWorms) to call INSTEAD of default won(). Call it or finishCombat() manually
		 */
		public var onWon:Function = null;
		/**
		 * Function() to call INSTEAD of common run attempt. Call runAway(false) to perform default run attempt
		 */
		public var onPcRunAttempt:Function = null;

		public function genericPcRunDisabled():void {
			SceneLib.combat.runFail("You can't escape from this fight!");
		}
		/**
		 * Final method to handle hooks before calling overriden method
		 */
		public final function defeated_(hpVictory:Boolean):void
		{
			if (onDefeated != null) onDefeated(hpVictory);
			else defeated(hpVictory);
		}

		/**
		 * Final method to handle hooks before calling overriden method
		 */
		public final function won_(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			if (onWon != null) onWon(hpVictory,pcCameWorms);
			else won(hpVictory,pcCameWorms);
		}

		/**
		 * Display tease reaction message. Then call applyTease() to increase lust.
		 * @param lustDelta value to be added to lust (already modified by lustVuln etc)
		 */
		public function teased(lustDelta:Number):void
		{
			outputDefaultTeaseReaction(lustDelta);
			if(lustDelta > 0) {
				//Imp mob uber interrupt!
			  	if(hasStatusEffect(StatusEffects.ImpUber)) { // TODO move to proper class
					outputText("\nThe imps in the back stumble over their spell, their loincloths tenting obviously as your display interrupts their casting.  One of them spontaneously orgasms, having managed to have his spell backfire.  He falls over, weakly twitching as a growing puddle of whiteness surrounds his defeated form.");
					//(-5% of max enemy HP)
					HP -= bonusHP * .05;
					lust -= 15;
					removeStatusEffect(StatusEffects.ImpUber);
					createStatusEffect(StatusEffects.ImpSkip,0,0,0,0);
				}
			}
			applyTease(lustDelta);
		}

		protected function outputDefaultTeaseReaction(lustDelta:Number):void
		{
			if (plural) {
				if (lustDelta == 0) outputText("\n\n" + capitalA + short + " seem unimpressed.");
				if (lustDelta > 0 && lustDelta < 4) outputText("\n" + capitalA + short + " look intrigued by what " + pronoun1 + " see.");
				if (lustDelta >= 4 && lustDelta < 10) outputText("\n" + capitalA + short + " definitely seem to be enjoying the show.");
				if (lustDelta >= 10 && lustDelta < 15) outputText("\n" + capitalA + short + " openly stroke " + pronoun2 + "selves as " + pronoun1 + " watch you.");
				if (lustDelta >= 15 && lustDelta < 20) outputText("\n" + capitalA + short + " flush hotly with desire, " + pronoun3 + " eyes filled with longing.");
				if (lustDelta >= 20) outputText("\n" + capitalA + short + " lick " + pronoun3 + " lips in anticipation, " + pronoun3 + " hands idly stroking " + pronoun3 + " bodies.");
			}
			else {
				if (lustDelta == 0) outputText("\n" + capitalA + short + " seems unimpressed.");
				if (lustDelta > 0 && lustDelta < 4) {
					if (plural) outputText("\n" + capitalA + short + " looks intrigued by what " + pronoun1 + " see.");
					else outputText("\n" + capitalA + short + " looks intrigued by what " + pronoun1 + " sees.");
				}
				if (lustDelta >= 4 && lustDelta < 10) outputText("\n" + capitalA + short + " definitely seems to be enjoying the show.");
				if (lustDelta >= 10 && lustDelta < 15) {
					if (plural) outputText("\n" + capitalA + short + " openly strokes " + pronoun2 + "selves as " + pronoun1 + " watch you.");
					else outputText("\n" + capitalA + short + " openly strokes " + pronoun2 + "self as " + pronoun1 + " watches you.");
				}
				if (lustDelta >= 15 && lustDelta < 20) {
					if (plural) outputText("\n" + capitalA + short + " flush hotly with desire, " + pronoun3 + " eyes filling with longing.");
					else outputText("\n" + capitalA + short + " flushes hotly with desire, " + pronoun3 + " eyes filled with longing.");
				}
				if (lustDelta >= 20) {
					if (plural) outputText("\n" + capitalA + short + " licks " + pronoun3 + " lips in anticipation, " + pronoun3 + " hands idly stroking " + pronoun3 + " own bodies.");
					else outputText("\n" + capitalA + short + " licks " + pronoun3 + " lips in anticipation, " + pronoun3 + " hands idly stroking " + pronoun3 + " own body.");
				}
			}
		}

		protected function applyTease(lustDelta:Number):void{
			lust += lustDelta;
			lustDelta = Math.round(lustDelta * 10)/10;
			outputText(" <b>(<font color=\"#ff00ff\">" + lustDelta + "</font>)</b>");
		}

		public function generateDebugDescription():String{
			var result:String;
			var be:String =plural?"are":"is";
			var have:String = plural ? "have" : "has";
			var Heis:String = Pronoun1+" "+be+" ";
			var Hehas:String = Pronoun1 + " " + have + " ";
			result = "You are inspecting "+a+short+" (imageName='"+imageName+"', class='"+getQualifiedClassName(this)+"'). You are fighting "+pronoun2+".\n\n";
			result += Heis+Gender.Values[gender].name+
					" with "+Appearance.numberOfThings(cocks.length,"cock") +
					", "+Appearance.numberOfThings(vaginas.length,"vagina")+
					" and "+Appearance.numberOfThings(breastRows.length,"breast row")+".\n\n";
			// APPEARANCE
			result += Heis + Appearance.inchesAndFeetsAndInches(tallness) + " tall with " +
			          Appearance.describeByScale(hips.type,Appearance.DEFAULT_HIP_RATING_SCALES,"thinner than","wider than") + " hips and " +
			          Appearance.describeByScale(butt.type,Appearance.DEFAULT_BUTT_RATING_SCALES,"thinner than","wider than") + " butt.\n";
			result +=Pronoun3+" lower body is "+LowerBody.Types[lowerBody].name;
			result += ", "+pronoun3+" arms are "+Arms.Types[arms.type].name;
			result += ", "+pronoun1+" "+have+" "+skinTone+" "+skinAdj+" "+skinDesc+
					  " (base "+Skin.Types[skin.baseType()].name+")." +
					  " (coat "+Skin.Types[skin.coatType()].name+")." +
					  "\n";
			result += Hehas;
			if (hairLength>0){
				result += hairColor+" "+Appearance.inchesAndFeetsAndInches(hairLength)+" long "+Hair.Types[hairType].name+" hair.\n";
			} else {
				result += "no hair.\n";
			}
			result += Hehas;
			if (beardLength>0){
				result += hairColor+" "+Appearance.inchesAndFeetsAndInches(beardLength)+" long "+Beard.Types[beardStyle].name+".\n";
			} else {
				result += "no beard.\n";
			}
			result += Hehas
					  + Face.Types[faceType].name + " face, "
					  + Ears.Types[ears.type].name + " ears, "
					  + Tongue.Types[tongue.type].name + " tongue and "
					  + Eyes.Types[eyes.type].name + " eyes.\n";
			result += Hehas;
			if (tailType == Tail.NONE) result += "no tail, ";
			else result+=Tail.Types[tailType].name+" "+tailCount+" tails with venom="+tailVenom+" and recharge="+tailRecharge+", ";
			if (horns.type == Horns.NONE) result += "no horns, ";
			else result += horns.count + " " + Horns.Types[horns.type].name + " horns, ";
			if (wings.type == Wings.NONE) result += "no wings, ";
			else result += wings.desc + " wings (type " + Wings.Types[wings.type].name + "), ";
			if (antennae.type == Antennae.NONE) result += "no antennae.\n\n";
			else result += Antennae.Types[antennae.type].name + " antennae.\n\n";

			// GENITALS AND BREASTS
			for (var i:int = 0; i<cocks.length; i++){
				var cock:Cock = (cocks[i] as Cock);
				result += Pronoun3+(i>0?(" #"+(i+1)):"")+" "+cock.cockType.toString().toLowerCase()+" cock is ";
				result += Appearance.inchesAndFeetsAndInches(cock.cockLength)+" long and "+cock.cockThickness+"\" thick";
				if (cock.isPierced) result+= ", pierced with "+cock.pLongDesc;
				if (cock.knotMultiplier!=1) result += ", with knot of size "+cock.knotMultiplier;
				result+=".\n";
			}
			if (balls>0 || ballSize>0) result += Hehas+Appearance.numberOfThings(balls,"ball")+" of size "+ballSize+".\n";
			if (cumMultiplier!=1 || cocks.length>0) result += Pronoun1+" "+have+" cum multiplier "+cumMultiplier+". ";
			if (hoursSinceCum>0 || cocks.length>0) result += "It were "+hoursSinceCum+" hours since "+pronoun1+" came.\n\n";
			for (i = 0; i<vaginas.length; i++){
				var vagina:VaginaClass = (vaginas[i] as VaginaClass);
				result += Pronoun3+ (i>0?(" #"+(i+1)):"")+" "+(Appearance.DEFAULT_VAGINA_TYPE_NAMES[vagina.type]||("vaginaType#"+vagina.type))+(vagina.virgin?" ":" non-")+"virgin vagina is ";
				result += Appearance.describeByScale(vagina.vaginalLooseness,Appearance.DEFAULT_VAGINA_LOOSENESS_SCALES,"tighter than","looser than");
				result += ", "+Appearance.describeByScale(vagina.vaginalWetness,Appearance.DEFAULT_VAGINA_WETNESS_SCALES,"drier than","wetter than");
				if (vagina.labiaPierced) result += ". Labia are pierced with "+vagina.labiaPLong;
				if (vagina.clitPierced) result += ". Clit is pierced with "+vagina.clitPLong;
				if (statusEffectv1(StatusEffects.BonusVCapacity) > 0){
					result+= "; vaginal capacity is increased by " + statusEffectv1(StatusEffects.BonusVCapacity);
				}
				result+=".\n";
			}
			if (breastRows.length>0){
				var nipple:String = nippleLength+"\" ";
				if (nipplesPierced) nipple+="pierced by "+nipplesPLong;
				for (i = 0; i < breastRows.length; i++) {
					var row:BreastRowClass = (breastRows[i] as BreastRowClass);
					result += Pronoun3+(i>0?(" #"+(i+1)):"") + " breast row has " + row.breasts;
					result += " " + row.breastRating.toFixed(2) + "-size (" + Appearance.breastCup(row.breastRating) + ") breasts with ";
					result += Appearance.numberOfThings(row.nipplesPerBreast, nipple+(row.fuckable ? "fuckable nipple" : "unfuckable nipple")) + " on each.\n";
				}
			}
			result += Pronoun3+" ass is "+Appearance.describeByScale(ass.analLooseness,Appearance.DEFAULT_ANAL_LOOSENESS_SCALES,"tighter than","looser than")+", "+Appearance.describeByScale(ass.analWetness,Appearance.DEFAULT_ANAL_WETNESS_SCALES,"drier than","wetter than");
			if (statusEffectv1(StatusEffects.BonusACapacity) > 0){
				result += "; anal capacity is increased by " + statusEffectv1(StatusEffects.BonusACapacity);
			}
			result +=".\n\n";

			// COMBAT AND OTHER STATS
			result += Hehas + "str=" + str + ", tou=" + tou + ", spe=" + spe +", inte=" + inte +", wis=" + wis +", lib=" + lib + ", sens=" + sens + ", cor=" + cor + ".\n";
			result += Pronoun1 + " can " + weaponVerb + " you with  " + weaponPerk + " " + weaponName+" (attack " + weaponAttack + ", value " + weaponValue+").\n";
			result += Pronoun1 + " is guarded with " + armorPerk + " " + armorName+" (defense " + armorDef + ", value " + armorValue+").\n";
			result += Hehas + HP + "/" + maxHP() + " HP, " + lust + "/" + maxLust() + " lust, " + fatigue + "/" + maxFatigue() + " fatigue, " + wrath + "/" + maxWrath() + " wrath, " + ki + "/" + maxKi() + " ki, " + mana + "/" + maxMana() + " mana. ";
			result += Pronoun3 + " bonus HP=" + bonusHP + ", bonus lust=" + bonusLust + ", bonus wrath=" + bonusWrath + ", bonus mana=" + bonusMana + ", bonus ki=" + bonusKi + ", and lust vulnerability=" + lustVuln + ".\n"
			result += Heis + "level " + level + " and " + have+" " + gems + " gems. You will be awarded " + XP + " XP.\n";
			
			var numSpec:int = (special1 != null ? 1 : 0) + (special2 != null ? 1 : 0) + (special3 != null ? 1 : 0);
			if (numSpec > 0) {
				result += Hehas + numSpec + " special attack" + (numSpec > 1 ? "s" : "") + ".\n";
			}
			else {
				result += Hehas + "no special attacks.\n";
			}

			return result;
		}

		protected function clearOutput():void
		{
			EngineCore.clearOutput();
		}

		public function dropLoot():ItemType
		{
			return _drop.roll() as ItemType;
		}

		//fixme monster statuses need to be simplified
		public function combatRoundUpdate():void
		{
			if(hasStatusEffect(StatusEffects.MilkyUrta)) {
				SceneLib.urtaQuest.milkyUrtaTic();
			}
			//Countdown
			var sac:StatusEffectClass = statusEffectByType(StatusEffects.TentacleCoolDown);
			if(sac) {
				sac.value1 -= 1;
				if (sac.value1 <= 0) {
					removeStatusEffect(StatusEffects.TentacleCoolDown);
				}
			}
			if(hasStatusEffect(StatusEffects.CoonWhip)) {
				if(statusEffectv2(StatusEffects.CoonWhip) <= 0) {
					armorDef += statusEffectv1(StatusEffects.CoonWhip);
					outputText("<b>Tail whip wears off!</b>\n\n");
					removeStatusEffect(StatusEffects.CoonWhip);
				}
				else {
					addStatusValue(StatusEffects.CoonWhip,2,-1);
					outputText("<b>Tail whip is currently reducing your foe");
					if(plural) outputText("s'");
					else outputText("'s");
					outputText(" armor by " + statusEffectv1(StatusEffects.CoonWhip) + ".</b>\n\n")
				}
			}
			if(hasStatusEffect(StatusEffects.TailSlamWhip)) {
				if(statusEffectv2(StatusEffects.TailSlamWhip) <= 0) {
					armorDef += statusEffectv1(StatusEffects.TailSlamWhip);
					outputText("<b>Tail slam wears off!</b>\n\n");
					removeStatusEffect(StatusEffects.TailSlamWhip);
				}
				else {
					addStatusValue(StatusEffects.TailSlamWhip,2,-1);
					outputText("<b>Tail slam is currently reducing your foe");
					if(plural) outputText("s'");
					else outputText("'s");
					outputText(" armor to 0.</b>\n\n")
				}
			}
			if(hasStatusEffect(StatusEffects.Blind)) {
				addStatusValue(StatusEffects.Blind,1,-1);
				if(statusEffectv1(StatusEffects.Blind) <= 0) {
					outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " no longer blind!</b>\n\n");
					removeStatusEffect(StatusEffects.Blind);
				}
				else outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " currently blind!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.InkBlind)) {
				addStatusValue(StatusEffects.InkBlind,1,-1);
				if(statusEffectv1(StatusEffects.InkBlind) <= 0) {
					outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " no longer blind!</b>\n\n");
					removeStatusEffect(StatusEffects.InkBlind);
				}
				else outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " currently blind!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.FreezingBreathStun)) {
				addStatusValue(StatusEffects.FreezingBreathStun,1,-1);
				if(statusEffectv1(StatusEffects.FreezingBreathStun) <= 0) {
					outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " no longer encased in the ice prison!</b>\n\n");
					removeStatusEffect(StatusEffects.FreezingBreathStun);
				}
				else outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " currently encased in the ice prison!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.Earthshield)) {
				outputText("<b>" + capitalA + short + " is protected by a shield of rocks!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.Flying)) {
				addStatusValue(StatusEffects.Flying,1,-1);
				if(statusEffectv1(StatusEffects.Flying) <= 0) {
					outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " no longer flying!</b>\n\n");
					removeStatusEffect(StatusEffects.Flying);
				}
			}
			if(hasStatusEffect(StatusEffects.PunishingKick)) {
				addStatusValue(StatusEffects.PunishingKick,1,-1);
				if(statusEffectv1(StatusEffects.PunishingKick) <= 0) {
					outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " no longer under Punishing Kick effect!</b>\n\n");
					removeStatusEffect(StatusEffects.PunishingKick);
				}
			}
			if(hasStatusEffect(StatusEffects.Sandstorm)) {
				//Blinded:
				if(player.hasStatusEffect(StatusEffects.Blind)) {
					outputText("<b>You blink the sand from your eyes, but you're sure that more will get you if you don't end it soon!</b>\n\n");
					player.removeStatusEffect(StatusEffects.Blind);
				}
				else {
					if(statusEffectv1(StatusEffects.Sandstorm) == 0 || statusEffectv1(StatusEffects.Sandstorm) % 4 == 0) {
						player.createStatusEffect(StatusEffects.Blind,0,0,0,0);
						outputText("<b>The sand is in your eyes!  You're blinded this turn!</b>\n\n");
					}
					else {
						outputText("<b>The grainy mess cuts at any exposed flesh and gets into every crack and crevice of your armor. ");
						var temp:Number = player.takePhysDamage(1 + rand(2), true);
						outputText("</b>\n\n");
					}
				}
				addStatusValue(StatusEffects.Sandstorm,1,1);
			}
			if(hasStatusEffect(StatusEffects.Stunned)) {
				outputText("<b>" + capitalA + short + " is still stunned!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.Shell)) {
				if(statusEffectv1(StatusEffects.Shell) >= 0) {
					outputText("<b>A wall of many hues shimmers around " + a + short + ".</b>\n\n");
					addStatusValue(StatusEffects.Shell,1,-1);
				}
				else {
					outputText("<b>The magical barrier " + a + short + " erected fades away to nothing at last.</b>\n\n");
					removeStatusEffect(StatusEffects.Shell);
				}
			}
			if(hasStatusEffect(StatusEffects.IzmaBleed)) {
				//Countdown to heal
				addStatusValue(StatusEffects.IzmaBleed,1,-1);
				//Heal wounds
				if (statusEffectv1(StatusEffects.IzmaBleed) <= 0) {
					outputText("The wounds you left on " + a + short + " stop bleeding so profusely.\n\n");
					removeStatusEffect(StatusEffects.IzmaBleed);
				}
				//Deal damage if still wounded.
				else {
					var store:Number = maxHP() * (4 + rand(7)) / 100;
					if (game.player.hasPerk(PerkLib.ThirstForBlood)) store *= 1.5;
					store = SceneLib.combat.doDamage(store);
					if (plural) outputText(capitalA + short + " bleed profusely from the jagged wounds your weapon left behind. <b>(<font color=\"#800000\">" + store + "</font>)</b>\n\n");
					else outputText(capitalA + short + " bleeds profusely from the jagged wounds your weapon left behind. <b>(<font color=\"#800000\">" + store + "</font>)</b>\n\n");
				}
			}
			if(hasStatusEffect(StatusEffects.SharkBiteBleed)) {
				//Countdown to heal
				addStatusValue(StatusEffects.SharkBiteBleed,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.SharkBiteBleed) <= 0) {
					outputText("The bite wounds you left on " + a + short + " stop bleeding so profusely.\n\n");
					removeStatusEffect(StatusEffects.SharkBiteBleed);
				}
				//Deal damage if still wounded.
				else {
					var store3:Number = (player.str + player.spe) * 2;
					store3 = SceneLib.combat.doDamage(store3);
					if(plural) outputText(capitalA + short + " bleed profusely from the jagged wounds your bite left behind. <b>(<font color=\"#800000\">" + store3 + "</font>)</b>\n\n");
					else outputText(capitalA + short + " bleeds profusely from the jagged wounds your bite left behind. <b>(<font color=\"#800000\">" + store3 + "</font>)</b>\n\n");
				}
			}
			if(hasStatusEffect(StatusEffects.GoreBleed)) {
				//Countdown to heal
				addStatusValue(StatusEffects.GoreBleed,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.GoreBleed) <= 0) {
					outputText("The ");
					if (player.horns.type == Horns.COW_MINOTAUR) outputText("horns wounds");
					else outputText("horns wound");
					outputText(" you left on " + a + short + " stop bleeding so profusely.\n\n");
					removeStatusEffect(StatusEffects.GoreBleed);
				}
				//Deal damage if still wounded.
				else {
					var store5:Number = (player.str + player.spe) * 2;
					store5 = SceneLib.combat.doDamage(store5);
					if (plural) {
						outputText(capitalA + short + " bleed profusely from the jagged ");
						if (player.horns.type == Horns.COW_MINOTAUR) outputText("wounds your horns");
						else outputText("wound your horns");
						outputText(" left behind. <b>(<font color=\"#800000\">" + store5 + "</font>)</b>\n\n");
					}
					else {
						outputText(capitalA + short + " bleeds profusely from the jagged ");
						if (player.horns.type == Horns.COW_MINOTAUR) outputText("wounds your horns");
						else outputText("wound your horns");
						outputText(" left behind. <b>(<font color=\"#800000\">" + store5 + "</font>)</b>\n\n");
					}
				}
			}
			if (hasStatusEffect(StatusEffects.Bloodlust)) {
				if (this is UnderwaterSharkGirl || this is UnderwaterTigersharkGirl) outputText("As blood flows through the water the shark girl grows increasingly vicious. ");
			}
			if(hasStatusEffect(StatusEffects.MonsterRegen)) {
				if(statusEffectv1(StatusEffects.MonsterRegen) <= 0)
					removeStatusEffect(StatusEffects.MonsterRegen);
				addStatusValue(StatusEffects.MonsterRegen,1,-1);
			}
			if(hasStatusEffect(StatusEffects.MonsterRegen2)) {
				if(statusEffectv1(StatusEffects.MonsterRegen2) <= 0)
					removeStatusEffect(StatusEffects.MonsterRegen2);
				addStatusValue(StatusEffects.MonsterRegen2,1,-1);
			}
			if(hasStatusEffect(StatusEffects.Timer)) {
				if(statusEffectv1(StatusEffects.Timer) <= 0)
					removeStatusEffect(StatusEffects.Timer);
				addStatusValue(StatusEffects.Timer,1,-1);
			}
			if(hasStatusEffect(StatusEffects.LustStick)) {
				//LoT Effect Messages:
				switch(statusEffectv1(StatusEffects.LustStick)) {
					//First:
					case 1:
						if(plural) outputText("One of " + a + short + " pants and crosses " + mf("his","her") + " eyes for a moment.  " + mf("His","Her") + " dick flexes and bulges, twitching as " + mf("he","she") + " loses himself in a lipstick-fueled fantasy.  When " + mf("he","she") + " recovers, you lick your lips and watch " + mf("his","her") + " blush spread.\n\n");
						else outputText(capitalA + short + " pants and crosses " + pronoun3 + " eyes for a moment.  " + mf("His","Her") + " dick flexes and bulges, twitching as " + pronoun1 + " loses " + mf("himself", "herself") + " in a lipstick-fueled fantasy.  When " + pronoun1 + " recovers, you lick your lips and watch " + mf("his","her") + " blush spread.\n\n");
						break;
					//Second:
					case 2:
						if(plural) outputText(capitalA + short + " moan out loud, " + pronoun3 + " dicks leaking and dribbling while " + pronoun1 + " struggle not to touch " + pronoun2 + ".\n\n");
						else outputText(capitalA + short + " moans out loud, " + pronoun3 + " dick leaking and dribbling while " + pronoun1 + " struggles not to touch it.\n\n");
						break;
					//Third:
					case 3:
						if(plural) outputText(capitalA + short + " pump " + pronoun3 + " hips futilely, air-humping non-existent partners.  Clearly your lipstick is getting to " + pronoun2 + ".\n\n");
						else outputText(capitalA + short + " pumps " + pronoun3 + " hips futilely, air-humping a non-existent partner.  Clearly your lipstick is getting to " + pronoun2 + ".\n\n");
						break;
					//Fourth:
					case 4:
						if(plural) outputText(capitalA + short + " close " + pronoun3 + " eyes and grunt, " + pronoun3 + " cocks twitching, bouncing, and leaking pre-cum.\n\n");
						else outputText(capitalA + short + " closes " + pronoun2 + " eyes and grunts, " + pronoun3 + " cock twitching, bouncing, and leaking pre-cum.\n\n");
						break;
					//Fifth and repeat:
					default:
						if(plural) outputText("Drops of pre-cum roll steadily out of their dicks.  It's a marvel " + pronoun1 + " haven't given in to " + pronoun3 + " lusts yet.\n\n");
						else outputText("Drops of pre-cum roll steadily out of " + a + short + "'s dick.  It's a marvel " + pronoun1 + " hasn't given in to " + pronoun3 + " lust yet.\n\n");
						break;
				}
				addStatusValue(StatusEffects.LustStick,1,1);
				//Damage = 5 + bonus score minus
				//Reduced by lust vuln of course
				lust += Math.round(lustVuln * (5 + statusEffectv2(StatusEffects.LustStick)));
			}
			if(hasStatusEffect(StatusEffects.PCTailTangle)) {
				//when Entwined
				outputText("You are bound tightly in the kitsune's tails.  <b>The only thing you can do is try to struggle free!</b>\n\n");
				outputText("Stimulated by the coils of fur, you find yourself growing more and more aroused...\n\n");
				player.dynStats("lus", 5+player.sens/10);
			}
			if(hasStatusEffect(StatusEffects.QueenBind)) {
				outputText("You're utterly restrained by the Harpy Queen's magical ropes!\n\n");
				if(flags[kFLAGS.PC_FETISH] >= 2) player.dynStats("lus", 3);
			}
			if(this is SecretarialSuccubus || this is MilkySuccubus) {
				if(player.lust < (player.maxLust() * 0.45)) outputText("There is something in the air around your opponent that makes you feel warm.\n\n");
				if(player.lust >= (player.maxLust() * 0.45) && player.lust < (player.maxLust() * 0.70)) outputText("You aren't sure why but you have difficulty keeping your eyes off your opponent's lewd form.\n\n");
				if(player.lust >= (player.maxLust() * 0.70) && player.lust < (player.maxLust() * 0.90)) outputText("You blush when you catch yourself staring at your foe's rack, watching it wobble with every step she takes.\n\n");
				if(player.lust >= (player.maxLust() * 0.90)) outputText("You have trouble keeping your greedy hands away from your groin.  It would be so easy to just lay down and masturbate to the sight of your curvy enemy.  The succubus looks at you with a sexy, knowing expression.\n\n");
				player.dynStats("lus", 1+rand(8));
			}
			//[LUST GAINED PER ROUND] - Omnibus
			if(hasStatusEffect(StatusEffects.LustAura)) {
				if (this is OmnibusOverseer || this is HeroslayerOmnibus) {
					if(player.lust < (player.maxLust() * 0.33)) outputText("Your groin tingles warmly.  The demon's aura is starting to get to you.\n\n");
					if(player.lust >= (player.maxLust() * 0.33) && player.lust < (player.maxLust() * 0.66)) outputText("You blush as the demon's aura seeps into you, arousing you more and more.\n\n");
					if(player.lust >= (player.maxLust() * 0.66)) {
						outputText("You flush bright red with desire as the lust in the air worms its way inside you.  ");
						temp = rand(4);
						if(temp == 0) outputText("You have a hard time not dropping to your knees to service her right now.\n\n");
						if(temp == 2) outputText("The urge to bury your face in her breasts and suckle her pink nipples nearly overwhelms you.\n\n");
						if(temp == 1) outputText("You swoon and lick your lips, tasting the scent of the demon's pussy in the air.\n\n");
						if(temp == 3) outputText("She winks at you and licks her lips, and you can't help but imagine her tongue sliding all over your body.  You regain composure moments before throwing yourself at her.  That was close.\n\n");
					}
				}
				if (this is Alraune) {
					if(player.lust < (player.maxLust() * 0.33)) outputText("The pollen in the air gradually increase your arousal.\n\n");
					if(player.lust >= (player.maxLust() * 0.33) && player.lust < (player.maxLust() * 0.66)) outputText("The pollen in the air is getting to you.\n\n");
					if(player.lust >= (player.maxLust() * 0.66)) outputText("You flush bright red with desire as the lust in the air worms its way inside you.\n\n");
				}
				player.dynStats("lus", (3 + int(player.lib/20 + player.cor/30)));
			}
			//immolation DoT
			if (hasStatusEffect(StatusEffects.ImmolationDoT)) {
				//Countdown to heal
				addStatusValue(StatusEffects.ImmolationDoT,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.ImmolationDoT) <= 0) {
					outputText("Flames left by immolation spell " + a + short + " finally stop burning.\n\n");
					removeStatusEffect(StatusEffects.ImmolationDoT);
				}
				//Deal damage if still wounded.
				else {
					var store2:Number = int(50+(player.inte/10));
					store2 = SceneLib.combat.doDamage(store2);
					if(plural) outputText(capitalA + short + " burn from lingering immolination after-effect. <b>(<font color=\"#800000\">" + store2 + "</font>)</b>\n\n");
					else outputText(capitalA + short + " burns from lingering immolination after-effect. <b>(<font color=\"#800000\">" + store2 + "</font>)</b>\n\n");
				}
			}
			//Burn DoT
			if (hasStatusEffect(StatusEffects.BurnDoT)) {
				//Countdown to heal
				addStatusValue(StatusEffects.BurnDoT,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.BurnDoT) <= 0) {
					outputText("Flames left by Burn " + a + short + " finally stop burning.\n\n");
					removeStatusEffect(StatusEffects.BurnDoT);
				}
				//Deal damage if still wounded.
				else {
					var store4:Number = (player.str + player.spe) * 2.5;
					store4 = SceneLib.combat.doDamage(store4);
					if(plural) outputText(capitalA + short + " burn from lingering Burn after-effect. <b>(<font color=\"#800000\">" + store4 + "</font>)</b>\n\n");
					else outputText(capitalA + short + " burns from lingering Burn after-effect. <b>(<font color=\"#800000\">" + store4 + "</font>)</b>\n\n");
				}
			}
			//Fire Punch Burn DoT
			if (hasStatusEffect(StatusEffects.FirePunchBurnDoT)) {
				//Countdown to heal
				addStatusValue(StatusEffects.FirePunchBurnDoT,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.FirePunchBurnDoT) <= 0) {
					outputText("Flames left by Fire Punch " + a + short + " finally stop burning.\n\n");
					removeStatusEffect(StatusEffects.FirePunchBurnDoT);
				}
				//Deal damage if still wounded.
				else {
					var store6:Number = (player.spe + player.inte) * player.kiPowerMod() * 0.5;
					store6 = SceneLib.combat.doDamage(store6);
					if(plural) outputText(capitalA + short + " burn from lingering Fire Punch after-effect. <b>(<font color=\"#800000\">" + store6 + "</font>)</b>\n\n");
					else outputText(capitalA + short + " burns from lingering Fire Punch after-effect. <b>(<font color=\"#800000\">" + store6 + "</font>)</b>\n\n");
				}
			}
			//regeneration perks for monsters
			if ((hasPerk(PerkLib.Regeneration) || hasPerk(PerkLib.LizanRegeneration) || hasPerk(PerkLib.LizanMarrow) || hasPerk(PerkLib.LizanMarrowEvolved) || hasPerk(PerkLib.EnemyPlantType) || hasPerk(PerkLib.EnemyGodType)
			     || hasPerk(PerkLib.MonsterRegeneration) || hasStatusEffect(StatusEffects.MonsterRegen) || hasStatusEffect(StatusEffects.MonsterRegen2)) && (this.HP < maxHP()) && (this.HP > 0)) {
				var healingPercent:Number = 0;
				var temp2:Number = 0;
				if (hasPerk(PerkLib.Regeneration)) healingPercent += (0.5 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.LizanRegeneration)) healingPercent += 1.5;
				if (hasPerk(PerkLib.LizanMarrow)) healingPercent += 0.5;
				if (hasPerk(PerkLib.LizanMarrowEvolved)) healingPercent += 0.5;
				if (hasPerk(PerkLib.EnemyPlantType)) healingPercent += 1;
				if (hasPerk(PerkLib.EnemyGodType)) healingPercent += 5;
				if (hasPerk(PerkLib.MonsterRegeneration)) healingPercent += perkv1(PerkLib.MonsterRegeneration);
				if (hasStatusEffect(StatusEffects.MonsterRegen)) healingPercent += statusEffectv2(StatusEffects.MonsterRegen);
				temp2 = Math.round(maxHP() * healingPercent / 100);
				if (hasStatusEffect(StatusEffects.MonsterRegen2)) temp2 += statusEffectv2(StatusEffects.MonsterRegen2);
				if (this is ChiChi && (flags[kFLAGS.CHI_CHI_SAM_TRAINING] < 2 || hasStatusEffect(StatusEffects.MonsterRegen))) {
					outputText("To your surprise, Chi Chi’s wounds start closing! <b>(<font color=\"#008000\">+" + temp2 + "</font>)</b>.\n\n");
				}
				else {
					outputText("Due to natural regeneration " + short + " recover");
					if (plural) outputText("s");
					else outputText("ed");
					outputText(" some HP! <b>(<font color=\"#008000\">+" + temp2 + "</font>)</b>.\n\n");
				}
				addHP(temp2);
			}
		}

		/**
		 * Handle the player waiting during combat
		 * @return null if the monster does not handle waits, true to skip combat action, false to perform Ai after wait
		 */
		public function handleWait():Object {
			return null;
		}

		/**
		 * Handle the player struggling during combat
		 * @return true if monster AI should be skipped
		 */
		public function handleStruggle():Boolean {
			return false;
		}

		protected function showLust():void {
			//Entrapped
			if(hasStatusEffect(StatusEffects.Constricted)) {
				outputText("[monster A][monster name] is currently wrapped up in your tail-coils!  ");
			}
			//Venom stuff!
			if(hasStatusEffect(StatusEffects.NagaVenom)) {
				if(statusEffectv1(StatusEffects.NagaVenom) <= 1) {
					outputText("You notice [monster he] [monster is] beginning to show signs of weakening, but there still appears to be plenty of fight left in [monster him].  ");
				}
				else {
					outputText("You notice [monster he] [monster is] obviously affected by your venom, [monster his] movements become unsure, and [monster his] balance begins to fade. Sweat begins to roll on [monster his] skin. You wager [monster he] [monster is] probably beginning to regret provoking you.  ");
				}
				spe -= statusEffectv1(StatusEffects.NagaVenom);
				str -= statusEffectv1(StatusEffects.NagaVenom);
				if (spe < 1) spe = 1;
				if (str < 1) str = 1;
				if (statusEffectv3(StatusEffects.NagaVenom) >= 1) lust += statusEffectv3(StatusEffects.NagaVenom);
				if (SceneLib.combat.combatIsOver()) {
					return;
				}
			}
			lustText();
		}

		protected function lustText():void {
			var percent:int = lust100;
			var s:String = plural ? "" : "s";
			if (percent > 50 && percent < 60) {outputText("[monster A][monster name]'" + s + " skin remains flushed with the beginnings of arousal.  ");}
			if (percent >= 60 && percent < 70) {outputText("[monster A][monster name]'" + s + " eyes constantly dart over your most sexual parts, betraying [monster his] lust.  ");}
			if (hasCock()) {
				if (percent >= 85) {outputText("[monster A][monster name] [monster is] panting and softly whining, each movement seeming to make [monster his] bulges more pronounced.  You don't think [monster he] can hold out much longer.  ");}
				else if (percent >= 70) {outputText("[monster A][monster name] [monster is] having trouble moving due to the rigid protrusion in [monster his] groin.  ");}
			}
			if (hasVagina()) {
				if (percent >= 85) {outputText("[monster A][monster name]'" + s + " [monster vagina]" + s + " [monster is] practically soaked with their lustful secretions.  ");}
				else if (percent >= 70) {outputText("[monster A][monster name] [monster is] obviously turned on, you can smell [monster his] arousal in the air.  ");}
			}
		}

		protected function get HPText():String {
			var math:Number = HPRatio();
			if(math >= 1) {return "You see [monster he] [monster is] in perfect health.  ";}
			else if(math > .75) {return "You see [monster he] [monster is]n't very hurt.  ";}
			else if(math > .5) {return "You see [monster he] [monster is] slightly wounded.  ";}
			else if(math > .25) {return "You see [monster he] [monster is] seriously hurt.  ";}
			else {return "You see [monster he] [monster is] unsteady and close to death.  ";}
		}

		public function showCBtext():void{
			outputText(long + "\n\n" + HPText);
			showLust();
		}

		public function endRoundChecks():Function {
			var combat:Combat = SceneLib.combat;
			if(HP < 1) {return curry(doNext, combat.endHpVictory);}
			if(lust >= maxLust()) {return curry(doNext, combat.endLustVictory);}
			return null;
		}

		public function getGeneralTypes(sens:int):Array {
			var generalTypes:Array = [];
			if (sens >= 25) {
				if (hasPerk(PerkLib.EnemyBeastOrAnimalMorphType)) {generalTypes.push("Beast or Animal-morph");}
				if (hasPerk(PerkLib.EnemyConstructType)) {generalTypes.push("Construct");}
				if (hasPerk(PerkLib.EnemyGigantType)) {generalTypes.push("Gigant");}
				if (hasPerk(PerkLib.EnemyGroupType)) {generalTypes.push("Group");}
				if (hasPerk(PerkLib.EnemyPlantType)) {generalTypes.push("Plant");}
			}
			if (sens >= 50) {
				if (hasPerk(PerkLib.EnemyBossType)) {generalTypes.push("Boss");}
				if (hasPerk(PerkLib.EnemyGodType)) {generalTypes.push("God");}
			}
			return generalTypes;
		}

		//Todo @oxdeception changes this to resist % after moving the perk effects to resists
		public function getElementalTypes(sens:int):Array {
			var elementalTypes:Array = [];
			if (sens >= 50) {
				if (hasPerk(PerkLib.DarknessNature)) {elementalTypes.push("Darkness Nature");}
				if (hasPerk(PerkLib.FireNature)) {elementalTypes.push("Fire Nature");}
				if (hasPerk(PerkLib.IceNature)) {elementalTypes.push("Ice Nature");}
				if (hasPerk(PerkLib.LightningNature)) {elementalTypes.push("Lightning Nature");}
			}
			if (sens >= 75) {
				if (hasPerk(PerkLib.DarknessVulnerability)) {elementalTypes.push("Darkness Vulnerability");}
				if (hasPerk(PerkLib.FireVulnerability)) {elementalTypes.push("Fire Vulnerability");}
				if (hasPerk(PerkLib.IceVulnerability)) {elementalTypes.push("Ice Vulnerability");}
				if (hasPerk(PerkLib.LightningVulnerability)) {elementalTypes.push("Lightning Vulnerability");}
			}
			return elementalTypes;
		}

		public function handleAwardItemText(itype:ItemType):void
		{ //New Function, override this function in child classes if you want a monster to output special item drop text
			if (itype != null) outputText("\nThere is " + itype.longName + " on your defeated opponent.  ");
		}

		public function handleAwardText():void
		{ //New Function, override this function in child classes if you want a monster to output special gem and XP text
			//This function doesn’t add the gems or XP to the player, it just provides the output text
			if (this.gems == 1) outputText("\n\nYou snag a single gem and " + this.XP + " XP as you walk away from your victory.");
			else if (this.gems > 1) outputText("\n\nYou grab " + this.gems + " gems and " + this.XP + " XP from your victory.");
			else if (this.gems == 0) outputText("\n\nYou gain " + this.XP + " XP from the battle.");
		}
		
		public function handleCombatLossText(inDungeon:Boolean, gemsLost:int):int
		{ //New Function, override this function in child classes if you want a monster to output special text after the player loses in combat
			//This function doesn’t take the gems away from the player, it just provides the output text
			if (SceneLib.prison.inPrison) {
				SceneLib.prison.doPrisonEscapeFightLoss();
				return 8;
			}
			if (!inDungeon) {
				if (SceneLib.prison.trainingFeed.prisonCaptorFeedingQuestTrainingExists()) {
					if (short == "goblin" || short == "goblin assassin" || short == "goblin warrior" || short == "goblin shaman" || short == "imp" || short == "imp lord" || short == "imp warlord" || short == "imp overlord" || //Generic encounter
						short == "tentacle beast" || (short == "kitsune" && hairColor == "red") || short == "Akbal" || short == "Tamani" || //Forest, deepwoods
						short == "goo-girl" || short == "green slime" || short == "fetish cultist" || short == "fetish zealot" || //Lake
						short == "sandtrap" || short == "sand tarp" || short == "naga" || short == "demons" || short == "Cum Witch" || //Desert
						short == "hellhound" || short == "infested hellhound" || short == "minotaur" || short == "minotaur lord" || short == "minotaur gang" || short == "minotaur tribe" || short == "basilisk" || short == "phoenix" || //Mountain, high mountains
						short == "satyr" || short == "gnoll" || short == "gnoll spear-thrower" || short == "female spider-morph" || short == "male spider-morph" || short == "corrupted drider" || //Plains, swamp, bog
						short == "yeti" || short == "behemoth") { //Glacial rift, volcanic crag
						SceneLib.prison.trainingFeed.prisonCaptorFeedingQuestTrainingProgress(1, 1);
					}
				}
				outputText("\n\nYou'll probably come to your senses in eight hours or so");
				if (player.gems > 1)
					outputText(", missing " + gemsLost + " gems.");
				else if (player.gems == 1)
					outputText(", missing your only gem.");
				else outputText(".");
			}
			else {
				outputText("\n\nSomehow you came out of that alive");
				if (player.gems > 1)
					outputText(", but after checking your gem pouch, you realize you're missing " + gemsLost + " gems.");
				else if (player.gems == 1)
					outputText(", but after checking your gem pouch, you realize you're missing your only gem.");
				else outputText(".");
			}
			return 8; //This allows different monsters to delay the player by different amounts of time after a combat loss. Normal loss causes an eight hour blackout
		}
		public function prepareForCombat():void {
			var mod:int = newGamePlusMod();
			var mMod:int = (1 + mod);
			if (hasPerk(PerkLib.JobCourtesan)) lib += (15 * mMod);
			if (hasPerk(PerkLib.JobDefender)) tou += (15 * mMod);
			if (hasPerk(PerkLib.JobElementalConjurer)) wis += (5 * mMod);
			if (hasPerk(PerkLib.JobEnchanter)) inte += (15 * mMod);
			if (hasPerk(PerkLib.JobEromancer)) {
				inte += (5 * mMod);
				lib += (5 * mMod);
			}
			if (hasPerk(PerkLib.JobGuardian)) tou += (5 * mMod);
			if (hasPerk(PerkLib.JobHunter)) {
				spe += (10 * mMod);
				inte += (5 * mMod);
			}
			if (hasPerk(PerkLib.JobKnight)) tou += (10 * mMod);
			if (hasPerk(PerkLib.AdvancedJobMonk)) wis += (15 * mMod);
			if (hasPerk(PerkLib.JobRanger)) spe += (5 * mMod);
			if (hasPerk(PerkLib.JobSeducer)) lib += (5 * mMod);
			if (hasPerk(PerkLib.JobSorcerer)) inte += (5 * mMod);
			if (hasPerk(PerkLib.JobWarrior)) str += (5 * mMod);
			if (hasPerk(PerkLib.PrestigeJobArcaneArcher)) {
				spe += (40 * mMod);
				inte += (40 * mMod);
			}
			if (hasPerk(PerkLib.PrestigeJobBerserker)) {
				str += (60 * mMod);
				tou += (20 * mMod);
			}
			if (hasPerk(PerkLib.PrestigeJobKiArtMaster)) {
				str += (40 * mMod);
				wis += (40 * mMod);
			}
			var bonusStatsAmp:Number = 0.2;
			if (level > 25) bonusStatsAmp += 0.1*((int)(level-1)/25);
			bonusStatsAmp *= mod;
			var bonusAscStr:int = Math.round(bonusStatsAmp * str);
			var bonusAscTou:int = Math.round(bonusStatsAmp * tou);
			var bonusAscSpe:int = Math.round(bonusStatsAmp * spe);
			var bonusAscInt:int = Math.round(bonusStatsAmp * inte);
			var bonusAscWis:int = Math.round(bonusStatsAmp * wis);
			var bonusAscLib:int = Math.round(bonusStatsAmp * lib);
			var bonusAscSen:int = Math.round(bonusStatsAmp * sens);
			this.str += bonusAscStr;
			this.tou += bonusAscTou;
			this.spe += bonusAscSpe;
			this.inte += bonusAscInt;
			this.wis += bonusAscWis;
			this.lib += bonusAscLib;
			this.sens += bonusAscSen;
			bonusAscMaxHP += bonusAscStr + bonusAscTou + bonusAscSpe + bonusAscInt + bonusAscWis + bonusAscLib + bonusAscSen;
			if (level > 10) {
				bonusAscMaxHP *= (int)(level / 10 + 1);
			}
			weaponAttack += (1 + (int)(weaponAttack / 5)) * mod;
			if (weaponRangeAttack > 0) {
				weaponRangeAttack += (1 + (int)(weaponRangeAttack / 5)) * mod;
			}
			armorDef += ((int)(1 + armorDef / 10)) * mod;

			lustVuln *= 1 - (Math.min(mod, 4)/10);

			HP = maxHP();
			mana = maxMana();
			ki = maxKi();
			XP = totalXP();
		}
	}
}
