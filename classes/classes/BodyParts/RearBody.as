package classes.BodyParts {
import classes.internals.EnumValue;

public class RearBody extends BodyPart {
	public static const Types:/*EnumValue*/Array = [];
	
	public static const NONE:int              = EnumValue.add(Types, 0, "NONE", {name:"none"});
	public static const DRACONIC_MANE:int     = EnumValue.add(Types, 1, "DRACONIC_MANE", {name:"draconic hairy mane"});
	public static const DRACONIC_SPIKES:int   = EnumValue.add(Types, 2, "DRACONIC_SPIKES", {name:"draconic spiky mane"});
	public static const FENRIR_ICE_SPIKES:int = EnumValue.add(Types, 3, "FENRIR_ICE_SPIKES", {name:"ice shards"});
	public static const LION_MANE:int         = EnumValue.add(Types, 4, "LION_MANE", {name:"lion mane"});
	public static const BEHEMOTH:int          = EnumValue.add(Types, 5, "BEHEMOTH", {name:"behemoth spikes"});
	public static const SHARK_FIN:int         = EnumValue.add(Types, 6, "SHARK_FIN", {name:"shark fin"});
	public static const ORCA_BLOWHOLE:int     = EnumValue.add(Types, 7, "ORCA_BLOWHOLE", {name:"orca blowhole"});
	public static const RAIJU_MANE:int        = EnumValue.add(Types, 8, "RAIJU_MANE", {name:"raiju mane"});
	public static const BAT_COLLAR:int        = EnumValue.add(Types, 9, "BAT_COLLAR", {name:"bat collar"});
	public static const WOLF_COLLAR:int       = EnumValue.add(Types, 10, "WOLF_COLLAR", {name:"wolf collar"});
	
	public function RearBody() {
		super(null, null);
	}
}
}
