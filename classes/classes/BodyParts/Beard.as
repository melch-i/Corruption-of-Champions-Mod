package classes.BodyParts {
import classes.internals.EnumValue;

public class Beard extends BodyPart {
	public static const Types:/*EnumValue*/Array = [];
	
	public static const NORMAL:int      = EnumValue.add(Types, 0, "NORMAL", {name: "normal"});
	public static const GOATEE:int      = EnumValue.add(Types, 1, "GOATEE", {name: "goatee"});
	public static const CLEANCUT:int    = EnumValue.add(Types, 2, "CLEANCUT", {name: "clean-cut"});
	public static const MOUNTAINMAN:int = EnumValue.add(Types, 3, "MOUNTAINMAN", {name: "mountain-man"});
	
	public var length:Number = 0;
	public function Beard() {
		super(null, null);
	}
}
}
