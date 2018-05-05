package classes.BodyParts {
import classes.internals.EnumValue;

public class Horns extends BodyPart {
	public static const Types:/*EnumValue*/Array     = [];
	
	public static const NONE:int                     = EnumValue.add(Types, 0, "NONE", {name:"no"});
	public static const DEMON:int                    = EnumValue.add(Types, 1, "DEMON", {name:"demon"});
	public static const COW_MINOTAUR:int             = EnumValue.add(Types, 2, "COW_MINOTAUR", {name:"cow"});
	public static const DRACONIC_X2:int              = EnumValue.add(Types, 3, "DRACONIC_X2", {name:"2 draconig"});
	public static const DRACONIC_X4_12_INCH_LONG:int = EnumValue.add(Types, 4, "DRACONIC_X4_12_INCH_LONG", {name:"four 12\" long draconic"});
	public static const ANTLERS:int                  = EnumValue.add(Types, 5, "ANTLERS", {name:"deer"});
	public static const GOAT:int                     = EnumValue.add(Types, 6, "GOAT", {name:"goat"});
	public static const UNICORN:int                  = EnumValue.add(Types, 7, "UNICORN", {name:"rhino"});
	public static const RHINO:int                    = EnumValue.add(Types, 8, "RHINO", {name:"unicorn"});
	public static const OAK:int                      = EnumValue.add(Types, 9, "OAK", {name:"oak"});
	public static const GARGOYLE:int                 = EnumValue.add(Types, 10, "GARGOYLE", {name:"gargoyle"});
	public static const ORCHID:int                   = EnumValue.add(Types, 11, "ORCHID", {name:"orchid"});
	public static const ONI_X2:int                   = EnumValue.add(Types, 12, "ONI_X2", {name:"1 oni"});
	public static const ONI:int                      = EnumValue.add(Types, 13, "ONI", {name:"2 oni"});
	public static const BICORN:int                   = EnumValue.add(Types, 14, "BICORN", {name:"bicorn"});
	
	public function Horns() {
		super(null, null);
	}
	public var count:int = 0;
}
}
