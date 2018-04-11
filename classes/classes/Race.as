/**
 * Coded by aimozg on 12.04.2018.
 */
package classes {
import classes.BodyParts.*;
import classes.internals.Utils;

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
		'cocks',
		'cocks/human'
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
			'cocks'        : ch.cocks.length,
			'cocks/human'  : ch.countCocksOfType(CockTypesEnum.HUMAN)
		}
	}
	/**
	 * @param metrics object{metricName:metricValue}
	 * @return object{raceName:raceScore}
	 */
	public static function AllScoresFor(ch:Creature,metrics:*=null):* {
		Utils.Begin("Race","AllScoresFor");
		if (metrics == null) metrics = MetricsFor(ch);
		var result:* = {};
		for each (var race:Race in RegisteredRaces) {
			result[race.name] = race.scoreFor(ch,metrics);
		}
		Utils.End("Race","AllScoresFor");
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
	/*
	public static var PLANT:Race = new Race("plant")
			.complex(+1,
					'hair', [Hair.LEAF, Hair.GRASS],
					'hairColor', 'green'
			).complex(+1,
					'skin', Skin.PLAIN,
					'coverage', Skin.COVERAGE_NONE,
					'skinTone', ['lime green', 'turquoise']
			).complex(+1,
					'legs', [LowerBody.PLANT_HIGH_HEELS, LowerBody.PLANT_ROOT_CLAWS],
					'hascock_tentacle', true
			).withFinalizerScript(function (ch:Creature, metrics:*, score:int):int {
						if (ch.findPerk(PerkLib.AscensionHybridTheory) >= 0 && score >= 3)
							score += 1;
						return score;
					}
			);
	*/
	
	/**
	 * object{metricName:object{metricValue:racialBonus}}
	 */
	private var simpleMetrics:*;
	/**
	 * (ch:Creature, metrics:{name:value}, score:int)=>int
	 */
	private var finalizerScript:Function = null;
	
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
			if (src.length%2 != 0) {
				throw "Odd number of simple metric descriptors in race "+name;
			}
			var values:*  = {};
			for (var i:int=0;i<src.length;i+=2) {
				values[src[i]] = src[i+1];
			}
			simpleMetrics[metricName] = values;
		}
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
		Utils.Begin("Race","scoreFor");
		var score:int = 0;
		score += calcSimpleScore(metrics);
		score += calcComplexScore(ch, metrics);
		if (finalizerScript) score = finalizerScript(ch, metrics, score);
		Utils.End("Race","scoreFor");
		return score;
	}
	public function calcSimpleScore(metrics:*):int {
		var score:int = 0;
		for (var metricName:String in metrics) {
			var value:* = metrics[metricName];
			score += (simpleMetrics[metricName][value] || 0);
		}
		return score;
	}
	public function calcComplexScore(ch:Creature, metrics:*):int {
		return 0;
	}
}
}
