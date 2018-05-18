package classes.Scenes.Combat {

	import classes.CoC;
	import classes.DefaultDict;
	import classes.GlobalFlags.kFLAGS;

	public class CombatDamage {
		public static const WATER:String = "WATER";
		public static const ICE:String = "ICE";

		private static const _types:DefaultDict = new DefaultDict(1);

		private var _min:int;
		private var _max:int;
		private var _dtype:DamageType;
		public function CombatDamage(dtype:String, min:int, max:int) {
			_min = min;
			_max = max;
		}

		public function cost():Number {
			var diffCalc:Number = (_min + _max) / (50 - (10 * CoC.instance.flags[kFLAGS.GAME_DIFFICULTY]));
			return _dtype.baseCost * diffCalc
		}
	}
}

class DamageType {
	function DamageType(type:String, cost:int){}
	internal var id:String;
	internal var baseCost:int;
}
