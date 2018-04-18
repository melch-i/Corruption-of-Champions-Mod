package classes.BodyParts {
import classes.internals.EnumValue;

public class Eyes extends BodyPart {
	public var count:int;
	
	public static const Types:/*EnumValue*/Array  = [];
	
	public static const HUMAN:int                = EnumValue.add(Types,0,"HUMAN",{name:"human"});
	public static const FOUR_SPIDER_EYES:int     = EnumValue.add(Types,1,"FOUR_SPIDER_EYES",{name:"4 spider"});
	public static const BLACK_EYES_SAND_TRAP:int = EnumValue.add(Types,2,"BLACK_EYES_SAND_TRAP",{name:"sandtrap"});
	public static const CAT_SLITS:int            = EnumValue.add(Types,3,"CAT_SLITS",{name:"cat"});
	public static const GORGON:int               = EnumValue.add(Types,4,"GORGON",{name:"snake"});
	public static const FENRIR:int               = EnumValue.add(Types,5,"FENRIR",{name:"fenrir"});
	public static const MANTICORE:int            = EnumValue.add(Types,6,"MANTICORE",{name:"manticore"});
	public static const FOX:int                  = EnumValue.add(Types,7,"FOX",{name:"fox"});
	public static const REPTILIAN:int            = EnumValue.add(Types,8,"REPTILIAN",{name:"reptilian"});
	public static const SNAKE:int                = EnumValue.add(Types,9,"SNAKE",{name:"snake"});
	public static const DRAGON:int               = EnumValue.add(Types,10,"DRAGON",{name:"dragon"});
	public static const DEVIL:int                = EnumValue.add(Types,11,"DEVIL",{name:"devil"});
	public static const ONI:int                  = EnumValue.add(Types,12,"ONI",{name:"oni"});
	public static const ELF:int                  = EnumValue.add(Types,13,"ELF",{name:"elf"});
	public static const RAIJU:int                = EnumValue.add(Types,14,"RAIJU",{name:"raiju"});
	public static const VAMPIRE:int              = EnumValue.add(Types,15,"VAMPIRE",{name:"vampire"});
	public static const GEMSTONES:int            = EnumValue.add(Types,16,"GEMSTONES",{name:"gemstone"});
	public static const FERAL:int            	 = EnumValue.add(Types,17,"FERAL",{name:"feral"});
	public static const GRYPHON:int            	 = EnumValue.add(Types,18,"GRYPHON",{name:"gryphon"});
	
	public var colour:String = "brown";
	public function Eyes() {
		super(null, null);
	}
}
}
