/**
 * Created by aimozg on 27.04.2017.
 */
package classes.BodyParts {
import classes.Creature;
import classes.internals.EnumValue;

public class Claws extends SaveableBodyPart {
	public var tone:String                  = "";
	
	public static const Types:/*EnumValue*/Array = [];
	
	public static const NORMAL:int     =  EnumValue.add(Types, 0, "NORMAL", {name:"fingernails"});
	public static const LIZARD:int     =  EnumValue.add(Types, 1, "LIZARD", {name:"claws"});
	public static const DRAGON:int     =  EnumValue.add(Types, 2, "DRAGON", {name:"claws"});
	public static const SALAMANDER:int =  EnumValue.add(Types, 3, "SALAMANDER", {name:"claws"});
	public static const CAT:int        =  EnumValue.add(Types, 4, "CAT", {name:"claws"}); // NYI! Placeholder for now!!
	public static const DOG:int        =  EnumValue.add(Types, 5, "DOG", {name:"claws"}); // NYI! Placeholder for now!!
	public static const RAPTOR:int     =  EnumValue.add(Types, 6, "RAPTOR", {name:"claws"}); // NYI! Placeholder for now!!
	public static const MANTIS:int     =  EnumValue.add(Types, 7, "MANTIS", {name:"claws"}); // NYI! Placeholder for Xianxia mod
	public static const IMP:int        =  EnumValue.add(Types, 8, "IMP", {name:"claws"}); // NYI! Placeholder from Revamp
	public static const COCKATRICE:int =  EnumValue.add(Types, 9, "COCKATRICE", {name:"claws"}); // NYI! Placeholder from Revamp
	public static const RED_PANDA:int  = EnumValue.add(Types, 10, "RED_PANDA", {name:"claws"}); // NYI! Placeholder from Revamp
	
	public function Claws(creature:Creature) {
		super(creature,"clawsPart",["tone"]);
	}

	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
		tone = "";
	}

	override public function descriptionFull():String {
		var toneText:String = tone == "" ? " " : (", " + tone + " ");
		switch (type) {
			case NORMAL: return "fingernails";
			case LIZARD: return "short curved" + toneText + "claws";
			case DRAGON: return "powerful, thick curved" + toneText + "claws";
			// Since mander arms are hardcoded and the others are NYI, we're done here for now
		}
		return "fingernails";
	}

	override protected function loadFromOldSave(savedata:Object):void {
		type = intOr(savedata.clawType,NORMAL);
		tone = stringOr(savedata.clawTone,"");
	}
	override protected function saveToOldSave(savedata:Object):void {
		savedata.clawType = type;
		savedata.clawTone = tone;
	}
}
}
