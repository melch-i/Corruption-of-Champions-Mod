package classes.BodyParts {
import classes.internals.EnumValue;

public class Arms extends BodyPart {
	public static const Types:/*EnumValue*/Array = [];
	
	public static const HUMAN:int      = EnumValue.add(Types, 0, "HUMAN", {name: "human"});
	public static const HARPY:int      = EnumValue.add(Types, 1, "HARPY", {name: "harpy"});
	public static const SPIDER:int     = EnumValue.add(Types, 2, "SPIDER", {name: "spider"});
	public static const MANTIS:int     = EnumValue.add(Types, 3, "MANTIS", {name: "mantis"});
	public static const BEE:int        = EnumValue.add(Types, 4, "BEE", {name: "bee"});
	public static const SALAMANDER:int = EnumValue.add(Types, 5, "SALAMANDER", {name: "salamander"});
	public static const PHOENIX:int    = EnumValue.add(Types, 6, "PHOENIX", {name: "phoenix"});
	public static const PLANT:int      = EnumValue.add(Types, 7, "PLANT", {name: "vine-covered"});
	public static const SHARK:int      = EnumValue.add(Types, 8, "SHARK", {name: "shark"});
	public static const GARGOYLE:int   = EnumValue.add(Types, 9, "GARGOYLE", {name: "gargoyle"});
	public static const WOLF:int       = EnumValue.add(Types, 10, "WOLF", {name: "wolf"});
	public static const LION:int       = EnumValue.add(Types, 11, "LION", {name: "lion"});
	public static const KITSUNE:int    = EnumValue.add(Types, 12, "KITSUNE", {name: "kitsune"});
	public static const FOX:int        = EnumValue.add(Types, 13, "FOX", {name: "fox"});
	public static const LIZARD:int     = EnumValue.add(Types, 14, "LIZARD", {name: "lizard"});
	public static const DRAGON:int     = EnumValue.add(Types, 15, "DRAGON", {name: "dragon"});
	public static const YETI:int       = EnumValue.add(Types, 16, "YETI", {name: "yeti"});
	public static const ORCA:int       = EnumValue.add(Types, 17, "ORCA", {name: "orca"});
	public static const PLANT2:int     = EnumValue.add(Types, 18, "PLANT2", {name: "tentacle-covered"});
	public static const DEVIL:int      = EnumValue.add(Types, 19, "DEVIL", {name: "devil"});
	public static const ONI:int        = EnumValue.add(Types, 20, "ONI", {name: "oni"});
	public static const ELF:int        = EnumValue.add(Types, 21, "ELF", {name: "elf"});
	public static const RAIJU:int      = EnumValue.add(Types, 22, "RAIJU", {name: "raiju"});
	public static const RED_PANDA:int  = EnumValue.add(Types, 23, "RED_PANDA", {name: "red-panda"});
	public static const GARGOYLE_2:int = EnumValue.add(Types, 24, "GARGOYLE_2", {name: "gargoyle"});
	public static const CAT:int        = EnumValue.add(Types, 25, "CAT", {name: "cat"});
	public static const AVIAN:int      = EnumValue.add(Types, 26, "AVIAN", {name: "avian"});
	public static const GRYPHON:int    = EnumValue.add(Types, 27, "GRYPHON", {name: "gryphon"});
	public static const SPHINX:int     = EnumValue.add(Types, 28, "SPHINX", {name: "sphinx"});
	
	public function Arms() {
		super(null, null);
	}
}
}
