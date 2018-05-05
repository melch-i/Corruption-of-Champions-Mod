package classes.BodyParts {
import classes.internals.EnumValue;

public class Tongue extends BodyPart{
	public static const Types:/*EnumValue*/Array  = [];
	
	public static const HUMAN:int    = EnumValue.add(Types,0,"HUMAN",{name:"human"});
	public static const SNAKE:int    = EnumValue.add(Types,1,"SNAKE",{name:"snake"});
	public static const DEMONIC:int  = EnumValue.add(Types,2,"DEMONIC",{name:"demonic"});
	public static const DRACONIC:int = EnumValue.add(Types,3,"DRACONIC",{name:"draconic"});
	public static const ECHIDNA:int  = EnumValue.add(Types,4,"ECHIDNA",{name:"echidna"});
	public static const CAT:int      = EnumValue.add(Types,5,"CAT",{name:"cat"});
	public static const ELF:int      = EnumValue.add(Types,6,"ELF",{name:"elf"});
	public static const DOG:int      = EnumValue.add(Types,7,"DOG",{name:"dog"});
	
	public function Tongue() {
		super(null, null);
	}
}
}
