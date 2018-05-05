package classes.BodyParts {
import classes.internals.EnumValue;

public class Ears extends BodyPart {
	public static const Types:/*EnumValue*/Array  = [];
	public static const HUMAN:int     = EnumValue.add(Types, 0, "HUMAN", {name:"human"});
	public static const HORSE:int     = EnumValue.add(Types, 1, "HORSE", {name:"horse"});
	public static const DOG:int       = EnumValue.add(Types, 2, "DOG", {name:"dog"});
	public static const COW:int       = EnumValue.add(Types, 3, "COW", {name:"cow"});
	public static const ELFIN:int     = EnumValue.add(Types, 4, "ELFIN", {name:"elfin"});
	public static const CAT:int       = EnumValue.add(Types, 5, "CAT", {name:"cat"});
	public static const LIZARD:int    = EnumValue.add(Types, 6, "LIZARD", {name:"lizard"});
	public static const BUNNY:int     = EnumValue.add(Types, 7, "BUNNY", {name:"bunny"});
	public static const KANGAROO:int  = EnumValue.add(Types, 8, "KANGAROO", {name:"kangaroo"});
	public static const FOX:int       = EnumValue.add(Types, 9, "FOX", {name:"fox"});
	public static const DRAGON:int    = EnumValue.add(Types, 10, "DRAGON", {name:"dragon"});
	public static const RACCOON:int   = EnumValue.add(Types, 11, "RACCOON", {name:"raccoon"});
	public static const MOUSE:int     = EnumValue.add(Types, 12, "MOUSE", {name:"mouse"});
	public static const FERRET:int    = EnumValue.add(Types, 13, "FERRET", {name:"ferret"});
	public static const PIG:int       = EnumValue.add(Types, 14, "PIG", {name:"pig"});
	public static const RHINO:int     = EnumValue.add(Types, 15, "RHINO", {name:"rhino"});
	public static const ECHIDNA:int   = EnumValue.add(Types, 16, "ECHIDNA", {name:"echidna"});
	public static const DEER:int      = EnumValue.add(Types, 17, "DEER", {name:"deer"});
	public static const WOLF:int      = EnumValue.add(Types, 18, "WOLF", {name:"wolf"});
	public static const LION:int      = EnumValue.add(Types, 19, "LION", {name:"lion"});
	public static const YETI:int      = EnumValue.add(Types, 20, "YETI", {name:"yeti"});
	public static const ORCA:int      = EnumValue.add(Types, 21, "ORCA", {name:"orca"});
	public static const SNAKE:int     = EnumValue.add(Types, 22, "SNAKE", {name:"snake"});
	public static const GOAT:int      = EnumValue.add(Types, 23, "GOAT", {name:"goat"});
	public static const ONI:int       = EnumValue.add(Types, 24, "ONI", {name:"oni"});
	public static const ELVEN:int     = EnumValue.add(Types, 25, "ELVEN", {name:"elven"});
	public static const WEASEL:int    = EnumValue.add(Types, 26, "WEASEL", {name:"weasel"});
	public static const BAT:int       = EnumValue.add(Types, 27, "BAT", {name:"bat"});
	public static const VAMPIRE:int   = EnumValue.add(Types, 28, "VAMPIRE", {name:"vampire"});
	public static const RED_PANDA:int = EnumValue.add(Types, 29, "RED_PANDA", {name:"red-panda"});
	public static const AVIAN:int	  = EnumValue.add(Types, 30, "AVIAN", {name:"avian"});
	public static const GRYPHON:int	  = EnumValue.add(Types, 31, "GRYPHON", {name:"gryphon"});
	
	public function Ears() {
		super(null, null);
	}
}
}
