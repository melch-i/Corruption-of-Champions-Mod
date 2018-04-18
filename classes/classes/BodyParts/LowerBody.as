/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Creature;
import classes.internals.EnumValue;

public class LowerBody extends SaveableBodyPart {
	public var legCount:int = 2;
	
	public static const Types:/*EnumValue*/Array = [];
	
	public static const HUMAN:int                 = EnumValue.add(Types, 0, "HUMAN", {name:"human"});
	public static const HOOFED:int                = EnumValue.add(Types, 1, "HOOFED", {name:"hoofed"});
	public static const DOG:int                   = EnumValue.add(Types, 2, "DOG", {name:"dog"});
	public static const NAGA:int                  = EnumValue.add(Types, 3, "NAGA", {name:"naga"});
	public static const CENTAUR:int               = EnumValue.add(Types, 4, "CENTAUR", {name:"centaur"});//[Deprecated] use HOOFED and legCount = 4
	public static const DEMONIC_HIGH_HEELS:int    = EnumValue.add(Types, 5, "DEMONIC_HIGH_HEELS", {name:"demonic high-heels"});
	public static const DEMONIC_CLAWS:int         = EnumValue.add(Types, 6, "DEMONIC_CLAWS", {name:"demonic claws"});
	public static const BEE:int                   = EnumValue.add(Types, 7, "BEE", {name:"bee"});
	public static const GOO:int                   = EnumValue.add(Types, 8, "GOO", {name:"goo"});
	public static const CAT:int                   = EnumValue.add(Types, 9, "CAT", {name:"cat"});
	public static const LIZARD:int                = EnumValue.add(Types, 10, "LIZARD", {name:"lizard"});
	public static const PONY:int                  = EnumValue.add(Types, 11, "PONY", {name:"pony"});
	public static const BUNNY:int                 = EnumValue.add(Types, 12, "BUNNY", {name:"bunny"});
	public static const HARPY:int                 = EnumValue.add(Types, 13, "HARPY", {name:"harpy"});
	public static const KANGAROO:int              = EnumValue.add(Types, 14, "KANGAROO", {name:"kangaroo"});
	public static const CHITINOUS_SPIDER_LEGS:int = EnumValue.add(Types, 15, "CHITINOUS_SPIDER_LEGS", {name:"chitinous spider legs"});
	public static const DRIDER:int                = EnumValue.add(Types, 16, "DRIDER", {name:"drider"});
	public static const FOX:int                   = EnumValue.add(Types, 17, "FOX", {name:"fox"});
	public static const DRAGON:int                = EnumValue.add(Types, 18, "DRAGON", {name:"dragon"});
	public static const RACCOON:int               = EnumValue.add(Types, 19, "RACCOON", {name:"raccoon"});
	public static const FERRET:int                = EnumValue.add(Types, 20, "FERRET", {name:"ferret"});
	public static const CLOVEN_HOOFED:int         = EnumValue.add(Types, 21, "CLOVEN_HOOFED", {name:"cloven-hoofed"});
	public static const ECHIDNA:int               = EnumValue.add(Types, 23, "ECHIDNA", {name:"echidna"});
	public static const DEERTAUR:int              = EnumValue.add(Types, 24, "DEERTAUR", {name:"deertaur"});//[Deprecated] use CLOVEN_HOOFED and legCount = 4
	public static const SALAMANDER:int            = EnumValue.add(Types, 25, "SALAMANDER", {name:"salamander"});
	public static const SCYLLA:int                = EnumValue.add(Types, 26, "SCYLLA", {name:"slippery octopus tentacles"});
	public static const MANTIS:int                = EnumValue.add(Types, 27, "MANTIS", {name:"mantis"});
	public static const SHARK:int                 = EnumValue.add(Types, 29, "SHARK", {name:"shark"});
	public static const GARGOYLE:int              = EnumValue.add(Types, 30, "GARGOYLE", {name:"gargoyle"});
	public static const PLANT_HIGH_HEELS:int      = EnumValue.add(Types, 31, "PLANT_HIGH_HEELS", {name:"vine-covered"});
	public static const PLANT_ROOT_CLAWS:int      = EnumValue.add(Types, 32, "PLANT_ROOT_CLAWS", {name:"root feet"});
	public static const WOLF:int                  = EnumValue.add(Types, 33, "WOLF", {name:"wolf"});
	public static const PLANT_FLOWER:int          = EnumValue.add(Types, 34, "PLANT_FLOWER", {name:"plant flower"});
	public static const LION:int                  = EnumValue.add(Types, 35, "LION", {name:"lion"});
	public static const YETI:int                  = EnumValue.add(Types, 36, "YETI", {name:"yeti"});
	public static const ORCA:int                  = EnumValue.add(Types, 37, "ORCA", {name:"orca"});
	public static const YGG_ROOT_CLAWS:int        = EnumValue.add(Types, 38, "YGG_ROOT_CLAWS", {name:"root feet"});
	public static const ONI:int                   = EnumValue.add(Types, 39, "ONI", {name:"oni"});
	public static const ELF:int                   = EnumValue.add(Types, 40, "ELF", {name:"elf"});
	public static const RAIJU:int                 = EnumValue.add(Types, 41, "RAIJU", {name:"raiju"});
	public static const RED_PANDA:int             = EnumValue.add(Types, 42, "RED_PANDA", {name:"red-panda"});
	public static const GARGOYLE_2:int            = EnumValue.add(Types, 43, "GARGOYLE_2", {name:"gargoyle"});
	public static const AVIAN:int            	  = EnumValue.add(Types, 44, "AVIAN", {name:"avian"});
	public static const GRYPHON:int            	  = EnumValue.add(Types, 45, "GRYPHON", {name:"gryphon"});
	
