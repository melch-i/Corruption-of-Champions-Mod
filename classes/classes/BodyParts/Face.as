/**
 * Created by aimozg on 27.04.2017.
 */
package classes.BodyParts {
import classes.Creature;
import classes.internals.EnumValue;

public class Face extends SaveableBodyPart {
	public static const Types:/*EnumValue*/Array = [];
	
	public static const HUMAN:int            = EnumValue.add(Types,0,"HUMAN",{name:'human face'});
	public static const HORSE:int            = EnumValue.add(Types,1,"HORSE",{name:'horse face'});
	public static const DOG:int              = EnumValue.add(Types,2,"DOG",{name:'dog muzzle'});
	public static const COW_MINOTAUR:int     = EnumValue.add(Types,3,"COW_MINOTAUR",{name:'cow face'});
	public static const SHARK_TEETH:int      = EnumValue.add(Types,4,"SHARK_TEETH",{name:'shark face'});
	public static const SNAKE_FANGS:int      = EnumValue.add(Types,5,"SNAKE_FANGS",{name:'snake face'});
	public static const CAT:int              = EnumValue.add(Types,6,"CAT",{name:'cat muzzle'});
	public static const LIZARD:int           = EnumValue.add(Types,7,"LIZARD",{name:'lizard face'});
	public static const BUNNY:int            = EnumValue.add(Types,8,"BUNNY",{name:'bunny muzzle'});
	public static const KANGAROO:int         = EnumValue.add(Types,9,"KANGAROO",{name:'kangaroo muzzle'});
	public static const SPIDER_FANGS:int     = EnumValue.add(Types,10,"SPIDER_FANGS",{name:'spider face'});
	public static const FOX:int              = EnumValue.add(Types,11,"FOX",{name:'fox muzzle'});
	public static const DRAGON:int           = EnumValue.add(Types,12,"DRAGON",{name:'dragon muzzle'});
	public static const RACCOON_MASK:int     = EnumValue.add(Types,13,"RACCOON_MASK",{name:'human face with raccoon mask'});
	public static const RACCOON:int          = EnumValue.add(Types,14,"RACCOON",{name:'racoon face'});
	public static const BUCKTEETH:int        = EnumValue.add(Types,15,"BUCKTEETH",{name:'human face with buckteeth'});
	public static const MOUSE:int            = EnumValue.add(Types,16,"MOUSE",{name:'mouse muzzle'});
	public static const FERRET_MASK:int      = EnumValue.add(Types,17,"FERRET_MASK",{name:'human face with ferret mask'});
	public static const FERRET:int           = EnumValue.add(Types,18,"FERRET",{name:'ferret muzzle'});
	public static const PIG:int              = EnumValue.add(Types,19,"PIG",{name:'pig muzzle'});
	public static const BOAR:int             = EnumValue.add(Types,20,"BOAR",{name:'boar muzzle'});
	public static const RHINO:int            = EnumValue.add(Types,21,"RHINO",{name:'rhino muzzle'});
	public static const ECHIDNA:int          = EnumValue.add(Types,22,"ECHIDNA",{name:'echidna muzzle'});
	public static const DEER:int             = EnumValue.add(Types,23,"DEER",{name:'deer muzzle'});
	public static const WOLF:int             = EnumValue.add(Types,24,"WOLF",{name:'wolf muzzle'});
	public static const MANTICORE:int        = EnumValue.add(Types,25,"MANTICORE",{name:'manticore face'});
	public static const SALAMANDER_FANGS:int = EnumValue.add(Types,26,"SALAMANDER_FANGS",{name:'salamander face'});
	public static const YETI_FANGS:int       = EnumValue.add(Types,27,"YETI_FANGS",{name:'yeti face'});
	public static const ORCA:int	         = EnumValue.add(Types,28,"ORCA",{name:'orca face'});
	public static const PLANT_DRAGON:int	 = EnumValue.add(Types,29,"PLANT_DRAGON",{name:'plant dragon face'});
	public static const DRAGON_FANGS:int	 = EnumValue.add(Types,30,"DRAGON_FANGS",{name:'human face with dragon fangs'});
	public static const DEVIL_FANGS:int 	 = EnumValue.add(Types,31,"DEVIL_FANGS",{name:'human face with devil fangs'});
	public static const ONI_TEETH:int   	 = EnumValue.add(Types,32,"ONI_TEETH",{name:'oni face'});
	public static const RAIJU_FANGS:int 	 = EnumValue.add(Types,33,"RAIJU_FANGS",{name:'raiju face'});
	public static const VAMPIRE:int     	 = EnumValue.add(Types,34,"VAMPIRE",{name:'human face with vampire fangs'});
	public static const BUCKTOOTH:int   	 = EnumValue.add(Types,35,"BUCKTOOTH",{name:'human face with jabberwocky buck teeth'});
	public static const JABBERWOCKY:int 	 = EnumValue.add(Types,36,"JABBERWOCKY",{name:'jabberwocky face'});
	public static const RED_PANDA:int   	 = EnumValue.add(Types,37,"RED_PANDA",{name:'red panda muzzle'});
	public static const CAT_CANINES:int 	 = EnumValue.add(Types,38,"CAT_CANINES",{name:'human face with cat canines'});
	public static const CHESHIRE:int    	 = EnumValue.add(Types,39,"CHESHIRE",{name:'cheshire cat muzzle'});
	public static const CHESHIRE_SMILE:int	 = EnumValue.add(Types,40,"CHESHIRE_SMILE",{name:'human face with cheshire cat smile'});
	public static const AVIAN:int			 = EnumValue.add(Types,41,"AVIAN",{name:'avian beak'});
	public static const WOLF_FANGS:int		 = EnumValue.add(Types,42,"WOLF_FANGS",{name:'human face with wolf fangs'});
	
	public function Face(creature:Creature) {
		super(creature,"facePart",[]);
	}

	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
	}
	public function hasMuzzle():Boolean {
		return [
			HORSE, DOG, CAT, LIZARD, KANGAROO,
			FOX, DRAGON, RHINO, ECHIDNA, DEER,
			WOLF
			   ].indexOf(type) >= 0;
	}
	public function hasBeak():Boolean {
		return [
			AVIAN
			   ].indexOf(type) >= 0;
	}
	public function hasBeard():Boolean {
		return creature.beardLength > 0;
	}
	public function beard():String {
		if (hasBeard()) {
			return "beard";
		} else {
			//CoC_Settings.error("");
			return "ERROR: NO BEARD! <b>YOU ARE NOT A VIKING AND SHOULD TELL KITTEH IMMEDIATELY.</b>";
		}
	}
	public function isHumanShaped():Boolean {
		return isAny(HUMAN,
				MANTICORE, BUCKTEETH, BUNNY, SHARK_TEETH,
				SNAKE_FANGS, SPIDER_FANGS, YETI_FANGS, SALAMANDER_FANGS,
				FERRET_MASK, VAMPIRE);
	}
	public function nounPhrase():String {
		var stringo:String = "";
		if (type == HUMAN) {
			return "face";
		}
		if (hasMuzzle()) {
			if (trueOnceInN(3)) {
				if (type == HORSE) {
					stringo = "long ";
				}
				if (type == CAT) {
					stringo = "feline ";
				}
				if (type == RHINO) {
					stringo = "rhino ";
				}
				if (type == LIZARD
						|| type == DRAGON) {
					stringo = "reptilian ";
				}
				if (type == WOLF) {
					stringo = "canine ";
				}
			}
			return stringo + randomChoice("muzzle", "snout", "face");
		}
		//3 - cowface
		if (type == COW_MINOTAUR) {
			if (trueOnceInN(4)) stringo = "bovine ";
			return randomChoice("muzzle", stringo + "face");
		}
		//4 - sharkface-teeth
		if (type == SHARK_TEETH) {
			if (trueOnceInN(4)) stringo = "angular ";
			return stringo + "face";
		}
		if (type == PIG || type == BOAR) {
			if (trueOnceInN(4)) {
				stringo = (type == PIG ? "pig" : "boar") + "-like ";
			}
			if (trueOnceInN(4))
				return stringo + "snout";
			return stringo + "face";
		}
		return "face";
	}

	override public function descriptionFull():String {
		return describe(false, true);
	}
	/**
	 * @param article (default false): Add an article a/an/the (default false): Describe femininity level
	 * @param deco (default false): If has decoration
	 */
	public function describe(article:Boolean=false,deco:Boolean=false):String {
		var femininity:Number = creature.femininity;
		var a:String          = "", an:String = "", the:String = "";
		if (article) {
			a   = "a ";
			an  = "an ";
			the = "the ";
		}
		return a + nounPhrase();
	}
	public function describeMF(article:Boolean=false):String {
			var faceo:String = "";
		var femininity:Number = creature.femininity;
		var a:String          = "", an:String = "", the:String = "";
		if (article) {
			a   = "a ";
			an  = "an ";
			the = "the ";
		}
			//0-10
			if (femininity < 10) {
				faceo = a + "square chin";
				if (!hasBeard()) faceo += " and chiseled jawline";
				else faceo += ", chiseled jawline, and " + beard();
				return faceo;
			}
			//10+ -20
			else if (femininity < 20) {
			faceo = a + "rugged looks ";
				if (hasBeard()) faceo += "and " + beard();
				return faceo + "that's surely handsome";
			}
			//21-28
			else if (femininity < 28)
				return a + "well-defined jawline and a fairly masculine profile";
			//28+-35
			else if (femininity < 35)
				return a + "somewhat masculine, angular jawline";
			//35-45
			else if (femininity < 45)
				return the + "barest hint of masculinity on its features";
			//45-55
			else if (femininity <= 55)
				return an + "androgynous set of features that would look normal on a male or female";
			//55+-65
			else if (femininity <= 65)
				return a + "tiny touch of femininity to it, with gentle curves";
			//65+-72
			else if (femininity <= 72)
				return a + "nice set of cheekbones and lips that have the barest hint of pout";
			//72+-80
			else if (femininity <= 80)
				return a + "beautiful, feminine shapeliness that's sure to draw the attention of males";
			//81-90
			else if (femininity <= 90)
				return a + "gorgeous profile with full lips, a button nose, and noticeable eyelashes";
			//91-100
			else
				return a + "jaw-droppingly feminine shape with full, pouting lips, an adorable nose, and long, beautiful eyelashes";
		}
	override protected function loadFromOldSave(savedata:Object):void {
		type = intOr(savedata.faceType, HUMAN);
	}
	override protected function saveToOldSave(savedata:Object):void {
		savedata.faceType = type;
	}
}
}
