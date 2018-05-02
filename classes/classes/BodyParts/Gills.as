package classes.BodyParts {
import classes.internals.EnumValue;

public class Gills extends BodyPart {
	public static const Types:/*EnumValue*/Array     = [];
	
	public static const NONE:int                   = 0;
	EnumValue.add(Types, NONE, "NONE", {name:"no gills"});
	public static const ANEMONE:int                = EnumValue.add(Types, 1, "ANEMONE", {name:"anemone gills"});
	public static const FISH:int                   = EnumValue.add(Types, 2, "FISH", {name:"fish gills"});
	public static const GILLS_IN_TENTACLE_LEGS:int = EnumValue.add(Types, 3, "GILLS_IN_TENTACLE_LEGS", {name:"gills in tentacle legs"});
	
	public function Gills() {
		super(null, null);
	}
}
}
