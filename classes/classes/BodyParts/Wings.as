package classes.BodyParts {
import classes.internals.EnumValue;

public class Wings extends BodyPart {
	public static const Types:/*EnumValue*/Array = [];
	
	public static const NONE:int                 = EnumValue.add(Types, 0, "NONE", {name:"non-existant"});
	public static const BEE_LIKE_SMALL:int       = EnumValue.add(Types, 1, "BEE_LIKE_SMALL", {name:"small bee-like"});
	public static const BEE_LIKE_LARGE:int       = EnumValue.add(Types, 2, "BEE_LIKE_LARGE", {name:"large bee-like"});
	public static const HARPY:int                = EnumValue.add(Types, 4, "HARPY", {name:"harpy"});
	public static const IMP:int                  = EnumValue.add(Types, 5, "IMP", {name:"imp"});
	public static const BAT_LIKE_TINY:int        = EnumValue.add(Types, 6, "BAT_LIKE_TINY", {name:"tiny bat-like"});
	public static const BAT_LIKE_LARGE:int       = EnumValue.add(Types, 7, "BAT_LIKE_LARGE", {name:"large bat-like"});
	public static const SHARK_FIN:int            = EnumValue.add(Types, 8, "SHARK_FIN", {name:"shark fin"});
	public static const FEATHERED_LARGE:int      = EnumValue.add(Types, 9, "FEATHERED_LARGE", {name:"large feathered"});
	public static const DRACONIC_SMALL:int       = EnumValue.add(Types, 10, "DRACONIC_SMALL", {name:"small draconic"});
	public static const DRACONIC_LARGE:int       = EnumValue.add(Types, 11, "DRACONIC_LARGE", {name:"large draconic"});
	public static const GIANT_DRAGONFLY:int      = EnumValue.add(Types, 12, "GIANT_DRAGONFLY", {name:"giant dragonfly"});
	public static const BAT_LIKE_LARGE_2:int     = EnumValue.add(Types, 13, "BAT_LIKE_LARGE_2", {name:"two large pairs of bat-like"});
	public static const DRACONIC_HUGE:int        = EnumValue.add(Types, 14, "DRACONIC_HUGE", {name:"large majestic draconic"});
	public static const FEATHERED_PHOENIX:int    = EnumValue.add(Types, 15, "FEATHERED_PHOENIX", {name:"phoenix"});
	public static const FEATHERED_ALICORN:int    = EnumValue.add(Types, 16, "FEATHERED_ALICORN", {name:"alicorn"});
	public static const MANTIS_LIKE_SMALL:int    = EnumValue.add(Types, 17, "MANTIS_LIKE_SMALL", {name:"small mantis-like"});
	public static const MANTIS_LIKE_LARGE:int    = EnumValue.add(Types, 18, "MANTIS_LIKE_LARGE", {name:"large mantis-like"});
	public static const MANTIS_LIKE_LARGE_2:int  = EnumValue.add(Types, 19, "MANTIS_LIKE_LARGE_2", {name:"two large pairs of mantis-like"});
	public static const GARGOYLE_LIKE_LARGE:int  = EnumValue.add(Types, 20, "GARGOYLE_LIKE_LARGE", {name:"large stony"});
	public static const PLANT:int                = EnumValue.add(Types, 21, "PLANT", {name:"three pairs of cockvines"});
	public static const MANTICORE_LIKE_SMALL:int = EnumValue.add(Types, 22, "MANTICORE_LIKE_SMALL", {name:"small manticore-like"});
	public static const MANTICORE_LIKE_LARGE:int = EnumValue.add(Types, 23, "MANTICORE_LIKE_LARGE", {name:"large manticore-like"});
	public static const BAT_ARM:int              = EnumValue.add(Types, 24, "BAT_ARM", {name:"large manticore-like"});
	public static const VAMPIRE:int              = EnumValue.add(Types, 25, "VAMPIRE", {name:"large manticore-like"});
	public static const FEY_DRAGON_WINGS:int     = EnumValue.add(Types, 26, "FEY_DRAGON_WINGS", {name:"large majestic fey draconic"});
	public static const FEATHERED_AVIAN:int      = EnumValue.add(Types, 27, "FEATHERED_AVIAN", {name:"avian"});
	public static const NIGHTMARE:int    		 = EnumValue.add(Types, 28, "NIGHTMARE", {name:"leathery"});
	public static const FEATHERED_SPHINX:int     = EnumValue.add(Types, 29, "FEATHERED_SPHINX", {name:"sphinx"});
	
	public var desc:String = "non-existant"; // TODO @aimozg @Oxdeception consider removal
	public function Wings() {
		super(null, null);
	}
}
}
