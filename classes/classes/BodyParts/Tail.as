/**
 * Created by aimozg on 27.04.2017.
 */
package classes.BodyParts {
import classes.Creature;
import classes.internals.EnumValue;

public class Tail extends SaveableBodyPart {

	// A number of tails; legacy version used venom for counting
	public var count:int       = 0;
	//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
	public var venom:Number    = 0;
	//Tail recharge determines how fast venom/webs comes back per hour.
	public var recharge:Number = 5;
	
	public static const Types:/*EnumValue*/Array = [];
	
	public static const NONE:int                = EnumValue.add(Types, 0, "NONE", {name:"non-existant"});
	public static const HORSE:int               = EnumValue.add(Types, 1, "HORSE", {name:"horse"});
	public static const DOG:int                 = EnumValue.add(Types, 2, "DOG", {name:"dog"});
	public static const DEMONIC:int             = EnumValue.add(Types, 3, "DEMONIC", {name:"demonic"});
	public static const COW:int                 = EnumValue.add(Types, 4, "COW", {name:"cow"});
	public static const SPIDER_ADBOMEN:int      = EnumValue.add(Types, 5, "SPIDER_ADBOMEN", {name:"spider abdomen"});
	public static const BEE_ABDOMEN:int         = EnumValue.add(Types, 6, "BEE_ABDOMEN", {name:"bee abdomen"});
	public static const SHARK:int               = EnumValue.add(Types, 7, "SHARK", {name:"shark"});
	public static const CAT:int                 = EnumValue.add(Types, 8, "CAT", {name:"cat"});
	public static const LIZARD:int              = EnumValue.add(Types, 9, "LIZARD", {name:"lizard"});
	public static const RABBIT:int              = EnumValue.add(Types, 10, "RABBIT", {name:"rabbit"});
	public static const HARPY:int               = EnumValue.add(Types, 11, "HARPY", {name:"harpy"});
	public static const KANGAROO:int            = EnumValue.add(Types, 12, "KANGAROO", {name:"kangaroo"});
	public static const FOX:int                 = EnumValue.add(Types, 13, "FOX", {name:"fox"});
	public static const DRACONIC:int            = EnumValue.add(Types, 14, "DRACONIC", {name:"draconic"});
	public static const RACCOON:int             = EnumValue.add(Types, 15, "RACCOON", {name:"raccoon"});
	public static const MOUSE:int               = EnumValue.add(Types, 16, "MOUSE", {name:"mouse"});
	public static const FERRET:int              = EnumValue.add(Types, 17, "FERRET", {name:"ferret"});
	public static const BEHEMOTH:int            = EnumValue.add(Types, 18, "BEHEMOTH", {name:"behemoth"});
	public static const PIG:int                 = EnumValue.add(Types, 19, "PIG", {name:"pig"});
	public static const SCORPION:int            = EnumValue.add(Types, 20, "SCORPION", {name:"scorpion"});
	public static const GOAT:int                = EnumValue.add(Types, 21, "GOAT", {name:"goat"});
	public static const RHINO:int               = EnumValue.add(Types, 22, "RHINO", {name:"rhino"});
	public static const ECHIDNA:int             = EnumValue.add(Types, 23, "ECHIDNA", {name:"echidna"});
	public static const DEER:int                = EnumValue.add(Types, 24, "DEER", {name:"deer"});
	public static const SALAMANDER:int          = EnumValue.add(Types, 25, "SALAMANDER", {name:"salamander"});
	public static const KITSHOO:int             = EnumValue.add(Types, 26, "KITSHOO", {name:"kitshoo"});
	public static const MANTIS_ABDOMEN:int      = EnumValue.add(Types, 27, "MANTIS_ABDOMEN", {name:"mantis abdomen"});
	public static const MANTICORE_PUSSYTAIL:int = EnumValue.add(Types, 28, "MANTICORE_PUSSYTAIL", {name:"manticore pussytail"});
	public static const WOLF:int                = EnumValue.add(Types, 29, "WOLF", {name:"wolf"});
	public static const GARGOYLE:int            = EnumValue.add(Types, 30, "GARGOYLE", {name:"mace-shaped gargoyle"});
	public static const ORCA:int                = EnumValue.add(Types, 31, "ORCA", {name:"orca"});
	public static const YGGDRASIL:int           = EnumValue.add(Types, 32, "YGGDRASIL", {name:"yggdrasil"});
	public static const RAIJU:int               = EnumValue.add(Types, 33, "RAIJU", {name:"raiju"});
	public static const RED_PANDA:int           = EnumValue.add(Types, 34, "RED_PANDA", {name:"red-panda"});
	public static const GARGOYLE_2:int          = EnumValue.add(Types, 35, "GARGOYLE_2", {name:"axe-shaped gargoyle"});
	public static const AVIAN:int          		= EnumValue.add(Types, 36, "AVIAN", {name:"avian"});
	public static const GRIFFIN:int          	= EnumValue.add(Types, 37, "GRIFFIN", {name:"griffin"});
	public static const LION:int                = EnumValue.add(Types, 38, "LION", {name:"lion"});

	override public function set type(value:int):void {
		var old:int = type;
		super.type = value;
		if (count < 1 || value != FOX) count = 1;
		if (value == NONE) {
			count = 0;
			venom = 0;
		}
	}

	public function Tail(creature:Creature) {
		super(creature,"tail",["count","venom","recharge"]);
	}

	public function isLong():Boolean {
		if (creature.isNaga()) return true;
		return [
			DOG, DEMONIC, COW, SHARK, CAT,
			LIZARD, KANGAROO, FOX, DRACONIC,
			RACCOON, MOUSE, FERRET, BEHEMOTH, SCORPION,
			WOLF
			   ].indexOf(type) >= 0;

	}

	override protected function loadFromOldSave(savedata:Object):void {
		count = savedata.tailCount || savedata.tailVenum;
		venom = savedata.tailVenum;
		recharge = savedata.tailRecharge;
		type = savedata.tailType;
	}
	override protected function saveToOldSave(savedata:Object):void {
		savedata.tailVenum = type == FOX ? count : venom;
		savedata.tailRecharge = recharge;
		savedata.tailType = type;
	}

}
}
