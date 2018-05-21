package classes.BodyParts {
import classes.internals.EnumValue;

public class Hair extends BodyPart {
	public static const Types:/*EnumValue*/Array  = [];
	
	public static const NORMAL:int  = EnumValue.add(Types,0,"NORMAL",{name:"normal"});
	public static const FEATHER:int = EnumValue.add(Types,1,"FEATHER",{name:"feather"});
	public static const GHOST:int   = EnumValue.add(Types,2,"GHOST",{name:"transparent"});
	public static const GOO:int     = EnumValue.add(Types,3,"GOO",{name:"goopy"});
	public static const ANEMONE:int = EnumValue.add(Types,4,"ANEMONE",{name:"tentacle"});
	public static const QUILL:int   = EnumValue.add(Types,5,"QUILL",{name:"quill"});
	public static const GORGON:int  = EnumValue.add(Types,6,"GORGON",{name:"snake-like"});
	public static const LEAF:int    = EnumValue.add(Types,7,"LEAF",{name:"leaf"});
	public static const FLUFFY:int  = EnumValue.add(Types,8,"FLUFFY",{name:"fluffy"});
	public static const GRASS:int   = EnumValue.add(Types,9,"GRASS",{name:"grass"});
	public static const SILKEN:int  = EnumValue.add(Types,10,"SILKEN",{name:"silk-like"});
	public static const STORM:int   = EnumValue.add(Types,11,"STORM",{name:"glowing lightning shaped"});
	
	public var color:String = "no";
	public var length:Number = 0.0;
	
	public function Hair() {
		super(null, null);
	}
	
	public override function restore(keepColor:Boolean = true):void {
		super.restore();
		color = "no";
		length = 0.0;
	}
}
}
