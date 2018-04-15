/**
 * Coded by aimozg on 12.04.2018.
 */
package classes {
import classes.BodyParts.*;
import classes.internals.Utils;

/**
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
 */
public class Race {
	public var name:String;
	
	public static var RegisteredRaces:/*Race*/Array = [];
	public static var MetricNames:/*String*/Array   = [
		'skin',
		'skin.coverage',
		'skin.tone',
		'skin.adj',
		'face',
		'eyes',
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
		'gender',
		'cocks',
		'cocks/human',
		'breastRows'
	];
	public static function MetricsFor(ch:Creature):* /* object{metricName:metricValue} */ {
		return {
			'skin'         : ch.skinType,
			'skin.coverage': ch.skin.coverage,
			'skin.tone'    : ch.skinTone,
			'skin.adj'     : ch.skinAdj,
			'face'         : ch.facePart.type,
			'eyes'         : ch.eyes.type,
			'ears'         : ch.ears.type,
			'tongue'       : ch.tongue.type,
			'gills'        : ch.gills.type,
			'antennae'     : ch.antennae.type,
			'horns'        : ch.horns.type,
			'horns.count'  : ch.horns.count,
			'wings'        : ch.wings.type,
			'tail'         : ch.tail.type,
			'tail.count'   : ch.tail.count,
			'arms'         : ch.arms.type,
			'legs'         : ch.lowerBody,
			'gender'       : ch.gender,
			'cocks'        : ch.cocks.length,
			'cocks/human'  : ch.countCocksOfType(CockTypesEnum.HUMAN),
			'breastRows'   : ch.breastRows.length
		}
	}
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
			);
	public static var DEMON:Race = new Race("demon")
			.simpleScores({
				'horns': [
					Horns.DEMON, +1,
					Horns.GOAT, -10
				],
				'tail':[Tail.DEMONIC,+1],
				'wings':[
						Wings.BAT_LIKE_TINY,+1,
						Wings.BAT_LIKE_LARGE,+2,
						Wings.BAT_LIKE_LARGE_2,+4
				],
				'tongue':[
						Tongue.DEMONIC,+1
				],
				'legs':[
						LowerBody.DEMONIC_HIGH_HEELS,+1,
						LowerBody.DEMONIC_CLAWS,+1
				]
			}).withFinalizerScript(
					function(ch:Creature,metrics:*,score:int):int {
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
							score+=1;
						return score;
					}
			);
	/*
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
			);
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
				throw "Not a simple metric name '" + metricName + "' in race " + name;
			}
			var src:Array = metrics[metricName];
			if (src.length % 2 != 0) {
				throw "Odd number of simple metric descriptors in race " + name;
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
		// todo @aimozg add validation
		complexMetrics.push([score,tests]);
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
	public function scoreFor(ch:Creature, metrics:*):int {
		Utils.Begin("Race", "scoreFor");
		var score:int = 0;
		score += calcSimpleScore(metrics);
		score += calcComplexScore(metrics);
		if (finalizerScript) score = finalizerScript(ch, metrics, score);
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
}
}
