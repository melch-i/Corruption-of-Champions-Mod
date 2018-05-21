package classes.BodyParts {
import classes.internals.EnumValue;

public class Antennae extends BodyPart {
	public static const Types:/*EnumValue*/Array = [];
	
	public static const NONE:int       = EnumValue.add(Types, 0, "NONE", {name: "no"});
	public static const MANTIS:int     = EnumValue.add(Types, 1, "MANTIS", {name: "mantis"});
	public static const BEE:int        = EnumValue.add(Types, 2, "BEE", {name: "bee"});
	public static const COCKATRICE:int = EnumValue.add(Types, 3, "COCKATRICE", {name: "cockatrice"});
	
	public function Antennae() {
		super(null, null);
	}
}
}