	override public function set type(value:int):void {
		super.type = value;
		// Reset leg count
		switch (value) {
			case GOO:
			case NAGA:
				legCount = 1;
				break;
			case BEE:
			case BUNNY:
			case CAT:
			case CHITINOUS_SPIDER_LEGS:
			case DEMONIC_CLAWS:
			case DEMONIC_HIGH_HEELS:
			case DOG:
			case DRAGON:
			case ECHIDNA:
			case FERRET:
			case FOX:
			case HARPY:
			case HUMAN:
			case KANGAROO:
			case LIZARD:
			case RACCOON:
			case RED_PANDA:
			case SALAMANDER:
				legCount = 2;
				break;
			case CLOVEN_HOOFED:
			case HOOFED:
				if (legCount != 4) legCount = 2;
				break;
			case PONY:
				legCount = 4;
				break;
			case CENTAUR: // deprecated value
				legCount = 4;
				type     = HOOFED;
				break;
			case DEERTAUR:
				legCount = 4;
				type     = CLOVEN_HOOFED;
				break;
			case DRIDER:
				legCount = 8;
				break;
			case PLANT_FLOWER:
				legCount = 12;
				break;
		}
	}
	public function LowerBody(creature:Creature) {
		super(creature,"lowerBodyPart",["legCount"]);
	}

	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
		legCount = 2;
	}
	
	public function legs():String {
		if (isTaur())
			return num2Text(legCount) + " legs";
		
		switch (type) {
			case DRIDER: return num2Text(legCount) + " spider legs";
			case PLANT_FLOWER: return num2Text(legCount) + " vine-like tentacle stamens";
			case HUMAN: return "legs";
			case HOOFED: return "legs";
			case DOG:  return "legs";
			case NAGA: return "snake-like coils";
			case GOO:  return "mounds of goo";
			case PONY: return "cute pony-legs";
			case BUNNY: {
				switch(Math.floor(Math.random() * (5))) {
					case 0 : return "fuzzy, bunny legs";
					case 1 : return "fur-covered legs";
					case 2 : return "furry legs";
					default: return "legs";
				}
			}
			case HARPY: {
				switch(Math.floor(Math.random() * (5))) {
					case 0 : return "bird-like legs";
					case 1 : return "feathered legs";
					default: return "legs";
				}
			}
			case FOX: {
				switch(Math.floor(Math.random() * (4))) {
					case 0 : return "fox-like legs";
					case 1 : return "legs";
					case 2 : return "legs";
					default: return "vulpine legs";
				}
			}
			case RACCOON: {
				switch(Math.floor(Math.random() * (4))) {
					case 0 : return "raccoon-like legs";
					default: return "legs";
				}
			}
			case CLOVEN_HOOFED: {
				switch(Math.floor(Math.random() * (4))) {
					case 0 : return "pig-like legs";
					case 1 : return "legs";
					case 2 : return "legs";
					default: return "swine legs";
				}
			}
			default:
				return "legs";
		}
	}
	
	public function leg():String {
		switch(type){
			case HUMAN:
			case HOOFED:
			case DOG:
				return "leg";
			case NAGA:
				return "snake-tail";
			case CENTAUR:
				return "equine leg";
			case GOO:
				return "mound of goo";
			case PONY:
				return "cartoonish pony-leg";
			case BUNNY:
				switch(Math.random()*5){
					case 0 : return "fuzzy, bunny leg";
					case 1 : return "fur-covered leg";
					case 2 : return "furry leg";
					default: return "leg";
				}
			case HARPY:
				switch(Math.floor(Math.random() * 5)){
					case 0 : return "bird-like leg";
					case 1 : return "feathered leg";
					default: return "leg";
				}
			case FOX:
				switch(Math.floor(Math.random() * 4)){
					case 0 : return "fox-like leg";
					case 1 : return "vulpine leg";
					default: return "leg";
				}
			case RACCOON:
				switch(Math.floor(Math.random() * 4)){
					case 0 : return "raccoon-like leg";
					default: return "leg";
				}
			default:
				return "leg";
		}
	}

	public function feet():String {
		switch(type){
			case HUMAN: return "feet";
			case HOOFED: return "hooves";
			case DOG: return "paws";
			case NAGA: return "coils";
			case CENTAUR: return "hooves";
			case DEMONIC_HIGH_HEELS: return "demonic high-heels";
			case DEMONIC_CLAWS: return "demonic foot-claws";
			case GOO: return "slimey cillia";
			case PONY: return "flat pony-feet";
			case BUNNY: {
				switch(rand(5)){
					case 0 : return "large bunny feet";
					case 1 : return "rabbit feet";
					case 2 : return "large feet";
					default: return "feet";
				}
			}
			case HARPY: {
				switch(Math.floor(Math.random() * 5)){
					case 0 : return "taloned feet";
					default: return "feet";
				}
			}
			case KANGAROO: return "foot-paws";
			case FOX: {
				switch(rand(4)){
					case 0 : return "soft, padded paws";
					case 1 : return "fox-like feet";
					default: return "paws";
				}
			}
			case RACCOON: {
				switch (Math.floor(Math.random() * 3)){
					case 0 : return "raccoon-like feet";
					case 1 : return "long-toed paws";
					case 2 : return "feet";
					default: return "paws";
				}
			}
			default: return "feet";
		}
	}

	public function foot():String {
		switch(type){
			case HUMAN: return "foot";
			case HOOFED: return "hoof";
			case DOG: return "paw";
			case NAGA: return "coiled tail";
			case CENTAUR: return "hoof";
			case GOO: return "slimey undercarriage";
			case PONY: return "flat pony-foot";
			case BUNNY: {
				switch(Math.random() * (5)) {
					case 0 : return "large bunny foot";
					case 1 : return "rabbit foot";
					case 2 : return "large foot";
					default: return "foot";
				}
			}
			case HARPY: {
				switch(Math.floor(Math.random() * (5))) {
					case 0 : return "taloned foot";
					default: return "foot";
				}
			}
			case FOX: {
				switch(Math.floor(Math.random() * (4))) {
					case 0 : return "paw";
					case 1 : return "soft, padded paw";
					case 2 : return "fox-like foot";
					default: return "paw";
				}
			}
			case KANGAROO: return "foot-paw";
			case RACCOON: {
				switch(Math.floor(Math.random() * (3))) {
					case 0 : return "raccoon-like foot";
					case 1 : return "long-toed paw";
					case 2 : return "foot";
					default: return "paw";
				}
			}
			default: return "foot";
		}
	}
	public function isDrider():Boolean {
		return (type == DRIDER);
	}
	public function isGoo():Boolean {
		return type == GOO;
	}
	public function isBiped():Boolean {
		return legCount == 2;
	}
	public function isNaga():Boolean {
		return type == NAGA;
	}

	public function isTaur():Boolean {
		// driders have genitals on their human part, inlike usual taurs... this is actually bad way to check, but too many places to fix just now
		return legCount == 4 && type != PLANT_FLOWER;
	}
	public function isScylla():Boolean {
		return type == SCYLLA;
	}
	public function isAlraune():Boolean {
		return type == PLANT_FLOWER;
	}
	
	override protected function loadFromOldSave(savedata:Object):void {
		type = intOr(savedata.lowerBody, HUMAN);
		if (type === CENTAUR) {
			type = HOOFED;
		} else if (type === DEERTAUR) {
			type = CLOVEN_HOOFED;
		}
		legCount = intOr(savedata.legCount,2);
	}

	override protected function saveToOldSave(savedata:Object):void {
		savedata.lowerBody = type;
		savedata.legCount = legCount;
	}
}
}
