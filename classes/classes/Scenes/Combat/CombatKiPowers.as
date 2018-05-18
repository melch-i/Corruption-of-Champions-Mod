/**
 * Coded by aimozg on 30.05.2017.
 */
package classes.Scenes.Combat {
	import classes.Creature;
	import classes.EngineCore;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.ShieldLib;
	import classes.Items.WeaponLib;
	import classes.PerkLib;
	import classes.Scenes.API.FnHelpers;
	import classes.Scenes.SceneLib;
	import classes.StatusEffectClass;
	import classes.StatusEffects;

	import coc.view.ButtonDataList;

	public class CombatKiPowers extends BaseCombatContent {
	public function CombatKiPowers() {
	}
	//------------
	// S. SPECIALS
	//------------
	internal function buildMenu(buttons:ButtonDataList):void {
		var actions:Array = player.availableActions.filter(function(item:CombatAction, index:int, array:Array):Boolean{return item.actionType == CombatAction.KiAction;});
		for each(var action:CombatAction in actions){
			buttons.list.push(action.button(player,monster));
		}
		var base:int = kiPowerCost();
		if (player.hasStatusEffect(StatusEffects.KnowsOverlimit)) {
			if (player.hasStatusEffect(StatusEffects.Overlimit)) {
				buttons.add("Overlimit(Off)", deactivaterOverlimit, "Deactivate Overlimit.");
			} else {
				buttons.add("Overlimit(On)", activaterOverlimit, "Strain your body to its limit to increase melee damage dealt by 100% at the cost of hurting yourself. This also increases lust resistance.");
			}
		}
		if (player.weapon == weapons.WGSWORD) {
			buttons.add("Beat of War", BeatOfWar, "Attack with low-moderate additional soul damage, gain strength equal to 15% your base strength until end of battle. This effect stacks.")
				.requireKi(50 * base);
		}
		if (player.weapon == weapons.WDBLADE) {
			buttons.add("Blade Dance", BladeDance, "Attack twice (four times if double attack is active, six times if triple attack is active and etc.).")
				.requireKi(50 * kiPowerCost() * (1 + flags[kFLAGS.DOUBLE_ATTACK_STYLE]));
		}
		if (player.weapon == weapons.WDSTAFF) {
			buttons.add("AvatarOfTheSong", AvatarOfTheSong, "Doublecast Charged Weapon and Might. Casts blind if charged weapon is already active. Casts Heal if Might is already active.")
				.requireKi(200)
				.disableIf(player.hasStatusEffect(StatusEffects.OniRampage), "You are too angry to think straight. Smash your puny opponents first and think later.");
		}
		if (player.weaponRangeName == "Warden’s bow") {
			buttons.add("ResonanceVolley", ResonanceVolley, "Perform a ranged attack where each arrow after the first gets an additional 10% accuracy for every arrow before it.")
				.requireKi(150);
		}
		if (player.hasStatusEffect(StatusEffects.KnowsVioletPupilTransformation)) {
			if (player.hasStatusEffect(StatusEffects.VioletPupilTransformation)) {
				buttons.add("Deactiv VPT", DeactivateVioletPupilTransformation, "Deactivate Violet Pupil Transformation.");
			} else {
				var regen:int = 200;
				regen += (Math.max(player.alicornScore() - 5, 0) * 25);
				regen += (Math.max(player.unicornScore() - 4, 0) * 25);
				var hint:String = "Violet Pupil Transformation is a regenerating oriented soul art that at the cost of constant using fixed amount of ki would be healing user.  Usualy it would ends when caster run out of ki to substain it or situation that casused it activation is over.";
				hint += "\n\nRegenerate [b: " + regen + "] HP per turn.";

				buttons.add("V P Trans", VioletPupilTransformation, hint)
					.requireKi(100);
			}
		}
		if (player.hasPerk(PerkLib.Trance)) {
			if (player.hasStatusEffect(StatusEffects.TranceTransformation)) {
				buttons.add("DeActTrance", DeactivateTranceTransformation, "Deactivate Trance.");
			} else {
				buttons.add("Trance", TranceTransformation, "Activate Trance state, whcih enhancing physical and mental abilities at constant cost of ki.\n\nCost: 100 ki on activation and 50 ki per turn)")
					.requireKi(100)
					.disableIf(player.hasStatusEffect(StatusEffects.OniRampage), "You are too angry to think straight. Smash your puny opponents first and think later.");
			}
		}
	}

	private static function endAction(target:Creature, damage:Number):void {
		SceneLib.combat.checkAchievementDamage(damage);
		EngineCore.outputText("\n\n");
		SceneLib.combat.heroBaneProc(damage);
		if (target.HP < 1) EngineCore.doNext(SceneLib.combat.endHpVictory);
		else SceneLib.combat.enemyAIImpl();
	}

	private static function weaponMod(host:Creature):Number {
		var weaponAttack:Number = host.weaponAttack;
		var baseMod:int = Math.floor((Math.min(weaponAttack, 200) /50));
		var mod:Number = weaponAttack - (baseMod * 50);
		mod *= 0.040 - (0.005 * baseMod);
		mod += 1 + (-0.125 * Math.pow(baseMod, 2)) + (2.125 * baseMod);
		return mod;
	}

	public static const MAGICAL:int = 0;
	public static const PHYSICAL:int = 1;
	public static const UNARMED:int = 2;
	public static function kiDamage(damType:int, host:Creature, target:Creature):Number{
		var damage:Number;
		switch(damType){
			case MAGICAL:
				damage = Math.max(10, host.scalingBonusIntelligence());
				damage *= SceneLib.combat.spellMod();
				damage *= host.kiPowerMod(false);
				break;
			case PHYSICAL:
				damage = Math.max(10, host.str + (host.scalingBonusStrength() / 2));
				damage *= weaponMod(host);
				damage *= host.kiPowerMod(true);
				if (host.hasPerk(PerkLib.HoldWithBothHands) && host.weaponName != WeaponLib.FISTS.name && host.shieldName == ShieldLib.NOTHING.name && !SceneLib.combat.isWieldingRangedWeapon()) damage *= 1.2;
				if (host.hasPerk(PerkLib.ThunderousStrikes) && host.str >= 80) damage *= 1.2;
				if (host.hasPerk(PerkLib.HistoryFighter) || host.hasPerk(PerkLib.PastLifeFighter)) damage *= 1.1;
				if (host.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
				if (host.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
				if (host.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
				break;
			case UNARMED:
				damage = SceneLib.combat.unarmedAttack();
				damage += host.str + host.scalingBonusStrength();
				damage += host.wis + host.scalingBonusWisdom();
				break;
		}
		return damage;
	}

	public static function SoulBlast(host:Creature, target:Creature):Number {
		var damage:Number = host.str;
		damage += host.scalingBonusStrength() * 1.8;
		damage += host.inte;
		damage += host.scalingBonusIntelligence() * 1.8;
		damage += host.wis;
		damage += host.scalingBonusWisdom() * 1.8;
		if (damage < 10) damage = 10;
		damage *= SceneLib.combat.spellMod();
		//kiPower mod effect
		damage *= host.kiPowerMod();
		return damage;
	}

	public function activaterOverlimit():void {
		clearOutput();
		outputText("You let out a primal roar of pain and fury, as you push your body beyond its normal capacity, a blood red aura cloaking your form.\n\n");
		player.createStatusEffect(StatusEffects.Overlimit, 0, 0, 0, 0);
		enemyAI();
	}

	public function deactivaterOverlimit():void {
		clearOutput();
		outputText("You let your rage cool down, feeling relieved as the stress in your body diminish along with your power.\n\n");
		player.removeStatusEffect(StatusEffects.Overlimit);
		enemyAI();
	}

	public function VioletPupilTransformation():void {
		clearOutput();
		outputText("Deciding you need additional regeneration during current fight you spend moment to concentrate and activate Violet Pupil Transformation.  Your eyes starting to glow with a violet hua and you can feel refreshing feeling spreading all over your body.\n");
		player.createStatusEffect(StatusEffects.VioletPupilTransformation,0,0,0,0);
		enemyAI();
	}

	public function DeactivateVioletPupilTransformation():void {
		clearOutput();
		outputText("Deciding you not need for now to constantly using Violet Pupil Transformation you concentrate and deactivating it.");
		player.removeStatusEffect(StatusEffects.VioletPupilTransformation);
		enemyAI();
	}

	private static const TranceABC:Object = FnHelpers.FN.buildLogScaleABC(10,100,1000,10,100);
	public function TranceTransformation():void {
		clearOutput();
		outputText("You focus the power of your mind and soul, letting the mystic energy fill you. Your [skin] begins to crystalize as the power within you takes form. The power whirls within you like a hurricane, the force of it lifting you off your feet. This power...  You will use it to reach victory!\n");
		var TranceBoost:Number = 10;
		if (player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) TranceBoost += 5;
		if (player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) TranceBoost += 5;
		if (player.hasPerk(PerkLib.JobEnchanter) && player.inte >= 50) TranceBoost += 5;
		if (player.hasPerk(PerkLib.Battleflash) && player.inte >= 50) TranceBoost += 15;
		if (player.hasPerk(PerkLib.JobDervish)) TranceBoost -= 10;
		if (player.hasPerk(PerkLib.IronFists)) TranceBoost -= 10;
		if (player.hasPerk(PerkLib.AdvancedJobMonk)) TranceBoost -= 15;
		if (player.hasPerk(PerkLib.Berzerker)) TranceBoost -= 15;
		if (player.hasPerk(PerkLib.Lustzerker)) TranceBoost -= 15;
		if (player.hasPerk(PerkLib.WeaponMastery)) TranceBoost -= 15;
		if (player.hasPerk(PerkLib.HeavyArmorProficiency)) TranceBoost -= 15;
		if (player.hasPerk(PerkLib.Agility)) TranceBoost -= 10;
		if (player.hasPerk(PerkLib.LightningStrikes)) TranceBoost -= 10;
		TranceBoost = Math.max(10, TranceBoost);
		TranceBoost = FnHelpers.FN.logScale(TranceBoost,TranceABC,10);
		TranceBoost = Math.round(TranceBoost);
		player.createStatusEffect(StatusEffects.TranceTransformation, TranceBoost, 0, 0, 0);
		mainView.statsView.showStatUp('str');
		mainView.statsView.showStatUp('tou');
		player.str += TranceBoost;
		player.tou += TranceBoost;
		statScreenRefresh();
		enemyAI();
	}

	public function DeactivateTranceTransformation():void {
		clearOutput();
		outputText("You disrupt the flow of power within you, softly falling to the ground as the crystal sheathing your [skin] dissipates into nothingness.");
		player.dynStats("str", -player.statusEffectv1(StatusEffects.TranceTransformation));
		player.dynStats("tou", -player.statusEffectv1(StatusEffects.TranceTransformation));
		player.removeStatusEffect(StatusEffects.TranceTransformation);
		enemyAI();
	}

	public function BeatOfWar():void {
		clearOutput();
		var kicost:int = 50 * kiPowerCost();
		player.ki -= kicost;

		var status:StatusEffectClass = player.createOrFindStatusEffect(StatusEffects.BeatOfWar);
		var BeatOfWarBoost:int = Math.max(1, (player.str - status.value1) * 0.15);
		status.value1 += BeatOfWarBoost;
		mainView.statsView.showStatUp('str');
		player.str += BeatOfWarBoost;
		statScreenRefresh();
		outputText("You momentarily attune yourself to the song of the mother tree, and prepare to add a note of your own to it’s rhythm. You feel the beat shift the song’s tempo slightly, taking a twist towards the ominous. This attunement augments your strength.\n\n");
		combat.basemeleeattacks();
	}

	public function BladeDance():void {
		clearOutput();
		outputText("You momentarily attune yourself to the song of the mother tree, and dance forward, darting your blade around your enemy.\n\n");
		player.createStatusEffect(StatusEffects.BladeDance,0,0,0,0);
		combat.basemeleeattacks();
	}
	public function ResonanceVolley():void {
		clearOutput();
		outputText("You ready your bow, infusing it with a figment of ki. The energy awakens the wood’s connection to the world tree, causing the bow to pulse beneath your fingers.\n\n");
		player.createStatusEffect(StatusEffects.ResonanceVolley,0,0,0,0);
		combat.fireBow();
	}
	public function AvatarOfTheSong():void {
		clearOutput();
		outputText("You feel the song of the mother tree all around you, and using your staff as a beacon, you unify it with the flow of magic through your body,");
		if (!player.hasStatusEffect(StatusEffects.Might)) {
			outputText("drawing strength from it");
			combat.magic.spellMight(true);
			casted();
		}
		else {
			outputText("feeling it mend your wounds");
			fatigue(30, USEFATG_BLACK_NOBM);
			combat.magic.spellHealEffect();
			casted();
		}
		if (!monster.hasStatusEffect(StatusEffects.Blind)) {
			outputText(". The residual power ");
			if (!player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
				outputText("makes your staff glow with barely contained energy");
				combat.magic.spellChargeWeapon(true);
				casted();
			}
			else {
				outputText("makes your staff flare up, as the energy escapes as a radiant flash");
				combat.magic.spellBlind();
				casted();
			}
		}
		endAction(monster, 0);

		function casted():void {
			flags[kFLAGS.SPELLS_CAST]++;
			player.createOrFindStatusEffect(StatusEffects.CastedSpell);
			spellPerkUnlock();
		}
	}
}
}
