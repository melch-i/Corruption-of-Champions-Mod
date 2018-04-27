/**
 * Coded by aimozg on 30.05.2017.
 */
package classes.Scenes.Combat {
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Items.ShieldLib;
import classes.Items.WeaponLib;
import classes.PerkLib;
import classes.Scenes.API.FnHelpers;
import classes.StatusEffects;

import coc.view.ButtonData;
import coc.view.ButtonDataList;

public class CombatSoulskills extends BaseCombatContent {
	public function CombatSoulskills() {
	}
	//------------
	// S. SPECIALS
	//------------
	internal function buildMenu(buttons:ButtonDataList):void {
		var bd:ButtonData;
		if (player.hasStatusEffect(StatusEffects.KnowsIceFist)) {
			bd = buttons.add("Ice Fist", IceFist).hint("A chilling strike that can freeze an opponent solid, leaving it vulnerable to shattering soul art and hindering its movement.  \n\nSoulforce cost: " + 30 * soulskillCost() * soulskillcostmulti());
			if (player.hasPerk(PerkLib.FireAffinity)) {
				bd.disable("Try as you want, you can’t call on the power of this technique due to your close affinity to fire.");
			} else if (!player.isFistOrFistWeapon()) {
				bd.disable("<b>Your current used weapon not allow to use this technique.</b>");
			} else if (player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("<b>Your current soulforce is too low.</b>");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsFirePunch)) {
			bd = buttons.add("Fire Punch", FirePunch).hint("Ignite your opponents dealing fire damage and setting them ablaze.  \n\nSoulforce cost: " + 30 * soulskillCost() * soulskillcostmulti());
			if (player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			} else if (!player.isFistOrFistWeapon()) {
				bd.disable("<b>Your current used weapon not allow to use this technique.</b>");
			} else if (player.hasPerk(PerkLib.ColdAffinity)) {
				bd.disable("Try as you want, you can’t call on the power of this technique due to your close affinity to cold.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsHurricaneDance)) {
			bd = buttons.add("Hurricane Dance", HurricaneDance).hint("Take on the aspect of the wind dodging attacks with aerial graces for a time.  \n\nWould go into cooldown after use for: 10 rounds  \n\nSoulforce cost: " + 30 * soulskillCost() * soulskillcostmulti());
			if (player.hasStatusEffect(StatusEffects.CooldownHurricaneDance)) {
				bd.disable("You need more time before you can use Hurricane Dance again.");
			} else if (player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsEarthStance)) {
			buttons.add("Earth Stance", EarthStance).hint("Take on the stability and strength of the earth gaining 30% damage reduction for the next 3 rounds.  \n\nWould go into cooldown after use for: 10 rounds  \n\nSoulforce cost: " + 30 * soulskillCost() * soulskillcostmulti());
			if (player.hasStatusEffect(StatusEffects.CooldownEarthStance)) {
				bd.disable("You need more time before you can use Earth Stance again.");
			} else if (player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsPunishingKick)) {
			buttons.add("Punishing Kick", PunishingKick).hint("A vicious kick that can daze an opponent, reducing its damage for a while.  \n\nWould go into cooldown after use for: 10 rounds  \n\nSoulforce cost: " + 30 * soulskillCost() * soulskillcostmulti());
			if (player.hasStatusEffect(StatusEffects.CooldownPunishingKick)) {
				bd.disable("You need more time before you can use Punishing Kick again.");
			} else if (!player.isBiped() || !player.isTaur()) {
				bd.disable("<b>Your legs not allow to use this technique.</b>");
			} else if (player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsSoulBlast)) {
			buttons.add("Soul Blast", SoulBlast).hint("Take in your reserve of soul force to unleash a torrent of devastating energy and obliterate your opponent.  \n\nWould go into cooldown after use for: 15 rounds  \n\nSoulforce cost: " + 100 * soulskillCost() * soulskillcostmulti());
			if (player.hasStatusEffect(StatusEffects.CooldownSoulBlast)) {
				bd.disable("You need more time before you can use Soul Blast again.");
			} else if (player.soulforce < 100 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsOverlimit)) {
			if (player.hasStatusEffect(StatusEffects.Overlimit)) {
				buttons.add("Overlimit(Off)", deactivaterOverlimit).hint("Deactivate Overlimit.");
			} else {
				buttons.add("Overlimit(On)", activaterOverlimit).hint("Strain your body to its limit to increase melee damage dealt by 100% at the cost of hurting yourself. This also increases lust resistance.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsTripleThrust)) {
			bd = buttons.add("Triple Thrust", TripleThrust).hint("Use a little bit of soulforce to infuse your weapon and thrust three times toward your enemy.\n\nSoulforce cost: " + 30 * soulskillCost() * soulskillcostmulti());
			if (player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsDracoSweep)) {
			bd = buttons.add("Draco Sweep", DracoSweep).hint("Use a little bit of soulforce to infuse your weapon and then sweep ahead hitting as many enemies as possible.\n\nSoulforce cost: " + 50 * soulskillCost() * soulskillcostmulti());
			if (player.soulforce < 50 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.weapon == weapons.WGSWORD) {
			bd = buttons.add("Beat of War", BeatOfWar).hint("Attack with low-moderate additional soul damage, gain strength equal to 15% your base strength until end of battle. This effect stacks.\n\nSoulforce cost: " + 50 * soulskillCost() * soulskillcostmulti());
			if (player.soulforce < 50 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.weapon == weapons.WDBLADE) {
			buttons.add("Blade Dance", BladeDance).hint("Attack twice (four times if double attack is active, six times if triple attack is active and etc.).\n\nSoulforce cost: " + 50 * soulskillCost() * (1 + flags[kFLAGS.DOUBLE_ATTACK_STYLE]));
			if (player.soulforce < 50 * soulskillCost() * (1 + flags[kFLAGS.DOUBLE_ATTACK_STYLE])) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.weapon == weapons.WDSTAFF) {
			bd = buttons.add("AvatarOfTheSong", AvatarOfTheSong).hint("Doublecast Charged Weapon and Might. Casts blind if charged weapon is already active. Casts Heal if Might is already active.\n\nSoulforce cost: 200");
			if (player.soulforce < 200) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.OniRampage)) {
				bd.disable("You are too angry to think straight. Smash your puny opponents first and think later.");
			}
		}
		if (player.weaponRangeName == "Warden’s bow") {
			bd = buttons.add("ResonanceVolley", ResonanceVolley).hint("Perform a ranged attack where each arrow after the first gets an additional 10% accuracy for every arrow before it.\n\nSoulforce cost: 150");
			if (player.soulforce < 150) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsManyBirds)) {
			bd = buttons.add("Many Birds", ManyBirds).hint("Project a figment of your soulforce as a crystal traveling at extreme speeds.\n\nSoulforce cost: " + 10 * soulskillCost() * soulskillcostmulti());
			if (player.soulforce < 10 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.OniRampage)) {
				bd.disable("You are too angry to think straight. Smash your puny opponents first and think later.");
			}
			
		}
		if (player.hasStatusEffect(StatusEffects.KnowsComet)) {
			bd = buttons.add("Comet", Comet).hint("Project a shard of soulforce, which will come crashing down upon your opponent as a crystalline comet.\n\nSoulforce cost: " + 60 * soulskillCost() * soulskillcostmulti());
			if (player.soulforce < 60 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.OniRampage)) {
				bd.disable("You are too angry to think straight. Smash your puny opponents first and think later.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsVioletPupilTransformation)) {
			if (player.hasStatusEffect(StatusEffects.VioletPupilTransformation)) {
				buttons.add("Deactiv VPT", DeactivateVioletPupilTransformation)
					   .hint("Deactivate Violet Pupil Transformation.");
			} else {
				bd = buttons.add("V P Trans", VioletPupilTransformation);
				
				var unicornScore:Number = player.unicornScore();
				var alicornScore:Number = player.alicornScore();
				if (unicornScore >= 5 && alicornScore >= 6) bd.hint("Violet Pupil Transformation is a regenerating oriented soul art that at the cost of constant using fixed amount of soulforce would be healing user.  Usualy it would ends when caster run out of soulforce to substain it or situation that casused it activation is over.\n\nSoulforce cost: <i>100 soulforce</i> regenerating <b>" + (200 + ((unicornScore - 4) * 25) + ((alicornScore - 5) * 25)) + " HP</b> per turn.");
				else if (unicornScore >= 5) bd.hint("Violet Pupil Transformation is a regenerating oriented soul art that at the cost of constant using fixed amount of soulforce would be healing user.  Usualy it would ends when caster run out of soulforce to substain it or situation that casused it activation is over.\n\nSoulforce cost: <i>100 soulforce</i> regenerating <b>" + (200 + ((unicornScore - 4) * 25)) + " HP</b> per turn.");
				else bd.hint("Violet Pupil Transformation is a regenerating oriented soul art that at the cost of constant using fixed amount of soulforce would be healing user.  Usualy it would ends when caster run out of soulforce to substain it or situation that casused it activation is over.\n\nSoulforce cost: <i>100 soulforce</i> regenerating <b>200 HP</b> per turn.");
				
				if (player.soulforce < 100) {
					bd.disable("<b>Your current soulforce is too low.</b>");
				}
			}
		}
		if (player.hasPerk(PerkLib.Trance)) {
			if (!player.hasStatusEffect(StatusEffects.TranceTransformation)) {
				buttons.add("Trance", TranceTransformation).hint("Activate Trance state, whcih enhancing physical and mental abilities at constant cost of soulforce.\n\nCost: 100 soulforce on activation and 50 soulforce per turn)");
				if (player.soulforce < 100) {
					bd.disable("Your current soulforce is too low.");
				} else if (player.hasStatusEffect(StatusEffects.OniRampage)) {
					bd.disable("You are too angry to think straight. Smash your puny opponents first and think later.");
				}
			} else {
				buttons.add("DeActTrance", DeactivateTranceTransformation).hint("Deactivate Trance.");
			}
		}
	}

	public function TripleThrust():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		outputText("You ready your [weapon] and prepare to thrust it towards " + monster.a + monster.short + ".  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
			enemyAI();
			return;
		}
		var soulforcecost:int = 30 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		var damage:Number = player.str;
		damage += scalingBonusStrength() * 0.5;
		if (damage < 10) damage = 10;
		//weapon bonus
		if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.04));
		else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (3 + ((player.weaponAttack - 50) * 0.035));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (4.75 + ((player.weaponAttack - 100) * 0.03));
		else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (6.25 + ((player.weaponAttack - 150) * 0.025));
		else damage *= (7.5 + ((player.weaponAttack - 200) * 0.02));
		//soulskill mod effect
		damage *= combat.soulskillPhysicalMod();
		//other bonuses
		if (player.hasPerk(PerkLib.HoldWithBothHands) && player.weapon != WeaponLib.FISTS && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) damage *= 1.2;
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= 1.1;
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		//triple strike bonus
		damage *= 3;
		if (monster.hasStatusEffect(StatusEffects.Frozen)) damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits()) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		if (monster.hasStatusEffect(StatusEffects.Frozen)) {
			monster.spe += monster.statusEffectv1(StatusEffects.Frozen);
			monster.removeStatusEffect(StatusEffects.Frozen);
			outputText("Your [weapon] hits the ice in three specific points, making it explode along with your frozen adversary! <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		}
		else outputText("Your [weapon] hits thrice against " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		if (monster.HP < 1) doNext(endHpVictory);
		else enemyAI();
	}

	public function DracoSweep():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		outputText("You ready your [weapon] and prepare to sweep it towards " + monster.a + monster.short + ".  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
			enemyAI();
			return;
		}
		var soulforcecost:int = 50 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		var damage:Number = player.str;
		damage += scalingBonusStrength() * 0.5;
		if (damage < 10) damage = 10;
		//weapon bonus
		if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.04));
		else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (3 + ((player.weaponAttack - 50) * 0.035));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (4.75 + ((player.weaponAttack - 100) * 0.03));
		else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (6.25 + ((player.weaponAttack - 150) * 0.025));
		else damage *= (7.5 + ((player.weaponAttack - 200) * 0.02));
		//soulskill mod effect
		damage *= combat.soulskillPhysicalMod();
		//group enemies bonus
		if (monster.plural == true) damage *= 5;
		//other bonuses
		if (player.hasPerk(PerkLib.HoldWithBothHands) && player.weapon != WeaponLib.FISTS && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) damage *= 1.2;
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= 1.1;
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits()) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		outputText("Your [weapon] sweeps against " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
		if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		if (monster.HP < 1) doNext(endHpVictory);
		else enemyAI();
	}

	public function ManyBirds():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (silly ()) outputText("You focus your soulforce, projecting it as an aura around you.  As you concentrate, dozens, hundreds, thousands of tiny, ethereal birds shimmer into existence.  As you raise your hand up, more and more appear, until the area around you and " + monster.a + monster.short + "  is drowned in spectral flappy shapes.  ");
		else {
			outputText("You thrust your hand outwards with deadly intent, and in the blink of an eye a crystal shoots towards " + monster.a + monster.short + ".  ");
			if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
				if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids crystal!");
				if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges crystal with superior quickness!");
				if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids crystal.");
				enemyAI();
				return;
			}
		}
		var soulforcecost:int = 10 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		var damage:Number = scalingBonusIntelligence();
		if (damage < 10) damage = 10;
		damage *= spellMod();
		//soulskill mod effect
		damage *= combat.soulskillMagicalMod();
		//other bonuses
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits()) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		if (silly ()) {
			outputText("You snap your fingers, and at once every bird lends their high pitched voice to a unified, glass shattering cry:");
			outputText("\n\n\"<i>AAAAAAAAAAAAAAAAAAAAAAAAAAAAA</i>\" (" + monster.a + monster.short + " take <b><font color=\"#800000\">" + damage + "</font></b> damage) ");
		}
		else outputText("Crystal hits " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		if (monster.HP < 1) doNext(endHpVictory);
		else enemyAI();
	}

	public function Comet():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		outputText("You focus for a moment, projecting a fragment of your soulforce above you.  A moment later, a prismatic comet crashes down on your opponents " + monster.a + monster.short + ".  ");
		if (monster.plural == true) outputText("Shattering into thousands of fragments that shower anything and everything around you.  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids comet fragments!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges comet fragments with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids comet fragments.");
			enemyAI();
			return;
		}
		var soulforcecost:int = 60 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		var damage:Number = scalingBonusIntelligence();
		if (damage < 10) damage = 10;
		damage *= spellMod();
		//soulskill mod effect
		damage *= combat.soulskillMagicalMod();
		//group enemies bonus
		if (monster.plural == true) damage *= 5;
		//other bonuses
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits()) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		outputText("Comet fragments hits " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		if (monster.HP < 1) doNext(endHpVictory);
		else enemyAI();
	}

	public function IceFist():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var soulforcecost:int = 30 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		var damage:Number = unarmedAttack();
		damage += player.str;
		damage += scalingBonusStrength();
		damage += player.wis;
		damage += scalingBonusWisdom();
		//other bonuses
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits()) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		monster.spe -= 20;
		outputText("Air seems to lose all temperature around your fist as you dash at " + monster.a + monster.short + " and shove your palm on " + monster.pronoun2 + ", " + monster.pronoun3 + " body suddenly is frozen solid, encased in a thick block of ice! (<b><font color=\"#800000\">" + damage + "</font></b>)");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		if (monster.hasStatusEffect(StatusEffects.Frozen)) {
			if (monster.spe - 20 >= 0) {
				monster.addStatusValue(StatusEffects.Frozen, 1, 20);
				monster.spe -= 20;
			}
			else {
				monster.addStatusValue(StatusEffects.Frozen, 1, monster.spe);
				monster.spe -= monster.spe;
			}
		}
		else {
			monster.createStatusEffect(StatusEffects.Frozen, 0, 0, 0, 0);
			if (monster.spe - 20 >= 0) {
				monster.addStatusValue(StatusEffects.Frozen, 1, 20);
				monster.spe -= 20;
			}
			else {
				monster.addStatusValue(StatusEffects.Frozen, 1, monster.spe);
				monster.spe -= monster.spe;
			}
		}
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		else {
			outputText("  <b>" + monster.capitalA + monster.short + " ");
			if(!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be frozen by your attack.</b>");
		}
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		outputText("\n\n");
		if (monster.HP < 1) doNext(endHpVictory);
		else enemyAI();
	}

	public function FirePunch():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var soulforcecost:int = 30 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		var damage:Number = unarmedAttack();
		damage += player.str;
		damage += scalingBonusStrength();
		damage += player.wis;
		damage += scalingBonusWisdom();
		//other bonuses
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits()) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		monster.createStatusEffect(StatusEffects.FirePunchBurnDoT,16,0,0,0);
		outputText("Setting your fist ablaze, you rush at " + monster.a + monster.short + " and scorch " + monster.pronoun2 + " with your searing flames. (<b><font color=\"#800000\">" + damage + "</font></b>)");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		outputText("\n\n");
		if (monster.HP < 1) doNext(endHpVictory);
		else enemyAI();
	}

	public function HurricaneDance():void {
		clearOutput();
		var soulforcecost:int = 30 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		outputText("Your movement becomes more fluid and precise, increasing your speed and evasion.\n\n");
		player.createStatusEffect(StatusEffects.HurricaneDance, 5, 0, 0, 0);
		player.createStatusEffect(StatusEffects.CooldownHurricaneDance, 10, 0, 0, 0);
		enemyAI();
	}

	public function EarthStance():void {
		clearOutput();
		var soulforcecost:int = 30 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		outputText("Your body suddenly hardens like rock. You will be way harder to damage for a while.\n\n");
		player.createStatusEffect(StatusEffects.EarthStance, 3, 0, 0, 0);
		player.createStatusEffect(StatusEffects.CooldownEarthStance, 10, 0, 0, 0);
		enemyAI();
	}

	public function PunishingKick():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		var soulforcecost:int = 30 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		var damage:Number = unarmedAttack();
		damage += player.str;
		damage += scalingBonusStrength();
		damage += player.wis;
		damage += scalingBonusWisdom();
		//other bonuses
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits()) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		monster.createStatusEffect(StatusEffects.PunishingKick, 5, 0, 0, 0);
		player.createStatusEffect(StatusEffects.CooldownPunishingKick, 10, 0, 0, 0);
		outputText("You lash out with a devastating kick, knocking your opponent back and disorienting it. " + monster.capitalA + monster.short + " will have a hard time recovering its balance for a while. <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		if (monster.HP < 1) doNext(endHpVictory);
		else enemyAI();
	}

	public function SoulBlast():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var soulforcecost:int = 100 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		var damage:Number = player.str;
		damage += scalingBonusStrength() * 1.8;
		damage += player.inte;
		damage += scalingBonusIntelligence() * 1.8;
		damage += player.wis;
		damage += scalingBonusWisdom() * 1.8;
		if (damage < 10) damage = 10;
		damage *= spellMod();
		//soulskill mod effect
		damage *= combat.soulskillMagicalMod();
		//other bonuses
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits()) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		player.createStatusEffect(StatusEffects.CooldownSoulBlast, 15, 0, 0, 0);
		outputText("You wave the sign of the gate, tiger and serpent as you unlock all of your soulforce for an attack. " + monster.capitalA + monster.short + " can’t figure out what you are doing until a small sphere of energy explodes at the end of your fist in a massive beam of condensed soulforce. <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 3, 0, 0, 0);
		else {
			outputText("  <b>" + monster.capitalA + monster.short + " ");
			if(!monster.plural) outputText("is ");
			else outputText("are ");
			outputText("too resolute to be stunned by your attack.</b>");
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		if (monster.HP < 1) doNext(endHpVictory);
		else enemyAI();
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

	public function VioletPupilTransformationHealing():Number {
		var modvpth:Number = 200;
		//if () modvpth += 5;
		//if (player.findPerk(PerkLib.) >= 0 || player.findPerk(PerkLib.) >= 0) modvpth *= 1.3;
		return modvpth;
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
		var doEffect:Function = function():* {
			var TranceBoost:Number = 10;
			if (player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) TranceBoost += 5;
			if (player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) TranceBoost += 5;
			if (player.hasPerk(PerkLib.JobEnchanter) && player.inte >= 50) TranceBoost += 5;
			if (player.hasPerk(PerkLib.Battleflash) && player.inte >= 50) TranceBoost += 15;
			if (player.hasPerk(PerkLib.JobDervish)) TranceBoost -= 10;
			if (player.hasPerk(PerkLib.IronFistsI)) TranceBoost -= 10;
			if (player.hasPerk(PerkLib.JobMonk)) TranceBoost -= 15;
			if (player.hasPerk(PerkLib.Berzerker)) TranceBoost -= 15;
			if (player.hasPerk(PerkLib.Lustzerker)) TranceBoost -= 15;
			if (player.hasPerk(PerkLib.WeaponMastery)) TranceBoost -= 15;
			if (player.hasPerk(PerkLib.HeavyArmorProficiency)) TranceBoost -= 15;
			if (player.hasPerk(PerkLib.Agility)) TranceBoost -= 10;
			if (player.hasPerk(PerkLib.LightningStrikes)) TranceBoost -= 10;
		//	TranceBoost += player.inte / 10;player.inte * 0.1 - może tylko jak bedzie mieć perk z prestige job: magus/warock/inny związany z spells
			if (TranceBoost < 10) TranceBoost = 10;
		//	if (player.hasPerk(PerkLib.JobEnchanter)) TranceBoost *= 1.2;
		//	TranceBoost *= spellModBlack();
			TranceBoost = FnHelpers.FN.logScale(TranceBoost,TranceABC,10);
			TranceBoost = Math.round(TranceBoost);
			tempStrTou = TranceBoost;
			player.createStatusEffect(StatusEffects.TranceTransformation, 0, 0, 0, 0);
			player.changeStatusValue(StatusEffects.TranceTransformation, 1, tempStrTou);
			mainView.statsView.showStatUp('str');
			// strUp.visible = true;
			// strDown.visible = false;
			mainView.statsView.showStatUp('tou');
			// touUp.visible = true;
			// touDown.visible = false;
			player.str += player.statusEffectv1(StatusEffects.TranceTransformation);
			player.tou += player.statusEffectv1(StatusEffects.TranceTransformation);
			statScreenRefresh();
		};
		var tempStrTou:Number = 0;
		var tempSpe:Number = 0;
		var tempInt:Number = 0;
		outputText("You focus the power of your mind and soul, letting the mystic energy fill you. Your [skin] begins to crystalize as the power within you takes form. The power whirls within you like a hurricane, the force of it lifting you off your feet. This power...  You will use it to reach victory!\n");
		doEffect.call();
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
		var tempStr:Number = 0;
		var soulforcecost:int = 50 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		var BeatOfWarBoost:Number = (player.str - player.statusEffectv1(StatusEffects.BeatOfWar)) * 0.15;
		if (BeatOfWarBoost < 1) BeatOfWarBoost = 1;
		BeatOfWarBoost = Math.round(BeatOfWarBoost);
		if (!player.hasStatusEffect(StatusEffects.BeatOfWar)) player.createStatusEffect(StatusEffects.BeatOfWar,0,0,0,0);//player.addStatusValue(StatusEffects.BeatOfWar, 1, BeatOfWarBoost);
		tempStr = BeatOfWarBoost;
		player.addStatusValue(StatusEffects.BeatOfWar,1,tempStr);
		mainView.statsView.showStatUp('str');
		player.str += BeatOfWarBoost;			//player.statusEffectv1(StatusEffects.BeatOfWar);
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
		outputText("You ready your bow, infusing it with a figment of soulforce. The energy awakens the wood’s connection to the world tree, causing the bow to pulse beneath your fingers.\n\n");
		player.createStatusEffect(StatusEffects.ResonanceVolley,0,0,0,0);
		combat.fireBow();
	}
	public function AvatarOfTheSong():void {
		clearOutput();
		outputText("You feel the song of the mother tree all around you, and using your staff as a beacon, you unify it with the flow of magic through your body,");
		if (!player.hasStatusEffect(StatusEffects.Might)) {
			outputText("drawing strength from it");
			combat.magic.spellMight(true);
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
		}
		else {
			outputText("feeling it mend your wounds");
			fatigue(30, USEFATG_BLACK_NOBM);
			combat.magic.spellHealEffect();
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
		}
		if (!monster.hasStatusEffect(StatusEffects.Blind)) {
			outputText(". The residual power ");
			if (!player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
				outputText("makes your staff glow with barely contained energy");
				combat.magic.spellChargeWeapon(true);
				flags[kFLAGS.SPELLS_CAST]++;
				if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
				spellPerkUnlock();
			}
			else {
				outputText("makes your staff flare up, as the energy escapes as a radiant flash");
				combat.magic.spellBlind();
				flags[kFLAGS.SPELLS_CAST]++;
				if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
				spellPerkUnlock();
			}
		}
		outputText(".\n\n");
		enemyAI();
	}
	/*
	 //Mantis Omni Slash (AoE attack) - przerobić to na soulskilla zużywającego jak inne soulforce z rosnącym kosztem im wyższy lvl postaci ^^ owinno wciąż jakoś być powiązane z posiadaniem mantis arms czy też ulepszonych mantis arms (czyt. versji 2.0 tych ramion z TF bdącego soul evolution of Mantis) ^^
	 public function mantisOmniSlash():void {
	 flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
	 clearOutput();
	 if (monster.plural) {
	 if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
	 outputText("You are too tired to slash " + monster.a + " " + monster.short + ".");
	 addButton(0, "Next", combatMenu, false);
	 return;
	 }
	 }
	 else {
	 if (player.fatigue + physicalCost(20) > player.maxFatigue()) {
	 outputText("You are too tired to slash " + monster.a + " " + monster.short + ".");
	 addButton(0, "Next", combatMenu, false);
	 return;
	 }
	 }
	 if (monster.plural) {
	 fatigue(60, USEFATG_PHYSICAL);
	 }
	 else fatigue(24, USEFATG_PHYSICAL);
	 //Amily!
	 if(monster.hasStatusEffect(StatusEffects.Concentration)) {
	 outputText("Amily easily glides around your attacks thanks to her complete concentration on your movements.\n\n");
	 enemyAI();
	 return;
	 }
	 outputText("You ready your wrists mounted scythes and prepare to sweep them towards " + monster.a + monster.short + ".\n\n");
	 if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe-player.spe) / 4) + 80)) > 80)) {
	 if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attacks!\n\n");
	 if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attacks with superior quickness!\n\n");
	 if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attacks.\n\n");
	 enemyAI();
	 return;
	 if (monster.plural) {
	 if (player.hasPerk(PerkLib.MantislikeAgility)) {
	 if (player.hasPerk(PerkLib.MantislikeAgilityEvolved) && player.hasPerk(PerkLib.TrachealSystemEvolved)) flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 10;
	 else flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 6;
	 }
	 else flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 3;
	 }
	 else flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 1;
	 mantisMultipleAttacks();
	 }
	 public function mantisMultipleAttacks():void {
	 var damage:Number = player.spe;
	 damage += speedscalingbonus() * 0.5;
	 if (damage < 10) damage = 10;
	 //adjusting to be used 60/100% of base speed while attacking depending on insect-related perks possesed
	 if (!player.hasPerk(PerkLib.MantislikeAgility)) damage *= 0.6;
	 //bonuses if fighting multiple enemies
	 if (monster.plural) {
	 if (!player.hasPerk(PerkLib.MantislikeAgility) && !player.hasPerk(PerkLib.TrachealSystemEvolved)) damage *= 1.1;
	 if (player.hasPerk(PerkLib.MantislikeAgility) && player.hasPerk(PerkLib.TrachealSystemEvolved)) damage *= 1.5;
	 }
	 //weapon bonus
	 if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.04));
	 else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (3 + ((player.weaponAttack - 50) * 0.035));
	 else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (4.75 + ((player.weaponAttack - 100) * 0.03));
	 else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (6.25 + ((player.weaponAttack - 150) * 0.025));
	 else damage *= (7.5 + ((player.weaponAttack - 200) * 0.02));
	 //other bonuses
	 if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
	 if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= 1.1;
	 //Determine if critical hit!
	 var crit:Boolean = false;
	 var critChance:int = 5;
	 if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
	 if (player.inte <= 100) critChance += (player.inte - 50) / 50;
	 if (player.inte > 100) critChance += 1;
	 }
	 if (monster.isImmuneToCrits()) critChance = 0;
	 if (rand(100) < critChance) {
	 crit = true;
	 damage *= 1.75;
	 }
	 //final touches
	 damage *= (monster.damagePercent() / 100);
	 damage = doDamage(damage);
	 outputText("Your scythes swiftly sweeps against " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
	 if (crit == true) outputText(" <b>*Critical Hit!*</b>");
	 outputText("\n");
	 checkAchievementDamage(damage);
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 0) {
	 outputText("\n");
	 enemyAI();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 1) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 2) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 3) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 4) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 5) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 6) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 7) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 8) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 9) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 }

	 public function tripleThrust():void {
	 flags[kFLAGS.LAST_ATTACK_TYPE] = 4;//fizyczny atak
	 clearOutput();
	 if (player.soulforce < 10 * soulskillCost() * soulskillcostmulti()) {
	 outputText("<b>Your current soulforce is too low.</b>");
	 doNext(combatMenu);
	 return;
	 }
	 outputText("You ready your [weapon] and prepare to thrust it towards " + monster.a + monster.short + ".  ");
	 if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe-player.spe) / 4) + 80)) > 80)) {
	 if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
	 if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
	 if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
	 enemyAI();
	 return;
	 }
	 var soulforcecost:int = 10 * soulskillCost() * soulskillcostmulti();
	 player.soulforce -= soulforcecost;
	 var damage:Number = player.str;
	 damage += strenghtscalingbonus() * 0.5;
	 if (damage < 10) damage = 10;
	 //weapon bonus
	 if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.04));
	 else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (3 + ((player.weaponAttack - 50) * 0.035));
	 else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (4.75 + ((player.weaponAttack - 100) * 0.03));
	 else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (6.25 + ((player.weaponAttack - 150) * 0.025));
	 else damage *= (7.5 + ((player.weaponAttack - 200) * 0.02));
	 //other bonuses
	 if (player.hasPerk(PerkLib.HoldWithBothHands) && player.weapon != WeaponLib.FISTS && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) damage *= 1.2;
	 if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
	 if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= 1.1;
	 if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
	 if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
	 //triple strike bonus
	 damage *= 3;
	 //soulskill mod effect
	 damage *= combat.soulskillPhysicalMod();
	 //final touches
	 damage *= (monster.damagePercent() / 100);
	 damage = doDamage(damage);
	 outputText("Your [weapon] hits thrice against " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
	 checkAchievementDamage(damage);
	 outputText("\n\n");
	 if (monster.HP < 1) doNext(endHpVictory);
	 else enemyAI();
	 }*/
}
}
