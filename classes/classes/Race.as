/**
 * Coded by aimozg on 12.04.2018.
 */
package classes {
import classes.BodyParts.*;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Hair;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tongue;
import classes.internals.Utils;
import classes.lists.BreastCup;
import classes.lists.Gender;
import classes.lists.Gender;

/**
 * I. Racial scores
 *
 * Racial score calculation is performed in 3 phases: simple, complex, and finalizer.
 * Simple and complex components are defined as data, while finalizer is a function.
 * The more stuff is moved from finalizer to complex and from complex to simple, the better.
 *
 * "Metrics" are some values (e.g. body part types) that are pre-calculated and used in calculations.
 *
 * Simple Racial Test is defined as list of (Metric Name, Expected Value, Bonus)
 * Simple Racial Score is sum of Bonuses for tests with metrics having exact expected value
 * Combined Simple Racial Tests can be (and actually are) represented as a (Metric Name, Value) -> Bonus mapping
 *
 * Complex Racial Test is defined as (Bonus, list of (Metric Name, List of Expected Values) )
 * Complex Racial Test is passed if EVERY metric has ANY of expected values
 *
 * Finalizer is a simply function that calculates everything that doesn't fit Simple/Complex test model.
 *
 *
 * II. Racial bonuses
 *
 * Racial bonuses are set of named values achievable on certain racial score thresholds.
 * Bonus values are not added on tiers within race (maxstr +15 at score 6 and +30 at 10 will give +30 at score 10),
 * but are added across different races.
 *
 * There is a AllBonusesFor function that iterates over all races and sums the bonuses.
 *
 * III. Racial perks
 *
 * Racial perks are perks automatically added/removed (in PlayerEvents every hour) if player achieves certain score
 * or drops below it.
 *
 * If a perk belongs to several races, it is awarded for completing any requirement, and removed for failing all.
 *
 * There is a AllPerksToAddOrRemoveFor function to get list of perks that should be added and removed.
 */
public class Race {
	public var name:String;
	
	public static var RegisteredRaces:/*Race*/Array = [];
	// TODO fur, scales, plain
	public static var MetricNames:/*String*/Array   = [
		'skin',
		'skin.coverage',
		'skin.tone',
		'skin.adj',
		'skin.base.pattern',
		'skin.coat',
		'skin.coat.color',
		'hair',
		'hair.color',
		'face',
		'eyes',
		'eyes.color',
		'ears',
		'tongue',
		'gills',
		'antennae',
		'horns',
		'horns.count',
		'wings',
		'tail',
		'tail.count',
		'arms',
		'legs',
		'legs.count',
		'rear',
		'gender'
	];
	public static function MetricsFor(ch:Creature):* /* object{metricName:metricValue} */ {
		return {
			'skin'           : ch.skinType,
			'skin.coverage'  : ch.skin.coverage,
			'skin.tone'      : ch.skinTone,
			'skin.adj'       : ch.skinAdj,
			'skin.coat'      : ch.skin.coat.type,
			'skin.coat.color': ch.skin.coat.color,
			'hair'           : ch.hairType,
			'hair.color'     : ch.hairColor,
			'face'           : ch.facePart.type,
			'eyes'           : ch.eyes.type,
			'eyes.color'     : ch.eyes.colour,
			'ears'           : ch.ears.type,
			'tongue'         : ch.tongue.type,
			'gills'          : ch.gills.type,
			'antennae'       : ch.antennae.type,
			'horns'          : ch.horns.type,
			'horns.count'    : ch.horns.count,
			'wings'          : ch.wings.type,
			'tail'           : ch.tail.type,
			'tail.count'     : ch.tail.count,
			'arms'           : ch.arms.type,
			'legs'           : ch.lowerBody,
			'legs.count'     : ch.legCount,
			'rear'           : ch.rearBody.type,
			'gender'         : ch.gender
		}
	}
	
	public static function ExplainMetricValue(metric:String, value:*):String {
		switch (metric) {
			case 'skin'           :
				return Skin.Types[value].name;
			case 'skin.coverage'  :
				return ["no", "partial", "medium", "high", "complete"]+" coat";
			case 'skin.coat'      :
				return Skin.Types[value].name+" coat";
			case 'hair'           :
				return Hair.Types[value].name+" hair";
			case 'face'           :
				return Face.Types[value].name;
			case 'eyes'           :
				return Eyes.Types[value].name+" eyes";
			case 'ears'           :
				return Ears.Types[value].name+" ears";
			case 'tongue'         :
				return Tongue.Types[value].name+" tongue";
			case 'gills'          :
				return Gills.Types[value].name;
			case 'antennae'       :
				return Antennae.Types[value].name+" antennae";
			case 'horns'          :
				return Horns.Types[value].name+" horns";
			case 'arms'           :
				return Arms.Types[value].name + " arms";
			case 'legs'           :
				return LowerBody.Types[value].name + " legs";
			case 'wings'          :
				return Wings.Types[value].name + " desc";
			case 'tail'           :
				return Tail.Types[value].name+" tail";
			case 'rear'           :
				return RearBody.Types[value].name;
			case 'gender'         :
				return Gender.Values[value].name;
			case 'skin.tone'      :
			case 'skin.adj'       :
			case 'skin.coat.color':
			case 'hair.color'     :
			case 'eyes.color'     :
			case 'horns.count'    :
			case 'tail.count'     :
			case 'legs.count'     :
			default:
				return value;
		}
	}
	
	public static const BonusName_maxstr:String       = 'maxstr';
	public static const BonusName_maxtou:String       = 'maxtou';
	public static const BonusName_maxspe:String       = 'maxspe';
	public static const BonusName_maxint:String       = 'maxint';
	public static const BonusName_maxwis:String       = 'maxwis';
	public static const BonusName_maxlib:String       = 'maxlib';
	public static const BonusName_minsen:String       = 'minsen';
	public static const BonusName_maxsen:String       = 'maxsen';
	public static const BonusName_maxlust:String      = 'maxlust';
	public static const BonusName_maxhp:String        = 'maxhp';
	public static const BonusName_maxfatigue:String   = 'maxfatigue';
	public static const BonusName_maxsoulforce:String = 'maxsoulforce';
	public static const BonusName_defense:String      = 'defense';
	public static const BonusNames:/*String*/Array    = [
		BonusName_maxstr,
		BonusName_maxtou,
		BonusName_maxspe,
		BonusName_maxint,
		BonusName_maxwis,
		BonusName_maxlib,
		BonusName_minsen,
		BonusName_maxsen,
		BonusName_maxlust,
		BonusName_maxhp,
		BonusName_maxfatigue,
		BonusName_maxsoulforce,
		BonusName_defense
	];
	
	/**
	 * @param metrics object{metricName:metricValue}
	 * @return object{raceName:raceScore}
	 */
	public static function AllScoresFor(ch:Creature, metrics:* = null):* {
		Utils.Begin("Race", "AllScoresFor");
		if (metrics == null) metrics = MetricsFor(ch);
		var result:* = {};
		for each (var race:Race in RegisteredRaces) {
			result[race.name] = race.scoreFor(ch, metrics);
		}
		Utils.End("Race", "AllScoresFor");
		return result;
	}
	public static function AllBonusesFor(ch:Creature, scores:* = null):* {
		Utils.Begin("Race", "AllBonusesFor");
		if (scores == null) scores = ch.racialScores();
		var result:* = {};
		for each (var bonus:String in BonusNames) {
			result[bonus] = 0;
		}
		for each(var race:Race in RegisteredRaces) {
			var bonuses:* = race.bonusesForScore(scores[race.name]);
			for (bonus in bonuses) {
				var value:int = result[bonus];
				value += bonuses[bonus];
				result[bonus] = value;
			}
		}
		Utils.End("Race", "AllBonusesFor");
		return result;
	}
	/**
	 * Returns list of perks that not present but should be added because enouch score,
	 * and those present but should be removed because too low score.
	 * @param score racial score
	 * @return array[object{
	 *     add:Boolean,
	 *     race:name,
	 *     perk:PerkType,
	 *     text:String
	 *  }]
	 */
	public static function AllPerksToAddOrRemoveFor(ch:Creature, scores:* = null):Array {
		// Lists of perks to add and perks to remove
		var add:Array = [],rem:Array = [];
		// List of perks NOT TO REMOVE.
		// We'll keep all unlocked racial perks here
		// and remove them from `rem`
		var dontrem:/*PerkType*/Array = [];
		for each (var race:Race in RegisteredRaces) {
			var score:int = scores[race.name]||0;
			for each (var rp:* in race.racialPerks) {
				if (score < rp.minScore && ch.hasPerk(rp.perk)) {
					rem.push({
						add:false,
						race:race.name,
						perk:rp.perk,
						text:rp.loseText
					});
				}
				if (score >= rp.minScore) {
					dontrem.push(rp.perk);
					if (!ch.hasPerk(rp.perk)) {
						add.push({
							add:true,
							race:race.name,
							perk:rp.perk,
							text:rp.gainText
						});
					}
				}
			}
		}
		for each (rp in rem) {
			if (dontrem.indexOf(rp.perk) < 0) add.push(rp);
		}
		return add;
	}
	
	public static var HUMAN:Race = new Race("human")
			.simpleScores({
				'face'       : [Face.HUMAN, +1],
				'eyes'       : [Eyes.HUMAN, +1],
				'ears'       : [
					Ears.HUMAN, +1,
					Ears.ELVEN, -7
				],
				'tongue'     : [Tongue.HUMAN, +1],
				'gills'      : [Gills.NONE, +1],
				'antennae'   : [Antennae.NONE, +1],
				'horns.count': [0, +1],
				'wings'      : [Wings.NONE, +1],
				'tail'       : [Tail.NONE, +1],
				'arms'       : [Arms.HUMAN, +1],
				'legs'       : [LowerBody.HUMAN, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.normalCocks() >= 1 || (ch.hasVagina() && ch.vaginaType() == 0))
							score++;
						if (ch.breastRows.length == 1 && ch.hasPlainSkinOnly() && ch.skinAdj != "slippery")
							score++;
						if (ch.hasPlainSkinOnly() && ch.skinAdj != "slippery")
							score++;
						var racialPerks:/*PerkType*/Array = [PerkLib.BlackHeart,
							PerkLib.CatlikeNimbleness,
							PerkLib.CatlikeNimblenessEvolved,
							PerkLib.DraconicLungs,
							PerkLib.DraconicLungsEvolved,
							PerkLib.GorgonsEyes,
							PerkLib.KitsuneThyroidGland,
							PerkLib.KitsuneThyroidGlandEvolved,
							PerkLib.LizanMarrow,
							PerkLib.LizanMarrowEvolved,
							PerkLib.ManticoreMetabolism,
							PerkLib.MantislikeAgility,
							PerkLib.SalamanderAdrenalGlands,
							PerkLib.SalamanderAdrenalGlandsEvolved,
							PerkLib.ScyllaInkGlands,
							PerkLib.TrachealSystem];
						for each (var perk:PerkType in racialPerks) {
							if (!ch.hasPerk(perk)) score++;
						}
						return score;
					}
			).withBonusTier(30,{
				'maxstr': +40,
				'maxtou': +40,
				'maxspe': +40,
				'maxint': +40,
				'maxwis': +40,
				'maxlib': +40,
				'maxsen': +40
			}).withBonusTier(29,{
				'maxstr': +30,
				'maxtou': +30,
				'maxspe': +30,
				'maxint': +30,
				'maxwis': +30,
				'maxlib': +30,
				'maxsen': +30
			}).withBonusTier(28,{
				'maxstr': +20,
				'maxtou': +20,
				'maxspe': +20,
				'maxint': +20,
				'maxwis': +20,
				'maxlib': +20,
				'maxsen': +20
			}).withBonusTier(27,{
				'maxstr': +10,
				'maxtou': +10,
				'maxspe': +10,
				'maxint': +10,
				'maxwis': +10,
				'maxlib': +10,
				'maxsen': +10
			});
	public static var MUTANT:Race = new Race("mutant")
			.simpleScores({
				'gender': [Gender.GENDER_HERM, +1],
				'face'  : [Face.HUMAN, -1],
				'tail'  : [Tail.NONE, -1]
			}).complexScore(-1, {
				'skin'         : Skin.PLAIN,
				'skin.coverage': Skin.COVERAGE_NONE
			}).complexScore(-1, {
				'face'     : Face.HORSE,
				'skin.coat': Skin.FUR
			}).complexScore(-1, {
				'face': Face.HORSE,
				'tail': Tail.HORSE
			}).complexScore(-1, {
				'face'     : Face.DOG,
				'skin.coat': Skin.FUR
			}).complexScore(-1, {
				'face': Face.DOG,
				'tail': Tail.DOG
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						// Compensate so "-1 for human face" becomes "+1 for non-human face"
						score += 3;
						if (ch.cockTotal() > 1)
							score++;
						if (ch.hasFuckableNipples())
							score++;
						if (ch.breastRows.length > 1)
							score++;
						return score;
					}
			);
	
	// ^^^^^ SPECIAL RACES
	// vvvvv NOT-SO-SPECIAL RACES
	
	public static var ALICORN:Race = new Race("alicorn")
			.simpleScores({
				'face'      : [
					Face.HORSE, +2,
					Face.HUMAN, +1
				],
				'ears'      : [Ears.HORSE, +1],
				'eyes.color': [
					"red", +1,
					"blue", +1
				],
				'hair.color': ['white', +1],
				'tail'      : [Tail.HORSE, +1],
				'legs'      : [LowerBody.HOOFED, +1],
				'legs.count': [4, +1],
				'wings'     : [Wings.FEATHERED_ALICORN, +2]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.horns.type == Horns.UNICORN && ch.horns.count < 6)
							score++;
						if (ch.horns.type == Horns.UNICORN && ch.horns.count >= 6)
							score += 2;
						if (ch.hasFur() || ch.hasPlainSkinOnly())
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(6, {
				'maxfatigue'  : +50,
				'maxsoulforce': +150
			}).withBonusTier(11, {
				'maxfatigue'  : 50,
				'maxsoulforce': +150,
				'maxhp'       : +150,
				'maxtou'      : +25,
				'maxspe'      : +50,
				'maxint'      : +90
			});
	
	public static var ALRAUNE:Race = new Race("alraune")
			.simpleScores({
				'face' : [Face.HUMAN, +1],
				'eyes' : [Eyes.HUMAN, +1],
				'ears' : [Ears.ELFIN, +1],
				'arms' : [Arms.PLANT, +1],
				'wings': [Wings.NONE, +1],
				'legs' : [LowerBody.PLANT_FLOWER, +2]
			}).complexScore(+1, {
				'hair'      : [Hair.LEAF, Hair.GRASS],
				'hair.color': 'green'
			}).complexScore(+1, {
				'skin'     : Skin.PLAIN,
				'skin.tone': ["leaf green", "lime green", "turquoise"]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.stamenCocks() > 0) score++;
						return score;
					}
			).withBonusTier(10,{
				'maxtou': +100,
				'maxspe': -50,
				'maxlib': +100
			});
	
	public static var AVIAN:Race = new Race("avian")
			.simpleScores({
				'hair'     : [Hair.FEATHER, +1],
				'face'     : [Face.AVIAN, +1],
				'ears'     : [Ears.AVIAN, +1],
				'tail'     : [Tail.AVIAN, +1],
				'arms'     : [Arms.AVIAN, +1],
				'legs'     : [LowerBody.AVIAN, +1],
				'wings'    : [Wings.FEATHERED_AVIAN, +2],
				'skin.coat': [Skin.FEATHER, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.avianCocks() > 0)
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(4,{
				'maxstr': +15,
				'maxspe': +30,
				'maxint': +15
			}).withBonusTier(9,{
				'maxstr': +30,
				'maxspe': +75,
				'maxint': +30
			});
	
	public static var BAT:Race = new Race("bat")
			.simpleScores({
				'ears' : [
					Ears.BAT, +1,
					Ears.ELFIN, -10
				],
				'wings': [Wings.BAT_ARM, +5],
				'legs' : [LowerBody.HUMAN, +1],
				'face' : [Face.VAMPIRE, +2],
				'eyes' : [Eyes.VAMPIRE, +1],
				'rear' : [RearBody.BAT_COLLAR, +1]
			}).withBonusTier(6,{
				'maxstr': +20,
				'maxspe': +20,
				'maxint': +20,
				'maxlib': +30
			}).withBonusTier(10,{
				'maxstr': +35,
				'maxspe': +35,
				'maxint': +35,
				'maxlib': +45
			});
	
	public static var BEE:Race = new Race("bee")
			.simpleScores({
				'hair.color': [
					'shiny black', +1,
					'black and yellow', +2 // TODO color/color2
				],
				'antennae'  : [Antennae.BEE, +1],
				'arms'      : [Arms.BEE, +1],
				'legs'      : [LowerBody.BEE, +1],
				'tail'      : [Tail.BEE_ABDOMEN, +1],
				'wings'     : [
					Wings.BEE_LIKE_SMALL, +1,
					Wings.BEE_LIKE_LARGE, +2
				]
			}).complexScore(+1, {
				'antennae': Antennae.BEE,
				'face'    : Face.HUMAN
			}).complexScore(+1, {
				'legs'  : LowerBody.BEE,
				'gender': [Gender.GENDER_FEMALE, Gender.GENDER_HERM]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (score > 0 && ch.hasPerk(PerkLib.TrachealSystem))
							score++;
						if (score > 4 && ch.hasPerk(PerkLib.TrachealSystemEvolved))
							score++;
						if (score > 8 && ch.hasPerk(PerkLib.TrachealSystemFinalForm))
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(5,{
				'maxtou': +30,
				'maxspe': +30,
				'maxint': +15
			}).withBonusTier(9,{
				'maxtou': +50,
				'maxspe': +50,
				'maxint': +35
			});
	
	public static var BUNNY:Race = new Race("bunny")
			.simpleScores({
				'face': [Face.BUNNY, +1],
				'tail': [Tail.RABBIT, +1],
				'ears': [Ears.BUNNY, +1],
				'legs': [LowerBody.BUNNY, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						//More than 2 balls reduces bunny score
						if (ch.balls > 2 && score > 0)
							score--;
						//Human skin on bunmorph adds
						if (ch.hasPlainSkin() && score > 1 && ch.skinAdj != "slippery")
							score++;
						//No wings and antennae.type a plus
						if (score > 0 && ch.antennae.type == 0)
							score++;
						if (score > 0 && ch.wings.type == Wings.NONE)
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(4,{
				'maxspe': +10
			});
	
	public static var CAT:Race = new Race("cat")
			.simpleScores({
				'face'     : [
					Face.CAT, +1,
					Face.CAT_CANINES, +1,
					Face.CHESHIRE, -7,
					Face.CHESHIRE_SMILE, -7
				],
				'eyes'     : [
					Eyes.CAT_SLITS, +1,
					Eyes.FERAL, -11,
				],
				'ears'     : [Ears.CAT, +1],
				'tongue'   : [Tongue.CAT, +1],
				'tail'     : [Tail.CAT, +1],
				'arms'     : [Arms.CAT, +1],
				'legs'     : [LowerBody.CAT, +1],
				'horns'    : [
					Horns.DEMON, -2,
					Horns.DRACONIC_X2, -2,
					Horns.DRACONIC_X4_12_INCH_LONG, -2
				],
				'wings'    : [
					Wings.BAT_LIKE_TINY, -2,
					Wings.DRACONIC_SMALL, -2,
					Wings.BAT_LIKE_LARGE, -2,
					Wings.DRACONIC_LARGE, -2,
					Wings.BAT_LIKE_LARGE_2, -2,
					Wings.DRACONIC_HUGE, -2
				],
				'skin.coat': [Skin.FUR, +1]
			}).complexScore(-7, {
				'hair.color'     : "lilac and white striped", // TODO separate into color/color2
				'skin.coat.color': "lilac and white striped" // TODO separate into color/color2/pattern
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, catCounter:int):int {
						if (ch.catCocks() > 0)
							catCounter++;
						if (ch.breastRows.length > 1 && catCounter > 0)
							catCounter++;
						if (ch.breastRows.length == 3 && catCounter > 0)
							catCounter++;
						if (ch.breastRows.length > 3)
							catCounter -= 2;
						if (ch.hasPerk(PerkLib.Flexibility))
							catCounter++;
						if (ch.hasPerk(PerkLib.CatlikeNimbleness))
							catCounter++;
						if (ch.hasPerk(PerkLib.CatlikeNimblenessEvolved))
							catCounter++;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && catCounter >= 3)
							catCounter += 1;
						if (ch.hasPerk(PerkLib.CatlikeNimbleness) && ch.hasPerk(PerkLib.ChimericalBodyAdvancedStage))
							catCounter++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							catCounter += 10;
						return catCounter;
					}
			).withBonusTier(4,{
				'maxspe': +40,
				'maxlib': +20
			}).withBonusTier(8,{
				'maxspe': +60,
				'maxlib': +60
			});
	
	public static var CENTAUR:Race = new Race("centaur")
			.simpleScores({
				'tail'      : [Tail.HORSE, +1],
				'arms'      : [Arms.HUMAN, +1],
				'face'      : [Face.HUMAN, +1],
				'legs'      : [
					LowerBody.HOOFED, +1,
					LowerBody.CLOVEN_HOOFED, +1
				],
				'legs.count': [4, +2],
				'ears'      : [Ears.HUMAN, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.hasPlainSkinOnly())
							score++;
						if (ch.horseCocks() > 0)
							score++;
						if (ch.wings.type != Wings.NONE)
							score -= 3;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						if (ch.horns.type == Horns.UNICORN)
							return 0;
						return score;
					}
			).withBonusTier(8, {
				'maxtou': +80,
				'maxspe': +40,
				'maxhp' : +100
			});
	
	public static var CHESHIRE:Race = new Race("cheshire")
			.simpleScores({
				'eyes'     : [Eyes.CAT_SLITS, +1],
				'ears'     : [Ears.CAT, +1],
				'tongue'   : [Tongue.CAT, +1],
				'tail'     : [Tail.CAT, +1],
				'arms'     : [Arms.CAT, +1],
				'legs'     : [LowerBody.CAT, +1],
				'face'     : [
					Face.CHESHIRE, +2,
					Face.CHESHIRE_SMILE, +2
				],
				'skin.coat': [Skin.FUR, +1]
			}).complexScore(+2, {
				'hair.color'     : "lilac and white striped",
				'skin.coat.color': "lilac and white striped"
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.hasPerk(PerkLib.Flexibility)) score++;
						if (ch.hasPerk(PerkLib.CatlikeNimbleness)) score++;
						if (ch.hasPerk(PerkLib.CatlikeNimblenessEvolved)) score++;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 7)
							score += 1;
						return score;
					}
			).withBonusTier(11,{
				'maxspe': +60,
				'maxint': +80,
				'maxsen': +25
			});
	
	public static var COUATL:Race = new Race("couatl")
			.simpleScores({
				'tongue'   : [Tongue.SNAKE, +1],
				'face'     : [Face.SNAKE_FANGS, +1],
				'arms'     : [Arms.HARPY, +1],
				'ears'     : [Ears.SNAKE, +1],
				'eyes'     : [Eyes.SNAKE, +1],
				'hair'     : [Hair.FEATHER, +1],
				'wings'    : [Wings.FEATHERED_LARGE, +2],
				'legs'     : [LowerBody.NAGA, +2],
				'skin.coat': [Skin.SCALES, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 7)
							score += 1;
						return score;
					}
			).withBonusTier(11,{
				'maxstr': +40,
				'maxtou': +25,
				'maxspe': +100
			});
	
	public static var COW:Race = new Race("cow")
			.simpleScores({
				'face'  : [
					Face.HUMAN, +1,
					Face.COW_MINOTAUR, +1
				],
				'ears'  : [Ears.COW, +1],
				'tail'  : [Tail.COW, +1],
				'legs'  : [LowerBody.HOOFED, +1],
				'horns' : [Horns.COW_MINOTAUR, +1],
				'gender': [
					Gender.GENDER_HERM, -8,
					Gender.GENDER_MALE, -8
				]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (score >= 4) {
							if (ch.biggestTitSize > 4) score++;
							if (ch.hasFur()) score++;
							if (ch.tallness >= 73) score++;
							if (ch.cor >= 20) score++;
							if (ch.hasVagina()) score++;
						}
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 4)
							score += 1;
						return score;
					}
			).withBonusTier(4, {
				'maxstr' : +60,
				'maxtou' : +10,
				'maxspe' : -20,
				'maxint' : -10,
				'maxlib' : +20,
				'maxlust': +25
			}).withBonusTier(10, {
				'maxstr' : +120,
				'maxtou' : +45,
				'maxspe' : -40,
				'maxint' : -20,
				'maxlib' : +45,
				'maxlust': +50
			});
	
	public static var DEMON:Race = new Race("demon")
			.simpleScores({
				'horns' : [
					Horns.DEMON, +1,
					Horns.GOAT, -10
				],
				'tail'  : [Tail.DEMONIC, +1],
				'wings' : [
					Wings.BAT_LIKE_TINY, +1,
					Wings.BAT_LIKE_LARGE, +2,
					Wings.BAT_LIKE_LARGE_2, +4
				],
				'tongue': [
					Tongue.DEMONIC, +1
				],
				'legs'  : [
					LowerBody.DEMONIC_HIGH_HEELS, +1,
					LowerBody.DEMONIC_CLAWS, +1
				]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.cor >= 50 && ch.horns.type == Horns.DEMON && ch.horns.count > 4)
							score++;
						if (ch.cor >= 50 && ch.hasPlainSkinOnly() && ch.skinAdj != "slippery")
							score++;
						if (ch.cor >= 50 && ch.faceType == Face.HUMAN)
							score++;
						if (ch.cor >= 50 && ch.arms.type == Arms.HUMAN)
							score++;
						if (ch.demonCocks() > 0)
							score++;
						if (ch.hasPerk(PerkLib.BlackHeart))
							score++;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 5)
							score += 1;
						if (ch.hasPerk(PerkLib.BlackHeart) && ch.hasPerk(PerkLib.ChimericalBodyAdvancedStage))
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.DemonicLethicite))
							score += 1;
						return score;
					}
			).withBonusTier(5, {
				'maxspe' : +15,
				'maxint' : +15,
				'maxlib' : +45,
				'maxlust': +50
			}).withBonusTier(11, {
				'maxspe' : +30,
				'maxint' : +35,
				'maxlib' : +100,
				'maxlust': +50
			});
	
	public static var DOG:Race = new Race("dog")
			.simpleScores({
				'face': [Face.DOG, +1],
				'ears': [Ears.DOG, +1],
				'tail': [Tail.DOG, +1],
				'legs': [LowerBody.DOG, +1]
			}).withFinalizerScript(function (ch:Creature, metrics:*, score:int):int {
				if (ch.dogCocks() > 0)
					score++;
				if (ch.breastRows.length > 1)
					score++;
				if (ch.breastRows.length == 3)
					score++;
				if (ch.breastRows.length > 3)
					score--;
				//Fur only counts if some canine features are present
				if (ch.hasFur() && score > 0)
					score++;
				if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
					score += 10;
				if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
					score += 1;
				return score;
			}).withBonusTier(4,{
				'maxspe': +15,
				'maxint': -5
			});
	
	public static var DEER:Race = new Race("deer")
			.simpleScores({
				'ears': [Ears.DEER, +1],
				'tail': [Tail.DEER, +1],
				'face': [Face.DEER, +1],
				'legs': [
					LowerBody.CLOVEN_HOOFED, +1,
					LowerBody.DEERTAUR, +1
				]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.horns.type == Horns.ANTLERS && ch.horns.count >= 4)
							score++;
						if (score >= 2 && ch.skinType == Skin.FUR)
							score++;
						if (score >= 3 && ch.countCocksOfType(CockTypesEnum.HORSE) > 0)
							score++;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(4,{
				'maxspe': +20
			});
	
	public static var DEVILKIN:Race = new Race("devilkin")
			.simpleScores({
				'legs' : [LowerBody.HOOFED, +1],
				'tail' : [
					Tail.GOAT, +1,
					Tail.DEMONIC, +1
				],
				'wings': [
					Wings.BAT_LIKE_TINY, +4,
					Wings.BAT_LIKE_LARGE, +4
				],
				'arms' : [Arms.DEVIL, +1],
				'horns': [Horns.GOAT, +1],
				'ears' : [Ears.GOAT, +1],
				'face' : [Face.DEVIL_FANGS, +1],
				'eyes' : [Eyes.DEVIL, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.tallness < 48) score++;
						if (ch.cor >= 60) score++;
						return score;
					}
			).withBonusTier(7, {
				'minsen' : +10,
				'maxstr' : +35,
				'maxspe' : -10,
				'maxint' : +40,
				'maxlib' : +50,
				'maxsen' : +10,
				'maxlust': +75
			}).withBonusTier(10, {
				'minsen' : +25,
				'maxstr' : +50,
				'maxspe' : -20,
				'maxint' : +60,
				'maxlib' : +75,
				'maxsen' : +15,
				'maxlust': +150
			}).withBonusTier(14, {
				'minsen' : +55,
				'maxspe' : +30,
				'maxint' : +35,
				'maxlib' : +100,
				'maxlust': +150
			});
	
	public static var DRAGON:Race = new Race("dragon")
			.simpleScores({
				'eyes'     : [Eyes.DRAGON, +1],
				'ears'     : [Ears.DRAGON, +1],
				'tail'     : [Tail.DRACONIC, +1],
				'tongue'   : [Tongue.DRACONIC, +1],
				'face'     : [
					Face.DRAGON, +1,
					Face.DRAGON_FANGS, +1,
					Face.JABBERWOCKY, -10,
					Face.BUCKTOOTH, -10
				],
				'wings'    : [
					Wings.DRACONIC_SMALL, +1,
					Wings.DRACONIC_LARGE, +2,
					Wings.DRACONIC_HUGE, +4,
					Wings.FEY_DRAGON_WINGS, -10
				],
				'legs'     : [LowerBody.DRAGON, +1],
				'arms'     : [Arms.DRAGON, +1],
				'horns'    : [
					Horns.DRACONIC_X4_12_INCH_LONG, +2,
					Horns.DRACONIC_X2, +1
				],
				'skin.coat': [Skin.DRAGON_SCALES, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.tallness > 120 && score >= 10)
							score++;
						//	if (dragonCocks() > 0)
						//		dragonCounter++;
						if (ch.hasPerk(PerkLib.DragonFireBreath) && score >= 4)
							score++;
						if (ch.hasPerk(PerkLib.DragonIceBreath) && score >= 4)
							score++;
						if (ch.hasPerk(PerkLib.DragonLightningBreath) && score >= 4)
							score++;
						if (ch.hasPerk(PerkLib.DragonDarknessBreath) && score >= 4)
							score++;
						if (ch.hasPerk(PerkLib.DraconicLungs))
							score++;
						if (ch.hasPerk(PerkLib.DraconicLungsEvolved))
							score++;
						//	if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
						//		dragonCounter += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 4)
							score += 1;
						if (ch.hasPerk(PerkLib.DraconicLungs) && ch.hasPerk(PerkLib.ChimericalBodyAdvancedStage))
							score++;
						return score;
					}
			).withBonusTier(4, {
				'maxstr': +15,
				'maxtou': +15,
				'maxint': +15,
				'maxwis': +15,
				'maxhp' : +100
			}).withBonusTier(10, {
				'defense': 1,
				'maxstr' : +50,
				'maxtou' : +40,
				'maxspe' : +10,
				'maxint' : +20,
				'maxwis' : +20,
				'maxlib' : +10,
				'maxhp'  : +200
			}).withBonusTier(20, {
				'defense'   : 4,
				'maxstr'    : +95,
				'maxtou'    : +95,
				'maxspe'    : +20,
				'maxint'    : +40,
				'maxwis'    : +40,
				'maxlib'    : +10,
				'maxfatigue': +100,
				'maxhp'     : +300,
				'maxlust'   : +25
			}).withBonusTier(28, {
				'defense'   : 10,
				'maxstr'    : +100,
				'maxtou'    : +100,
				'maxspe'    : +40,
				'maxint'    : +50,
				'maxwis'    : +50,
				'maxlib'    : +20,
				'maxfatigue': +200,
				'maxhp'     : +400,
				'maxlust'   : +50
			});
	
	public static var DRAGONNE:Race = new Race("dragonne")
			.simpleScores({
				'face'  : [Face.CAT, +1],
				'ears'  : [Ears.CAT, +1],
				'tail'  : [Tail.CAT, +1],
				'tongue': [Tongue.DRACONIC, +1],
				'wings' : [
					Wings.DRACONIC_LARGE, +2,
					Wings.DRACONIC_SMALL, +1
				],
				'legs'  : [LowerBody.CAT, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.skinType == Skin.SCALES && score > 0)
							score++;
						return score;
					}
			);
	
	public static var ECHIDNA:Race = new Race("echidna")
			.simpleScores({
				'ears'  : [Ears.ECHIDNA, +1],
				'tail'  : [Tail.ECHIDNA, +1],
				'face'  : [Face.ECHIDNA, +1],
				'tongue': [Tongue.ECHIDNA, +1],
				'legs'  : [LowerBody.ECHIDNA, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (score >= 2 && ch.skinType == Skin.FUR)
							score++;
						if (score >= 2 && ch.countCocksOfType(CockTypesEnum.ECHIDNA) > 0)
							score++;
						return score;
					}
			);
	
	public static var ELF:Race = new Race("elf")
			.simpleScores({
				'ears'      : [Ears.ELVEN, +1],
				'eyes'      : [Eyes.ELF, +1],
				'tongue'    : [Tongue.ELF, +1],
				'arms'      : [Arms.ELF, +1],
				'legs'      : [LowerBody.ELF, +1],
				'hair'      : [Hair.SILKEN, +1],
				'hair.color': [
					'black', +1,
					'leaf green', +1,
					'golden blonde', +1,
					'silver', +1
				],
				'skin.tone' : [
					'dark', +1,
					'light', +1,
					'tan', +1
				]
			}).complexScore(+2, {
				'skin'    : Skin.PLAIN,
				'skin.adj': 'flawless'
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.biggestCockLength() < 6)
							score++;
						if (ch.hasVagina() && ch.biggestTitSize() >= BreastCup.C)
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(5, {
				'minsen': 15,
				'maxstr': -10,
				'maxtou': -10,
				'maxspe': +40,
				'maxint': +40,
				'maxwis': +30,
				'maxsen': +15
			}).withBonusTier(11, {
				'minsen': 30,
				'maxstr': -10,
				'maxtou': -15,
				'maxspe': +80,
				'maxint': +80,
				'maxwis': +60,
				'maxsen': +30
			});
	
	public static var FERRET:Race = new Race("ferret")
			.simpleScores({
				'face': [
					Face.FERRET_MASK, +1,
					Face.FERRET, +2
				],
				'ears': [Ears.FERRET, +1],
				'tail': [Tail.FERRET, +1],
				'legs': [LowerBody.FERRET, +1]
			}).withFinalizerScript(function (ch:Creature, metrics:*, score:int):int {
				if (ch.hasFur() && score > 0) score++;
				return score;
			});
	
	public static var FOX:Race = new Race("fox")
			.simpleScores({
				'face': [Face.FOX, +1],
				'eyes': [Eyes.FOX, +1],
				'ears': [Ears.FOX, +1],
				'tail': [Tail.FOX, +1],
				'arms': [Arms.FOX, +1],
				'legs': [LowerBody.FOX, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.tailType == Tail.FOX && ch.tailCount >= 2) score -= 7;
						if (ch.foxCocks() > 0 && score > 0) score++;
						if (ch.breastRows.length > 1 && score > 0) score++;
						if (ch.breastRows.length == 3 && score > 0) score++;
						if (ch.breastRows.length == 4 && score > 0) score++;
						//Fur only counts if some canine features are present
						if (ch.hasFur() && score > 0) score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(4,{
				'maxstr': -5,
				'maxspe': +40,
				'maxint': +25
			}).withBonusTier(7,{
				'maxstr': -30,
				'maxspe': +80,
				'maxint': +55,
				'maxfatigue': +20
			});
	
	public static var GARGOYLE:Race = new Race("gargoyle")
			.simpleScores({
				'horns'     : [Horns.GARGOYLE, +1],
				'eyes'      : [Eyes.GEMSTONES, +1],
				'ears'      : [Ears.ELFIN, +1],
				'face'      : [Face.DEVIL_FANGS, +1],
				'tongue'    : [Tongue.DEMONIC, +1],
				'hair.color': [
					"light grey", +1,
					"quartz white", +1
				],
				'arms'      : [
					Arms.GARGOYLE, +1,
					Arms.GARGOYLE_2, +1
				],
				'tail'      : [
					Tail.GARGOYLE, +1,
					Tail.GARGOYLE_2, +1
				],
				'legs'      : [
					LowerBody.GARGOYLE, +1,
					LowerBody.GARGOYLE_2, +1
				],
				'skin'      : [Skin.STONE, +1],
				'skin.tone' : [
					"light grey", +1,
					"quartz white", +1
				],
				'hair'      : [Hair.NORMAL, +1],
				'wings'     : [Wings.GARGOYLE_LIKE_LARGE, +4]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.hasPerk(PerkLib.GargoylePure) || ch.hasPerk(PerkLib.GargoyleCorrupted))
							score++;
						if (ch.hasPerk(PerkLib.TransformationImmunity))
							score += 4;
						return score;
					}
			).withBonusTier(21,{
				'maxstr':+70,
				'maxtou':+100,
				'maxint':+70
			});
	
	public static var GoblinSkinColors:/*String*/Array = ["pale yellow", "grayish-blue", "green", "dark green"];
	public static var GOBLIN:Race                      = new Race("goblin")
			.simpleScores({
				'ears': [Ears.ELFIN, +1]
			}).complexScore(+1, {
				// Moved from simpleScores for readability
				'skin.tone': GoblinSkinColors
			}).complexScore(+1, {
				'skin.tone': GoblinSkinColors,
				'face'     : Face.HUMAN
			}).complexScore(+1, {
				'skin.tone': GoblinSkinColors,
				'legs'     : LowerBody.HUMAN
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (GoblinSkinColors.indexOf(ch.skinTone) >= 0) {
							if (ch.tallness < 48 && score > 0)
								score++;
							if (ch.hasVagina())
								score++;
						}
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(4,{
				'maxint': +20
			});
	
	public static var GOO:Race = new Race("goo")
			.simpleScores({
				'hair' : [Hair.GOO, +1],
				'wings': [Wings.NONE, +1],
				'legs' : [LowerBody.GOO, +2]
			}).complexScore(+1, {
				'skin'    : Skin.GOO,
				'skin.adj': 'slimy'
			}).complexScore(+1, {
				// TODO could optimize these by big - if not goo & slimy skin
				'skin'    : Skin.GOO,
				'skin.adj': 'slimy',
				'face'    : Face.HUMAN
			}).complexScore(+1, {
				// TODO could optimize these by big - if not goo & slimy skin
				'skin'    : Skin.GOO,
				'skin.adj': 'slimy',
				'arms'    : Arms.HUMAN
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.vaginalCapacity() > 9000)
							score++;
						if (ch.hasStatusEffect(StatusEffects.SlimeCraving))
							score++;
						if (ch.hasPerk(PerkLib.SlimeCore))
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 4)
							score += 1;
						return score;
					}
			).withBonusTier(4,{
				'maxtou': +40,
				'maxspe': -20,
				'maxlib': +40
			}).withBonusTier(8,{
				'maxtou': +80,
				'maxspe': -40,
				'maxlib': +80
			});
	
	public static var GORGON:Race = new Race("gorgon")
			.simpleScores({
				'tongue'   : [Tongue.SNAKE, +1],
				'face'     : [Face.SNAKE_FANGS, +1],
				'arms'     : [Arms.HUMAN, +1],
				'ears'     : [Ears.SNAKE, +1],
				'eyes'     : [
					Eyes.SNAKE, +1,
					Eyes.GORGON, +2
				],
				'legs'     : [LowerBody.NAGA, +2],
				'skin.coat': [Skin.SCALES, +1],
				'hair'     : [Hair.GORGON, +2]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.hasPerk(PerkLib.GorgonsEyes))
							score++;
						if (ch.antennae.type != Antennae.NONE)
							score -= 3;
						if (ch.wings.type != Wings.NONE)
							score -= 3;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 7)
							score += 1;
						if (ch.hasPerk(PerkLib.GorgonsEyes) && ch.hasPerk(PerkLib.ChimericalBodyAdvancedStage))
							score++;
						return score;
					}
			).withBonusTier(11,{
				'maxstr': +50,
				'maxtou': +45,
				'maxspe': +70,
				'maxhp' : +50
			});
	
	public static var HARPY:Race = new Race("harpy")
			.simpleScores({
				'arms' : [Arms.HARPY, +1],
				'hair' : [Hair.FEATHER, +1],
				'wings': [Wings.FEATHERED_LARGE, +2],
				'tail' : [
					Tail.HARPY, +1,
					Tail.SHARK, -5,
					Tail.SALAMANDER, -5
				],
				'legs' : [
					LowerBody.HARPY, +1,
					LowerBody.SALAMANDER, -1
				],
				'face' : [Face.SHARK_TEETH, -1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (score >= 2 && ch.faceType == Face.HUMAN)
							score++;
						if (score >= 2 && (ch.ears.type == Ears.HUMAN || ch.ears.type == Ears.ELFIN))
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(4,{
				'maxtou': -10,
				'maxspe': +40,
				'maxlib': +30
			}).withBonusTier(8,{
				'maxtou': -20,
				'maxspe': +80,
				'maxlib': +60
			});
	
	public static var HORSE:Race = new Race("horse")
			.simpleScores({
				'face'     : [Face.HORSE, +1],
				'ears'     : [Ears.HORSE, +1],
				'tail'     : [Tail.HORSE, +1],
				'legs'     : [
					LowerBody.HOOFED, +1,
					LowerBody.CENTAUR, +1
				],
				'skin.coat': [Skin.FUR, +1]
			}).complexScore(+1, {
				'skin.coat': Skin.FUR,
				'arms'     : Arms.HUMAN
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.horseCocks() > 0)
							score++;
						if (ch.isTaur())
							score -= 5;
//						if (ch.racialScores[Race.UNICORN.name] > 8 || ch.racialScores[Race.ALICORN.name] > 10) TODO conflicting races
//							score -= 5;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(4,{
				'maxspe': +40,
				'maxtou': +20,
				'maxhp' : +35
			}).withBonusTier(7,{
				'maxspe': +70,
				'maxtou': +35,
				'maxhp' : +70
			});
	
	public static var JABBERWOCKY:Race = new Race("jabberwocky")
			.simpleScores({
				'face'     : [
					Face.JABBERWOCKY, +1,
					Face.BUCKTOOTH, +1,
					Face.DRAGON, -10,
					Face.DRAGON_FANGS, -10
				],
				'eyes'     : [Eyes.DRAGON, +1],
				'ears'     : [Ears.DRAGON, +1],
				'tail'     : [Tail.DRACONIC, +1],
				'tongue'   : [Tongue.DRACONIC, +1],
				'wings'    : [
					Wings.FEY_DRAGON_WINGS, +4,
					Wings.DRACONIC_SMALL, -10,
					Wings.DRACONIC_LARGE, -10,
					Wings.DRACONIC_HUGE, -10
				],
				'legs'     : [LowerBody.DRAGON, +1],
				'arms'     : [Arms.DRAGON, +1],
				'horns'    : [
					Horns.DRACONIC_X4_12_INCH_LONG, +2,
					Horns.DRACONIC_X2, +1
				],
				'skin.coat': [Skin.DRAGON_SCALES, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.tallness > 120 && score >= 10)
							score++;
						//	if (dragonCocks() > 0)
						//		dragonCounter++;
						if (ch.hasPerk(PerkLib.DragonFireBreath) && score >= 4)
							score++;
						if (ch.hasPerk(PerkLib.DragonIceBreath) && score >= 4)
							score++;
						if (ch.hasPerk(PerkLib.DragonLightningBreath) && score >= 4)
							score++;
						if (ch.hasPerk(PerkLib.DragonDarknessBreath) && score >= 4)
							score++;
						if (ch.hasPerk(PerkLib.DraconicLungs))
							score++;
						if (ch.hasPerk(PerkLib.DraconicLungsEvolved))
							score++;
						//	if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
						//		dragonCounter += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 4)
							score += 1;
						if (ch.hasPerk(PerkLib.DraconicLungs) && ch.hasPerk(PerkLib.ChimericalBodyAdvancedStage))
							score++;
						return score;
					}
			).withBonusTier(4,{
				'maxstr': +15,
				'maxtou': +15,
				'maxspe': +30,
				'maxint': +15,
				'maxwis': -15
			}).withBonusTier(10,{
				'maxstr': +50,
				'maxtou': +40,
				'maxspe': +50,
				'maxint': +20,
				'maxwis': -20,
				'maxlib': +10
			}).withBonusTier(20,{
				'maxstr': +95,
				'maxtou': +95,
				'maxspe': +100,
				'maxint': +40,
				'maxwis': -50,
				'maxlib': +20
			});
	
	public static var KANGA:Race = new Race("kangaroo")
			.simpleScores({
				'ears': [Ears.KANGAROO, +1],
				'tail': [Tail.KANGAROO, +1],
				'legs': [LowerBody.KANGAROO, +1],
				'face': [Face.KANGAROO, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.kangaCocks() > 0)
							score++;
						if (score >= 2 && ch.hasFur())
							score++;
						return score;
					}
			).withBonusTier(4,{
				'maxtou': +5,
				'maxspe': +15
			});
	
	public static var KITSHOO:Race = new Race("kitshoo")
			.simpleScores({
				'ears'     : [Ears.FOX, +1],
				'skin'     : [Skin.GOO, -3],
				'skin.coat': [Skin.CHITIN, -2]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						//If the character has a fox tail, +1
						//	if (tailType == FOX)
						//		score++;
						//If the character has two to eight fox tails, +2
						//	if (tailType == FOX && tailCount >= 2 && tailCount < 9)
						//		score += 2;
						//If the character has nine fox tails, +3
						//	if (tailType == FOX && tailCount == 9)
						//		score += 3;
						//If the character has tattooed skin, +1
						//9999
						//If the character has a 'vag of holding', +1
						//	if (vaginalCapacity() >= 8000)
						//		score++;
						//If the character's kitshoo score is greater than 0 and:
						//If the character has a normal face, +1
						if (score > 0 && (ch.faceType == Face.HUMAN || ch.faceType == Face.FOX))
							score++;
						//If the character's kitshoo score is greater than 1 and:
						//If the character has "blonde","black","red","white", or "silver" hair, +1
						if (score > 0 && ch.hasFur() && (Utils.InCollection(ch.coatColor, KitsuneHairColors) || Utils.InCollection(ch.coatColor, KitsuneElderColors)))
							score++;
						//If the character's femininity is 40 or higher, +1
						//	if (score > 0 && femininity >= 40)
						//		score++;
						//If the character has fur, chitin, or gooey skin, -1
						//	if (skinType == FUR && !InCollection(furColor, KitsuneScene.basicKitsuneFur) && !InCollection(furColor, KitsuneScene.elderKitsuneColors))
						//		score--;
						//	if (skinType == SCALES)
						//		score -= 2; - czy bedzie pozytywny do wyniku czy tez nie?
						//If the character has abnormal legs, -1
						//	if (lowerBody != HUMAN && lowerBody != FOX)
						//		score--;
						//If the character has a nonhuman face, -1
						//	if (faceType != HUMAN && faceType != FOX)
						//		score--;
						//If the character has ears other than fox ears, -1
						//	if (earType != FOX)
						//		score--;
						//If the character has tail(s) other than fox tails, -1
						//	if (tailType != FOX)
						//		score--;
						//When character get one of 9-tail perk
						//	if (score >= 3 && (hasPerk(PerkLib.EnlightenedNinetails) || hasPerk(PerkLib.CorruptedNinetails)))
						//		score += 2;
						//When character get Hoshi no tama
						//	if (hasPerk(PerkLib.KitsuneThyroidGland))
						//		score++;
						//	if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
						//		score += 10;
						return score;
					}
			);
	
	public static const KitsuneHairColors:/*String*/Array  = ["white", "black", "black", "black", "red", "red", "red"];
	public static const KitsuneFurColors:/*String*/Array   = ["orange and white", "black", "black and white", "red", "red and white", "white"];
	public static const KitsuneElderColors:/*String*/Array = ["metallic golden", "golden blonde", "metallic silver", "silver blonde", "snow white", "iridescent gray"];
	public static var KITSUNE:Race                         = new Race("kitsune")
			.simpleScores({
				'eyes'             : [Eyes.FOX, +1],
				'ears'             : [Ears.FOX, +1],
				'arms'             : [
					Arms.HUMAN, +1,
					Arms.KITSUNE, +1
				],
				'legs'             : [
					LowerBody.FOX, +1,
					LowerBody.HUMAN, +1
				],
				'face'             : [
					Face.HUMAN, +1,
					Face.FOX, +1
				],
				// TODO wasn't +2 for tattoo and fur
				'skin.base.pattern': [Skin.PATTERN_MAGICAL_TATTOO, +1],
				'skin.coat'        : [Skin.FUR, +1]
			}).complexScore(-7, {
				'tail'      : Tail.FOX,
				'tail.count': 1
			}).complexScore(+1, {
				'tail'      : Tail.FOX,
				'tail.count': [2, 3]
			}).complexScore(+2, {
				'tail'      : Tail.FOX,
				'tail.count': [4, 5]
			}).complexScore(+3, {
				'tail'      : Tail.FOX,
				'tail.count': [6, 7, 8]
			}).complexScore(+4, {
				'tail'      : Tail.FOX,
				'tail.count': 9
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						// TODO make global -1, and add +1 to Fox Ears?
						if (ch.ears.type != Ears.FOX)
							score--;
						if (ch.tailType != Tail.FOX)
							score -= 7;
						//If the character has fur, scales, or gooey skin, -1
						//	if (skinType == FUR && !InCollection(furColor, KitsuneScene.basicKitsuneFur) && !InCollection(furColor, KitsuneScene.elderKitsuneColors))
						//		kitsuneCounter--;
						if (ch.hasCoat() && !ch.hasCoatOfType(Skin.FUR))
							score -= 2;
						if (ch.skin.base.type != Skin.PLAIN)
							score -= 3;
						if (ch.lowerBody != LowerBody.HUMAN && ch.lowerBody != LowerBody.FOX)
							score--;
						//If the character has a 'vag of holding', +1
						if (ch.vaginalCapacity() >= 8000)
							score++;
						if (ch.faceType != Face.HUMAN && ch.faceType != Face.FOX)
							score--;
						//If the character has "blonde","black","red","white", or "silver" hair, +1
						//	if (kitsuneCounter > 0 && (InCollection(furColor, KitsuneScene.basicKitsuneHair) || InCollection(furColor, KitsuneScene.elderKitsuneColors)))
						//		kitsuneCounter++;
						if (ch.hasPerk(PerkLib.StarSphereMastery))
							score++;
						//When character get Hoshi no tama
						if (ch.hasPerk(PerkLib.KitsuneThyroidGland))
							score++;
						if (ch.hasPerk(PerkLib.KitsuneThyroidGlandEvolved))
							score++;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 5)
							score += 1;
						if (ch.hasPerk(PerkLib.KitsuneThyroidGland) && ch.hasPerk(PerkLib.ChimericalBodyAdvancedStage))
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						return score;
					}
			).withBonusTier(5, {
				'maxstr'    : -35,
				'maxspe'    : +20,
				'maxint'    : +30,
				'maxwis'    : +40,
				'maxlib'    : +20,
				'maxfatigue': +100
			}).withBonusTier(12, {
				'maxstr'    : -50,
				'maxspe'    : +40,
				'maxint'    : +70,
				'maxwis'    : +100,
				'maxlib'    : +20,
				'maxfatigue': +300
			});
	
	public static var LIZARD:Race = new Race("lizard")
			.simpleScores({
				'face' : [Face.LIZARD, +1],
				'ears' : [Ears.LIZARD, +1],
				'eyes' : [Eyes.REPTILIAN, +1],
				'tail' : [Tail.LIZARD, +1],
				'arms' : [Arms.LIZARD, +1],
				'legs' : [LowerBody.LIZARD, +1],
				'horns': [
					Horns.DRACONIC_X2, +1,
					Horns.DRACONIC_X4_12_INCH_LONG, +1
				]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.hasScales())
							score++;
						if (ch.lizardCocks() > 0)
							score++;
						if (score > 0 && ch.hasPerk(PerkLib.LizanRegeneration))
							score++;
						if (ch.hasPerk(PerkLib.LizanMarrow))
							score++;
						if (ch.hasPerk(PerkLib.LizanMarrowEvolved))
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.LizanMarrow) && ch.hasPerk(PerkLib.ChimericalBodyAdvancedStage))
							score++;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 4)
							score += 1;
						return score;
					}
			).withBonusTier(4, {
				'maxtou'    : +40,
				'maxint'    : +20,
				'maxfatigue': +30
			}).withBonusTier(8, {
				'maxint'    : +70,
				'maxlib'    : +50,
				'maxfatigue': +30
			});
	
	public static var MANTICORE:Race = new Race("manticore")
			.simpleScores({
				'face'  : [Face.MANTICORE, +1],
				'eyes'  : [Eyes.MANTICORE, +1],
				'ears'  : [Ears.LION, +1],
				'rear'  : [RearBody.LION_MANE, +1],
				'arms'  : [Arms.LION, +1],
				'legs'  : [LowerBody.LION, +1],
				'tongue': [Tongue.CAT, +1],
				'wings' : [
					Wings.MANTICORE_LIKE_SMALL, +1,
					Wings.MANTICORE_LIKE_LARGE, +2
				],
				'tail'  : [Tail.MANTICORE_PUSSYTAIL, +2]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (!ch.hasCock()) score++;
						else score -= 3;
						if (ch.hasPerk(PerkLib.ManticoreMetabolism))
							score++;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						if (ch.hasPerk(PerkLib.ChimericalBodyAdvancedStage) && ch.hasPerk(PerkLib.ManticoreMetabolism))
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage) && ch.hasPerk(PerkLib.ManticoreMetabolism) && score >= 6)
							score += 1;
						if (ch.hasPerk(PerkLib.ChimericalBodyUltimateStage) && ch.hasPerk(PerkLib.ManticoreMetabolism) && score >= 7)
							score += 1;
						return score;
					}
			).withBonusTier(6, {
				'minsen': 30,
				'maxspe': +50,
				'maxint': +25,
				'maxlib': +30,
				'maxhp' : +50
			}).withBonusTier(12, {
				'minsen': 45,
				'maxspe': +100,
				'maxint': +50,
				'maxlib': +60,
				'maxhp' : +50
			});
	
	public static var MANTIS:Race = new Race("mantis")
			.simpleScores({
				'arms'     : [Arms.MANTIS, +1],
				'legs'     : [LowerBody.MANTIS, +1],
				'tail'     : [Tail.MANTIS_ABDOMEN, +1],
				'wings'    : [
					Wings.MANTIS_LIKE_SMALL, +1,
					Wings.MANTIS_LIKE_LARGE, +2,
					Wings.MANTIS_LIKE_LARGE_2, +4
				],
				'skin.coat': [Skin.CHITIN, +1],
				'antennae' : [Antennae.MANTIS, +1]
			}).complexScore(+1, {
				'antennae': Antennae.MANTIS,
				'face'    : Face.HUMAN
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (score > 0 && ch.hasPerk(PerkLib.TrachealSystem))
							score++;
						if (score > 4 && ch.hasPerk(PerkLib.TrachealSystemEvolved))
							score++;
						if (score > 8 && ch.hasPerk(PerkLib.TrachealSystemFinalForm))
							score++;
						if (ch.hasPerk(PerkLib.MantislikeAgility))
							score++;
						if (ch.hasPerk(PerkLib.MantislikeAgilityEvolved))
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						if (ch.hasPerk(PerkLib.MantislikeAgility) && ch.hasPerk(PerkLib.ChimericalBodyAdvancedStage))
							score++;
						return score;
					}
			).withBonusTier(6,{
				'maxstr': -20,
				'maxtou': +30,
				'maxspe': +70,
				'maxint': +10
			}).withBonusTier(12,{
				'maxstr': -40,
				'maxtou': +60,
				'maxspe': +140,
				'maxint': +20
			});
	
	public static var MINOTAUR:Race = new Race("minotaur")
			.simpleScores({
				'face'  : [
					Face.HUMAN, +1,
					Face.COW_MINOTAUR, +1
				],
				'ears'  : [Ears.COW, +1],
				'tail'  : [Tail.COW, +1],
				'legs'  : [LowerBody.HOOFED, +1],
				'horns' : [Horns.COW_MINOTAUR, +1],
				'gender': [
					Gender.GENDER_FEMALE, -8,
					Gender.GENDER_HERM, -8
				]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (score >= 4) {
							if (ch.cumQ() > 500) score++;
							if (ch.hasFur()) score++;
							if (ch.tallness >= 81) score++;
							if (ch.cor >= 20) score++;
							if (ch.horseCocks() > 0) score++;
						}
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage)) score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 4) score += 1;
						return score;
					}
			).withBonusTier(4, {
				'maxstr' : +60,
				'maxtou' : +10,
				'maxspe' : -10,
				'maxint' : -20,
				'maxlib' : +20,
				'maxlust': +25
			}).withBonusTier(10, {
				'maxstr' : +120,
				'maxtou' : +45,
				'maxspe' : -20,
				'maxint' : -40,
				'maxlib' : +45,
				'maxlust': +50
			});
	
	public static var MOUSE:Race = new Race("mouse")
			.simpleScores({
				'ears': [Ears.MOUSE, +1],
				'tail': [Tail.MOUSE, +1],
				'face': [
					Face.BUCKTEETH, +1,
					Face.MOUSE, +2
				]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						//Fur only counts if some canine features are present
						if (ch.hasFur() && score > 0) score++;
						if (ch.tallness < 55 && score > 0) score++;
						if (ch.tallness < 45 && score > 0) score++;
						return score;
					}
			);
	
	public static var NAGA:Race = new Race("naga")
			.simpleScores({
				'tongue': [Tongue.SNAKE, +1],
				'face'  : [Face.SNAKE_FANGS, +1],
				'arms'  : [Arms.HUMAN, +1],
				'eyes'  : [Eyes.SNAKE, +1],
				'ears'  : [Ears.SNAKE, +1],
				'legs'  : [LowerBody.NAGA, +2]
			}).complexScore(+1, {
				'skin.coverage': Skin.COVERAGE_LOW,
				'skin.coat'    : Skin.SCALES
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						// TODO conflicting races if (racialScores[Race.GORGON.name] > 10 || racialScores[Race.VOUIVRE.name] > 10 || racialScores[Race.COUATL.name] > 10) score -= 8;
						return score;
					}
			).withBonusTier(4,{
				'maxstr': +20,
				'maxspe': +40
			}).withBonusTier(8,{
				'maxstr': +40,
				'maxtou': +20,
				'maxspe': +60
			});
	
	public static var NEKOMATA:Race = new Race("nekomata")
			.simpleScores({
				'face'  : [
					Face.CAT, +1,
					Face.CAT_CANINES, +1
				],
				'eyes'  : [Eyes.CAT_SLITS, +1],
				'ears'  : [Ears.CAT, +1],
				'tongue': [Tongue.CAT, +1],
				'tail'  : [Tail.CAT, +1],
				'arms'  : [Arms.CAT, +1],
				'legs'  : [LowerBody.CAT, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.hasFur()) score++;
						if (ch.hasPerk(PerkLib.Flexibility)) score++;
						if (ch.hasPerk(PerkLib.CatlikeNimbleness)) score++;
						if (ch.hasPerk(PerkLib.CatlikeNimblenessEvolved)) score++;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 7)
							score += 1;
						return score;
					}
			).withBonusTier(11,{
				'maxspe': +40,
				'maxint': +40,
				'maxwis': +85
			});
	
	public static const OniEyeColors:/*String*/Array = ["red", "orange", "yellow"];
	public static var ONI:Race                       = new Race("oni")
			.simpleScores({
				'ears'             : [Ears.ONI, +1],
				'face'             : [Face.ONI_TEETH, +1],
				'horns'            : [Horns.ONI, +1],
				'arms'             : [Arms.ONI, +1],
				'legs'             : [LowerBody.ONI, +1],
				'tail'             : [Tail.NONE, +1],
				'skin.base.pattern': [Skin.PATTERN_BATTLE_TATTOO, +1],
				'skin.tone'        : [
					'red', +1,
					'reddish orange', +1,
					'purple', +1,
					'blue', +1
				]
			}).complexScore(+1, {
				'eyes'      : Eyes.ONI,
				'eyes.color': OniEyeColors
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch is Character && (ch as Character).tone >= 75)
							score++;
						if ((ch.hasVagina() && ch.biggestTitSize() >= BreastCup.H) || (ch.cocks.length > 18))
							score++;
						if (ch.tallness >= 120)
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(6,{
				'maxstr': +50,
				'maxtou': +30,
				'maxint': -10,
				'maxwis': +20
			}).withBonusTier(12,{
				'maxstr': +100,
				'maxtou': +60,
				'maxint': -20,
				'maxwis': +40
			});
	
	public static var ORCA:Race = new Race("orca")
			.simpleScores({
				'ears'             : [Ears.ORCA, +1],
				'tail'             : [Tail.ORCA, +1],
				'face'             : [Face.ORCA, +1],
				'legs'             : [LowerBody.ORCA, +1],
				'arms'             : [Arms.ORCA, +1],
				'rear'             : [RearBody.ORCA_BLOWHOLE, +1],
				'wings'            : [Wings.NONE, +2],
				'eyes'             : [Eyes.HUMAN, +1],
				'skin.base.pattern': [Skin.PATTERN_ORCA_UNDERBODY, +1]
			}).complexScore(+1, {
				'skin'         : Skin.PLAIN,
				'skin.coverage': Skin.COVERAGE_NONE,
				'skin.adj'     : 'glossy'
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.tallness >= 84)
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(6,{
				'maxstr': +35,
				'maxtou': +20,
				'maxspe': +35
			}).withBonusTier(12,{
				'maxstr': +70,
				'maxtou': +40,
				'maxspe': +70
			});
	
	public static var PHOENIX:Race = new Race("phoenix")
			.simpleScores({
				'eyes' : [Eyes.REPTILIAN, +1],
				'wings': [Wings.FEATHERED_PHOENIX, +1],
				'arms' : [Arms.PHOENIX, +1],
				'legs' : [LowerBody.SALAMANDER, +1],
				'tail' : [Tail.SALAMANDER, +1],
				'hair' : [Hair.FEATHER, +1]
			}).complexScore(+1, {
				'hair': Hair.FEATHER,
				'face': Face.HUMAN
			}).complexScore(+1, {
				'hair': Hair.FEATHER,
				'ears': Ears.HUMAN
			}).complexScore(+1, {
				'skin.coat'    : Skin.SCALES,
				'skin.coverage': Skin.COVERAGE_LOW
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.lizardCocks() > 0)
							score++;
						if (ch.hasPerk(PerkLib.PhoenixFireBreath))
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(5, {
				'maxlust': +25
			}).withBonusTier(10, {
				'maxstr' : +20,
				'maxtou' : +20,
				'maxspe' : +70,
				'maxlib' : +40,
				'maxlust': +25
			}).withRacialPerk(10,PerkLib.FireAffinity,
					"You suddenly feels your body temperature rising to ridiculus level. You pant for several minutes until your finaly at ease with your bodily heat. You doubt any more heat is gunna make you more incomfortable then this as you quietly soak in the soothing warmth your body naturaly produce. Its like your body is made out of living fire.\n\n(<b>Gained Perk: Fire Affinity</b>)",
					"You suddenly feel chilly as your bodily temperature drop down to human level. You lost your natural warmth reverting to that of a standard human.\n\n<b>(Lost Perk: Fire Affinity)</b>"
			);
	
	public static var PIG:Race = new Race("pig")
			.simpleScores({
				'ears': [Ears.PIG, +1],
				'tail': [Tail.PIG, +1],
				'legs': [LowerBody.CLOVEN_HOOFED, +2],
				'face': [
					Face.PIG, +1,
					Face.BOAR, +1
				]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.pigCocks() > 0) score++;
						return score;
					}
			);
	
	public static var PLANT:Race = new Race("plant")
			.simpleScores({
				'face' : [
					Face.HUMAN, +1,
					Face.PLANT_DRAGON, -1
				],
				'ears' : [
					Ears.ELFIN, +1,
					Ears.LIZARD, -1
				],
				'arms' : [Arms.PLANT, +1],
				'horns': [
					Horns.OAK, +1,
					Horns.ORCHID, +1
				],
				'legs' : [
					LowerBody.PLANT_HIGH_HEELS, +1,
					LowerBody.PLANT_ROOT_CLAWS, +1
				],
				'wings': [Wings.PLANT, +1]
			}).complexScore(+1, {
				'hair.color': 'green',
				'hair'      : [Hair.LEAF, Hair.GRASS]
			}).complexScore(+1, {
				'skin'         : Skin.PLAIN,
				'skin.coverage': Skin.COVERAGE_NONE,
				'skin.tone'    : ["leaf green", "lime green", "turquoise"]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if ((ch.lowerBody == LowerBody.PLANT_HIGH_HEELS || ch.lowerBody == LowerBody.PLANT_ROOT_CLAWS) && ch.tentacleCocks() > 0)
							score++;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						// TODO conflicting races
//						if (racialScores[Race.ALRAUNE.name] >= 10)
//							score -= 7;
//						if (racialScores[Race.YGGDRASIL.name] >= 10)
//							score -= 4;
						return score;
					}
			).withBonusTier(4, {
				'defense': 2,
				'maxtou': +30,
				'maxspe': -10
			}).withBonusTier(5, {
				'defense': 4,
				'maxstr': +10,
				'maxtou': +50,
				'maxspe': -20
			}).withBonusTier(6, {
				'defense': 8,
				'maxstr': +20,
				'maxtou': +80,
				'maxspe': -40
			}).withBonusTier(7, {
				'defense': 10,
				'maxstr': +25,
				'maxtou': +100,
				'maxspe': -50
			});
	
	public static var RACCOON:Race = new Race("raccoon")
			.simpleScores({
				'face': [
					Face.RACCOON_MASK, +1,
					Face.RACCOON, +2
				],
				'ears': [Ears.RACCOON, +1],
				'tail': [Tail.RACCOON, +1],
				'legs': [LowerBody.RACCOON, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.balls > 0 && score > 0) score++;
						//Fur only counts if some canine features are present
						if (ch.hasFur() && score > 0) score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(4,{
				'maxspe': +15
			});
	
	public static var RAIJU:Race = new Race("raiju")
			.simpleScores({
				'ears'             : [Ears.WEASEL, +1],
				'eyes'             : [Eyes.RAIJU, +1],
				'face'             : [Face.RAIJU_FANGS, +1],
				'arms'             : [Arms.RAIJU, +1],
				'legs'             : [LowerBody.RAIJU, +1],
				'tail'             : [Tail.RAIJU, +1],
				'rear'             : [RearBody.RAIJU_MANE, +1],
				'hair'             : [Hair.STORM, +1],
				'hair.color'       : [
					"purple", +1,
					"light blue", +1,
					"yellow", +1,
					"white", +1
				],
				'skin.base.pattern': [Skin.PATTERN_LIGHTNING_SHAPED_TATTOO, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(5, {
				'minsen': 25,
				'maxspe': +35,
				'maxint': +25,
				'maxlib': +40,
				'maxsen': +25
			}).withBonusTier(10, {
				'minsen': 50,
				'maxspe': +70,
				'maxint': +50,
				'maxlib': +80,
				'maxsen': +50
			}).withRacialPerk(7,PerkLib.LightningAffinity,
					"You suddenly feel a rush of electricity run across your skin as your arousal builds up and begin to masturbate in order to get rid of your creeping desire. However even after achieving orgasm not only are you still aroused but you are even hornier than before! You realise deep down that the only way for you to be freed from this jolting pleasure is to have sex with a partner!\n\n(<b>Gained the lightning affinity perk, electrified desire perk and Orgasmic lightning strike ability!</b>)",
					"Your natural electricity production start dropping at a dramatic rate until finally there is no more. You realise you likely aren’t raiju enough to build electricity anymore which, considering you can reach satisfaction again, might not be a bad thing.\n\n<b>(Lost the lightning affinity perk, electrified desire perk and Orgasmic lightning strike ability!)</b>"
			).withRacialPerk(7,PerkLib.ElectrifiedDesire,"","");
	
	public static var REDPANDA:Race = new Race("red panda")
			.simpleScores({
				'face': [Face.RED_PANDA, +2],
				'ears': [Ears.RED_PANDA, +1],
				'tail': [Tail.RED_PANDA, +1],
				'arms': [Arms.RED_PANDA, +1],
				'legs': [LowerBody.RED_PANDA, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						if (score >= 2 && ch.skin.base.pattern == Skin.PATTERN_RED_PANDA_UNDERBODY)
							score++;
						if (score >= 2 && ch.skinType == Skin.FUR)
							score++;
						return score;
					}
			).withBonusTier(4,{
				'maxspe': +45,
				'maxint': +15
			}).withBonusTier(8,{
				'maxstr': +15,
				'maxspe': +75,
				'maxint': +30
			}).withRacialPerk(6,PerkLib.JunglesWanderer,
					"",
					""
			);
	
	public static var RHINO:Race = new Race("rhino")
			.simpleScores({
				'ears' : [Ears.RHINO, +1],
				'tail' : [Tail.RHINO, +1],
				'face' : [Face.RHINO, +1],
				'horns': [Horns.RHINO, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (score >= 2 && ch.skinTone == "gray")
							score++;
						if (score >= 2 && ch.hasCock() && ch.countCocksOfType(CockTypesEnum.RHINO) > 0)
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(4,{
				'maxstr': +15,
				'maxtou': +15,
				'maxspe': -10,
				'maxint': -10,
				'maxhp' : +100
			});
	
	public static var SALAMANDER:Race = new Race("salamander")
			.simpleScores({
				'eyes': [Eyes.REPTILIAN, +1],
				'arms': [Arms.SALAMANDER, +1],
				'legs': [LowerBody.SALAMANDER, +1],
				'tail': [Tail.SALAMANDER, +1],
				'face': [Face.SALAMANDER_FANGS, +1]
			}).complexScore(+1, {
				'skin.coat'    : Skin.SCALES,
				'skin.coverage': Skin.COVERAGE_LOW
			}).complexScore(+1, {
				'ears': Ears.HUMAN,
				'face': Face.SALAMANDER_FANGS
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.lizardCocks() > 0)
							score++;
						if (ch.hasPerk(PerkLib.Lustzerker))
							score++;
						if (ch.hasPerk(PerkLib.SalamanderAdrenalGlands))
							score++;
						if (ch.hasPerk(PerkLib.SalamanderAdrenalGlandsEvolved))
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 4)
							score += 1;
						if (ch.hasPerk(PerkLib.SalamanderAdrenalGlands) && ch.hasPerk(PerkLib.ChimericalBodyAdvancedStage))
							score++;
						return score;
					}
			).withBonusTier(4, {
				'maxstr' : +15,
				'maxtou' : +15,
				'maxlib' : +30,
				'maxlust': +25
			}).withBonusTier(7, {
				'maxstr' : +25,
				'maxtou' : +25,
				'maxlib' : +40,
				'maxlust': +25
			}).withRacialPerk(4,PerkLib.FireAffinity,
				"You suddenly feels your body temperature rising to ridiculus level. You pant for several minutes until your finaly at ease with your bodily heat. You doubt any more heat is gunna make you more incomfortable then this as you quietly soak in the soothing warmth your body naturaly produce. Its like your body is made out of living fire.\n\n(<b>Gained Perk: Fire Affinity</b>)",
				"You suddenly feel chilly as your bodily temperature drop down to human level. You lost your natural warmth reverting to that of a standard human.\n\n<b>(Lost Perk: Fire Affinity)</b>"
			);
	
	public static var SANDTRAP:Race = new Race("sandtrap")
			.simpleScores({
				'eyes' : [Eyes.BLACK_EYES_SAND_TRAP, +1],
				'wings': [Wings.GIANT_DRAGONFLY, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.hasStatusEffect(StatusEffects.BlackNipples))
							score++;
						if (ch.hasStatusEffect(StatusEffects.Uniball))
							score++;
						if (ch.hasVagina() && ch.vaginaType() == VaginaClass.BLACK_SAND_TRAP)
							score++; // TODO ?
						if (ch.hasStatusEffect(StatusEffects.Uniball))
							score++;
						return score;
					}
			);
	
	public static var SATYR:Race = new Race("satyr")
			.simpleScores({
				'legs': [LowerBody.HOOFED, +1],
				'tail': [Tail.GOAT, +1]
			}).complexScore(+1, {
				'legs': LowerBody.HOOFED,
				'tail': Tail.GOAT,
				'ears': Ears.ELFIN
			}).complexScore(+1, {
				'legs': LowerBody.HOOFED,
				'tail': Tail.GOAT,
				'face': Face.HUMAN
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (score >= 2) {
							if (ch.countCocksOfType(CockTypesEnum.HUMAN) > 0)
								score++;
							if (ch.balls > 0 && ch.ballSize >= 3)
								score++;
						}
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(4,{
				'maxstr': +5,
				'maxspe': +5
			});
	
	public static var SCORPION:Race = new Race("scorpion")
			.simpleScores({
				'tail'     : [Tail.SCORPION, +1],
				'skin.coat': [Skin.CHITIN, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (score > 0 && ch.hasPerk(PerkLib.TrachealSystem))
							score++;
						if (score > 4 && ch.hasPerk(PerkLib.TrachealSystemEvolved))
							score++;
						if (score > 8 && ch.hasPerk(PerkLib.TrachealSystemFinalForm))
							score++;
						return score;
					}
			);
	
	public static var SCYLLA:Race = new Race("scylla")
			.simpleScores({
				'face': [Face.HUMAN, +1],
				'ears': [Ears.ELFIN, +1],
				'legs': [LowerBody.SCYLLA, +2]
			}).complexScore(+1, {
				'skin'         : Skin.PLAIN,
				'skin.coverage': Skin.COVERAGE_NONE,
				'skin.adj'     : 'slippery' // TODO commented +2 for 'rubberlike slippery'
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.faceType != 0)
							score--;
						if (ch.tallness > 96)
							score++;
						if (ch.hasPerk(PerkLib.InkSpray))
							score++;
						if (ch.hasPerk(PerkLib.ScyllaInkGlands))
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 4)
							score += 1;
						if (ch.hasPerk(PerkLib.ScyllaInkGlands) && ch.hasPerk(PerkLib.ChimericalBodyAdvancedStage))
							score++;
						return score;
					}
			).withBonusTier(4,{
				'maxstr': +40,
				'maxint': +20,
				'maxhp' : +25
			}).withBonusTier(7,{
				'maxstr': +65,
				'maxint': +40,
				'maxhp' : +50
			}).withBonusTier(12,{
				'maxstr': +120,
				'maxint': +60,
				'maxhp' : +150
			});
	
	public static var SHARK:Race = new Race("shark")
			.simpleScores({
				'face' : [Face.SHARK_TEETH, +1],
				'gills': [Gills.FISH, +1],
				'rear' : [RearBody.SHARK_FIN, +1],
				'arms' : [Arms.SHARK, +1],
				'legs' : [LowerBody.SHARK, +1],
				'tail' : [Tail.SHARK, +1],
				'wings': [Wings.SHARK_FIN, -7]
			}).complexScore(+1, {
				'hair'      : Hair.NORMAL,
				'hair.color': 'silver'
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.hasScales() && Utils.InCollection(ch.skin.coat.color, "rough gray", "orange and black"))
							score++;
						if (ch.eyes.type == Eyes.HUMAN && ch.hairType == Hair.NORMAL && ch.hairColor == "silver" && ch.hasScales() && Utils.InCollection(ch.skin.coat.color, "rough gray", "orange and black"))
							score++;
						if (ch.vaginas.length > 0 && ch.cocks.length > 0)
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(4,{
				'maxstr': +20,
				'maxspe': +40
			}).withBonusTier(8,{
				'maxstr': +40,
				'maxspe': +70,
				'maxlib': +10
			}).withBonusTier(9, {
				'maxstr' : +60,
				'maxspe' : +70,
				'maxlib' : +20,
				'maxlust': +50
			});
	
	public static var SIREN:Race = new Race("siren")
			.simpleScores({
				'face'      : [Face.SHARK_TEETH, +1],
				'hair'      : [Hair.FEATHER, +1],
				'tail'      : [Tail.SHARK, +1],
				'wings'     : [Wings.FEATHERED_LARGE, +2],
				'arms'      : [Arms.HARPY, +1],
				'legs'      : [LowerBody.SHARK, +1],
				'gills'     : [Gills.FISH, +1],
				'eyes'      : [Eyes.HUMAN, +1],
				'hair.color': ['silver', +1]
			}).complexScore(+1, {
				'skin'     : Skin.SCALES,
				'skin.tone': ['rough gray', 'orange and black']
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(10,{
				'maxstr': +40,
				'maxspe': +70,
				'maxint': +40
			});
	
	public static var SPHINX:Race = new Race("sphinx")
			.simpleScores({
				'eyes'  : [Eyes.CAT_SLITS, +1],
				'ears'  : [Ears.LION, +1],
				'tongue': [Tongue.CAT, +1],
				'tail'  : [
					Tail.CAT, +1,
					Tail.LION, +1
				],
				'legs'  : [LowerBody.CAT, +1],
				'face'  : [Face.CAT_CANINES, +1],
				'wings' : [Wings.FEATHERED_SPHINX, +2]
			}).complexScore(+2, {
				'legs.count': 4,
				'legs'      : LowerBody.CAT
			}).complexScore(+1, {
				'legs.count': 4,
				'legs'      : LowerBody.CAT,
				'tail'      : Tail.CAT
			}).complexScore(+1, {
				'legs.count'   : 4,
				'legs'         : LowerBody.CAT,
				'skin'         : Skin.PLAIN,
				'skin.coverage': Skin.COVERAGE_NONE
			}).complexScore(+1, {
				'legs.count': 4,
				'legs'      : LowerBody.CAT,
				'arms'      : Arms.SPHINX
			}).complexScore(+1, {
				'legs.count': 4,
				'legs'      : LowerBody.CAT,
				'ears'      : Ears.LION
			}).complexScore(+1, {
				'legs.count': 4,
				'legs'      : LowerBody.CAT,
				'face'      : Face.CAT_CANINES
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						if (ch.hasPerk(PerkLib.Flexibility))
							score++;
						if (ch.hasPerk(PerkLib.CatlikeNimbleness))
							score += 1;
						return score;
					}
			).withBonusTier(14,{
				'maxspe': +40,
				'maxstr': +50,
				'maxtou': -20,
				'maxint': +100,
				'maxwis': +40
			});
	
	public static var SPIDER:Race = new Race("spider")
			.simpleScores({
				'eyes'     : [Eyes.FOUR_SPIDER_EYES, +1],
				'face'     : [Face.SPIDER_FANGS, +1],
				'arms'     : [Arms.SPIDER, +1],
				'legs'     : [
					LowerBody.CHITINOUS_SPIDER_LEGS, +1,
					LowerBody.DRIDER, +2
				],
				'tail'     : [Tail.SPIDER_ADBOMEN, +1],
				'skin.coat': [Skin.CHITIN, +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (!ch.hasCoatOfType(Skin.CHITIN) && score > 0)
							score--;
						if (score > 0 && ch.hasPerk(PerkLib.TrachealSystem))
							score++;
						if (score > 4 && ch.hasPerk(PerkLib.TrachealSystemEvolved))
							score++;
						if (score > 8 && ch.hasPerk(PerkLib.TrachealSystemFinalForm))
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(4,{
				'maxstr': -10,
				'maxtou': +30,
				'maxint': +40
			}).withBonusTier(7,{
				'maxstr': -20,
				'maxtou': +50,
				'maxint': +75
			});
	
	public static var UNICORN:Race = new Race("unicorn")
			.simpleScores({
				'face'      : [
					Face.HORSE, +2,
					Face.HUMAN, +1
				],
				'ears'      : [Ears.HORSE, +1],
				'tail'      : [Tail.HORSE, +1],
				'legs'      : [LowerBody.HOOFED, +1],
				'legs.count': [4, +1],
				'eyes.color': [
					"red", +1,
					"blue", +1
				],
				'horns'     : [Horns.UNICORN, +1],
				'hair.color': ['white', +1]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.horns.type != Horns.UNICORN) return 0;
						if (ch.wings.type == Wings.FEATHERED_ALICORN) return 0;
						if (ch.horns.count >= 6) score++;
						if (ch.hasFur() || ch.hasPlainSkinOnly())
							score++;
						if (ch.hasPerk(PerkLib.ChimericalBodyPerfectStage))
							score += 10;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score += 1;
						return score;
					}
			).withBonusTier(5, {
				'maxfatigue'  : +20,
				'maxsoulforce': +50
			}).withBonusTier(9, {
				'maxtou'      : +20,
				'maxspe'      : +40,
				'maxint'      : +75,
				'maxfatigue'  : +20,
				'maxsoulforce': +50,
				'maxhp'       : +120
			});
	
	public static var VAMPIRE:Race = new Race("vampire")
			.simpleScores({
				'ears' : [
					Ears.BAT, -10,
					Ears.ELFIN, +1
				],
				'wings': [Wings.VAMPIRE, +4],
				'legs' : [LowerBody.HUMAN, +1],
				'face' : [Face.VAMPIRE, +2],
				'eyes' : [Eyes.VAMPIRE, +1],
				'arms' : [Arms.HUMAN, +1]
			}).withBonusTier(6,{
				'maxstr': +20,
				'maxspe': +20,
				'maxint': +20,
				'maxlib': +30
			}).withBonusTier(10,{
				'maxstr': +35,
				'maxspe': +35,
				'maxint': +35,
				'maxlib': +45
			});
	
	public static var VOUIVRE:Race = new Race("vouivre")
			.simpleScores({
				'tongue'   : [Tongue.SNAKE, +1],
				'face'     : [Face.SNAKE_FANGS, +1],
				'arms'     : [Arms.DRAGON, +1],
				'eyes'     : [Eyes.SNAKE, +1],
				'ears'     : [Ears.DRAGON, +1],
				'legs'     : [LowerBody.NAGA, +2],
				'skin.coat': [Skin.DRAGON_SCALES, +1],
				'horns'    : [
					Horns.DRACONIC_X2, +1,
					Horns.DRACONIC_X4_12_INCH_LONG, +1
				],
				'wings'    : [
					Wings.DRACONIC_SMALL, +2,
					Wings.DRACONIC_LARGE, +2,
					Wings.DRACONIC_HUGE, +2
				]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.hasPerk(PerkLib.DragonFireBreath) && score >= 11)
							score++;
						if (ch.hasPerk(PerkLib.DragonIceBreath) && score >= 11)
							score++;
						if (ch.hasPerk(PerkLib.DragonLightningBreath) && score >= 11)
							score++;
						if (ch.hasPerk(PerkLib.DragonDarknessBreath) && score >= 11)
							score++;
						if (ch.hasPerk(PerkLib.DraconicLungs))
							score++;
						if (ch.hasPerk(PerkLib.DraconicLungsEvolved))
							score++;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 7)
							score += 1;
						return score;
					}
			).withBonusTier(11,{
				'maxstr': +10,
				'maxtou': -10,
				'maxspe': +35,
				'maxint': +10,
				'maxwis': -20
			});
	
	public static var WEREWOLF:Race = new Race("werewolf")
			.simpleScores({
				'face'  : [Face.WOLF_FANGS, +1],
				'eyes'  : [
					Eyes.FERAL, +1,
					Eyes.FENRIR, -7
				],
				'ears'  : [Ears.WOLF, +1],
				'tongue': [Tongue.DOG, +1],
				'arms'  : [Arms.WOLF, +1],
				'legs'  : [LowerBody.WOLF, +1],
				'tail'  : [Tail.WOLF, +1],
				'rear'  : [
					RearBody.WOLF_COLLAR, +1,
					RearBody.FENRIR_ICE_SPIKES, -7
				]
			}).complexScore(+1, {
				'skin.coat'    : Skin.FUR,
				'skin.coverage': Skin.COVERAGE_LOW
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.wolfCocks() > 0 && score > 0)
							score++;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && score >= 3)
							score++;
						if (ch.cor >= 20)
							score += 2;
						if (ch.hasPerk(PerkLib.Lycanthropy))
							score++;
						if (ch.hasPerk(PerkLib.LycanthropyDormant))
							score -= 11;
						return score;
					}
			).withBonusTier(6,{
				'maxstr': +50,
				'maxtou': +20,
				'maxspe': +30,
				'maxint': -10
			}).withBonusTier(12,{
				'maxstr': +100,
				'maxtou': +40,
				'maxspe': +60,
				'maxint': -20
			});
	
	public static var WOLF:Race = new Race("wolf")
			.simpleScores({
				'face'     : [Face.WOLF, +1],
				'eyes'     : [
					Eyes.FENRIR, +1,
					Eyes.FERAL, -11
				],
				'skin.coat': [Skin.FUR, +1],
				'ears'     : [Ears.WOLF, +1],
				'arms'     : [Arms.WOLF, +1],
				'legs'     : [LowerBody.WOLF, +1],
				'tail'     : [Tail.WOLF, +1],
				'rear'     : [RearBody.FENRIR_ICE_SPIKES, +1]
			}).complexScore(+1, {
				'hair.color'     : 'glacial white',
				'skin.coat'      : Skin.FUR,
				'skin.coat.color': 'glacial white'
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.wolfCocks() > 0 && score > 0) score++;
						if (ch.hasPerk(PerkLib.FreezingBreath)) score++;
						if (ch.hasPerk(PerkLib.AscensionHybridTheory) && ch.eyes.type == Eyes.FENRIR)
							score += 1;
						return score;
					}
			).withBonusTier(4,{
				'maxstr': +15,
				'maxspe': +10,
				'maxint': -10
			}).withBonusTier(6,{
				'maxstr': +30,
				'maxtou': +10,
				'maxspe': +30,
				'maxint': -10
			}).withBonusTier(7,{
				'maxstr': +30,
				'maxtou': +20,
				'maxspe': +30,
				'maxint': -10
			}).withBonusTier(10,{
				'maxstr': +60,
				'maxtou': +30,
				'maxspe': +60,
				'maxint': -10
			});
	
	public static var YETI:Race = new Race("yeti")
			.simpleScores({
				'skin.tone' : ['dark', +1],
				'eyes'      : [Eyes.HUMAN, +1],
				'legs'      : [LowerBody.YETI, +1],
				'arms'      : [Arms.YETI, +1],
				'ears'      : [Ears.YETI, +1],
				'face'      : [Face.YETI_FANGS, +1],
				'hair'      : [Hair.FLUFFY, +1],
				'hair.color': ['white', +1]
			}).complexScore(+1, {
				'skin.coat'    : Skin.FUR,
				'skin.coverage': Skin.COVERAGE_LOW
			}).complexScore(+1, {
				'skin.coat'      : Skin.FUR,
				'skin.coat.color': 'white'
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.tallness >= 78)
							score++;
						if (ch.butt.type >= Butt.RATING_JIGGLY)
							score++;
						return score;
					}
			).withBonusTier(6,{
				'maxstr': +30,
				'maxtou': +40,
				'maxspe': +25,
				'maxint': -30,
				'maxlib': +25
			}).withBonusTier(12,{
				'maxstr': +60,
				'maxtou': +80,
				'maxspe': +50,
				'maxint': -60,
				'maxlib': +50
			}).withRacialPerk(6, PerkLib.ColdAffinity,
					"You suddenly no longer feel the cold so you guess you finally got acclimated to the icy winds of the glacial rift. You feel at one with the cold. So well that you actually developed icy power of your own.\n\n(<b>Gained Perks: Cold Affinity and Freezing Breath Yeti</b>)",
					"You suddenly feel a chill in the air. You guess you somehow no longer resist the cold.\n\n<b>(Lost Perks: Cold Affinity and Freezing Breath Yeti)</b>"
			).withRacialPerk(6, PerkLib.FreezingBreathYeti,
					"",
					""
			);
	
	public static var YGGDRASIL:Race = new Race("yggdrasil")
			.simpleScores({
				'face' : [Face.PLANT_DRAGON, +2],
				'arms' : [
					//untill claws tf added arms tf will count for both arms and claws
					Arms.PLANT, +2,
					Arms.PLANT2, +2
				],
				'ears' : [
					Ears.LIZARD, +1,
					Ears.ELFIN, -2
				],
				'wings': [Wings.PLANT, +1],
				'skin' : [Skin.SCALES, +1],
				'legs' : [LowerBody.YGG_ROOT_CLAWS, +1],
				'tail' : [Tail.YGGDRASIL, +1]
			}).complexScore(+1, {
				'hair.color': "green",
				'hair'      : [Hair.ANEMONE, Hair.LEAF, Hair.GRASS]
			}).withFinalizerScript(
					function (ch:Creature, metrics:*, score:int):int {
						if (ch.tentacleCocks() > 0 || ch.stamenCocks() > 0)
							score++;
						return score;
					}
			).withBonusTier(10, {
				'defense': 10,
				'maxstr': +50,
				'maxtou': +70,
				'maxspe': -50,
				'maxint': +50,
				'maxwis': +80,
				'maxlib': -50
			});
	
	/*
	//////////////
	// TEMPLATE //
	//////////////
	public static var RACENAME:Race = new Race("racename")
			.simpleScores({
				'metric1': [
						'metricValue', +1,
						'metricValue', -1
				]
			}).complexScore(+1,{
				'metric1': 'metricValue',
				'metric2': ['metricValue','metricValue']
			}).withFinalizerScript(
					function(ch:Creature,metrics:*,score:int):int {
						return score;
					}
			).withBonusTier(4,{
				'maxstr':10
			});
	*/
	
	/**
	 * object{metricName:object{metricValue:racialBonus}}
	 */
	private var simpleMetrics:*;
	/**
	 * array[score,{metricName:[metricValues]}]
	 */
	private var complexMetrics:/*Array*/Array = [];
	/**
	 * (ch:Creature, metrics:{name:value}, score:int)=>int
	 */
	private var finalizerScript:Function      = null;
	/**
	 * array[minScore,{bonusName:bonusValue}]
	 */
	public const bonusTiers:/*Array*/Array     = [];
	/**
	 * array[object{minScore:int,perk:PerkType,gainText:String,loseText:String}]
	 */
	public const racialPerks:Array             = [];
	
	public function Race(name:String) {
		this.name          = name;
		this.simpleMetrics = {};
		for each (var metricName:String in MetricNames) {
			simpleMetrics[metricName] = {};
		}
		RegisteredRaces.push(this);
	}
	
	/**
	 * @param metrics object{metricName:array[metricValue,racialBonus,...]]}
	 * @return this
	 */
	private function simpleScores(metrics:*):Race {
		for (var metricName:String in metrics) {
			if (MetricNames.indexOf(metricName) == -1) {
				error("Not a simple metric name '" + metricName + "' in race " + name);
			}
			var src:Array = metrics[metricName];
			if (src.length % 2 != 0) {
				error("Odd number of simple metric '" + metricName + "' descriptors in race " + name);
			}
			var values:* = {};
			for (var i:int = 0; i < src.length; i += 2) {
				values[src[i]] = src[i + 1];
			}
			simpleMetrics[metricName] = values;
		}
		return this;
	}
	/**
	 * @param tests object{metricName:(requiredValue|array[possibleValue])}
	 * @param score added if all metrics pass
	 * @return this
	 */
	private function complexScore(score:int, tests:*):Race {
		for (var metric:String in tests) {
			if (MetricNames.indexOf(metric) == -1) {
				error("Not a simple metric name '" + metric + "' in race " + name);
			}
		}
		complexMetrics.push([score, tests]);
		return this;
	}
	/**
	 * @param fn (ch:Creature, metrics:{name:value}, score:int)=>int
	 * @return this
	 */
	private function withFinalizerScript(fn:Function):Race {
		this.finalizerScript = fn;
		return this;
	}
	/**
	 * @param minScore Minimal score to grant these bonuses
	 * @param bonuses object{ bonusName:bonusValue }
	 * @return this
	 */
	private function withBonusTier(minScore:int, bonuses:*):Race {
		for (var key:String in bonuses) {
			if (BonusNames.indexOf(key) == -1) error("Invalid bonus name '" + key + "' for race " + name);
		}
		for each (var tier:Array in this.bonusTiers) {
			if (tier[0] == minScore) error("Duplicate bonus tier value "+minScore+" for race "+name);
		}
		this.bonusTiers.push([minScore, bonuses]);
		this.bonusTiers.sortOn(['0'], [Array.NUMERIC]);
		return this;
	}
	private function withRacialPerk(minScore:int,perk:PerkType,gainText:String,loseText:String):Race {
		this.racialPerks.push({minScore:minScore,perk:perk,gainText:gainText,loseText:loseText});
		return this;
	}
	/**
	 * Returns list of perks that not present but should be added because enouch score,
	 * and those present but should be removed because too low score
	 * @param score racial score
	 * @return array[object{
	 *     add:Boolean,
	 *     race:name,
	 *     perk:PerkType,
	 *     text:String
	 *  }]
	 */
	public function perksToAddRemove(score:int,ch:Creature):Array {
		var rslt:Array = [];
		for each (var rp:* in racialPerks) {
			if (score < rp.minScore && ch.hasPerk(rp.perk)) {
				rslt.push({
					add : false,
					race: this.name,
					perk: rp.perk,
					text: rp.loseText
				});
			} else if (score >= rp.minScore && !ch.hasPerk(rp.perk)) {
				rslt.push({
					add : true,
					race: this.name,
					perk: rp.perk,
					text: rp.gainText
				});
			}
		}
		return rslt;
	}
	/**
	 * @return object{ bonusName:bonusValue }
	 */
	public function bonusesForScore(score:int):* {
		for (var i:int = bonusTiers.length - 1; i >= 0; i--) {
			if (score >= bonusTiers[i][0]) return Utils.shallowCopy(bonusTiers[i][1]);
		}
		return {};
	}
	public function scoreFor(ch:Creature, metrics:*):int {
		Utils.Begin("Race", "scoreFor");
		var score:int = 0;
		score += calcSimpleScore(metrics);
		score += calcComplexScore(metrics);
		if (finalizerScript != null) score = finalizerScript(ch, metrics, score);
		Utils.End("Race", "scoreFor");
		return score;
	}
	/**
	 * Computes only 'simple' part of total racial score
	 */
	public function calcSimpleScore(metrics:*):int {
		var score:int = 0;
		for (var metricName:String in metrics) {
			var value:* = metrics[metricName];
			score += (simpleMetrics[metricName][value] || 0);
		}
		return score;
	}
	/**
	 * @return object{
	 *     total:int,
	 *     items:list[
	 *         item:object{
	 *             metric:string,
	 *             actual:*,
	 *             bonus:int,
	 *             checks:list[ pair[expected,bonus] ]
	 *         }
	 *     ]
	 * }
	 */
	public function explainSimpleScore(metrics:*):* {
		var rslt:* = {total: 0, items: []};
		for (var metricName:String in metrics) {
			var value:*  = metrics[metricName];
			var checks:* = simpleMetrics[metricName];
			var bonus:*  = simpleMetrics[metricName][value];
			var item:*   = {metric: metricName, actual: value, bonus: bonus || 0, checks: []};
			if (typeof bonus != 'undefined') {
				rslt.total += bonus;
			}
			for (var expectedValue:String in checks) {
				item.checks.push([expectedValue, checks[expectedValue]]);
			}
			if (item.checks.length > 0) rslt.items.push(item);
		}
		return rslt;
	}
	/**
	 * Computes only 'complex' part of total racial score
	 */
	public function calcComplexScore(metrics:*):int {
		// array[score,{metricName:[metricValues]}]
		var score:int = 0;
		for each (var scoreTests:Array in complexMetrics) {
			var tests:*      = scoreTests[1];
			var pass:Boolean = true;
			for (var metric:String in tests) {
				var actual:*   = metrics[metric];
				var expected:* = tests[metric];
				if (expected is Array) {
					if (expected.indexOf(actual) == -1) {
						pass = false;
						break;
					}
				} else if (expected != actual) {
					pass = false;
					break;
				}
			}
			if (pass) score += scoreTests[0];
		}
		return score;
	}
	/**
	 * @return object{
	 *     total:int,
	 *     items:list[
	 *         item:object{
	 *             checks:list[
	 *                 check:object{
	 *                     metric:string,
	 *                     actual:*,
	 *                     expected:* | list[*],
	 *                     passed:boolean
	 *                 }
	 *             ],
	 *             passed:boolean,
	 *             bonus:int
	 *         ]
	 *     ]
	 * }
	 */
	public function explainComplexScore(metrics:*):* {
		var rslt:* = {total: 0, items: []};
		for each (var scoreTests:Array in complexMetrics) {
			var tests:*      = scoreTests[1];
			var pass:Boolean = true;
			var item:*       = {checks: [], passed: true, bonus: scoreTests[0]};
			rslt.items.push(item);
			for (var metric:String in tests) {
				var actual:*   = metrics[metric];
				var expected:* = tests[metric];
				var check:*    = {metric: metric, actual: actual, expected: expected, passed: true};
				item.checks.push(check);
				if (expected is Array) {
					if (expected.indexOf(actual) == -1) {
						pass         = false;
						check.passed = false;
					}
				} else if (expected != actual) {
					pass         = false;
					check.passed = false;
				}
			}
			item.passed = pass;
			if (pass) rslt.total += scoreTests[0];
		}
		return rslt;
	}
	
	private static function error(msg:String):* {
		trace("[RACE CONFIG ERROR]", msg);
		if (CoC_Settings.haltOnErrors) {
			throw msg;
		}
	}
}
}
