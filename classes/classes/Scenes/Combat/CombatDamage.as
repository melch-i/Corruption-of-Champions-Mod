package classes.Scenes.Combat {

	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	import classes.lists.DamageType;

	public class CombatDamage {
		private var _min:int;
		private var _die:int;
		private var _rolls:int;
		private var _max:int;
		private var _dtype:DamageType;

		public function CombatDamage(damage:String, dtype:DamageType) {
			var reg:RegExp = /(\d+)d?(\d*)\+?(\d*)/g;
			if(!reg.test(damage)){throw "Incorrect damage format"}
			var res:Array = damage.split("d");
			_rolls = res[0];
			if(res.length > 1){
				res = res[1].split('+');
				_die = res[0];
				if(res.length > 1){
					_min = res[1];
				}
			}
			_max = (_rolls * _die) + _min;
			_dtype = dtype;
		}

		public function cost():Number {
			var diffCalc:Number = (_min + _max) / (50 - (10 * CoC.instance.flags[kFLAGS.GAME_DIFFICULTY]));
			return _dtype.baseCost * diffCalc
		}

		public function roll():Number {
			var damage:int = 0;
			for (var i:int = 0; i < _rolls; i++) {
				damage += Math.random() * _die;
			}
			damage += _min;
			return damage;
		}

		public function get dtype():DamageType {
			return _dtype;
		}
	}
}
