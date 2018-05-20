package classes.lists {
	import classes.Creature;

	public final class DamageType {
		public static const LUST:DamageType = new DamageType("lust", 5, "#ee60aa", Creature.damage_LUST);
		public static const PHYSICAL:DamageType = new DamageType("physical", 5, "#000000", Creature.damage_PHYS);
		public static const MAGIC:DamageType = new DamageType("magic", 5, "#8447ab", Creature.damage_MAGIC);
		public static const FIRE:DamageType = new DamageType("fire", 5, "#ff9739", Creature.damage_MAGIC);
		public static const WATER:DamageType = new DamageType("water", 5, "#0000fe", Creature.damage_MAGIC);
		public static const EARTH:DamageType = new DamageType("earth", 5, "#7d4021", Creature.damage_MAGIC);
		public static const AIR:DamageType = new DamageType("air", 5, "#00d36d", Creature.damage_MAGIC);

		private var _name:String;
		private var _baseCost:int;
		private var _colour:String;
		private var _damage:Function;

		/**
		 * A damage type
		 * @param name
		 * @param baseCost
		 * @param colour
		 * @param damage the function that is used to apply the damage
		 */
		public function DamageType(name:String, baseCost:int, colour:String, damage:*) {
			_name = name;
			_baseCost = baseCost;
			_colour = colour;
			_damage = damage;
		}

		public function get name():String {
			return _name;
		}

		public function get baseCost():int {
			return _baseCost;
		}

		public function get colour():String {
			return _colour;
		}

		public function get damage():Function {
			return _damage;
		}

		public function colourText(text:String):String {
			return "<font color='"+_colour+"'>" + text + "</font>"
		}
	}
}