/**
 * ...
 * @author Ormael
 */
package classes.Items
{
	import classes.ItemType;
	import classes.PerkLib;
	import classes.Player;

	public class WeaponRange extends Useable //Equipable
	{
		private var _verb:String;
		private var _attack:Number;
		private var _perk:String;
		private var _name:String;
		private var _ammoWord:String;
		
		public function WeaponRange(id:String, shortName:String, name:String,longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "") {
			super(id, shortName, longName, value, description);
			this._name = name;
			this._verb = verb;
			this._attack = attack;
			this._perk = perk;
			switch(_perk){
				case "Bow": _ammoWord = "arrow"; break;
				case "Crossbow": _ammoWord = "bolt"; break;
				case "Throwing": _ammoWord = "projectile"; break;
				case "Pistol":
				case "Rifle":
					_ammoWord = "bullet"
			}
		}
		
		public function get verb():String { return _verb; }
		
		public function get attack():Number { return _attack; }
		
		public function get perk():String { return _perk; }
		
		public function get name():String { return _name; }
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Range Weapon ";
			if (perk == "Bow") desc += "(Bow)";
			else if (perk == "Crossbow") desc += "(Crossbow)";
			else if (perk == "Pistol") desc += "(Pistol)";
			else if (perk == "Rifle") desc += "(Rifle)";
			else if (perk == "Throwing") desc += "(Throwing)";
			//Attack
			desc += "\nRange Attack: " + String(attack);
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}
		
		override public function useText():void {
			outputText("You equip " + longName + ".  ");
		}
		
		override public function canUse():Boolean {
			return true;
		}

		/**
		 * This item is being equipped by the player. Add any perks, etc. - This function should only handle mechanics, not text output
		 * @return
		 */
		public function playerEquip():WeaponRange {
			return this;
		}

		/**
		 * This item is being removed by the player. Remove any perks, etc. - This function should only handle mechanics, not text output
		 * @return
		 */
		public function playerRemove():WeaponRange {
			return this;
		}

		/**
		 * Produces any text seen when removing the armor normally
		 */
		public function removeText():void {}

		public function get ammoWord():String{
			return _ammoWord;
		}
		
	}
}