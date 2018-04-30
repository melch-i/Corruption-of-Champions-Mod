package classes
{
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.ISexyPart;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Armor;
import classes.Items.ArmorLib;
import classes.Items.Jewelry;
import classes.Items.JewelryLib;
import classes.Items.Mutations;
import classes.Items.Shield;
import classes.Items.ShieldLib;
import classes.Items.Undergarment;
import classes.Items.UndergarmentLib;
import classes.Items.Weapon;
import classes.Items.WeaponLib;
import classes.Items.WeaponRange;
import classes.Items.WeaponRangeLib;
import classes.Scenes.Areas.Forest.KitsuneScene;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.Pregnancy;
import classes.Scenes.SceneLib;
import classes.StatusEffects.VampireThirstEffect;
import classes.internals.Utils;
import classes.lists.BreastCup;

use namespace CoC;

	/**
	 * ...
	 * @author Yoffy
	 */
	public class Player extends Character {
		
		public function Player() {
			//Item things
			itemSlot1 = new ItemSlotClass();
			itemSlot2 = new ItemSlotClass();
			itemSlot3 = new ItemSlotClass();
			itemSlot4 = new ItemSlotClass();
			itemSlot5 = new ItemSlotClass();
			itemSlot6 = new ItemSlotClass();
			itemSlot7 = new ItemSlotClass();
			itemSlot8 = new ItemSlotClass();
			itemSlot9 = new ItemSlotClass();
			itemSlot10 = new ItemSlotClass();
			itemSlots = [itemSlot1, itemSlot2, itemSlot3, itemSlot4, itemSlot5, itemSlot6, itemSlot7, itemSlot8, itemSlot9, itemSlot10];
		}
		
		protected final function outputText(text:String, clear:Boolean = false):void
		{
			if (clear) EngineCore.clearOutputTextOnly();
			EngineCore.outputText(text);
		}
		
		public var startingRace:String = "human";
		
		//Autosave
		public var slotName:String = "VOID";
		public var autoSave:Boolean = false;

		//Lust vulnerability
		//TODO: Kept for backwards compatibility reasons but should be phased out.
		public var lustVuln:Number = 1;

		//Teasing attributes
		public var teaseLevel:Number = 0;
		public var teaseXP:Number = 0;
		
		//Prison stats
		public var hunger:Number = 0; //Also used in survival and realistic mode
		public var obey:Number = 0;
		public var esteem:Number = 0;
		public var will:Number = 0;
		
		public var obeySoftCap:Boolean = true;
		
		//Perks used to store 'queued' perk buys
		public var perkPoints:Number = 0;
		public var statPoints:Number = 0;
		public var ascensionPerkPoints:Number = 0;

		public var tempStr:Number = 0;
		public var tempTou:Number = 0;
		public var tempSpe:Number = 0;
		public var tempInt:Number = 0;
		public var tempWis:Number = 0;
		public var tempLib:Number = 0;
		//Number of times explored for new areas
		public var explored:Number = 0;
		public var exploredForest:Number = 0;
		public var exploredDesert:Number = 0;
		public var exploredMountain:Number = 0;
		public var exploredLake:Number = 0;

		//Player pregnancy variables and functions
		private var pregnancy:Pregnancy = new Pregnancy();
		override public function pregnancyUpdate():Boolean {
			return pregnancy.updatePregnancy(); //Returns true if we need to make sure pregnancy texts aren't hidden
		}

		// Inventory
		public var itemSlot1:ItemSlotClass;
		public var itemSlot2:ItemSlotClass;
		public var itemSlot3:ItemSlotClass;
		public var itemSlot4:ItemSlotClass;
		public var itemSlot5:ItemSlotClass;
		public var itemSlot6:ItemSlotClass;
		public var itemSlot7:ItemSlotClass;
		public var itemSlot8:ItemSlotClass;
		public var itemSlot9:ItemSlotClass;
		public var itemSlot10:ItemSlotClass;
		public var itemSlots:Array;
		
		public var prisonItemSlots:Array = [];
		public var previouslyWornClothes:Array = []; //For tracking achievement.
		
		private var _weapon:Weapon = WeaponLib.FISTS;
		private var _weaponRange:WeaponRange = WeaponRangeLib.NOTHING;
		private var _armor:Armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
		private var _jewelry:Jewelry = JewelryLib.NOTHING;
		private var _shield:Shield = ShieldLib.NOTHING;
		private var _upperGarment:Undergarment = UndergarmentLib.NOTHING;
		private var _lowerGarment:Undergarment = UndergarmentLib.NOTHING;
		private var _modArmorName:String = "";

		//override public function set armors
		override public function set armorValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorValue.");
		}

		override public function set armorName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorName.");
		}

		override public function set armorDef(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorDef.");
		}

		override public function set armorPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorPerk.");
		}

		//override public function set weapons
		override public function set weaponName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponName.");
		}

		override public function set weaponVerb(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponVerb.");
		}

		override public function set weaponAttack(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponAttack.");
		}

		override public function set weaponPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponPerk.");
		}

		override public function set weaponValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponValue.");
		}

		//override public function set weapons
		override public function set weaponRangeName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeName.");
		}

		override public function set weaponRangeVerb(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeVerb.");
		}

		override public function set weaponRangeAttack(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeAttack.");
		}

		override public function set weaponRangePerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangePerk.");
		}

		override public function set weaponRangeValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeValue.");
		}

		//override public function set jewelries
		override public function set jewelryName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryName.");
		}
		
		override public function set jewelryEffectId(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryEffectId.");
		}
		
		override public function set jewelryEffectMagnitude(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryEffectMagnitude.");
		}
				
		override public function set jewelryPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryPerk.");
		}
		
		override public function set jewelryValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryValue.");
		}

		//override public function set shields
		override public function set shieldName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldName.");
		}
		
		override public function set shieldBlock(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldBlock.");
		}
		
		override public function set shieldPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldPerk.");
		}
		
		override public function set shieldValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldValue.");
		}
		
		//override public function set undergarments
		override public function set upperGarmentName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.upperGarmentName.");
		}
		
		override public function set upperGarmentPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.upperGarmentPerk.");
		}
		
		override public function set upperGarmentValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.upperGarmentValue.");
		}

		override public function set lowerGarmentName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.lowerGarmentName.");
		}
		
		override public function set lowerGarmentPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.lowerGarmentPerk.");
		}
		
		override public function set lowerGarmentValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.lowerGarmentValue.");
		}
		
		
		public function get modArmorName():String
		{
			if (_modArmorName == null) _modArmorName = "";
			return _modArmorName;
		}

		public function set modArmorName(value:String):void
		{
			if (value == null) value = "";
			_modArmorName = value;
		}
		public function isWearingArmor():Boolean {
			return armor != ArmorLib.COMFORTABLE_UNDERCLOTHES && armor != ArmorLib.NOTHING;
		}
		//Natural Armor (need at least to partialy covering whole body)
		public function haveNaturalArmor():Boolean
		{
			return hasPerk(PerkLib.ThickSkin) || skin.hasFur() || skin.hasChitin() || skin.hasScales() || skin.hasBark() || skin.hasDragonScales() || skin.hasBaseOnly(Skin.STONE);
		}
		//Unhindered related acceptable armor types
		public function meetUnhinderedReq():Boolean
		{
			return armorName == "arcane bangles" || armorName == "practically indecent steel armor" || armorName == "revealing chainmail bikini" || armorName == "slutty swimwear" || armorName == "barely-decent bondage straps" || armor == ArmorLib.NOTHING;
		}
		//override public function get armors
		override public function get armorName():String {
			if (_modArmorName.length > 0) return modArmorName;
			else if (_armor.name == "nothing" && lowerGarmentName != "nothing") return lowerGarmentName;
			else if (_armor.name == "nothing" && lowerGarmentName == "nothing") return "gear";
			return _armor.name;
		}
		override public function get armorDef():Number {
			var racialBonus:int = this.racialBonuses()[Race.BonusName_defense];
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var armorDef:Number = _armor.def;
			armorDef += upperGarment.armorDef;
			armorDef += lowerGarment.armorDef;
			//Blacksmith history!
			if (armorDef > 0 && (hasPerk(PerkLib.HistorySmith) || hasPerk(PerkLib.PastLifeSmith))) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			//Konstantine buff
			if (hasStatusEffect(StatusEffects.KonstantinArmorPolishing)) {
				armorDef = Math.round(armorDef * (1 + (statusEffectv2(StatusEffects.KonstantinArmorPolishing) / 100)));
				armorDef += 1;
			}
			//Skin armor perk
			if (hasPerk(PerkLib.ThickSkin)) {
				armorDef += (2 * newGamePlusMod);
			}
			//Stacks on top of Thick Skin perk.
			var p:Boolean = skin.isCoverLowMid();
			if (skin.hasFur()) armorDef += (p?1:2)*newGamePlusMod;
			if (skin.hasChitin()) armorDef += (p?2:4)*newGamePlusMod;
			if (skin.hasScales()) armorDef += (p?3:6)*newGamePlusMod; //bee-morph (), mantis-morph (), scorpion-morph (wpisane), spider-morph (wpisane)
			if (skin.hasBark() || skin.hasDragonScales()) armorDef += (p?4:8)*newGamePlusMod;
			if (skin.hasBaseOnly(Skin.STONE)) armorDef += (10 * newGamePlusMod);
			//'Thick' dermis descriptor adds 1!
			if (skinAdj == "smooth") armorDef += (1 * newGamePlusMod);
			//Racial score bonuses
			armorDef += racialBonus * newGamePlusMod;
			//Bonus defense
			if (arms.type == Arms.YETI) armorDef += (1 * newGamePlusMod);
			if (arms.type == Arms.SPIDER || arms.type == Arms.MANTIS || arms.type == Arms.BEE || arms.type == Arms.SALAMANDER) armorDef += (2 * newGamePlusMod);
			if (arms.type == Arms.GARGOYLE) armorDef += (8 * newGamePlusMod);
			if (arms.type == Arms.GARGOYLE_2) armorDef += (5 * newGamePlusMod);
			if (tailType == Tail.SPIDER_ADBOMEN || tailType == Tail.MANTIS_ABDOMEN || tailType == Tail.BEE_ABDOMEN) armorDef += (2 * newGamePlusMod);
			if (tailType == Tail.GARGOYLE) armorDef += (8 * newGamePlusMod);
			if (tailType == Tail.GARGOYLE_2) armorDef += (5 * newGamePlusMod);
			if (wings.type == Wings.GARGOYLE_LIKE_LARGE) armorDef += (8 * newGamePlusMod);
			if (lowerBody == LowerBody.YETI) armorDef += (1 * newGamePlusMod);
			if (lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS || lowerBody == LowerBody.BEE || lowerBody == LowerBody.MANTIS || lowerBody == LowerBody.SALAMANDER) armorDef += (2 * newGamePlusMod);
			if (lowerBody == LowerBody.DRAGON) armorDef += (3 * newGamePlusMod);
			if (lowerBody == LowerBody.DRIDER) armorDef += (4 * newGamePlusMod);
			if (lowerBody == LowerBody.GARGOYLE) armorDef += (8 * newGamePlusMod);
			if (lowerBody == LowerBody.GARGOYLE_2) armorDef += (5 * newGamePlusMod);
			if (hasPerk(PerkLib.Lycanthropy)) armorDef += 10 * newGamePlusMod;
			//Agility boosts armor ratings!
			var speedBonus:int = 0;
			if (hasPerk(PerkLib.Agility)) {
				if (armorPerk == "Light" || _armor.name == "nothing") {
					speedBonus += Math.round(spe / 10);
				}
				else if (armorPerk == "Medium") {
					speedBonus += Math.round(spe / 25);
				}
			}
			armorDef += speedBonus;
			//Feral armor boosts armor ratings!
			var toughnessBonus:int = 0;
			if (hasPerk(PerkLib.FeralArmor) && haveNaturalArmor() && meetUnhinderedReq()) {
				toughnessBonus += Math.round(tou / 20);
			}
			armorDef += toughnessBonus;
			if (hasPerk(PerkLib.PrestigeJobSentinel) && armorPerk == "Heavy") armorDef += _armor.def;
			//Acupuncture effect
			if (hasPerk(PerkLib.ChiReflowDefense)) armorDef *= UmasShop.NEEDLEWORK_DEFENSE_DEFENSE_MULTI;
			if (hasPerk(PerkLib.ChiReflowAttack)) armorDef *= UmasShop.NEEDLEWORK_ATTACK_DEFENSE_MULTI;
			//Other bonuses
			if (hasPerk(PerkLib.ToughHide) && haveNaturalArmor()) armorDef += (2 * newGamePlusMod);
			armorDef = Math.round(armorDef);
			//Berzerking removes armor
			if (hasStatusEffect(StatusEffects.Berzerking) && !hasPerk(PerkLib.ColdFury)) {
				armorDef = 0;
			}
			if (hasStatusEffect(StatusEffects.ChargeArmor) && (!isNaked())) armorDef += Math.round(statusEffectv1(StatusEffects.ChargeArmor));
			if (hasStatusEffect(StatusEffects.StoneSkin)) armorDef += Math.round(statusEffectv1(StatusEffects.StoneSkin));
			if (hasStatusEffect(StatusEffects.BarkSkin)) armorDef += Math.round(statusEffectv1(StatusEffects.BarkSkin));
			if (hasStatusEffect(StatusEffects.MetalSkin)) armorDef += Math.round(statusEffectv1(StatusEffects.MetalSkin));
			if (CoC.instance.monster.hasStatusEffect(StatusEffects.TailWhip)) {
				armorDef -= CoC.instance.monster.statusEffectv1(StatusEffects.TailWhip);
				if(armorDef < 0) armorDef = 0;
			}
			if (hasStatusEffect(StatusEffects.Lustzerking)) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			if (hasStatusEffect(StatusEffects.CrinosShape)) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			armorDef = Math.round(armorDef);
			return armorDef;
		}
		public function get armorBaseDef():Number {
			return _armor.def;
		}
		override public function get armorPerk():String {
			return _armor.perk;
		}
		override public function get armorValue():Number {
			return _armor.value;
		}
		//Natural Claws (arm types and weapons that can substitude them)
		public function haveNaturalClaws():Boolean
		{
			return arms.type == Arms.CAT || arms.type == Arms.DEVIL || arms.type == Arms.DRAGON || arms.type == Arms.FOX || arms.type == Arms.GARGOYLE || arms.type == Arms.LION || arms.type == Arms.LIZARD || arms.type == Arms.RAIJU
			       || arms.type == Arms.RED_PANDA || arms.type == Arms.SALAMANDER || arms.type == Arms.WOLF;
		}
		public function haveNaturalClawsTypeWeapon():Boolean
		{
			return weaponName == "gauntlet with claws";
		}
		//Weapons for Whirlwind
		public function isWeaponForWhirlwind():Boolean
		{
			return weapon == game.weapons.BFSWORD || weapon == game.weapons.NPHBLDE || weapon == game.weapons.EBNYBLD || weapon == game.weapons.CLAYMOR || weapon == game.weapons.URTAHLB || weapon == game.weapons.KIHAAXE || weapon == game.weapons.L__AXE || weapon == game.weapons.L_HAMMR || weapon == game.weapons.TRASAXE || weapon == game.weapons.WARHAMR
			 || weapon == game.weapons.OTETSU || weapon == game.weapons.NODACHI || weapon == game.weapons.WGSWORD || weapon == game.weapons.DBFSWO || weapon == game.weapons.D_WHAM_ || weapon == game.weapons.DL_AXE_ || weapon == game.weapons.DSWORD_ || weapon == game.weapons.HALBERD || weapon == game.weapons.GUANDAO;// || weapon == game.weapons.
		}
		//Weapons for Whipping
		public function isWeaponsForWhipping():Boolean
		{
			return weapon == game.weapons.FLAIL || weapon == game.weapons.L_WHIP || weapon == game.weapons.SUCWHIP || weapon == game.weapons.PSWHIP || weapon == game.weapons.WHIP || weapon == game.weapons.PWHIP || weapon == game.weapons.NTWHIP || weapon == game.weapons.CNTWHIP || weapon == game.weapons.RIBBON || weapon == game.weapons.ERIBBON
			|| weapon == game.weapons.SNAKESW;
		}
		//1H Weapons
		public function isOneHandedWeapons():Boolean
		{
			return weaponPerk != "Dual Large" && weaponPerk != "Dual" && weaponPerk != "Staff" && weaponPerk != "Large";
		}
		//Wrath Weapons
		public function isLowGradeWrathWeapon():Boolean
		{
			return weapon == game.weapons.BFSWORD || weapon == game.weapons.NPHBLDE || weapon == game.weapons.EBNYBLD || weapon == game.weapons.OTETSU || weapon == game.weapons.POCDEST || weapon == game.weapons.DOCDEST || weapon == game.weapons.CNTWHIP;
		}
		public function isDualLowGradeWrathWeapon():Boolean
		{
			return weapon == game.weapons.DBFSWO;
		}
		//Fists and fist weapons
		public function isFistOrFistWeapon():Boolean
		{
			return weaponName == "fists" || weapon == game.weapons.S_GAUNT || weapon == game.weapons.H_GAUNT || weapon == game.weapons.MASTGLO || weapon == game.weapons.KARMTOU || weapon == game.weapons.YAMARG || weapon == game.weapons.CLAWS;
		}
		//Natural Jouster perks req check
		public function isMeetingNaturalJousterReq():Boolean
		{
			return (((isTaur() || isDrider()) && spe >= 60) && hasPerk(PerkLib.Naturaljouster)) || (spe >= 150 && hasPerk(PerkLib.Naturaljouster));
		}
		public function isMeetingNaturalJousterMasterGradeReq():Boolean
		{
			return (((isTaur() || isDrider()) && spe >= 180) && hasPerk(PerkLib.NaturaljousterMastergrade)) || (spe >= 450 && hasPerk(PerkLib.NaturaljousterMastergrade));
		}
		public function haveWeaponForJouster():Boolean
		{
			return weaponName == "deadly spear" || weaponName == "deadly lance" || weaponName == "deadly trident" || weaponName == "seraph spear" || weaponName == "demon snake spear";
		}
		//override public function get weapons
		override public function get weaponName():String {
			return _weapon.name;
		}
		override public function get weaponVerb():String {
			return _weapon.verb;
		}
		override public function get weaponAttack():Number {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var attack:Number = _weapon.attack;
			if (hasPerk(PerkLib.HiddenMomentum) && weaponPerk == "Large" && str >= 75 && spe >= 50) {
				attack += (((str + spe) - 100) * 0.1);
			}//30-70-110
			if (hasPerk(PerkLib.LightningStrikes) && spe >= 60 && (weaponPerk != "Large" || weaponPerk != "Dual Large" || !isFistOrFistWeapon())) {
				attack += ((spe - 50) * 0.3);//wyjątek potem dodać dla daggers i innych assasins weapons i dać im lepszy przelicznik
			}//45-105-165
			if (hasPerk(PerkLib.SteelImpact)) {
				attack += ((tou - 50) * 0.3);
			}
			if (isFistOrFistWeapon()) {
				if (hasPerk(PerkLib.IronFists) && str >= 50) {
					attack += 10;
				}
				if (hasPerk(PerkLib.MightyFist)) {
					attack += (5 * newGamePlusMod);
				}
				if (SceneLib.combat.unarmedAttack() > 0) {
					attack += SceneLib.combat.unarmedAttack();
				}
			}
			if (arms.type == Arms.MANTIS && weaponName == "fists") {
				attack += (15 * newGamePlusMod);
			}
			if ((arms.type == Arms.YETI || arms.type == Arms.CAT) && weaponName == "fists") {
				attack += (5 * newGamePlusMod);
			}
			//Konstantine buff
			if (hasStatusEffect(StatusEffects.KonstantinWeaponSharpening) && weaponName != "fists") {
				attack *= 1 + (statusEffectv2(StatusEffects.KonstantinWeaponSharpening) / 100);
			}
			if (hasStatusEffect(StatusEffects.Berzerking)) attack += (15 + (15 * newGamePlusMod));
			if (hasStatusEffect(StatusEffects.Lustzerking)) attack += (15 + (15 * newGamePlusMod));
			if (hasStatusEffect(StatusEffects.ChargeWeapon)) {
				if (( weaponName != "fists") && weaponPerk != "Large" && weaponPerk != "Dual Large") attack += Math.round(statusEffectv1(StatusEffects.ChargeWeapon));
				if (weaponPerk == "Large" || weaponPerk == "Dual Large") attack += Math.round(statusEffectv1(StatusEffects.ChargeWeapon));
			}
			attack = Math.round(attack);
			return attack;
		}
		public function get weaponBaseAttack():Number {
			return _weapon.attack;
		}
		override public function get weaponPerk():String {
			return _weapon.perk || "";
		}
		override public function get weaponValue():Number {
			return _weapon.value;
		}
		//Artifacts Bows
		public function isArtifactBow():Boolean
		{
			return weaponRange == game.weaponsrange.BOWGUID || weaponRange == game.weaponsrange.BOWHODR;
		}
		//Using Tome
		public function isUsingTome():Boolean
		{
			return weaponRangeName == "nothing" || weaponRangeName == "Inquisitor’s Tome" || weaponRangeName == "Sage’s Sketchbook";
		}
		//override public function get weapons
		override public function get weaponRangeName():String {
			return _weaponRange.name;
		}
		override public function get weaponRangeVerb():String {
			return _weaponRange.verb;
		}
		override public function get weaponRangeAttack():Number {
			var rangeattack:Number = _weaponRange.attack;
			rangeattack = Math.round(rangeattack);
			return rangeattack;
		}
		public function get weaponRangeBaseAttack():Number {
			return _weaponRange.attack;
		}
		override public function get weaponRangePerk():String {
			return _weaponRange.perk || "";
		}
		override public function get weaponRangeValue():Number {
			return _weaponRange.value;
		}
		public function get ammo():int {
			return flags[kFLAGS.FLINTLOCK_PISTOL_AMMO];
		}
		public function set ammo(value:int):void {
			flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = value;
		}
		
		//override public function get jewelries.
		override public function get jewelryName():String {
			return _jewelry.name;
		}
		override public function get jewelryEffectId():Number {
			return _jewelry.effectId;
		}
		override public function get jewelryEffectMagnitude():Number {
			return _jewelry.effectMagnitude;
		}
		override public function get jewelryPerk():String {
			return _jewelry.perk;
		}
		override public function get jewelryValue():Number {
			return _jewelry.value;
		}
		
		//Shields for Bash
		public function isShieldsForShieldBash():Boolean
		{
			return shield == game.shields.BUCKLER || shield == game.shields.GREATSH || shield == game.shields.KITE_SH || shield == game.shields.TRASBUC || shield == game.shields.TOWERSH || shield == game.shields.DRGNSHL || shield == game.shields.SANCTYN || shield == game.shields.SANCTYL || shield == game.shields.SANCTYD;
		}
		//override public function get shields
		override public function get shieldName():String {
			return _shield.name;
		}
		override public function get shieldBlock():Number {
			var block:Number = _shield.block;
			if (hasPerk(PerkLib.JobKnight)) block += 3;
			//miejce na sposoby boostowania block value like perks or status effects
			block = Math.round(block);
			return block;
		}
		override public function get shieldPerk():String {
			return _shield.perk;
		}
		override public function get shieldValue():Number {
			return _shield.value;
		}
		public function get shield():Shield
		{
			return _shield;
		}

		//override public function get undergarment
		override public function get upperGarmentName():String {
			return _upperGarment.name;
		}
		override public function get upperGarmentPerk():String {
			return _upperGarment.perk;
		}
		override public function get upperGarmentValue():Number {
			return _upperGarment.value;
		}
		public function get upperGarment():Undergarment
		{
			return _upperGarment;
		}
		
		override public function get lowerGarmentName():String {
			return _lowerGarment.name;
		}
		override public function get lowerGarmentPerk():String {
			return _lowerGarment.perk;
		}
		override public function get lowerGarmentValue():Number {
			return _lowerGarment.value;
		}
		public function get lowerGarment():Undergarment
		{
			return _lowerGarment;
		}
		
		public function get armor():Armor
		{
			return _armor;
		}
		
		public function setArmor(newArmor:Armor):Armor {
			//Returns the old armor, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldArmor:Armor = _armor.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newArmor == null) {
				CoC_Settings.error(short + ".armor is set to null");
				newArmor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			}
			_armor = newArmor.playerEquip(); //The armor can also choose to equip something else - useful for Ceraph's trap armor
			return oldArmor;
		}
		
		/*
		public function set armor(value:Armor):void
		{
			if (value == null){
				CoC_Settings.error(short+".armor is set to null");
				value = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			}
			value.equip(this, false, false);
		}
		*/

		// in case you don't want to call the value.equip
		public function setArmorHiddenField(value:Armor):void
		{
			this._armor = value;
		}

		public function get weapon():Weapon
		{
			return _weapon;
		}
		
		public function get weaponRange():WeaponRange
		{
			return _weaponRange;
		}

		public function setWeapon(newWeapon:Weapon):Weapon {
			//Returns the old weapon, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldWeapon:Weapon = _weapon.playerRemove(); //The weapon is responsible for removing any bonuses, perks, etc.
			if (newWeapon == null) {
				CoC_Settings.error(short + ".weapon (melee) is set to null");
				newWeapon = WeaponLib.FISTS;
			}
			_weapon = newWeapon.playerEquip(); //The weapon can also choose to equip something else
			return oldWeapon;
		}
		
		/*
		public function set weapon(value:Weapon):void
		{
			if (value == null){
				CoC_Settings.error(short+".weapon is set to null");
				value = WeaponLib.FISTS;
			}
			value.equip(this, false, false);
		}
		*/

		// in case you don't want to call the value.equip
		public function setWeaponHiddenField(value:Weapon):void
		{
			this._weapon = value;
		}
		
		public function setWeaponRange(newWeaponRange:WeaponRange):WeaponRange {
			//Returns the old shield, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldWeaponRange:WeaponRange = _weaponRange.playerRemove();
			if (newWeaponRange == null) {
				CoC_Settings.error(short + ".weapon (range) is set to null");
				newWeaponRange = WeaponRangeLib.NOTHING;
			}
			_weaponRange = newWeaponRange.playerEquip();
			return oldWeaponRange;
		}
		
		// in case you don't want to call the value.equip
		public function setWeaponRangeHiddenField(value:WeaponRange):void
		{
			this._weaponRange = value;
		}
		
		//Jewelry, added by Kitteh6660
		public function get jewelry():Jewelry
		{
			return _jewelry;
		}

		public function setJewelry(newJewelry:Jewelry):Jewelry {
			//Returns the old jewelry, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldJewelry:Jewelry = _jewelry.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newJewelry == null) {
				CoC_Settings.error(short + ".jewelry is set to null");
				newJewelry = JewelryLib.NOTHING;
			}
			_jewelry = newJewelry.playerEquip(); //The jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldJewelry;
		}
		// in case you don't want to call the value.equip
		public function setJewelryHiddenField(value:Jewelry):void
		{
			this._jewelry = value;
		}
		
		public function setShield(newShield:Shield):Shield {
			//Returns the old shield, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldShield:Shield = _shield.playerRemove(); //The shield is responsible for removing any bonuses, perks, etc.
			if (newShield == null) {
				CoC_Settings.error(short + ".shield is set to null");
				newShield = ShieldLib.NOTHING;
			}
			_shield = newShield.playerEquip(); //The shield can also choose to equip something else.
			return oldShield;
		}
		
		// in case you don't want to call the value.equip
		public function setShieldHiddenField(value:Shield):void
		{
			this._shield = value;
		}

		public function setUndergarment(newUndergarment:Undergarment, typeOverride:int = -1):Undergarment {
			//Returns the old undergarment, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldUndergarment:Undergarment = UndergarmentLib.NOTHING;
			if (newUndergarment.type == UndergarmentLib.TYPE_UPPERWEAR || typeOverride == 0) { 
				oldUndergarment = _upperGarment.playerRemove(); //The undergarment is responsible for removing any bonuses, perks, etc.
				if (newUndergarment == null) {
					CoC_Settings.error(short + ".upperGarment is set to null");
					newUndergarment = UndergarmentLib.NOTHING;
				}
				_upperGarment = newUndergarment.playerEquip(); //The undergarment can also choose to equip something else.
			}
			else if (newUndergarment.type == UndergarmentLib.TYPE_LOWERWEAR || typeOverride == 1) { 
				oldUndergarment = _lowerGarment.playerRemove(); //The undergarment is responsible for removing any bonuses, perks, etc.
				if (newUndergarment == null) {
					CoC_Settings.error(short + ".lowerGarment is set to null");
					newUndergarment = UndergarmentLib.NOTHING;
				}
				_lowerGarment = newUndergarment.playerEquip(); //The undergarment can also choose to equip something else.
			}
			return oldUndergarment;
		}
		
		// in case you don't want to call the value.equip
		public function setUndergarmentHiddenField(value:Undergarment, type:int):void
		{
			if (type == UndergarmentLib.TYPE_UPPERWEAR) this._upperGarment = value;
			else this._lowerGarment = value;
		}
		
		public function reduceDamage(damage:Number):Number {
			var damageMultiplier:Number = 1;
			//EZ MOAD half damage
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) damageMultiplier /= 2;
			//Difficulty modifier flags.
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) damageMultiplier *= 1.15;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) damageMultiplier *= 1.3;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) damageMultiplier *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) damageMultiplier *= 2;
			
			//Opponents can critical too!
			var crit:Boolean = false;
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.Tactician) && CoC.instance.monster.inte >= 50) {
				if (CoC.instance.monster.inte <= 100) critChanceMonster += (CoC.instance.monster.inte - 50) / 5;
				if (CoC.instance.monster.inte > 100) critChanceMonster += 10;
			}
			if (CoC.instance.monster.hasPerk(PerkLib.VitalShot) && CoC.instance.monster.inte >= 50) critChanceMonster += 10;
			if (rand(100) < critChanceMonster) {
				crit = true;
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			//Apply damage resistance percentage.
			damage *= damagePercent() / 100;
			if (damageMultiplier < 0.2) damageMultiplier = 0;
			return int(damage * damageMultiplier);
		}
		public function reduceMagicDamage(damage:Number):Number {
			var magicdamageMultiplier:Number = 1;
			//EZ MOAD half damage
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) magicdamageMultiplier /= 2;
			//Difficulty modifier flags.
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) magicdamageMultiplier *= 1.15;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) magicdamageMultiplier *= 1.3;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) magicdamageMultiplier *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) magicdamageMultiplier *= 2;

			//Opponents can critical too!
			var crit:Boolean = false;
			var critChanceMonster:int = 5;
			/*if (CoC.instance.monster.hasPerk(PerkLib.Tactician) && CoC.instance.monster.inte >= 50) {
				if (CoC.instance.monster.inte <= 100) critChanceMonster += (CoC.instance.monster.inte - 50) / 5;
				if (CoC.instance.monster.inte > 100) critChanceMonster += 10;
			}
			if (CoC.instance.monster.hasPerk(PerkLib.VitalShot) && CoC.instance.monster.inte >= 50) critChanceMonster += 10;
			*/if (rand(100) < critChanceMonster) {
				crit = true;
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			//Apply magic damage resistance percentage.
			damage *= damageMagicalPercent() / 100;
			if (magicdamageMultiplier < 0.2) magicdamageMultiplier = 0;
			return int(damage * magicdamageMultiplier);
		}

		public override function lustPercent():Number {
			var lust:Number = 100;
			var minLustCap:Number = 25;
			
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//ADDITIVE REDUCTIONS
			//THESE ARE FLAT BONUSES WITH LITTLE TO NO DOWNSIDE
			//TOTAL IS LIMITED TO 75%!
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//Corrupted Libido reduces lust gain by 10%!
			if(hasPerk(PerkLib.CorruptedLibido)) lust -= 10;
			//Acclimation reduces by 15%
			if(hasPerk(PerkLib.Acclimation)) lust -= 15;
			//Purity blessing reduces lust gain
			if(hasPerk(PerkLib.PurityBlessing)) lust -= 5;
			//Resistance = 10%
			if(hasPerk(PerkLib.Resistance)) lust -= 5;
			if((hasPerk(PerkLib.UnicornBlessing) && cor <= 20) || (hasPerk(PerkLib.BicornBlessing) && cor >= 80)) lust -= 10;
			if(hasPerk(PerkLib.ChiReflowLust)) lust -= UmasShop.NEEDLEWORK_LUST_LUST_RESIST;
			if(lust < minLustCap) lust = minLustCap;
			if(statusEffectv1(StatusEffects.BlackCatBeer) > 0) {
				if(lust >= 80) lust = 100;
				else lust += 20;
			}
			lust += Math.round(perkv1(PerkLib.PentUp)/2);
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//MULTIPLICATIVE REDUCTIONS
			//THESE PERKS ALSO RAISE MINIMUM LUST OR HAVE OTHER
			//DRAWBACKS TO JUSTIFY IT.
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//Bimbo body slows lust gains!
			if((hasStatusEffect(StatusEffects.BimboChampagne) || hasPerk(PerkLib.BimboBody)) && lust > 0) lust *= .75;
			if(hasPerk(PerkLib.BroBody) && lust > 0) lust *= .75;
			if(hasPerk(PerkLib.FutaForm) && lust > 0) lust *= .75;
			//Omnibus' Gift reduces lust gain by 15%
			if(hasPerk(PerkLib.OmnibusGift)) lust *= .85;
			//Fera Blessing reduces lust gain by 15%
			if(hasStatusEffect(StatusEffects.BlessingOfDivineFera)) lust *= .85;
			//Luststick reduces lust gain by 10% to match increased min lust
			if(hasPerk(PerkLib.LuststickAdapted)) lust *= 0.9;
			if(hasStatusEffect(StatusEffects.Berzerking)) lust *= .6;
			if (hasPerk(PerkLib.PureAndLoving)) lust *= 0.95;
			//Berseking reduces lust gains by 10%
			if (hasStatusEffect(StatusEffects.Berzerking)) lust *= 0.9;
			if (hasStatusEffect(StatusEffects.Overlimit)) lust *= 0.9;

			//Items
			if (jewelryEffectId == JewelryLib.PURITY) lust *= 1 - (jewelryEffectMagnitude / 100);
			if (armor == game.armors.DBARMOR) lust *= 0.9;
			if (weapon == game.weapons.HNTCANE) lust *= 0.75;
			if ((weapon == game.weapons.PURITAS) || (weapon == game.weapons.ASCENSU)) lust *= 0.9;
			// Lust mods from Uma's content -- Given the short duration and the gem cost, I think them being multiplicative is justified.
			// Changing them to an additive bonus should be pretty simple (check the static values in UmasShop.as)
			var sac:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (sac)
			{
				if (sac.value1 == UmasShop.MASSAGE_RELIEF || sac.value1 == UmasShop.MASSAGE_LUST)
				{
					lust *= sac.value2;
				}
			}
			if(statusEffectv1(StatusEffects.Maleficium) > 0) {
				if(lust >= 50) lust = 100;
				else lust += 50;
			}
			lust = Math.round(lust);
			if (hasStatusEffect(StatusEffects.Lustzerking) && !hasPerk(PerkLib.ColdLust)) lust = 100;
			return lust;
		}

		public override function takePhysDamage(damage:Number, display:Boolean = false):Number{
			//Round
			damage = Math.round(damage);
			// we return "1 damage received" if it is in (0..1) but deduce no HP
			var returnDamage:int = (damage>0 && damage<1)?1:damage;
			if (damage>0){
				if (hasStatusEffect(StatusEffects.ManaShield) && damage < mana) {
					mana -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">Absorbed " + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('mana');
					dynStats("lus", 0); //Force display arrow.
				}
				else {
					damage = reduceDamage(damage);
					//Wrath
					var gainedWrath:Number = 0;
					gainedWrath += damage / 10;
					gainedWrath = Math.round(gainedWrath);
					wrath += gainedWrath;
					if (wrath > maxWrath()) wrath = maxWrath();
					//game.HPChange(-damage, display);
					HP -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('hp');
					dynStats("lus", 0); //Force display arrow.
				}
				if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
					dynStats("lus", int(damage / 2));
				}
				//Prevent negatives
				if (HP<=0){
					HP = 0;
					//This call did nothing. There is no event 5010: if (game.inCombat) game.doNext(5010);
				}
			}
			return returnDamage;
		}
		public override function takeMagicDamage(damage:Number, display:Boolean = false):Number{
			//Round
			damage = Math.round(damage);
			// we return "1 damage received" if it is in (0..1) but deduce no HP
			var returnDamage:int = (damage>0 && damage<1)?1:damage;
			if (damage>0){
				if (hasStatusEffect(StatusEffects.ManaShield) && (damage / 2) < mana) {
					mana -= damage / 2;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">Absorbed " + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('mana');
					dynStats("lus", 0); //Force display arrow.
				}
				else {
					damage = reduceMagicDamage(damage);
					//Wrath
					var gainedWrath:Number = 0;
					gainedWrath += damage / 10;
					gainedWrath = Math.round(gainedWrath);
					wrath += gainedWrath;
					if (wrath > maxWrath()) wrath = maxWrath();
					//game.HPChange(-damage, display);
					HP -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('hp');
					dynStats("lus", 0); //Force display arrow.
				}
				if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
					dynStats("lus", int(damage / 2));
				}
				//Prevent negatives
				if (HP<=0){
					HP = 0;
					//This call did nothing. There is no event 5010: if (game.inCombat) game.doNext(5010);
				}
			}
			return returnDamage;
		}

		/**
		 * @return 0: did not avoid; 1-3: avoid with varying difference between
		 * speeds (1: narrowly avoid, 3: deftly avoid)
		 */
		public function speedDodge(monster:Monster):int{
			var diff:Number = spe - monster.spe;
			var rnd:int = int(Math.random() * ((diff / 4) + 80));
			if (rnd<=80) return 0;
			else if (diff<8) return 1;
			else if (diff<20) return 2;
			else return 3;
		}

		//Body Type
		public function bodyType():String
		{
			var desc:String = "";
			//OLD STUFF
			//SUPAH THIN
			if (thickness < 10)
			{
				//SUPAH BUFF
				if (tone > 90)
					desc += "a lithe body covered in highly visible muscles";
				else if (tone > 75)
					desc += "an incredibly thin, well-muscled frame";
				else if (tone > 50)
					desc += "a very thin body that has a good bit of muscle definition";
				else if (tone > 25)
					desc += "a lithe body and only a little bit of muscle definition";
				else
					desc += "a waif-thin body, and soft, forgiving flesh";
			}
			//Pretty thin
			else if (thickness < 25)
			{
				if (tone > 90)
					desc += "a thin body and incredible muscle definition";
				else if (tone > 75)
					desc += "a narrow frame that shows off your muscles";
				else if (tone > 50)
					desc += "a somewhat lithe body and a fair amount of definition";
				else if (tone > 25)
					desc += "a narrow, soft body that still manages to show off a few muscles";
				else
					desc += "a thin, soft body";
			}
			//Somewhat thin
			else if (thickness < 40)
			{
				if (tone > 90)
					desc += "a fit, somewhat thin body and rippling muscles all over";
				else if (tone > 75)
					desc += "a thinner-than-average frame and great muscle definition";
				else if (tone > 50)
					desc += "a somewhat narrow body and a decent amount of visible muscle";
				else if (tone > 25)
					desc += "a moderately thin body, soft curves, and only a little bit of muscle";
				else
					desc += "a fairly thin form and soft, cuddle-able flesh";
			}
			//average
			else if (thickness < 60)
			{
				if (tone > 90)
					desc += "average thickness and a bevy of perfectly defined muscles";
				else if (tone > 75)
					desc += "an average-sized frame and great musculature";
				else if (tone > 50)
					desc += "a normal waistline and decently visible muscles";
				else if (tone > 25)
					desc += "an average body and soft, unremarkable flesh";
				else
					desc += "an average frame and soft, untoned flesh with a tendency for jiggle";
			}
			else if (thickness < 75)
			{
				if (tone > 90)
					desc += "a somewhat thick body that's covered in slabs of muscle";
				else if (tone > 75)
					desc += "a body that's a little bit wide and has some highly-visible muscles";
				else if (tone > 50)
					desc += "a solid build that displays a decent amount of muscle";
				else if (tone > 25)
					desc += "a slightly wide frame that displays your curves and has hints of muscle underneath";
				else
					desc += "a soft, plush body with plenty of jiggle";
			}
			else if (thickness < 90)
			{
				if (tone > 90)
					desc += "a thickset frame that gives you the appearance of a wall of muscle";
				else if (tone > 75)
					desc += "a burly form and plenty of muscle definition";
				else if (tone > 50)
					desc += "a solid, thick frame and a decent amount of muscles";
				else if (tone > 25)
					desc += "a wide-set body, some soft, forgiving flesh, and a hint of muscle underneath it";
				else
				{
					desc += "a wide, cushiony body";
					if (gender >= 2 || biggestTitSize() > 3 || hips.type > 7 || butt.type > 7)
						desc += " and plenty of jiggle on your curves";
				}
			}
			//Chunky monkey
			else
			{
				if (tone > 90)
					desc += "an extremely thickset frame and so much muscle others would find you harder to move than a huge boulder";
				else if (tone > 75)
					desc += "a very wide body and enough muscle to make you look like a tank";
				else if (tone > 50)
					desc += "an extremely substantial frame packing a decent amount of muscle";
				else if (tone > 25)
				{
					desc += "a very wide body";
					if (gender >= 2 || biggestTitSize() > 4 || hips.type > 10 || butt.type > 10)
						desc += ", lots of curvy jiggles,";
					desc += " and hints of muscle underneath";
				}
				else
				{
					desc += "a thick";
					if (gender >= 2 || biggestTitSize() > 4 || hips.type > 10 || butt.type > 10)
						desc += ", voluptuous";
					desc += " body and plush, ";
					if (gender >= 2 || biggestTitSize() > 4 || hips.type > 10 || butt.type > 10)
						desc += " jiggly curves";
					else
						desc += " soft flesh";
				}
			}
			return desc;
		}

		public function race():String
		{
			var racialScores:* = this.racialScores();
			//Determine race type:
			var race:String = "human";
			if (racialScores[Race.CAT.name] >= 4)
			{
				if (racialScores[Race.CAT.name] >= 8) {
					if (isTaur() && lowerBody == LowerBody.CAT) {
						race = "cat-taur";
					}
					else {
						race = "cat-morph";
						if (faceType == Face.HUMAN)
							race = "cat-" + mf("boy", "girl");
					}
				}
				else {
					if (isTaur() && lowerBody == LowerBody.CAT) {
						race = "half cat-taur";
						if (faceType == Face.HUMAN)
							race = "half sphinx-morph"; // no way to be fully feral anyway
					}
					else {
						race = " half cat-morph";
						if (faceType == Face.HUMAN)
							race = "half cat-" + mf("boy", "girl");
					}
				}
			}
			if (racialScores[Race.SPHINX.name] >= 13)
			{
				race = "Sphinx";
			}
			if (racialScores[Race.NEKOMATA.name] >= 11)
			{
				race = "Nekomanta";
			}
			if (racialScores[Race.CHESHIRE.name] >= 11)
			{
				race = "Cheshire cat";
			}
			if (racialScores[Race.LIZARD.name] >= 4)
			{
				if (racialScores[Race.LIZARD.name] >= 8) {
					if (isTaur()) race = "lizan-taur";
					else race = "lizan";
				}
				else {
					if (isTaur()) race = "half lizan-taur";
					else race = "half lizan";
				}
			}
			if (racialScores[Race.DRAGON.name] >= 4)
			{
				if (racialScores[Race.DRAGON.name] >= 28) {
					if (isTaur()) race = "ancient dragon-taur";
					else {
						race = "ancient dragon";
						if (faceType == Face.HUMAN)
							race = "ancient dragon-" + mf("man", "girl");
					}
				}
				else if (racialScores[Race.CAT.name] >= 20) {
					if (isTaur()) race = " elder dragon-taur";
					else {
						race = "elder dragon";
						if (faceType == Face.HUMAN)
							race = "elder dragon-" + mf("man", "girl");
					}
				}
				else if (racialScores[Race.DRAGON.name] >= 10) {
					if (isTaur()) race = "dragon-taur";
					else {
						race = "dragon";
						if (faceType == Face.HUMAN)
							race = "dragon-" + mf("man", "girl");
					}
				}
				else {
					if (isTaur()) race = "half-dragon-taur";
					else {
						race = "half-dragon";
						if (faceType == Face.HUMAN)
							race = "half-dragon-" + mf("man", "girl");
					}
				}
			}
			if (racialScores[Race.JABBERWOCKY.name] >= 4)
			{
				if (racialScores[Race.JABBERWOCKY.name] >= 20) {
					if (isTaur()) race = " greater jabberwocky-taur";
					else race = "greater jabberwocky";
				}
				else if (racialScores[Race.JABBERWOCKY.name] >= 10) {
					if (isTaur()) race = "jabberwocky-taur";
					else race = "jabberwocky";
				}
				else {
					if (isTaur()) race = "half-jabberwocky-taur";
					else race = "half-jabberwocky";
				}
			}
			if (racialScores[Race.RACCOON.name] >= 4)
			{
				race = "raccoon-morph";
				if (balls > 0 && ballSize > 5)
					race = "tanuki";
			}
			if (racialScores[Race.DOG.name] >= 4)
			{
				if (isTaur() && lowerBody == LowerBody.DOG)
					race = "dog-taur";
				else {
					race = "dog-morph";
					if (faceType == Face.HUMAN)
						race = "dog-" + mf("man", "girl");
				}
			}
			if (racialScores[Race.WOLF.name] >= 4)
			{
				if (isTaur() && lowerBody == LowerBody.WOLF)
					race = "wolf-taur";
				else if (racialScores[Race.WOLF.name] >= 10)
					race = "Fenrir";
				else if (racialScores[Race.WOLF.name] >= 7 && hasFur() && coatColor == "glacial white")
					race = "winter wolf";
				else if (racialScores[Race.WOLF.name] >= 6)
					race = "wolf-morph";
				else
					race = "wolf-" + mf("boy", "girl");
			}
			if (racialScores[Race.WEREWOLF.name] >= 6)
			{
				if (racialScores[Race.WEREWOLF.name] >= 12)
					race = "Werewolf";
				else
					race = "half werewolf";
			}
			if (racialScores[Race.FOX.name] >= 4)
			{
				if (racialScores[Race.FOX.name] >= 7 && isTaur() && lowerBody == LowerBody.FOX)
					race = "fox-taur";
				else if (racialScores[Race.FOX.name] >= 7)
					race = "fox-morph";
				else
					race = "half fox";
			}
			if (racialScores[Race.FERRET.name] >= 4)
			{
				if (hasFur())
					race = "ferret-morph";
				else
					race = "ferret-" + mf("morph", "girl");
			}
			if (racialScores[Race.KITSUNE.name] >= 5)
			{
				if (tailType == 13 && tailCount >= 2 && racialScores[Race.KITSUNE.name] >= 6) {
					if (racialScores[Race.KITSUNE.name] >= 12) {
						if (tailCount == 9 && isTaur()) {
							race = "nine tailed kitsune-taur";
						}
						else if (tailCount == 9) {
							race = "nine tailed kitsune";
						}
						else {
							race = "kitsune";
						}
					}
					else {
						if (isTaur()) {
							race = "kitsune-taur";
						}
						else {
							race = "kitsune";
						}
					}
				}
				else {
					race = "half kitsune";
				}
			}
			if (racialScores[Race.KITSHOO.name] >= 6)
			{
				if (isTaur()) race = "kitshoo-taur";
				else {
					race = "kitshoo";
				}
			}
			if (racialScores[Race.HORSE.name] >= 4)
			{
				if (racialScores[Race.HORSE.name] >= 7)
					race = "equine-morph";
				else
					race = "half equine-morph";
			}
			if (racialScores[Race.UNICORN.name] >= 9)
			{
				if (isTaur()) race = "unicorn-taur";
				else {
					race = "unicorn";
				}
			}
			if (racialScores[Race.ALICORN.name] >= 11)
			{
				if (isTaur()) race = "alicorn-taur";
				else {
					race = "alicorn";
				}
			}
			if (racialScores[Race.CENTAUR.name] >= 8)
				race = "centaur";
			if (racialScores[Race.MUTANT.name] >= 5 && race == "human")
				race = "corrupted mutant";
			if (racialScores[Race.MINOTAUR.name] >= 4)
				if (racialScores[Race.MINOTAUR.name] >= 9) race = "minotaur";
				else race = "half-minotaur";
			if (racialScores[Race.COW.name] >= 4)
			{
				if (racialScores[Race.COW.name] >= 9) {
					race = "cow-";
					race += mf("morph", "girl");
				}
				else {
					race = "half cow-";
					race += mf("morph", "girl");
				}
			}
			if (racialScores[Race.BEE.name] >= 5) {
				if (racialScores[Race.BEE.name] >= 9) {
					race = "bee-morph";
				}
				else {
					race = "half bee-morph";
				}
			}
			if (racialScores[Race.GOBLIN.name] >= 4)
				race = "goblin";
			if (racialScores[Race.HUMAN.name] >= 5 && race == "corrupted mutant")
				race = "somewhat human mutant";
			if (racialScores[Race.DEMON.name] >= 5) {
				var incub:String = mf("incub","succub");
				if (racialScores[Race.DEMON.name] >= 11) {
					if (isTaur()) {
						race = incub+"i-kintaur";
					} else {
						race = incub+"i-kin";
					}
				} else {
					if (isTaur()) {
						race = "half "+incub+"us-taur";
					} else {
						race = "half "+incub+"us";
					}
				}
			}
			if (racialScores[Race.DEVILKIN.name] >= 7)
			{
				if (racialScores[Race.DEVILKIN.name] >= 10) {
					if (racialScores[Race.DEVILKIN.name] >= 14)  {
						if (isTaur()) race = "greater devil-taur";
						else race = "greater devil";
					}
					else {
						if (isTaur()) race = "devil-taur";
						else race = "devil";
					}
				}
				else {
					if (isTaur()) race = "half devil-taur";
					else race = "half devil";
				}
			}
			if (racialScores[Race.SHARK.name] >= 4)
			{
				if (racialScores[Race.SHARK.name] >= 9 && vaginas.length > 0 && cocks.length > 0) {
					if (isTaur()) race = "tigershark-taur";
					else {
						race = "tigershark-morph";
					}
				}
				else if (racialScores[Race.SHARK.name] >= 8) {
					if (isTaur()) race = "shark-taur";
					else {
						race = "shark-morph";
					}
				}
				else {
					if (isTaur()) race = "half shark-taur";
					else {
						race = "half shark-morph";
					}
				}
			}
			if (racialScores[Race.ORCA.name] >= 6)
			{
				if (racialScores[Race.ORCA.name] >= 12) {
					if (isTaur()) race = "orca-taur";
					else {
						race = "orca-morph";
					}
				}
				else {
					if (isTaur()) race = "half orca-taur";
					else {
						race = "half orca-";
						race += mf("boy", "girl");
					}
				}
			}
			if (racialScores[Race.BUNNY.name] >= 4)
				race = "bunny-" + mf("boy", "girl");
			if (racialScores[Race.HARPY.name] >= 4)
			{
				if (racialScores[Race.HARPY.name] >= 8) {
					if (gender >= 2) {
						race = "harpy";
					}
					else {
						race = "avian";
					}
				}
				else {
					if (gender >= 2) {
						race = "half harpy";
					}
					else {
						race = "half avian";
					}
				}
			}
			if (racialScores[Race.SPIDER.name] >= 4)
			{
				if (racialScores[Race.SPIDER.name] >= 7) {
					race = "spider-morph";
					if (mf("no", "yes") == "yes")
						race = "spider-girl";
					if (isDrider())
						race = "drider";
				}
				else {
					race = "half spider-morph";
					if (mf("no", "yes") == "yes")
						race = "half spider-girl";
					if (isDrider())
						race = "half drider";
				}
			}
			if (racialScores[Race.KANGA.name] >= 4)
				race = "kangaroo-morph";
			if (racialScores[Race.MOUSE.name] >= 3)
			{
				if (isTaur()) race = "mouse-taur";
				else {
					if (faceType != 16)
					race = "mouse-" + mf("boy", "girl");
					else
						race = "mouse-morph";
				}
			}
			if (racialScores[Race.SCORPION.name] >= 4)
			{
				if (isTaur()) race = "scorpion-taur";
				else {
					race = "scorpion-morph";
				}
			}
			if (racialScores[Race.MANTIS.name] >= 6)
			{
				if (racialScores[Race.MANTIS.name] >= 12) {
					if (isTaur()) race = "mantis-taur";
					else {
						race = "mantis-morph";
					}
				}
				else {
					if (isTaur()) race = "half mantis-taur";
					else {
						race = "half mantis-morph";
					}
				}
			}
			if (racialScores[Race.SALAMANDER.name] >= 4)
			{
				if (racialScores[Race.SALAMANDER.name] >= 7) {
					if (isTaur()) race = "salamander-taur";
					else race = "salamander";
				}
				else {
					if (isTaur()) race = "half salamander-taur";
					else race = "half salamander";
				}
			}
			if (racialScores[Race.YETI.name] >= 6)
			{
				if (racialScores[Race.YETI.name] >= 12) {
					if (isTaur()) race = "yeti-taur";
					else race = "yeti";
				}
				else {
					if (isTaur()) race = "half yeti-taur";
					else race = "half yeti";
				}
			}
			if (racialScores[Race.COUATL.name] >= 11)
			{
				if (isTaur()) race = "couatl-taur";
				else {
					race = "couatl";
				}
			}
			if (racialScores[Race.VOUIVRE.name] >= 11)
			{
				if (isTaur()) race = "vouivre-taur";
				else {
					race = "vouivre";
				}
			}
			if (racialScores[Race.GORGON.name] >= 11)
			{
				if (isTaur()) race = "gorgon-taur";
				else {
					race = "gorgon";
				}
			}
			if (lowerBody == 3 && racialScores[Race.NAGA.name] >= 4)
			{
				if (racialScores[Race.NAGA.name] >= 8) race = "naga";
				else race = "half-naga";
			}

			if (racialScores[Race.PHOENIX.name] >= 10)
			{
				if (isTaur()) race = "phoenix-taur";
				else race = "phoenix";
			}
			if (racialScores[Race.SCYLLA.name] >= 4)
			{
				if (racialScores[Race.SCYLLA.name] >= 12) race = "kraken";
				else if (racialScores[Race.SCYLLA.name] >= 7) race = "scylla";
				else race = "half scylla";
			}
			if (racialScores[Race.PLANT.name] >= 4)
			{
				if (isTaur()) {
					if (racialScores[Race.PLANT.name] >= 6) race = mf("treant-taur", "dryad-taur");
					else race = "plant-taur";
				}
				else {
					if (racialScores[Race.PLANT.name] >= 6) race = mf("treant", "dryad");
					else race = "plant-morph";
				}
			}
			if (racialScores[Race.ALRAUNE.name] >= 10)
			{
				race = "Alraune";
			}
			if (racialScores[Race.YGGDRASIL.name] >= 10)
			{
				race = "Yggdrasil";
			}
			if (racialScores[Race.ONI.name] >= 6)
			{
				if (racialScores[Race.ONI.name] >= 12) {
					if (isTaur()) race = "oni-taur";
					else race = "oni";
				}
				else {
					if (isTaur()) race = "half oni-taur";
					else race = "half oni";
				}
			}
			if (racialScores[Race.ELF.name] >= 5)
			{
				if (racialScores[Race.ELF.name] >= 11) {
					if (isTaur()) race = "elf-taur";
					else race = "elf";
				}
				else {
					if (isTaur()) race = "half elf-taur";
					else race = "half elf";
				}
			}
			if (racialScores[Race.RAIJU.name] >= 5)
			{
				if (racialScores[Race.RAIJU.name] >= 10) {
					if (isTaur()) race = "raiju-taur";
					else race = "raiju";
				}
				else {
					if (isTaur()) race = "half raiju-taur";
					else race = "half raiju";
				}
			}
			//<mod>
			if (racialScores[Race.PIG.name] >= 4)
			{
				race = "pig-morph";
				if (faceType == Face.HUMAN)
					race = "pig-" + mf("boy", "girl");
				if (faceType == 20)
					race = "boar-morph";
			}
			if (racialScores[Race.SATYR.name] >= 4)
			{
				race = "satyr";
			}
			if (racialScores[Race.RHINO.name] >= 4)
			{
				race = "rhino-morph";
				if (faceType == Face.HUMAN) race = "rhino-" + mf("man", "girl");
			}
			if (racialScores[Race.ECHIDNA.name] >= 4)
			{
				race = "echidna";
				if (faceType == Face.HUMAN) race = "echidna-" + mf("boy", "girl");
			}
			if (racialScores[Race.DEER.name] >= 4)
			{
				if (isTaur()) race = "deer-taur";
				else {
					race = "deer-morph";
					if (faceType == Face.HUMAN) race = "deer-" + mf("morph", "girl");
				}
			}
			//Special, bizarre races
			if (racialScores[Race.DRAGONNE.name] >= 6)
			{
				if (isTaur()) race = "dragonne-taur";
				else {
					race  = "dragonne";
					if (faceType == Face.HUMAN)
						race = "dragonne-" + mf("man", "girl");
				}
			}
			if (racialScores[Race.MANTICORE.name] >= 6)
			{
				if (isTaur() && lowerBody == LowerBody.LION) {
					if (racialScores[Race.MANTICORE.name] < 12)
						race = "half manticore-taur";
					if (racialScores[Race.MANTICORE.name] >= 12)
						race = "manticore-taur";
				}
				else if (racialScores[Race.MANTICORE.name] >= 12)
					race = "manticore";
				else
					race = "half manticore";
			}
			if (racialScores[Race.REDPANDA.name] >= 4)
			{
				if (racialScores[Race.REDPANDA.name] >= 8) {
					race = "red-panda-morph";
					if (faceType == Face.HUMAN)
						race = "red-panda-" + mf("boy", "girl");
					if (isTaur())
						race = "red-panda-taur";
				}
				else {
					race = "half red-panda-morph";
					if (faceType == Face.HUMAN)
						race = "half red-panda-" + mf("boy", "girl");
					if (isTaur())
						race = "half red-panda-taur";
				}
			}
			if (racialScores[Race.SIREN.name] >= 10)
			{
				if (isTaur()) race = "siren-taur";
				else race = "siren";
			}
			if (racialScores[Race.GARGOYLE.name] >= 21)
			{
				if (hasPerk(PerkLib.GargoyleCorrupted)) race = "corrupted gargoyle";
				else race = "gargoyle";
			}
			if (racialScores[Race.BAT.name] >= 6){
				race = racialScores[Race.BAT.name] >= 10? "bat":"half bat";
				race += mf("boy","girl");
			}
			if (racialScores[Race.VAMPIRE.name] >= 6){
				race = racialScores[Race.VAMPIRE.name] >= 10 ? "vampire" : "dhampir"
			}
			if (racialScores[Race.AVIAN.name] >= 4)
			{
				if (racialScores[Race.AVIAN.name] >= 9)
					race = "avian-morph";
				else
					race = "half avian-morph";
			}
			//</mod>
			if (lowerBody == LowerBody.HOOFED && isTaur() && wings.type == Wings.FEATHERED_LARGE) {
				race = "pegataur";
			}
			if (lowerBody == LowerBody.PONY)
				race = "pony-kin";
			if (racialScores[Race.GOO.name] >= 4)
			{
				if (racialScores[Race.GOO.name] >= 8) {
					race = "goo-";
					race += mf("boi", "girl");
				}
				else {
					race = "half goo-";
					race += mf("boi", "girl");
				}
			}
			
			if (chimeraScore() >= 3)
			{
				race = "chimera";
			}
			
			if (grandchimeraScore() >= 3)
			{
				race = "grand chimera";
			}
			
			return race;
		}

		
		//Determine Chimera Race Rating
		public function chimeraScore():Number {
			Begin("Player","racialScore","chimera");
			var chimeraCounter:Number = 0;
			var racialScores:* = this.racialScores();
			if (racialScores[Race.CAT.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.LIZARD.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.DRAGON.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.RACCOON.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.DOG.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.WOLF.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.WEREWOLF.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.FOX.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.FERRET.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.KITSUNE.name] >= 5)
				chimeraCounter++;
			if (racialScores[Race.HORSE.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.MINOTAUR.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.COW.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.BEE.name] >= 5)
				chimeraCounter++;
			if (racialScores[Race.GOBLIN.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.DEMON.name] >= 5)
				chimeraCounter++;
			if (racialScores[Race.DEVILKIN.name] >= 7)
				chimeraCounter++;
			if (racialScores[Race.SHARK.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.ORCA.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.ONI.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.ELF.name] >= 5)
				chimeraCounter++;
			if (racialScores[Race.RAIJU.name] >= 5)
				chimeraCounter++;
			if (racialScores[Race.BUNNY.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.HARPY.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.SPIDER.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.KANGA.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.MOUSE.name] >= 3)
				chimeraCounter++;
			if (racialScores[Race.SCORPION.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.MANTIS.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.SALAMANDER.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.NAGA.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.PHOENIX.name] >= 10)
				chimeraCounter++;
			if (racialScores[Race.SCYLLA.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.PLANT.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.PIG.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.SATYR.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.RHINO.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.ECHIDNA.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.DEER.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.MANTICORE.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.REDPANDA.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.SIREN.name] >= 10)
				chimeraCounter++;
			if (racialScores[Race.YETI.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.BAT.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.VAMPIRE.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.JABBERWOCKY.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.AVIAN.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.GARGOYLE.name] >= 21)
				chimeraCounter++;
			if (racialScores[Race.GOO.name] >= 4)
				chimeraCounter++;
			
			End("Player","racialScore");
			return chimeraCounter;
		}
		
		//Determine Grand Chimera Race Rating
		public function grandchimeraScore():Number {
			Begin("Player","racialScore","grandchimera");
			var grandchimeraCounter:Number = 0;
			var racialScores:* = this.racialScores();
			if (racialScores[Race.CAT.name] >= 8)
				grandchimeraCounter++;
			if (racialScores[Race.NEKOMATA.name] >= 11)
				grandchimeraCounter++;
			if (racialScores[Race.CHESHIRE.name] >= 11)
				grandchimeraCounter++;
			if (racialScores[Race.LIZARD.name] >= 8)
				grandchimeraCounter++;
			if (racialScores[Race.DRAGON.name] >= 10)
				grandchimeraCounter++;
/*			if (racialScores[Race.RACCOON.name] >= 4)
				grandchimeraCounter++;
			if (racialScores[Race.DOG.name] >= 4)
				grandchimeraCounter++;
			if (racialScores[Race.WOLF.name] >= 6)
				grandchimeraCounter++;
*/			if (racialScores[Race.WEREWOLF.name] >= 12)
				grandchimeraCounter++;
			if (racialScores[Race.FOX.name] >= 7)
				grandchimeraCounter++;
//			if (racialScores[Race.FERRET.name] >= 4)
//				grandchimeraCounter++;
			if (racialScores[Race.KITSUNE.name] >= 6 && tailType == 13 && tailCount >= 2)
				grandchimeraCounter++;	
			if (racialScores[Race.HORSE.name] >= 7)
				grandchimeraCounter++;
			if (racialScores[Race.UNICORN.name] >= 9)
				grandchimeraCounter++;
			if (racialScores[Race.ALICORN.name] >= 11)
				grandchimeraCounter++;	
			if (racialScores[Race.CENTAUR.name] >= 8)
				grandchimeraCounter++;
			if (racialScores[Race.MINOTAUR.name] >= 9)
				grandchimeraCounter++;
			if (racialScores[Race.COW.name] >= 9)
				grandchimeraCounter++;
			if (racialScores[Race.BEE.name] >= 9)
				grandchimeraCounter++;
//			if (racialScores[Race.GOBLIN.name] >= 4)
//				grandchimeraCounter++;
			if (racialScores[Race.DEMON.name] >= 11)
				grandchimeraCounter++;
			if (racialScores[Race.DEVILKIN.name] >= 10)
				grandchimeraCounter++;
			if (racialScores[Race.SHARK.name] >= 8)
				grandchimeraCounter++;
			if (racialScores[Race.ORCA.name] >= 12)
				grandchimeraCounter++;
			if (racialScores[Race.ONI.name] >= 12)
				grandchimeraCounter++;
			if (racialScores[Race.ELF.name] >= 11)
				grandchimeraCounter++;
			if (racialScores[Race.RAIJU.name] >= 10)
				grandchimeraCounter++;
//			if (racialScores[Race.BUNNY.name] >= 4)
//				grandchimeraCounter++;
			if (racialScores[Race.HARPY.name] >= 8)
				grandchimeraCounter++;
			if (racialScores[Race.SPIDER.name] >= 7)
				grandchimeraCounter++;
/*			if (racialScores[Race.KANGA.name] >= 4)
				grandchimeraCounter++;
			if (racialScores[Race.MOUSE.name] >= 3)
				grandchimeraCounter++;
			if (racialScores[Race.SCORPION.name] >= 4)
				grandchimeraCounter++;
*/			if (racialScores[Race.MANTIS.name] >= 12)
				grandchimeraCounter++;
			if (racialScores[Race.SALAMANDER.name] >= 7)
				grandchimeraCounter++;
			if (racialScores[Race.NAGA.name] >= 8)
				grandchimeraCounter++;
			if (racialScores[Race.GORGON.name] >= 11)
				grandchimeraCounter++;
			if (racialScores[Race.VOUIVRE.name] >= 11)
				grandchimeraCounter++;
			if (racialScores[Race.COUATL.name] >= 11)
				grandchimeraCounter++;
			if (racialScores[Race.PHOENIX.name] >= 10)
				grandchimeraCounter++;
			if (racialScores[Race.SCYLLA.name] >= 7)
				grandchimeraCounter++;
//			if (racialScores[Race.PLANT.name] >= 6)
//				grandchimeraCounter++;
			if (racialScores[Race.ALRAUNE.name] >= 10)
				grandchimeraCounter++;
			if (racialScores[Race.YGGDRASIL.name] >= 10)
				grandchimeraCounter++;
/*			if (racialScores[Race.PIG.name] >= 4)
				grandchimeraCounter++;
			if (racialScores[Race.SATYR.name] >= 4)
				grandchimeraCounter++;
			if (racialScores[Race.RHINO.name] >= 4)
				grandchimeraCounter++;
			if (racialScores[Race.ECHIDNA.name] >= 4)
				grandchimeraCounter++;
			if (racialScores[Race.DEER.name] >= 4)
				grandchimeraCounter++;
*/			if (racialScores[Race.MANTICORE.name] >= 12)
				grandchimeraCounter += 2;
			if (racialScores[Race.REDPANDA.name] >= 8)
				grandchimeraCounter++;
			if (racialScores[Race.SIREN.name] >= 10)
				grandchimeraCounter++;
			if (racialScores[Race.YETI.name] >= 12)
				grandchimeraCounter++;
			if (racialScores[Race.BAT.name] >= 10)
				grandchimeraCounter++;
			if (racialScores[Race.VAMPIRE.name] >= 10)
				grandchimeraCounter++;
			if (racialScores[Race.JABBERWOCKY.name] >= 10)
				grandchimeraCounter++;	
			if (racialScores[Race.AVIAN.name] >= 9)
				grandchimeraCounter++;
			if (racialScores[Race.GARGOYLE.name] >= 21)
				grandchimeraCounter++;
			if (racialScores[Race.GOO.name] >= 8)
				grandchimeraCounter++;
			
			End("Player","racialScore");
			return grandchimeraCounter;
		}
		
		//Determine Inner Chimera Score
		public function internalChimeraScore():Number {
			Begin("Player","racialScore","internalChimeraScore");
			var internalChimeraCounter:Number = 0;
			if (hasPerk(PerkLib.BlackHeart))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.CatlikeNimbleness))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.CatlikeNimblenessEvolved))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.DraconicLungs))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.DraconicLungsEvolved))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.GorgonsEyes))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.KitsuneThyroidGland))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.KitsuneThyroidGlandEvolved))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.LizanMarrow))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.LizanMarrowEvolved))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.ManticoreMetabolism))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.MantislikeAgility))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.MantislikeAgilityEvolved))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.SalamanderAdrenalGlands))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.SalamanderAdrenalGlandsEvolved))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.ScyllaInkGlands))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.TrachealSystem))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.TrachealSystemEvolved))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.TrachealSystemFinalForm))
				internalChimeraCounter++;
		//	if (hasPerk(PerkLib.TrachealSystemEvolved))
		//		internalChimeraCounter++;
			
			End("Player","racialScore");
			return internalChimeraCounter;
		}
		
		//Determine Inner Chimera Rating
		public function internalChimeraRating():Number {
			Begin("Player","racialScore","internalChimeraRating");
			var internalChimeraRatingCounter:Number = 0;
			if (hasPerk(PerkLib.BlackHeart))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.CatlikeNimbleness))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.CatlikeNimblenessEvolved))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.DraconicLungs))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.DraconicLungsEvolved))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.GorgonsEyes))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.KitsuneThyroidGland))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.KitsuneThyroidGlandEvolved))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.LizanMarrow))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.LizanMarrowEvolved))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.ManticoreMetabolism))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.MantislikeAgility))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.MantislikeAgilityEvolved))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.SalamanderAdrenalGlands))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.SalamanderAdrenalGlandsEvolved))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.ScyllaInkGlands))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.TrachealSystem))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.TrachealSystemEvolved))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.TrachealSystemFinalForm))
				internalChimeraRatingCounter++;
		//	if (hasPerk(PerkLib.TrachealSystemEvolved))
		//		internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.ChimericalBodyInitialStage))
				internalChimeraRatingCounter -= 2;
			if (hasPerk(PerkLib.ChimericalBodyBasicStage))
				internalChimeraRatingCounter -= 3;
			if (hasPerk(PerkLib.ChimericalBodyAdvancedStage))
				internalChimeraRatingCounter -= 4;
			if (hasPerk(PerkLib.ChimericalBodySemiPerfectStage))
				internalChimeraRatingCounter -= 5;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				internalChimeraRatingCounter -= 6;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				internalChimeraRatingCounter -= 7;
			End("Player","racialScore");
			return internalChimeraRatingCounter;
		}

		public function alicornScore():int{ return racialScore(Race.ALICORN); }
		public function alrauneScore():int{ return racialScore(Race.ALRAUNE); }
		public function avianScore():int{ return racialScore(Race.AVIAN); }
		public function batScore():int{ return racialScore(Race.BAT); }
		public function beeScore():int{ return racialScore(Race.BEE); }
		public function bunnyScore():int { return racialScore(Race.BUNNY); }
		public function catScore():int { return racialScore(Race.CAT); }
		public function centaurScore():int { return racialScore(Race.CENTAUR); }
		public function cheshireScore():int { return racialScore(Race.CHESHIRE); }
		public function couatlScore():int { return racialScore(Race.COUATL); }
		public function cowScore():int { return racialScore(Race.COW); }
		public function deerScore():int { return racialScore(Race.DEER); }
		public function demonScore():int { return racialScore(Race.DEMON); }
		public function devilkinScore():int { return racialScore(Race.DEVILKIN); }
		public function dogScore():int { return racialScore(Race.DOG); }
		public function dragonScore():int { return racialScore(Race.DRAGON); }
		public function dragonneScore():int { return racialScore(Race.DRAGONNE); }
		public function echidnaScore():int { return racialScore(Race.ECHIDNA); }
		public function elfScore():int { return racialScore(Race.ELF); }
		public function ferretScore():int { return racialScore(Race.FERRET); }
		public function foxScore():int { return racialScore(Race.FOX); }
		public function gargoyleScore():int { return racialScore(Race.GARGOYLE); }
		public function goblinScore():int { return racialScore(Race.GOBLIN); }
		public function gooScore():int { return racialScore(Race.GOO); }
		public function gorgonScore():int { return racialScore(Race.GORGON); }
		public function harpyScore():int { return racialScore(Race.HARPY); }
		public function horseScore():int { return racialScore(Race.HORSE); }
		public function humanScore():int { return racialScore(Race.HUMAN); }
		public function jabberwockyScore():int { return racialScore(Race.JABBERWOCKY); }
		public function kangaScore():int { return racialScore(Race.KANGA); }
		public function kitshooScore():int { return racialScore(Race.KITSHOO); }
		public function kitsuneScore():int { return racialScore(Race.KITSUNE); }
		public function lizardScore():int { return racialScore(Race.LIZARD); }
		public function manticoreScore():int { return racialScore(Race.MANTICORE); }
		public function mantisScore():int { return racialScore(Race.MANTIS); }
		public function minotaurScore():int { return racialScore(Race.MINOTAUR); }
		public function mouseScore():int { return racialScore(Race.MOUSE); }
		public function mutantScore():int { return racialScore(Race.MUTANT); }
		public function nagaScore():int { return racialScore(Race.NAGA); }
		public function nekomataScore():int { return racialScore(Race.NEKOMATA); }
		public function oniScore():int { return racialScore(Race.ONI); }
		public function orcaScore():int { return racialScore(Race.ORCA); }
		public function phoenixScore():int { return racialScore(Race.PHOENIX); }
		public function pigScore():int { return racialScore(Race.PIG); }
		public function plantScore():int { return racialScore(Race.PLANT); }
		public function raccoonScore():int { return racialScore(Race.RACCOON); }
		public function raijuScore():int { return racialScore(Race.RAIJU); }
		public function redpandaScore():int { return racialScore(Race.REDPANDA); }
		public function rhinoScore():int { return racialScore(Race.RHINO); }
		public function salamanderScore():int { return racialScore(Race.SALAMANDER); }
		public function sandtrapScore():int { return racialScore(Race.SANDTRAP); }
		public function satyrScore():int { return racialScore(Race.SATYR); }
		public function scorpionScore():int { return racialScore(Race.SCORPION); }
		public function scyllaScore():int { return racialScore(Race.SCYLLA); }
		public function sharkScore():int { return racialScore(Race.SHARK); }
		public function sirenScore():int { return racialScore(Race.SIREN); }
		public function sphinxScore():int { return racialScore(Race.SPHINX); }
		public function spiderScore():int { return racialScore(Race.SPIDER); }
		public function unicornScore():int { return racialScore(Race.UNICORN); }
		public function vampireScore():int { return racialScore(Race.VAMPIRE); }
		public function vouivreScore():int { return racialScore(Race.VOUIVRE); }
		public function wolfScore():int { return racialScore(Race.WOLF); }
		public function werewolfScore():int { return racialScore(Race.WEREWOLF); }
		public function yetiScore():int { return racialScore(Race.YETI); }
		public function yggdrasilScore():int { return racialScore(Race.YGGDRASIL); }

		//TODO: (logosK) elderSlime, succubus pussy/demonic eyes, arachne, wasp, lactabovine/slut, sleipnir, hellhound, ryu, quetzalcoatl, eredar, anihilan,

		
		public function maxPrestigeJobs():Number
		{
			var prestigeJobs:Number = 1;
			if (hasPerk(PerkLib.PrestigeJobArcaneArcher))
				prestigeJobs--;
			if (hasPerk(PerkLib.PrestigeJobBerserker))
				prestigeJobs--;
			if (hasPerk(PerkLib.PrestigeJobSentinel))
				prestigeJobs--;
			if (hasPerk(PerkLib.PrestigeJobKiArtMaster))
				prestigeJobs--;
		//	if (hasPerk(PerkLib.TrachealSystemEvolved))
		//		prestigeJobs++;
		//	if (hasPerk(PerkLib.TrachealSystemEvolved))
		//		prestigeJobs++;
			return prestigeJobs;
		}

		public function lactationQ():Number
		{
			if (biggestLactation() < 1)
				return 0;
			//(Milk production TOTAL= breastSize x 10 * lactationMultiplier * breast total * milking-endurance (1- default, maxes at 2.  Builds over time as milking as done)
			//(Small – 0.01 mLs – Size 1 + 1 Multi)
			//(Large – 0.8 - Size 10 + 4 Multi)
			//(HUGE – 2.4 - Size 12 + 5 Multi + 4 tits)
			var total:Number;
			if (!hasStatusEffect(StatusEffects.LactationEndurance))
				createStatusEffect(StatusEffects.LactationEndurance, 1, 0, 0, 0);
			total = biggestTitSize() * 10 * averageLactation() * statusEffectv1(StatusEffects.LactationEndurance) * totalBreasts();
			if (hasPerk(PerkLib.MilkMaid))
				total += 200 + (perkv1(PerkLib.MilkMaid) * 100);
			if (hasPerk(PerkLib.ProductivityDrugs))
				total += (perkv4(PerkLib.ProductivityDrugs));
			if (statusEffectv1(StatusEffects.LactationReduction) >= 48)
				total = total * 1.5;
			if (total > int.MAX_VALUE)
				total = int.MAX_VALUE;
			return total;
		}
		
		public function isLactating():Boolean
		{
			return lactationQ() > 0;

		}

		public function cuntChange(cArea:Number, display:Boolean, spacingsF:Boolean = false, spacingsB:Boolean = true):Boolean {
			if (vaginas.length==0) return false;
			var wasVirgin:Boolean = vaginas[0].virgin;
			var stretched:Boolean = cuntChangeNoDisplay(cArea);
			var devirgined:Boolean = wasVirgin && !vaginas[0].virgin;
			if (devirgined){
				if(spacingsF) outputText("  ");
				outputText("<b>Your hymen is torn, robbing you of your virginity.</b>");
				if(spacingsB) outputText("  ");
			}
			//STRETCH SUCCESSFUL - begin flavor text if outputting it!
			if(display && stretched) {
				//Virgins get different formatting
				if(devirgined) {
					//If no spaces after virgin loss
					if(!spacingsB) outputText("  ");
				}
				//Non virgins as usual
				else if(spacingsF) outputText("  ");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_LEVEL_CLOWN_CAR) outputText("<b>Your " + Appearance.vaginaDescript(this,0)+ " is stretched painfully wide, large enough to accommodate most beasts and demons.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_GAPING_WIDE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched so wide that it gapes continually.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_GAPING) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " painfully stretches, the lips now wide enough to gape slightly.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_LOOSE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now very loose.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_NORMAL) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now a little loose.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_TIGHT) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched out to a more normal size.</b>");
				if(spacingsB) outputText("  ");
			}
			return stretched;
		}

		public function buttChange(cArea:Number, display:Boolean, spacingsF:Boolean = true, spacingsB:Boolean = true):Boolean
		{
			var stretched:Boolean = buttChangeNoDisplay(cArea);
			//STRETCH SUCCESSFUL - begin flavor text if outputting it!
			if(stretched && display) {
				if (spacingsF) outputText("  ");
				buttChangeDisplay();
				if (spacingsB) outputText("  ");
			}
			return stretched;
		}

		/**
		 * Refills player's hunger. 'amnt' is how much to refill, 'nl' determines if new line should be added before the notification.
		 * @param	amnt
		 * @param	nl
		 */
		public function refillHunger(amnt:Number = 0, nl:Boolean = true):void {
			if ((flags[kFLAGS.HUNGER_ENABLED] > 0 || flags[kFLAGS.IN_PRISON] > 0) && !isGargoyle())
			{
				
				var oldHunger:Number = hunger;
				var weightChange:int = 0;
				
				hunger += amnt;
				if (hunger > maxHunger())
				{
					while (hunger > (maxHunger() + 10) && !SceneLib.prison.inPrison) {
						weightChange++;
						hunger -= 10;
					}
					modThickness(100, weightChange);
					hunger = maxHunger();
				}
				if (hunger > oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) CoC.instance.mainView.statsView.showStatUp('hunger');
				//game.dynStats("lus", 0, "scale", false);
				if (nl) outputText("\n");
				//Messages
				if (hunger < maxHunger() * 0.1) outputText("<b>You still need to eat more. </b>");
				else if (hunger >= maxHunger() * 0.1 && hunger < maxHunger() * 0.25) outputText("<b>You are no longer starving but you still need to eat more. </b>");
				else if (hunger >= maxHunger() * 0.25 && hunger < maxHunger() * 0.5) outputText("<b>The growling sound in your stomach seems to quiet down. </b>");
				else if (hunger >= maxHunger() * 0.5 && hunger < maxHunger() * 0.75) outputText("<b>Your stomach no longer growls. </b>");
				else if (hunger >= maxHunger() * 0.75 && hunger < maxHunger() * 0.9) outputText("<b>You feel so satisfied. </b>");
				else if (hunger >= maxHunger() * 0.9) outputText("<b>Your stomach feels so full. </b>");
				if (weightChange > 0) outputText("<b>You feel like you've put on some weight. </b>");
				EngineCore.awardAchievement("Tastes Like Chicken ", kACHIEVEMENTS.REALISTIC_TASTES_LIKE_CHICKEN);
				if (oldHunger < 1 && hunger >= 100) EngineCore.awardAchievement("Champion Needs Food Badly ", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD);
				if (oldHunger >= 90) EngineCore.awardAchievement("Glutton ", kACHIEVEMENTS.REALISTIC_GLUTTON);
				if (hunger > oldHunger) CoC.instance.mainView.statsView.showStatUp("hunger");
				dynStats("lus", 0, "scale", false);
				EngineCore.statScreenRefresh();
			}
		}
		public function refillGargoyleHunger(amnt:Number = 0, nl:Boolean = true):void {
			var oldHunger:Number = hunger;
			hunger += amnt;
			if (hunger > maxHunger()) hunger = maxHunger();
			if (hunger > oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) CoC.instance.mainView.statsView.showStatUp('hunger');
			//game.dynStats("lus", 0, "scale", false);
			if (nl) outputText("\n");
			if (hunger > oldHunger) CoC.instance.mainView.statsView.showStatUp("hunger");
			dynStats("lus", 0, "scale", false);
			EngineCore.statScreenRefresh();
		}
		
		/**
		 * Damages player's hunger. 'amnt' is how much to deduct.
		 * @param	amnt
		 */
		public function damageHunger(amnt:Number = 0):void {
			var oldHunger:Number = hunger;
			hunger -= amnt;
			if (hunger < 0) hunger = 0;
			if (hunger < oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) CoC.instance.mainView.statsView.showStatDown('hunger');
			dynStats("lus", 0, "scale", false);
		}
		
		public function corruptionTolerance():int {
			var temp:int = perkv1(PerkLib.AscensionTolerance) * 5;
			if (flags[kFLAGS.MEANINGLESS_CORRUPTION] > 0) temp += 100;
			return temp;
		}
		
		public function newGamePlusMod():int {
			var temp:int = flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			//Constrains value between 0 and 5.
			if (temp < 0) temp = 0;
			if (temp > 5) temp = 5;
			return temp;
		}
		
		public function buttChangeDisplay():void
		{	//Allows the test for stretching and the text output to be separated
			if (ass.analLooseness == 5) outputText("<b>Your " + Appearance.assholeDescript(this) + " is stretched even wider, capable of taking even the largest of demons and beasts.</b>");
			if (ass.analLooseness == 4) outputText("<b>Your " + Appearance.assholeDescript(this) + " becomes so stretched that it gapes continually.</b>");
			if (ass.analLooseness == 3) outputText("<b>Your " + Appearance.assholeDescript(this) + " is now very loose.</b>");
			if (ass.analLooseness == 2) outputText("<b>Your " + Appearance.assholeDescript(this) + " is now a little loose.</b>");
			if (ass.analLooseness == 1) outputText("<b>You have lost your anal virginity.</b>");
		}

		public function slimeFeed():void{
			if (hasStatusEffect(StatusEffects.SlimeCraving)) {
				//Reset craving value
				changeStatusValue(StatusEffects.SlimeCraving,1,0);
				//Flag to display feed update and restore stats in event parser
				if(!hasStatusEffect(StatusEffects.SlimeCravingFeed)) {
					createStatusEffect(StatusEffects.SlimeCravingFeed,0,0,0,0);
				}
			}
			if (hasPerk(PerkLib.Diapause)) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00228] += 3 + rand(3);
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00229] = 1;
			}
			if (isGargoyle() && hasPerk(PerkLib.GargoyleCorrupted)) refillGargoyleHunger(30);
		}

		public function minoCumAddiction(raw:Number = 10):void {
			//Increment minotaur cum intake count
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00340]++;
			//Fix if variables go out of range.
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 0;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 120) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 120;

			//Turn off withdrawal
			//if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 1;
			//Reset counter
			flags[kFLAGS.TIME_SINCE_LAST_CONSUMED_MINOTAUR_CUM] = 0;
			//If highly addicted, rises slower
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 60) raw /= 2;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 80) raw /= 2;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 90) raw /= 2;
			if(hasPerk(PerkLib.MinotaurCumResistance) || hasPerk(PerkLib.ManticoreCumAddict)) raw *= 0;
			//If in withdrawl, readdiction is potent!
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3) raw += 10;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2) raw += 5;
			raw = Math.round(raw * 100)/100;
			//PUT SOME CAPS ON DAT' SHIT
			if(raw > 50) raw = 50;
			if(raw < -50) raw = -50;
			if(!hasPerk(PerkLib.ManticoreCumAddict)) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] += raw;
			//Recheck to make sure shit didn't break
			if(hasPerk(PerkLib.MinotaurCumResistance)) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0; //Never get addicted!
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 120) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 120;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;

		}

		public function hasSpells():Boolean
		{
			return spellCount()>0;
		}

		public function spellCount():Number
		{
			return [StatusEffects.KnowsArouse,StatusEffects.KnowsHeal,StatusEffects.KnowsMight,StatusEffects.KnowsCharge,StatusEffects.KnowsBlind,StatusEffects.KnowsWhitefire,StatusEffects.KnowsChargeA,StatusEffects.KnowsBlink,StatusEffects.KnowsBlizzard,StatusEffects.KnowsIceSpike,StatusEffects.KnowsLightningBolt,StatusEffects.KnowsDarknessShard,StatusEffects.KnowsFireStorm,StatusEffects.KnowsIceRain]
					.filter(function(item:StatusEffectType, index:int, array:Array):Boolean{
						return this.hasStatusEffect(item);},this)
					.length;
		}

		public function armorDescript(nakedText:String = "gear"):String
		{
			var textArray:Array = [];
			var text:String = "";
			//if (armor != ArmorLib.NOTHING) text += armorName;
			//Join text.
			if (armor != ArmorLib.NOTHING) textArray.push(armor.name);
			if (upperGarment != UndergarmentLib.NOTHING) textArray.push(upperGarmentName);
			if (lowerGarment != UndergarmentLib.NOTHING) textArray.push(lowerGarmentName);
			if (textArray.length > 0) text = formatStringArray(textArray);
			//Naked?
			if (upperGarment == UndergarmentLib.NOTHING && lowerGarment == UndergarmentLib.NOTHING && armor == ArmorLib.NOTHING) text = nakedText;
			return text;
		}
		
		public function clothedOrNaked(clothedText:String, nakedText:String = ""):String
		{
			return (armorDescript() != "gear" ? clothedText : nakedText);
		}
		
		public function clothedOrNakedLower(clothedText:String, nakedText:String = ""):String
		{
			return (armorName != "gear" && (armorName != "lethicite armor" && lowerGarmentName == "nothing") && !isTaur() ? clothedText : nakedText);
		}
		
		public function addToWornClothesArray(armor:Armor):void {
			for (var i:int = 0; i < previouslyWornClothes.length; i++) {
				if (previouslyWornClothes[i] == armor.shortName) return; //Already have?
			}
			previouslyWornClothes.push(armor.shortName);
		}
		
		public function shrinkTits(ignore_hyper_happy:Boolean=false):void
		{
			if (flags[kFLAGS.HYPER_HAPPY] && !ignore_hyper_happy)
			{
				return;
			}
			if(breastRows.length == 1) {
				if(breastRows[0].breastRating > 0) {
					//Shrink if bigger than N/A cups
					var temp:Number;
					temp = 1;
					breastRows[0].breastRating--;
					//Shrink again 50% chance
					if(breastRows[0].breastRating >= 1 && rand(2) == 0 && !hasPerk(PerkLib.BigTits)) {
						temp++;
						breastRows[0].breastRating--;
					}
					if(breastRows[0].breastRating < 0) breastRows[0].breastRating = 0;
					//Talk about shrinkage
					if(temp == 1) outputText("\n\nYou feel a weight lifted from you, and realize your breasts have shrunk!  With a quick measure, you determine they're now " + breastCup(0) + "s.");
					if(temp == 2) outputText("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are much smaller!  With a quick measure, you determine they're now " + breastCup(0) + "s.");
				}
			}
			else if(breastRows.length > 1) {
				//multiple
				outputText("\n");
				//temp2 = amount changed
				//temp3 = counter
				var temp2:Number = 0;
				var temp3:Number = breastRows.length;
				while(temp3 > 0) {
					temp3--;
					if(breastRows[temp3].breastRating > 0) {
						breastRows[temp3].breastRating--;
						if(breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
						temp2++;
						outputText("\n");
						if(temp3 < breastRows.length - 1) outputText("...and y");
						else outputText("Y");
						outputText("our " + breastDescript(temp3) + " shrink, dropping to " + breastCup(temp3) + "s.");
					}
					if(breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
				}
				if(temp2 == 2) outputText("\nYou feel so much lighter after the change.");
				if(temp2 == 3) outputText("\nWithout the extra weight you feel particularly limber.");
				if(temp2 >= 4) outputText("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.");
			}
		}

		public function growTits(amount:Number, rowsGrown:Number, display:Boolean, growthType:Number):void
		{
			if(breastRows.length == 0) return;
			//GrowthType 1 = smallest grows
			//GrowthType 2 = Top Row working downward
			//GrowthType 3 = Only top row
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Chance for "big tits" perked characters to grow larger!
			if(hasPerk(PerkLib.BigTits) && rand(3) == 0 && amount < 1) amount=1;

			// Needs to be a number, since uint will round down to 0 prevent growth beyond a certain point
			var temp:Number = breastRows.length;
			if(growthType == 1) {
				//Select smallest breast, grow it, move on
				while(rowsGrown > 0) {
					//Temp = counter
					temp = breastRows.length;
					//Temp2 = smallest tits index
					temp2 = 0;
					//Find smallest row
					while(temp > 0) {
						temp--;
						if(breastRows[temp].breastRating < breastRows[temp2].breastRating) temp2 = temp;
					}
					//Temp 3 tracks total amount grown
					temp3 += amount;
					trace("Breastrow chosen for growth: " + String(temp2) + ".");
					//Reuse temp to store growth amount for diminishing returns.
					temp = amount;
					if (!flags[kFLAGS.HYPER_HAPPY])
					{
						//Diminishing returns!
						if(breastRows[temp2].breastRating > 3)
						{
							if(!hasPerk(PerkLib.BigTits))
								temp /=1.5;
							else
								temp /=1.3;
						}

						// WHy are there three options here. They all have the same result.
						if(breastRows[temp2].breastRating > 7)
						{
							if(!hasPerk(PerkLib.BigTits))
								temp /=2;
							else
								temp /=1.5;
						}
						if(breastRows[temp2].breastRating > 9)
						{
							if(!hasPerk(PerkLib.BigTits))
								temp /=2;
							else
								temp /=1.5;
						}
						if(breastRows[temp2].breastRating > 12)
						{
							if(!hasPerk(PerkLib.BigTits))
								temp /=2;
							else
								temp  /=1.5;
						}
					}

					//Grow!
					trace("Growing breasts by ", temp);
					breastRows[temp2].breastRating += temp;
					rowsGrown--;
				}
			}

			if (!flags[kFLAGS.HYPER_HAPPY])
			{
				//Diminishing returns!
				if(breastRows[0].breastRating > 3) {
					if(!hasPerk(PerkLib.BigTits)) amount/=1.5;
					else amount/=1.3;
				}
				if(breastRows[0].breastRating > 7) {
					if(!hasPerk(PerkLib.BigTits)) amount/=2;
					else amount /= 1.5;
				}
				if(breastRows[0].breastRating > 12) {
					if(!hasPerk(PerkLib.BigTits)) amount/=2;
					else amount /= 1.5;
				}
			}
			/*if(breastRows[0].breastRating > 12) {
				if(hasPerk("Big Tits") < 0) amount/=2;
				else amount /= 1.5;
			}*/
			if(growthType == 2) {
				temp = 0;
				//Start at top and keep growing down, back to top if hit bottom before done.
				while(rowsGrown > 0) {
					if(temp+1 > breastRows.length) temp = 0;
					breastRows[temp].breastRating += amount;
					trace("Breasts increased by " + amount + " on row " + temp);
					temp++;
					temp3 += amount;
					rowsGrown--;
				}
			}
			if(growthType == 3) {
				while(rowsGrown > 0) {
					rowsGrown--;
					breastRows[0].breastRating += amount;
					temp3 += amount;
				}
			}
			//Breast Growth Finished...talk about changes.
			trace("Growth amount = ", amount);
			if(display) {
				if(growthType < 3) {
					if(amount <= 2)
					{
						if(breastRows.length > 1) outputText("Your rows of " + breastDescript(0) + " jiggle with added weight, growing a bit larger.");
						if(breastRows.length == 1) outputText("Your " + breastDescript(0) + " jiggle with added weight as they expand, growing a bit larger.");
					}
					else if(amount <= 4)
					{
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your rows of " + breastDescript(0) + " expand significantly.");
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.");
					}
					else
					{
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your " + breastDescript(0) + " tingle strongly, growing disturbingly large.");
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.");
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .5;
					}
				}
				else
				{
					if(amount <= 2) {
						if(breastRows.length > 1) outputText("Your top row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.");
						if(breastRows.length == 1) outputText("Your row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.");
					}
					if(amount > 2 && amount <= 4) {
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your top row of " + breastDescript(0) + " expand significantly.");
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.");
					}
					if(amount > 4) {
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your top row of " + breastDescript(0) + " tingle strongly, growing disturbingly large.");
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.");
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .5;
					}
				}
			}
		}

		public override function getAllMinStats():Object {
			var minStr:int = 1;
			var minTou:int = 1;
			var minSpe:int = 1;
			var minInt:int = 1;
			var minWis:int = 1;
			var minLib:int = 0;
			var minSen:int = 10;
			var minCor:int = 0;
			var racialScores:* = this.racialScores();
			var racial:* = this.racialBonuses();
			//Minimum Libido
			if (this.gender > 0) minLib = 15;
			else minLib = 10;
	
			if (this.armorName == "lusty maiden's armor") {
				if (minLib < 50) minLib = 50;
			}
			if (minLib < (minLust() * 2 / 3))
			{
				minLib = (minLust() * 2 / 3);
			}
			if (this.jewelryEffectId == JewelryLib.PURITY)
			{
				minLib -= this.jewelryEffectMagnitude;
			}
			if (this.hasPerk(PerkLib.PurityBlessing)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.HistoryReligious) || this.hasPerk(PerkLib.PastLifeReligious)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.GargoylePure)) {
				minLib = 5;
				minSen = 5;
			}
			if (this.hasPerk(PerkLib.GargoyleCorrupted)) {
				minSen += 15;
			}
			//Factory Perks
			if(this.hasPerk(PerkLib.ProductivityDrugs)) {minLib+=this.perkv1(PerkLib.ProductivityDrugs);minCor+=this.perkv2(PerkLib.ProductivityDrugs);}

			//Minimum Sensitivity
			minSen += racial[Race.BonusName_minsen];

			return {
				str:minStr,
				tou:minTou,
				spe:minSpe,
				inte:minInt,
				wis:minWis,
				lib:minLib,
				sens:minSen,
				cor:minCor
			};
		}

		//Determine minimum lust
		public override function minLust():Number
		{
			var min:Number = 0;
			var minCap:Number = maxLust();
			//Bimbo body boosts minimum lust by 40
			if(hasStatusEffect(StatusEffects.BimboChampagne) || hasPerk(PerkLib.BimboBody) || hasPerk(PerkLib.BroBody) || hasPerk(PerkLib.FutaForm)) min += 40;
			//Omnibus' Gift
			if (hasPerk(PerkLib.OmnibusGift)) min += 35;
			//Fera Blessing
			if (hasStatusEffect(StatusEffects.BlessingOfDivineFera)) min += 15;
			//Nymph perk raises to 30
			if(hasPerk(PerkLib.Nymphomania)) min += 30;
			//Oh noes anemone!
			if(hasStatusEffect(StatusEffects.AnemoneArousal)) min += 30;
			//Hot blooded perk raises min lust!
			if(hasPerk(PerkLib.HotBlooded)) min += perkv1(PerkLib.HotBlooded);
			if(hasPerk(PerkLib.LuststickAdapted)) min += 10;
			if(hasStatusEffect(StatusEffects.Infested)) min += 50;
			//Add points for Crimstone
			min += perkv1(PerkLib.PiercedCrimstone);
			//Subtract points for Icestone!
			min -= perkv1(PerkLib.PiercedIcestone);
			min += perkv1(PerkLib.PentUp);
			//Cold blooded perk reduces min lust, to a minimum of 20! Takes effect after piercings. This effectively caps minimum lust at 80.
			if (hasPerk(PerkLib.ColdBlooded)) {
				if (min >= 20) min -= 20;
				else min = 0;
				minCap -= 20;
			}
			//Purity Blessing perk reduce min lust, to a minimum of 10! Takes effect after piercings. This effectively caps minimum lust at 90.
			if (hasPerk(PerkLib.PurityBlessing)) {
				if (min >= 10) min -= 10;
				else min = 0;
				minCap -= 10;
			}
			//Harpy Lipstick status forces minimum lust to be at least 50.
			if(hasStatusEffect(StatusEffects.Luststick)) min += 50;
			//SHOULDRA BOOSTS
			//+20
			if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -168 && flags[kFLAGS.URTA_QUEST_STATUS] != 0.75) {
				min += 20;
				if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -216)
					min += 30;
			}
			//cumOmeter
			if (tailType == Tail.MANTICORE_PUSSYTAIL && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 25) {
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 25 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 20) min += 10;
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 20 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 15) min += 20;
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 15 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 10) min += 30;
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 10 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 5) min += 40;
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 5) min += 50;
			}
			//SPOIDAH BOOSTS
			if(eggs() >= 20) {
				min += 10;
				if(eggs() >= 40) min += 10;
			}
			//Werebeast
			if (hasPerk(PerkLib.Lycanthropy)) min += perkv1(PerkLib.Lycanthropy);
			//Jewelry effects
			if (jewelryEffectId == JewelryLib.MODIFIER_MINIMUM_LUST)
			{
				min += jewelryEffectMagnitude;
				if (min > (minCap - jewelryEffectMagnitude) && jewelryEffectMagnitude < 0)
				{
					minCap += jewelryEffectMagnitude;
				}
			}
			if (armorName == "lusty maiden's armor") min += 30;
			if (armorName == "tentacled bark armor") min += 20;
			//Constrain values
			if (min < 0) min = 0;
			if (min > (maxLust() - 10)) min = (maxLust() - 10);
			if (min > minCap) min = minCap;
			return min;
		}
		
		public override function getAllMaxStats():Object {
			Begin("Player","getAllMaxStats");
			var maxStr:int = 100;
			var maxTou:int = 100;
			var maxSpe:int = 100;
			var maxInt:int = 100;
			var maxWis:int = 100;
			var maxLib:int = 100;
			var maxSen:int = 100;
			var maxCor:int = 100;
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var racialScores:* = Race.AllScoresFor(this);
			
			//Alter max speed if you have oversized parts. (Realistic mode)
			if (flags[kFLAGS.HUNGER_ENABLED] >= 1)
			{
				//Balls
				var tempSpeedPenalty:Number = 0;
				var lim:int = isTaur() ? 9 : 4;
				if (ballSize > lim && balls > 0) tempSpeedPenalty += Math.round((ballSize - lim) / 2);
				//Breasts
				lim = isTaur() ? BreastCup.I : BreastCup.G;
				if (hasBreasts() && biggestTitSize() > lim) tempSpeedPenalty += ((biggestTitSize() - lim) / 2);
				//Cocks
				lim = isTaur() ? 72 : 24;
				if (biggestCockArea() > lim) tempSpeedPenalty += ((biggestCockArea() - lim) / 6);
				//Min-cap
				var penaltyMultiplier:Number = 1;
				penaltyMultiplier -= str * 0.1;
				penaltyMultiplier -= (tallness - 72) / 168;
				if (penaltyMultiplier < 0.4) penaltyMultiplier = 0.4;
				tempSpeedPenalty *= penaltyMultiplier;
				maxSpe -= tempSpeedPenalty;
				if (maxSpe < 50) maxSpe = 50;
			}
			//Perks ahoy
			Begin("Player","getAllMaxStats.perks");
			if (hasPerk(PerkLib.BasiliskResistance) && hasPerk(PerkLib.GorgonsEyes))
			{
				// 'maxspe': -5, // TODO withBonusTier
			}
			//Uma's Needlework affects max stats. Takes effect BEFORE racial modifiers and AFTER modifiers from body size.
			//Caps strength from Uma's needlework. 
			if (hasPerk(PerkLib.ChiReflowSpeed))
			{
				if (maxStr > UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP)
				{
					maxStr = UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP;
				}
			}
			//Caps speed from Uma's needlework.
			if (hasPerk(PerkLib.ChiReflowDefense))
			{
				if (maxSpe > UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP)
				{
					maxSpe = UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP;
				}
			}
			End("Player","getAllMaxStats.perks");
			Begin("Player","getAllMaxStats.racial");
			//Alter max stats depending on race (+15 za pkt)
			var racials:* = racialBonuses();
			maxStr += racials[Race.BonusName_maxstr] * newGamePlusMod;
			maxTou += racials[Race.BonusName_maxtou] * newGamePlusMod;
			maxSpe += racials[Race.BonusName_maxspe] * newGamePlusMod;
			maxInt += racials[Race.BonusName_maxint] * newGamePlusMod;
			maxWis += racials[Race.BonusName_maxwis] * newGamePlusMod;
			maxLib += racials[Race.BonusName_maxlib] * newGamePlusMod;
			maxSen += racials[Race.BonusName_maxsen] * newGamePlusMod;

			if (isNaga()) {
				maxStr += (15 * newGamePlusMod);
				maxSpe += (15 * newGamePlusMod);
			}
			if (isTaur()) {
				maxSpe += (20 * newGamePlusMod);
			}
			if (isDrider()) {
				maxTou += (15 * newGamePlusMod);
				maxSpe += (15 * newGamePlusMod);
			}
			if (isScylla()) {
				maxStr += (30 * newGamePlusMod);
			}
			if (racialScores[Race.GARGOYLE.name] >= 21) {
				if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) {
					maxStr += (20 * newGamePlusMod);
				}
				if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) {
					maxInt += (20 * newGamePlusMod);
				}
			}
			if (internalChimeraScore() >= 1) {
				maxStr += (5 * internalChimeraScore() * newGamePlusMod);
				maxTou += (5 * internalChimeraScore() * newGamePlusMod);
				maxSpe += (5 * internalChimeraScore() * newGamePlusMod);
				maxInt += (5 * internalChimeraScore() * newGamePlusMod);
				maxWis += (5 * internalChimeraScore() * newGamePlusMod);
				maxLib += (5 * internalChimeraScore() * newGamePlusMod);
				maxSen += (5 * internalChimeraScore() * newGamePlusMod);
			}
			if (maxStr < 25) maxStr = 25;
			if (maxTou < 25) maxTou = 25;
			if (maxSpe < 25) maxSpe = 25;
			if (maxInt < 25) maxInt = 25;
			if (maxWis < 25) maxWis = 25;
			if (maxLib < 25) maxLib = 25;
			if (maxSen < 25) maxSen = 25;
			End("Player","getAllMaxStats.racial");
			Begin("Player","getAllMaxStats.perks2");
			if (hasPerk(PerkLib.ChimericalBodyInitialStage)) {
				maxTou += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.ChimericalBodyBasicStage)) {
				maxStr += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
				maxInt += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.ChimericalBodyAdvancedStage)) {
				maxStr += (10 * newGamePlusMod);
				maxTou += (10 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage)) {
				maxInt += (10 * newGamePlusMod);
				maxWis += (10 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage)) {
				maxStr += (10 * newGamePlusMod);
				maxTou += (10 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
				maxInt += (10 * newGamePlusMod);
				maxWis += (10 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.SalamanderAdrenalGlands)) {
				maxTou += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.SalamanderAdrenalGlandsEvolved)) {
				maxStr += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.ScyllaInkGlands)) {
				maxStr += (10 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.MantislikeAgility)) {
				if (hasCoatOfType(Skin.CHITIN) && hasPerk(PerkLib.ThickSkin)) maxSpe += (20 * newGamePlusMod);
				if ((skinType == Skin.SCALES && hasPerk(PerkLib.ThickSkin)) || hasCoatOfType(Skin.CHITIN)) maxSpe += (15 * newGamePlusMod);
				if (skinType == Skin.SCALES) maxSpe += (10 * newGamePlusMod);
				if (hasPerk(PerkLib.ThickSkin)) maxSpe += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.MantislikeAgilityEvolved)) {
				if (hasCoatOfType(Skin.CHITIN) && hasPerk(PerkLib.ThickSkin)) maxSpe += (20 * newGamePlusMod);
				if ((skinType == Skin.SCALES && hasPerk(PerkLib.ThickSkin)) || hasCoatOfType(Skin.CHITIN)) maxSpe += (15 * newGamePlusMod);
				if (skinType == Skin.SCALES) maxSpe += (10 * newGamePlusMod);
				if (hasPerk(PerkLib.ThickSkin)) maxSpe += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.DraconicLungs)) {
				maxSpe += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.DraconicLungsEvolved)) {
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.KitsuneThyroidGland)) {
				maxSpe += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.KitsuneThyroidGlandEvolved)) {
				maxSpe += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.CatlikeNimblenessEvolved)) {
				maxSpe += (10 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.GargoylePure)) {
				maxWis += (80 * newGamePlusMod);
				maxLib -= (10 * newGamePlusMod);
				maxSen -= (10 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.GargoyleCorrupted)) {
				maxWis -= (10 * newGamePlusMod);
				maxLib += (80 * newGamePlusMod);
			}
			//Perks
			if (hasPerk(PerkLib.JobCourtesan)) maxLib += (15 * newGamePlusMod);
			if (hasPerk(PerkLib.JobDervish)) maxSpe += (10 * newGamePlusMod);
			if (hasPerk(PerkLib.JobDefender)) maxTou += (15 * newGamePlusMod);
			if (hasPerk(PerkLib.JobElementalConjurer)) maxWis += (5 * newGamePlusMod);
			if (hasPerk(PerkLib.JobEnchanter)) maxInt += (15 * newGamePlusMod);
			if (hasPerk(PerkLib.JobEromancer)) {
				maxInt += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.JobGuardian)) maxTou += (5 * newGamePlusMod);
			if (hasPerk(PerkLib.JobHunter)) {
				maxSpe += (10 * newGamePlusMod);
				maxInt += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.JobKnight)) maxTou += (10 * newGamePlusMod);
			if (hasPerk(PerkLib.JobMonk)) maxWis += (15 * newGamePlusMod);
			if (hasPerk(PerkLib.JobRanger)) maxSpe += (5 * newGamePlusMod);
			if (hasPerk(PerkLib.JobSeducer)) maxLib += (5 * newGamePlusMod);
			if (hasPerk(PerkLib.JobSorcerer)) maxInt += (5 * newGamePlusMod);
			if (hasPerk(PerkLib.JobWarrior)) maxStr += (5 * newGamePlusMod);
			if (hasPerk(PerkLib.PrestigeJobArcaneArcher)) {
				maxSpe += (40 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.PrestigeJobBerserker)) {
				maxStr += (60 * newGamePlusMod);
				maxTou += (20 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.PrestigeJobSentinel)) {
				maxStr += (20 * newGamePlusMod);
				maxTou += (60 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.PrestigeJobKiArtMaster)) {
				maxStr += (40 * newGamePlusMod);
				maxWis += (40 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.WeaponMastery)) maxStr += (5 * newGamePlusMod);
			if (hasPerk(PerkLib.ElementalConjurerResolve)) {
				maxStr -= (15 * newGamePlusMod);
				maxTou -= (15 * newGamePlusMod);
				maxSpe -= (15 * newGamePlusMod);
				maxInt += (20 * newGamePlusMod);
				maxWis += (30 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.ElementalConjurerDedication)) {
				maxStr -= (30 * newGamePlusMod);
				maxTou -= (30 * newGamePlusMod);
				maxSpe -= (30 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
				maxWis += (60 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.ElementalConjurerSacrifice)) {
				maxStr -= (45 * newGamePlusMod);
				maxTou -= (45 * newGamePlusMod);
				maxSpe -= (45 * newGamePlusMod);
				maxInt += (60 * newGamePlusMod);
				maxWis += (90 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.Lycanthropy)) {
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 3 || flags[kFLAGS.LUNA_MOON_CYCLE] == 5) {
					maxStr += (10 * newGamePlusMod);
					maxTou += (10 * newGamePlusMod);
					maxSpe += (10 * newGamePlusMod);
				}
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 2 || flags[kFLAGS.LUNA_MOON_CYCLE] == 6) {
					maxStr += (20 * newGamePlusMod);
					maxTou += (20 * newGamePlusMod);
					maxSpe += (20 * newGamePlusMod);
				}
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 1 || flags[kFLAGS.LUNA_MOON_CYCLE] == 7) {
					maxStr += (30 * newGamePlusMod);
					maxTou += (30 * newGamePlusMod);
					maxSpe += (30 * newGamePlusMod);
				}
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) {
					maxStr += (40 * newGamePlusMod);
					maxTou += (40 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
				}
			}
			End("Player","getAllMaxStats.perks2");
			Begin("Player","getAllMaxStats.effects");
			//Apply New Game+
			maxStr += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxTou += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxSpe += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxInt += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxWis += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxLib += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxSen += 5 * perkv1(PerkLib.AscensionTranshumanism);
			//Might
			if (hasStatusEffect(StatusEffects.Might)) {
				if (hasStatusEffect(StatusEffects.FortressOfIntellect)) maxInt += statusEffectv1(StatusEffects.Might);
				else maxStr += statusEffectv1(StatusEffects.Might);
				maxTou += statusEffectv2(StatusEffects.Might);
			}
			//Blink
			if (hasStatusEffect(StatusEffects.Blink)) {
				maxSpe += statusEffectv1(StatusEffects.Blink);
			}
			//Dwarf Rage
			if (hasStatusEffect(StatusEffects.DwarfRage)) {
				maxStr += statusEffectv1(StatusEffects.DwarfRage);
				maxTou += statusEffectv2(StatusEffects.DwarfRage);
				maxSpe += statusEffectv2(StatusEffects.DwarfRage);
			}
			//Trance Transformation
			if (hasStatusEffect(StatusEffects.TranceTransformation)) {
				maxStr += statusEffectv1(StatusEffects.TranceTransformation);
				maxTou += statusEffectv1(StatusEffects.TranceTransformation);
			}
			//Crinos Shape
			if (hasStatusEffect(StatusEffects.CrinosShape)) {
				maxStr += statusEffectv1(StatusEffects.CrinosShape);
				maxTou += statusEffectv2(StatusEffects.CrinosShape);
				maxSpe += statusEffectv3(StatusEffects.CrinosShape);
			}
			//
			if (hasStatusEffect(StatusEffects.ShiraOfTheEastFoodBuff2)) {
				if (statusEffectv1(StatusEffects.ShiraOfTheEastFoodBuff2) >= 1) maxStr += statusEffectv1(StatusEffects.ShiraOfTheEastFoodBuff2);
				maxTou += statusEffectv4(StatusEffects.ShiraOfTheEastFoodBuff2);
				if (statusEffectv2(StatusEffects.ShiraOfTheEastFoodBuff2) >= 1) maxSpe += statusEffectv2(StatusEffects.ShiraOfTheEastFoodBuff2);
				if (statusEffectv3(StatusEffects.ShiraOfTheEastFoodBuff2) >= 1) maxInt += statusEffectv3(StatusEffects.ShiraOfTheEastFoodBuff2);
			}
			//Beat of War
			if (hasStatusEffect(StatusEffects.BeatOfWar)) {
				maxStr += statusEffectv1(StatusEffects.BeatOfWar);
			}
			if (hasStatusEffect(StatusEffects.AndysSmoke)) {
				maxSpe -= statusEffectv2(StatusEffects.AndysSmoke);
				maxInt += statusEffectv3(StatusEffects.AndysSmoke);
			}
			if (hasStatusEffect(StatusEffects.FeedingEuphoria)) {
				maxSpe += statusEffectv2(StatusEffects.FeedingEuphoria);
			}
			if (hasStatusEffect(StatusEffects.BlessingOfDivineFenrir)) {
				maxStr += statusEffectv2(StatusEffects.BlessingOfDivineFenrir);
				maxTou += statusEffectv3(StatusEffects.BlessingOfDivineFenrir);
			}
			if (hasStatusEffect(StatusEffects.BlessingOfDivineTaoth)) {
				maxSpe += statusEffectv2(StatusEffects.BlessingOfDivineTaoth);
			}
			var vthirst:VampireThirstEffect = statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
			if (vthirst != null) {
				maxStr += vthirst.currentBoost;
				maxSpe += vthirst.currentBoost;
				maxInt += vthirst.currentBoost;
				maxLib += vthirst.currentBoost;
			}
			if (hasStatusEffect(StatusEffects.UnderwaterCombatBoost)) {
				maxStr += statusEffectv1(StatusEffects.UnderwaterCombatBoost);
				maxSpe += statusEffectv2(StatusEffects.UnderwaterCombatBoost);
			}
			End("Player","getAllMaxStats.effects");
			End("Player","getAllMaxStats");
			maxStr = Math.max(maxStr,1);
			maxTou = Math.max(maxTou,1);
			maxSpe = Math.max(maxSpe,1);
			maxInt = Math.max(maxInt,1);
			maxWis = Math.max(maxWis,1);
			maxLib = Math.max(maxLib,1);
			maxSen = Math.max(maxSen,1);
			maxCor = Math.max(maxCor,1);
			return {
				str:maxStr,
				tou:maxTou,
				spe:maxSpe,
				inte:maxInt,
				wis:maxWis,
				lib:maxLib,
				sens:maxSen,
				cor:maxCor
			};
		}
		
		public function requiredXP():int {
			var temp:int = level * 100;
			if (temp > 15000) temp = 15000;
			return temp;
		}
		
		public function minotaurAddicted():Boolean {
			return !hasPerk(PerkLib.MinotaurCumResistance) && !hasPerk(PerkLib.ManticoreCumAddict) && (hasPerk(PerkLib.MinotaurCumAddict) || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 1);
		}
		public function minotaurNeed():Boolean {
			return !hasPerk(PerkLib.MinotaurCumResistance) && !hasPerk(PerkLib.ManticoreCumAddict) && flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1;
		}

		public function clearStatuses(visibility:Boolean):void
		{
			if (hasStatusEffect(StatusEffects.DriderIncubusVenom))
			{
				str += statusEffectv2(StatusEffects.DriderIncubusVenom);
				removeStatusEffect(StatusEffects.DriderIncubusVenom);
				CoC.instance.mainView.statsView.showStatUp('str');
			}
			if(CoC.instance.monster.hasStatusEffect(StatusEffects.Sandstorm)) CoC.instance.monster.removeStatusEffect(StatusEffects.Sandstorm);
			if(hasStatusEffect(StatusEffects.DwarfRage)) {
				dynStats("str", -statusEffectv1(StatusEffects.DwarfRage),"tou", -statusEffectv2(StatusEffects.DwarfRage),"spe", -statusEffectv2(StatusEffects.DwarfRage), "scale", false);
				removeStatusEffect(StatusEffects.DwarfRage);
			}
			if(hasStatusEffect(StatusEffects.Berzerking)) {
				removeStatusEffect(StatusEffects.Berzerking);
			}
			if(hasStatusEffect(StatusEffects.Lustzerking)) {
				removeStatusEffect(StatusEffects.Lustzerking);
			}
			if(hasStatusEffect(StatusEffects.EverywhereAndNowhere)) {
				removeStatusEffect(StatusEffects.EverywhereAndNowhere);
			}
			if(CoC.instance.monster.hasStatusEffect(StatusEffects.TailWhip)) {
				CoC.instance.monster.removeStatusEffect(StatusEffects.TailWhip);
			}
			if(CoC.instance.monster.hasStatusEffect(StatusEffects.TwuWuv)) {
				inte += CoC.instance.monster.statusEffectv1(StatusEffects.TwuWuv);
				EngineCore.statScreenRefresh();
				CoC.instance.mainView.statsView.showStatUp( 'inte' );
			}
			if(hasStatusEffect(StatusEffects.NagaVenom)) {
				spe += statusEffectv1(StatusEffects.NagaVenom);
				CoC.instance.mainView.statsView.showStatUp( 'spe' );
				removeStatusEffect(StatusEffects.NagaVenom);
			}
			if(hasStatusEffect(StatusEffects.MedusaVenom)) {
				str += statusEffectv1(StatusEffects.MedusaVenom);
				tou += statusEffectv2(StatusEffects.MedusaVenom);
				spe += statusEffectv3(StatusEffects.MedusaVenom);
				inte += statusEffectv4(StatusEffects.MedusaVenom);
				CoC.instance.mainView.statsView.showStatUp( 'str' );
				CoC.instance.mainView.statsView.showStatUp( 'tou' );
				CoC.instance.mainView.statsView.showStatUp( 'spe' );
				CoC.instance.mainView.statsView.showStatUp( 'inte' );
				removeStatusEffect(StatusEffects.MedusaVenom);
			}
			if(hasStatusEffect(StatusEffects.Frostbite)) {
				str += statusEffectv1(StatusEffects.Frostbite);
				CoC.instance.mainView.statsView.showStatUp( 'str' );
				removeStatusEffect(StatusEffects.Frostbite);
			}
			if(hasStatusEffect(StatusEffects.Flying)) {
				removeStatusEffect(StatusEffects.Flying);
				if(hasStatusEffect(StatusEffects.FlyingNoStun)) {
					removeStatusEffect(StatusEffects.FlyingNoStun);
					removePerk(PerkLib.Resolute);
				}
			}
			if(hasStatusEffect(StatusEffects.Might)) {
				if (hasStatusEffect(StatusEffects.FortressOfIntellect)) dynStats("int", -statusEffectv1(StatusEffects.Might), "scale", false);
				else dynStats("str", -statusEffectv1(StatusEffects.Might), "scale", false);
				dynStats("tou", -statusEffectv2(StatusEffects.Might), "scale", false);
				removeStatusEffect(StatusEffects.Might);
			}
			if(hasStatusEffect(StatusEffects.Blink)) {
				dynStats("spe", -statusEffectv1(StatusEffects.Blink), "scale", false);
				removeStatusEffect(StatusEffects.Blink);
			}
			if(hasStatusEffect(StatusEffects.BeatOfWar)) {
				dynStats("str", -statusEffectv1(StatusEffects.BeatOfWar), "scale", false);
				removeStatusEffect(StatusEffects.BeatOfWar);
			}
			if(hasStatusEffect(StatusEffects.UnderwaterCombatBoost)) {
				dynStats("str", -statusEffectv1(StatusEffects.UnderwaterCombatBoost),"spe", -statusEffectv2(StatusEffects.UnderwaterCombatBoost), "scale", false);
				removeStatusEffect(StatusEffects.UnderwaterCombatBoost);
			}
			if(hasStatusEffect(StatusEffects.TranceTransformation)) {
				dynStats("str", -statusEffectv1(StatusEffects.TranceTransformation), "scale", false);
				dynStats("tou", -statusEffectv1(StatusEffects.TranceTransformation), "scale", false);
				removeStatusEffect(StatusEffects.TranceTransformation);
			}
			if(hasStatusEffect(StatusEffects.CrinosShape)) {
				dynStats("str", -statusEffectv1(StatusEffects.CrinosShape), "scale", false);
				dynStats("tou", -statusEffectv2(StatusEffects.CrinosShape), "scale", false);
				dynStats("spe", -statusEffectv3(StatusEffects.CrinosShape), "scale", false);
				removeStatusEffect(StatusEffects.CrinosShape);
			}
			if(hasStatusEffect(StatusEffects.EzekielCurse)) {
				removeStatusEffect(StatusEffects.EzekielCurse);
			}
			if(hasStatusEffect(StatusEffects.DragonBreathCooldown) && hasPerk(PerkLib.DraconicLungsEvolved)) {
				removeStatusEffect(StatusEffects.DragonBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown) && hasPerk(PerkLib.DraconicLungs)) {
				removeStatusEffect(StatusEffects.DragonDarknessBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonFireBreathCooldown) && hasPerk(PerkLib.DraconicLungs)) {
				removeStatusEffect(StatusEffects.DragonFireBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonIceBreathCooldown) && hasPerk(PerkLib.DraconicLungs)) {
				removeStatusEffect(StatusEffects.DragonIceBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonLightningBreathCooldown) && hasPerk(PerkLib.DraconicLungs)) {
				removeStatusEffect(StatusEffects.DragonLightningBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.HeroBane)) {
				removeStatusEffect(StatusEffects.HeroBane);
			}
			if(hasStatusEffect(StatusEffects.PlayerRegenerate)) {
				removeStatusEffect(StatusEffects.PlayerRegenerate);
			}
			if(hasStatusEffect(StatusEffects.Disarmed)) {
				removeStatusEffect(StatusEffects.Disarmed);
				if (weapon == WeaponLib.FISTS) {
//					weapon = ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon;
//					(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon).doEffect(this, false);
					setWeapon(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon);
				}
				else {
					flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID];
				}
			}
			if (hasStatusEffect(StatusEffects.DriderIncubusVenom))
			{
				str += statusEffectv2(StatusEffects.DriderIncubusVenom);
				removeStatusEffect(StatusEffects.DriderIncubusVenom);
			}
			
			// All CombatStatusEffects are removed here
			for (var a:/*StatusEffectClass*/Array=statusEffects.slice(),n:int=a.length,i:int=0;i<n;i++) {
				// Using a copy of array in case effects are removed/added in handler
				if (statusEffects.indexOf(a[i])>=0) a[i].onCombatEnd();
			}
		}

		public function consumeItem(itype:ItemType, amount:int = 1):Boolean {
			if (!hasItem(itype, amount)) {
				CoC_Settings.error("ERROR: consumeItem attempting to find " + amount + " item" + (amount > 1 ? "s" : "") + " to remove when the player has " + itemCount(itype) + ".");
				return false;
			}
			//From here we can be sure the player has enough of the item in inventory
			var slot:ItemSlotClass;
			while (amount > 0) {
				slot = getLowestSlot(itype); //Always draw from the least filled slots first
				if (slot.quantity > amount) {
					slot.quantity -= amount;
					amount = 0;
				}
				else { //If the slot holds the amount needed then amount will be zero after this
					amount -= slot.quantity;
					slot.emptySlot();
				}
			}
			return true;
/*			
			var consumed:Boolean = false;
			var slot:ItemSlotClass;
			while (amount > 0)
			{
				if(!hasItem(itype,1))
				{
					CoC_Settings.error("ERROR: consumeItem in items.as attempting to find an item to remove when the has none.");
					break;
				}
				trace("FINDING A NEW SLOT! (ITEMS LEFT: " + amount + ")");
				slot = getLowestSlot(itype);
				while (slot != null && amount > 0 && slot.quantity > 0)
				{
					amount--;
					slot.quantity--;
					if(slot.quantity == 0) slot.emptySlot();
					trace("EATIN' AN ITEM");
				}
				//If on slot 5 and it doesn't have any more to take, break out!
				if(slot == undefined) amount = -1

			}
			if(amount == 0) consumed = true;
			return consumed;
*/
		}

		public function getLowestSlot(itype:ItemType):ItemSlotClass
		{
			var minslot:ItemSlotClass = null;
			for each (var slot:ItemSlotClass in itemSlots) {
				if (slot.itype == itype) {
					if (minslot == null || slot.quantity < minslot.quantity) {
						minslot = slot;
					}
				}
			}
			return minslot;
		}
		
		public function hasItem(itype:ItemType, minQuantity:int = 1):Boolean {
			return itemCount(itype) >= minQuantity;
		}
		
		public function itemCount(itype:ItemType):int {
			var count:int = 0;
			for each (var itemSlot:ItemSlotClass in itemSlots){
				if (itemSlot.itype == itype) count += itemSlot.quantity;
			}
			return count;
		}

		// 0..5 or -1 if no
		public function roomInExistingStack(itype:ItemType):Number {
			for (var i:int = 0; i<itemSlots.length; i++){
				if(itemSlot(i).itype == itype && itemSlot(i).quantity != 0 && itemSlot(i).quantity < 10)
					return i;
			}
			return -1;
		}

		public function itemSlot(idx:int):ItemSlotClass
		{
			return itemSlots[idx];
		}

		// 0..5 or -1 if no
		public function emptySlot():Number {
		    for (var i:int = 0; i<itemSlots.length;i++){
				if (itemSlot(i).isEmpty() && itemSlot(i).unlocked) return i;
			}
			return -1;
		}


		public function destroyItems(itype:ItemType, numOfItemToRemove:Number):Boolean
		{
			for (var slotNum:int = 0; slotNum < itemSlots.length; slotNum += 1)
			{
				if(itemSlot(slotNum).itype == itype)
				{
					while(itemSlot(slotNum).quantity > 0 && numOfItemToRemove > 0)
					{
						itemSlot(slotNum).removeOneItem();
						numOfItemToRemove--;
					}
				}
			}
			return numOfItemToRemove <= 0;
		}

		public function lengthChange(temp2:Number, ncocks:Number):void {

			if (temp2 < 0 && flags[kFLAGS.HYPER_HAPPY])  // Early return for hyper-happy cheat if the call was *supposed* to shrink a cock.
			{
				return;
			}
			//DIsplay the degree of length change.
			if(temp2 <= 1 && temp2 > 0) {
				if(cocks.length == 1) outputText("Your [cock] has grown slightly longer.");
				if(cocks.length > 1) {
					if(ncocks == 1) outputText("One of your [cocks] grows slightly longer.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("Some of your [cocks] grow slightly longer.");
					if(ncocks == cocks.length) outputText("Your [cocks] seem to fill up... growing a little bit larger.");
				}
			}
			if(temp2 > 1 && temp2 < 3) {
				if(cocks.length == 1) outputText("A very pleasurable feeling spreads from your groin as your [cock] grows permanently longer - at least an inch - and leaks pre-cum from the pleasure of the change.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("A very pleasurable feeling spreads from your groin as your [cocks] grow permanently longer - at least an inch - and leak plenty of pre-cum from the pleasure of the change.");
					if(ncocks == 1) outputText("A very pleasurable feeling spreads from your groin as one of your [cocks] grows permanently longer, by at least an inch, and leaks plenty of pre-cum from the pleasure of the change.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("A very pleasurable feeling spreads from your groin as " + num2Text(ncocks) + " of your [cocks] grow permanently longer, by at least an inch, and leak plenty of pre-cum from the pleasure of the change.");
				}
			}
			if(temp2 >=3){
				if(cocks.length == 1) outputText("Your [cock] feels incredibly tight as a few more inches of length seem to pour out from your crotch.");
				if(cocks.length > 1) {
					if(ncocks == 1) outputText("Your [cocks] feel incredibly tight as one of their number begins to grow inch after inch of length.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("Your [cocks] feel incredibly number as " + num2Text(ncocks) + " of them begin to grow inch after inch of added length.");
					if(ncocks == cocks.length) outputText("Your [cocks] feel incredibly tight as inch after inch of length pour out from your groin.");
				}
			}
			//Display LengthChange
			if(temp2 > 0) {
				if(cocks[0].cockLength >= 8 && cocks[0].cockLength-temp2 < 8){
					if(cocks.length == 1) outputText("  <b>Most men would be overly proud to have a tool as long as yours.</b>");
					if(cocks.length > 1) outputText("  <b>Most men would be overly proud to have one cock as long as yours, let alone " + multiCockDescript() + ".</b>");
				}
				if(cocks[0].cockLength >= 12 && cocks[0].cockLength-temp2 < 12) {
					if(cocks.length == 1) outputText("  <b>Your [cock] is so long it nearly swings to your knee at its full length.</b>");
					if(cocks.length > 1) outputText("  <b>Your [cocks] are so long they nearly reach your knees when at full length.</b>");
				}
				if(cocks[0].cockLength >= 16 && cocks[0].cockLength-temp2 < 16) {
					if(cocks.length == 1) outputText("  <b>Your [cock] would look more at home on a large horse than you.</b>");
					if(cocks.length > 1) outputText("  <b>Your [cocks] would look more at home on a large horse than on your body.</b>");
					if (biggestTitSize() >= BreastCup.C) {
						if (cocks.length == 1) outputText("  You could easily stuff your [cock] between your breasts and give yourself the titty-fuck of a lifetime.");
						if (cocks.length > 1) outputText("  They reach so far up your chest it would be easy to stuff a few cocks between your breasts and give yourself the titty-fuck of a lifetime.");
					}
					else {
						if(cocks.length == 1) outputText("  Your [cock] is so long it easily reaches your chest.  The possibility of autofellatio is now a foregone conclusion.");
						if(cocks.length > 1) outputText("  Your [cocks] are so long they easily reach your chest.  Autofellatio would be about as hard as looking down.");
					}
				}
				if(cocks[0].cockLength >= 20 && cocks[0].cockLength-temp2 < 20) {
					if(cocks.length == 1) outputText("  <b>As if the pulsing heat of your [cock] wasn't enough, the tip of your [cock] keeps poking its way into your view every time you get hard.</b>");
					if(cocks.length > 1) outputText("  <b>As if the pulsing heat of your [cocks] wasn't bad enough, every time you get hard, the tips of your [cocks] wave before you, obscuring the lower portions of your vision.</b>");
					if(cor > 40 && cor <= 60) {
						if(cocks.length > 1) outputText("  You wonder if there is a demon or beast out there that could take the full length of one of your [cocks]?");
						if(cocks.length ==1) outputText("  You wonder if there is a demon or beast out there that could handle your full length.");
					}
					if(cor > 60 && cor <= 80) {
						if(cocks.length > 1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your [cocks] to their hilts, milking you dry.\n\nYou smile at the pleasant thought.");
						if(cocks.length ==1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your [cock] to the hilt, milking it of all your cum.\n\nYou smile at the pleasant thought.");
					}
					if(cor > 80) {
						if(cocks.length > 1) outputText("  You find yourself fantasizing about impaling nubile young champions on your [cocks] in a year's time.");
					}
				}
			}
			//Display the degree of length loss.
			if(temp2 < 0 && temp2 >= -1) {
				if(cocks.length == 1) outputText("Your [cocks] has shrunk to a slightly shorter length.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("Your [cocks] have shrunk to a slightly shorter length.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("You feel " + num2Text(ncocks) + " of your [cocks] have shrunk to a slightly shorter length.");
					if(ncocks == 1) outputText("You feel " + num2Text(ncocks) + " of your [cocks] has shrunk to a slightly shorter length.");
				}
			}
			if(temp2 < -1 && temp2 > -3) {
				if(cocks.length == 1) outputText("Your [cocks] shrinks smaller, flesh vanishing into your groin.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("Your [cocks] shrink smaller, the flesh vanishing into your groin.");
					if(ncocks == 1) outputText("You feel " + num2Text(ncocks) + " of your [cocks] shrink smaller, the flesh vanishing into your groin.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("You feel " + num2Text(ncocks) + " of your [cocks] shrink smaller, the flesh vanishing into your groin.");
				}
			}
			if(temp2 <= -3) {
				if(cocks.length == 1) outputText("A large portion of your [cocks]'s length shrinks and vanishes.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("A large portion of your [cocks] recedes towards your groin, receding rapidly in length.");
					if(ncocks == 1) outputText("A single member of your [cocks] vanishes into your groin, receding rapidly in length.");
					if(ncocks > 1 && cocks.length > ncocks) outputText("Your [cocks] tingles as " + num2Text(ncocks) + " of your members vanish into your groin, receding rapidly in length.");
				}
			}
		}

		public function killCocks(deadCock:Number):void
		{
			//Count removal for text bits
			var removed:Number = 0;
			var temp:Number;
			//Holds cock index
			var storedCock:Number = 0;
			//Less than 0 = PURGE ALL
			if (deadCock < 0) {
				deadCock = cocks.length;
			}
			//Double loop - outermost counts down cocks to remove, innermost counts down
			while (deadCock > 0) {
				//Find shortest cock and prune it
				temp = cocks.length;
				while (temp > 0) {
					temp--;
					//If anything is out of bounds set to 0.
					if (storedCock > cocks.length - 1) storedCock = 0;
					//If temp index is shorter than stored index, store temp to stored index.
					if (cocks[temp].cockLength <= cocks[storedCock].cockLength) storedCock = temp;
				}
				//Smallest cock should be selected, now remove it!
				removeCock(storedCock, 1);
				removed++;
				deadCock--;
				if (cocks.length == 0) deadCock = 0;
			}
			//Texts
			if (removed == 1) {
				if (cocks.length == 0) {
					outputText("<b>Your manhood shrinks into your body, disappearing completely.</b>");
					if (hasStatusEffect(StatusEffects.Infested)) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.");
				}
				if (cocks.length == 1) {
					outputText("<b>Your smallest penis disappears, shrinking into your body and leaving you with just one [cock].</b>");
				}
				if (cocks.length > 1) {
					outputText("<b>Your smallest penis disappears forever, leaving you with just your [cocks].</b>");
				}
			}
			if (removed > 1) {
				if (cocks.length == 0) {
					outputText("<b>All your male endowments shrink smaller and smaller, disappearing one at a time.</b>");
					if (hasStatusEffect(StatusEffects.Infested)) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.");
				}
				if (cocks.length == 1) {
					outputText("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with just your [cock].");
				}
				if (cocks.length > 1) {
					outputText("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with [cocks].");
				}
			}
			//remove infestation if cockless
			if (cocks.length == 0) removeStatusEffect(StatusEffects.Infested);
			if (cocks.length == 0 && balls > 0) {
				outputText("  <b>Your " + sackDescript() + " and [balls] shrink and disappear, vanishing into your groin.</b>");
				balls = 0;
				ballSize = 1;
			}
		}
		public function modCumMultiplier(delta:Number):Number
		{
			trace("modCumMultiplier called with: " + delta);
		
			if (delta == 0) {
				trace( "Whoops! modCumMuliplier called with 0... aborting..." );
				return delta;
			}
			else if (delta > 0) {
				trace("and increasing");
				if (hasPerk(PerkLib.MessyOrgasms)) {
					trace("and MessyOrgasms found");
					delta *= 1.5
				}
			}
			else if (delta < 0) {
				trace("and decreasing");
				if (hasPerk(PerkLib.MessyOrgasms)) {
					trace("and MessyOrgasms found");
					delta *= 0.5
				}
			}

			trace("and modifying by " + delta);
			cumMultiplier += delta;
			return delta;
		}

		public function increaseCock(cockNum:Number, lengthDelta:Number):Number
		{
			var bigCock:Boolean = false;
	
			if (hasPerk(PerkLib.BigCock))
				bigCock = true;

			return cocks[cockNum].growCock(lengthDelta, bigCock);
		}
		
		public function increaseEachCock(lengthDelta:Number):Number
		{
			var totalGrowth:Number = 0;
			
			for (var i:Number = 0; i < cocks.length; i++) {
				trace( "increaseEachCock at: " + i);
				totalGrowth += increaseCock(i as Number, lengthDelta);
			}
			
			return totalGrowth;
		}
		
		// Attempts to put the player in heat (or deeper in heat).
		// Returns true if successful, false if not.
		// The player cannot go into heat if she is already pregnant or is a he.
		// 
		// First parameter: boolean indicating if function should output standard text.
		// Second parameter: intensity, an integer multiplier that can increase the 
		// duration and intensity. Defaults to 1.
		public function goIntoHeat(output:Boolean, intensity:int = 1):Boolean {
			if(!hasVagina() || pregnancyIncubation != 0) {
				// No vagina or already pregnant, can't go into heat.
				return false;
			}
			
			//Already in heat, intensify further.
			if (inHeat) {
				if(output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Despite already being in heat, the desire to copulate constantly grows even larger.");
				}
				var sac:StatusEffectClass = statusEffectByType(StatusEffects.Heat);
				sac.value1 += 5 * intensity;
				sac.value2 += 5 * intensity;
				sac.value3 += 48 * intensity;
				dynStats("lib", 5 * intensity, "scale", false);
			}
			//Go into heat.  Heats v1 is bonus fertility, v2 is bonus libido, v3 is hours till it's gone
			else {
				if(output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Your hands begin stroking your body from top to bottom, your sensitive skin burning with desire.  Fantasies about bending over and presenting your needy pussy to a male overwhelm you as <b>you realize you have gone into heat!</b>");
				}
				createStatusEffect(StatusEffects.Heat, 10 * intensity, 15 * intensity, 48 * intensity, 0);
				dynStats("lib", 15 * intensity, "scale", false);
			}
			return true;
		}
		
		// Attempts to put the player in rut (or deeper in heat).
		// Returns true if successful, false if not.
		// The player cannot go into heat if he is a she.
		// 
		// First parameter: boolean indicating if function should output standard text.
		// Second parameter: intensity, an integer multiplier that can increase the 
		// duration and intensity. Defaults to 1.
		public function goIntoRut(output:Boolean, intensity:int = 1):Boolean {
			if (!hasCock()) {
				// No cocks, can't go into rut.
				return false;
			}
			
			//Has rut, intensify it!
			if (inRut) {
				if(output) {
					outputText("\n\nYour [cock] throbs and dribbles as your desire to mate intensifies.  You know that <b>you've sunken deeper into rut</b>, but all that really matters is unloading into a cum-hungry cunt.");
				}
				
				addStatusValue(StatusEffects.Rut, 1, 100 * intensity);
				addStatusValue(StatusEffects.Rut, 2, 5 * intensity);
				addStatusValue(StatusEffects.Rut, 3, 48 * intensity);
				dynStats("lib", 5 * intensity, "scale", false);
			}
			else {
				if(output) {
					outputText("\n\nYou stand up a bit straighter and look around, sniffing the air and searching for a mate.  Wait, what!?  It's hard to shake the thought from your head - you really could use a nice fertile hole to impregnate.  You slap your forehead and realize <b>you've gone into rut</b>!");
				}
				
				//v1 - bonus cum production
				//v2 - bonus libido
				//v3 - time remaining!
				createStatusEffect(StatusEffects.Rut, 150 * intensity, 5 * intensity, 100 * intensity, 0);
				dynStats("lib", 5 * intensity, "scale", false);
			}
			
			return true;
		}
		public function orgasmReal():void
		{
			dynStats("lus=", 0, "sca", false);
			hoursSinceCum = 0;
			flags[kFLAGS.TIMES_ORGASMED]++;

			if (countCockSocks("gilded") > 0) {
				var randomCock:int = rand( cocks.length );
				var bonusGems:int = rand( cocks[randomCock].cockThickness ) + countCockSocks("gilded"); // int so AS rounds to whole numbers
				EngineCore.outputText("\n\nFeeling some minor discomfort in your " + cockDescript(randomCock) + " you slip it out of your [armor] and examine it. <b>With a little exploratory rubbing and massaging, you manage to squeeze out " + bonusGems + " gems from its cum slit.</b>\n\n");
				gems += bonusGems;
			}
		}
		public function orgasm(type:String = 'Default', real:Boolean = true):void
		{
			switch (type) {
					// Start with that, whats easy
				case 'Vaginal': //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_VAGINAL] < 10) flags[kFLAGS.TIMES_ORGASM_VAGINAL]++;
					break;
				case 'Anal':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_ANAL]    < 10) flags[kFLAGS.TIMES_ORGASM_ANAL]++;
					break;
				case 'Dick':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_DICK]    < 10) flags[kFLAGS.TIMES_ORGASM_DICK]++;
					break;
				case 'Lips':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_LIPS]    < 10) flags[kFLAGS.TIMES_ORGASM_LIPS]++;
					break;
				case 'Tits':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_TITS]    < 10) flags[kFLAGS.TIMES_ORGASM_TITS]++;
					break;
				case 'Nipples': //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_NIPPLES] < 10) flags[kFLAGS.TIMES_ORGASM_NIPPLES]++;
					break;
				case 'Ovi':     break;

					// Now to the more complex types
				case 'VaginalAnal':
					orgasm((hasVagina() ? 'Vaginal' : 'Anal'), real);
					return; // Prevent calling orgasmReal() twice

				case 'DickAnal':
					orgasm((rand(2) == 0 ? 'Dick' : 'Anal'), real);
					return;

				case 'Default':
				case 'Generic':
				default:
					if (!hasVagina() && !hasCock()) {
						orgasm('Anal'); // Failsafe for genderless PCs
						return;
					}

					if (hasVagina() && hasCock()) {
						orgasm((rand(2) == 0 ? 'Vaginal' : 'Dick'), real);
						return;
					}

					orgasm((hasVagina() ? 'Vaginal' : 'Dick'), real);
					return;
			}

			if (real) orgasmReal();
		}
		public function orgasmRaijuStyle():void
		{
			if (game.player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) {
				EngineCore.outputText("\n\nAs you finish masturbating you feel a jolt in your genitals, as if for a small moment the raiju discharge was brought back, increasing the intensity of the pleasure and your desire to touch yourself. Electricity starts coursing through your body again by intermittence as something in you begins to change.");
				game.player.addStatusValue(StatusEffects.RaijuLightningStatus,1,6);
				dynStats("lus", (60 + rand(20)), "sca", false);
				game.mutations.voltageTopaz(false,CoC.instance.player);
			}
			else {
				EngineCore.outputText("\n\nAfter this electrifying orgasm your lust only raise sky high above. You will need a partner to fuck with in order to discharge your ramping up desire and electricity.");
				dynStats("lus", (maxLust() * 0.1), "sca", false);
			}
			hoursSinceCum = 0;
			flags[kFLAGS.TIMES_ORGASMED]++;
		}
		public function penetrated(where:ISexyPart, tool:ISexyPart, options:Object = null):void {
			options = Utils.extend({
				display:true,
				orgasm:false
			},options||{});

			if (where.host != null && where.host != this) {
				trace("Penetration confusion! Host is "+where.host);
				return;
			}

			var size:Number = 8;
			if ('size' in options) size = options.size;
			else if (tool is Cock) size = (tool as Cock).cArea();

			var otype:String = 'Default';
			if (where is AssClass) {
				buttChange(size, options.display);
				otype = 'Anal';
			} else if (where is VaginaClass) {
				cuntChange(size, options.display);
				otype = 'Vaginal';
			}
			if (options.orgasm) {
				orgasm(otype);
			}
		}
		
		protected override function maxHP_base():Number {
			var max:Number = super.maxHP_base();
			max += racialBonuses()[Race.BonusName_maxhp]*(1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			return max;
		}
		protected override function maxLust_base():Number {
			var max:Number = super.maxLust_base();
			max += racialBonuses()[Race.BonusName_maxlust]*(1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			return max;
		}
		
		override public function modStats(dstr:Number, dtou:Number, dspe:Number, dinte:Number, dwis:Number,dlib:Number, dsens:Number, dlust:Number, dcor:Number, scale:Boolean, max:Boolean):void {
			//Easy mode cuts lust gains!
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1 && dlust > 0 && scale) dlust /= 2;
			
			//Set original values to begin tracking for up/down values if
			//they aren't set yet.
			//These are reset when up/down arrows are hidden with
			//hideUpDown();
			//Just check str because they are either all 0 or real values
			if(game.oldStats.oldStr == 0) {
				game.oldStats.oldStr = str;
				game.oldStats.oldTou = tou;
				game.oldStats.oldSpe = spe;
				game.oldStats.oldInte = inte;
				game.oldStats.oldWis = wis;
				game.oldStats.oldLib = lib;
				game.oldStats.oldSens = sens;
				game.oldStats.oldCor = cor;
				game.oldStats.oldHP = HP;
				game.oldStats.oldLust = lust;
				game.oldStats.oldFatigue = fatigue;
				game.oldStats.oldKi = ki;
				game.oldStats.oldHunger = hunger;
			}
			if (scale) {
				//MOD CHANGES FOR PERKS
				//Bimbos learn slower
				if (hasPerk(PerkLib.FutaFaculties) || hasPerk(PerkLib.BimboBrains) || hasPerk(PerkLib.BroBrains)) {
					if (dinte > 0) dinte /= 2;
					if (dinte < 0) dinte *= 2;
				}
				if (hasPerk(PerkLib.FutaForm) || hasPerk(PerkLib.BimboBody) || hasPerk(PerkLib.BroBody)) {
					if (dlib > 0) dlib *= 2;
					if (dlib < 0) dlib /= 2;
				}
				
				// Uma's Perkshit
				if (hasPerk(PerkLib.ChiReflowSpeed) && dspe < 0) dspe *= UmasShop.NEEDLEWORK_SPEED_SPEED_MULTI;
				if (hasPerk(PerkLib.ChiReflowLust) && dlib > 0) dlib *= UmasShop.NEEDLEWORK_LUST_LIBSENSE_MULTI;
				if (hasPerk(PerkLib.ChiReflowLust) && dsens > 0) dsens *= UmasShop.NEEDLEWORK_LUST_LIBSENSE_MULTI;
				
				//Apply lust changes in NG+.
				dlust *= 1 + (newGamePlusMod() * 0.2);
				
				//lust resistance
				if (dlust > 0 && scale) dlust *= EngineCore.lustPercent() / 100;
				if (dlib > 0 && hasPerk(PerkLib.PurityBlessing)) dlib *= 0.75;
				if (dcor > 0 && hasPerk(PerkLib.PurityBlessing)) dcor *= 0.5;
				if (dcor > 0 && hasPerk(PerkLib.PureAndLoving)) dcor *= 0.75;
				if (dcor > 0 && weapon == game.weapons.HNTCANE) dcor *= 0.5;
				if (hasPerk(PerkLib.AscensionMoralShifter)) dcor *= 1 + (perkv1(PerkLib.AscensionMoralShifter) * 0.2);
				if (hasPerk(PerkLib.Lycanthropy)) dcor *= 1.2;
				if (hasStatusEffect(StatusEffects.BlessingOfDivineFera)) dcor *= 2;
				
				if (sens > 50 && dsens > 0) dsens /= 2;
				if (sens > 75 && dsens > 0) dsens /= 2;
				if (sens > 90 && dsens > 0) dsens /= 2;
				if (sens > 50 && dsens < 0) dsens *= 2;
				if (sens > 75 && dsens < 0) dsens *= 2;
				if (sens > 90 && dsens < 0) dsens *= 2;
				
				
				//Bonus gain for perks!
				if (hasPerk(PerkLib.Strong)) dstr += dstr * perkv1(PerkLib.Strong);
				if (hasPerk(PerkLib.Tough)) dtou += dtou * perkv1(PerkLib.Tough);
				if (hasPerk(PerkLib.Fast)) dspe += dspe * perkv1(PerkLib.Fast);
				if (hasPerk(PerkLib.Smart)) dinte += dinte * perkv1(PerkLib.Smart);
				if (hasPerk(PerkLib.Lusty)) dlib += dlib * perkv1(PerkLib.Lusty);
				if (hasPerk(PerkLib.Sensitive)) dsens += dsens * perkv1(PerkLib.Sensitive);
				
				// Uma's Str Cap from Perks (Moved to max stats)
				/*if (hasPerk(PerkLib.ChiReflowSpeed))
				{
					if (str > UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP)
					{
						str = UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP;
					}
				}
				if (hasPerk(PerkLib.ChiReflowDefense))
				{
					if (spe > UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP)
					{
						spe = UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP;
					}
				}*/
			}
			//Change original stats
			super.modStats(dstr,dtou,dspe,dinte,dwis,dlib,dsens,dlust,dcor,false,max);
			//Refresh the stat pane with updated values
			//mainView.statsView.showUpDown();
			EngineCore.showUpDown();
			EngineCore.statScreenRefresh();
		}
	}
}
