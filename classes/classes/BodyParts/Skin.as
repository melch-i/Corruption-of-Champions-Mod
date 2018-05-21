package classes.BodyParts {
import classes.Creature;
import classes.internals.EnumValue;

/**
 * Container class for the players skin
 *
 * * character has two layer of skin: base and ~~cover~~ coat
 * each layer has: `type`, `tone`, `adj` (optional adjective), and `desc` (overrides default noun for type)
 * a **coverage** parameter with the rance:
 * `(0) COVERAGE_NONE` : coat layer is non-existant
 * `(1) COVERAGE_LOW` : coat layer exists, but its descriptions appear only when explicitly called
 * `(2) COVERAGE_MEDIUM` : coat layer exists, descriptions use mixed "[base] and [coat]", can explicitly check either
 * `(3) COVERAGE_HIGH` : coat layer exists and is used as a default layer when describing skin; base description appear only when explicitly called
 * `(4) COVERAGE_COMPLETE` : same as COVERAGE_HIGH; intended to be used when even face is fully coverred
 * tattoos should be moved to body part-level as patterns
 *
 * @since December 27, 2016
 * @author Stadler76, aimozg
 */
public class Skin extends SaveableBodyPart {

    public static const COVERAGE_NONE:int     = 0;
	public static const COVERAGE_LOW:int      = 1;
	public static const COVERAGE_MEDIUM:int   = 2;
	public static const COVERAGE_HIGH:int     = 3;
	public static const COVERAGE_COMPLETE:int = 4;
	
	public static const Types:/*EnumValue*/Array  = [];
	public static const PLAIN:int                 = EnumValue.add(Types,0,"PLAIN",{name:"skin",adj:"",plural:false});
	public static const FUR:int                   = EnumValue.add(Types,1,"FUR",{name:"fur",adj:"",plural:false});
	public static const SCALES:int                = EnumValue.add(Types,2,"SCALES",{name:"scales",adj:"",plural:true});
	public static const GOO:int                   = EnumValue.add(Types,3,"GOO",{name:"skin",adj:"goopey",plural:false});
	public static const UNDEFINED:int             = EnumValue.add(Types,4,"UNDEFINED",{name:"",adj:"",plural:false});//[Deprecated] Silently discarded upon loading save
	public static const CHITIN:int                = EnumValue.add(Types,5,"CHITIN",{name:"chitin",adj:"",plural:false});
	public static const BARK:int                  = EnumValue.add(Types,6,"BARK",{name:"bark",adj:"",plural:false});
	public static const STONE:int                 = EnumValue.add(Types,7,"STONE",{name:"stone",adj:"",plural:false});
	public static const TATTOED:int               = EnumValue.add(Types,8,"TATTOED",{name:"tattooed skin",adj:"",plural:false});//[Deprecated] Use pattern
	public static const AQUA_SCALES:int           = EnumValue.add(Types,9,"AQUA_SCALES",{name:"scales",adj:"",plural:true});
	public static const PARTIAL_FUR:int           = EnumValue.add(Types,10,"PARTIAL_FUR",{name:"partial fur",adj:"",plural:false});//[Deprecated] Use coverage
	public static const PARTIAL_SCALES:int        = EnumValue.add(Types,11,"PARTIAL_SCALES",{name:"",adj:"",plural:true});//[Deprecated] Use coverage
	public static const PARTIAL_CHITIN:int        = EnumValue.add(Types,12,"PARTIAL_CHITIN",{name:"",adj:"",plural:false});//[Deprecated] Use coverage
	public static const PARTIAL_BARK:int          = EnumValue.add(Types,13,"PARTIAL_BARK",{name:"",adj:"",plural:false});//[Deprecated] Use coverage
	public static const DRAGON_SCALES:int         = EnumValue.add(Types,14,"DRAGON_SCALES",{name:"dragon scales",adj:"",plural:true});
	public static const MOSS:int                  = EnumValue.add(Types,15,"MOSS",{name:"moss",adj:"",plural:false});
	public static const PARTIAL_DRAGON_SCALES:int = EnumValue.add(Types,16,"PARTIAL_DRAGON_SCALES",{name:"",adj:"",plural:true});//[Deprecated] Use coverage
	public static const PARTIAL_STONE:int         = EnumValue.add(Types,17,"PARTIAL_STONE",{name:"",adj:"",plural:false});//[Deprecated] Use coverage
	public static const PARTIAL_AQUA_SCALES:int   = EnumValue.add(Types,18,"PARTIAL_AQUA_SCALES",{name:"",adj:"",plural:true});//[Deprecated] Use coverage
	public static const AQUA_RUBBER_LIKE:int      = EnumValue.add(Types,19,"AQUA_RUBBER_LIKE",{name:"slippery rubber-like skin",adj:"",plural:false});
	public static const TATTOED_ONI:int           = EnumValue.add(Types,20,"TATTOED_ONI",{name:"tattooed skin",adj:"",plural:false});//[Deprecated] Use pattern
	public static const FEATHER:int 	          = EnumValue.add(Types,21,"FEATHER",{name:"feathers",adj:"",plural:true});
	
	public static const Patterns:/*EnumValue*/Array = [];
	public static const PATTERN_NONE:int = EnumValue.add(Patterns, 0, "PATTERN_NONE",{name:"none"});
	public static const PATTERN_MAGICAL_TATTOO:int = EnumValue.add(Patterns, 1, "PATTERN_MAGICAL_TATTOO",{name:"magical tattoo"});
	public static const PATTERN_ORCA_UNDERBODY:int = EnumValue.add(Patterns, 2, "PATTERN_ORCA_UNDERBODY",{name:"orca underbody"});
	public static const PATTERN_BEE_STRIPES:int = EnumValue.add(Patterns, 3, "PATTERN_BEE_STRIPES",{name:"bee stripes"});
	public static const PATTERN_TIGER_STRIPES:int = EnumValue.add(Patterns, 4, "PATTERN_TIGER_STRIPES",{name:"tiger stripes"});
	public static const PATTERN_BATTLE_TATTOO:int = EnumValue.add(Patterns, 5, "PATTERN_BATTLE_TATTOO",{name:"battle tattoo"});
	public static const PATTERN_SPOTTED:int = EnumValue.add(Patterns, 6, "PATTERN_SPOTTED",{name:"spotted"});
	public static const PATTERN_LIGHTNING_SHAPED_TATTOO:int = EnumValue.add(Patterns, 7, "PATTERN_LIGHTNING_SHAPED_TATTOO",{name:"lightning shaped tattoo"});
	public static const PATTERN_RED_PANDA_UNDERBODY:int = EnumValue.add(Patterns, 8, "PATTERN_RED_PANDA_UNDERBODY",{name:"red panda underbody"});
	
	public var base:SkinLayer;
	public var coat:SkinLayer;
	private var _coverage:int = COVERAGE_NONE;
	
	public function Skin(creature:Creature) {
		super(creature, "skin", ["coverage"]);
		base = new SkinLayer(this);
		coat = new SkinLayer(this);
		addPublicJsonables(["base", "coat"]);
	}

	[Deprecated(replacement="describe('coat')")]
	public function skinFurScales():String {
		return describe('coat');
	}
	public function get coverage():int {
		return _coverage;
	}
	public function set coverage(value:int):void {
		_coverage = boundInt(COVERAGE_NONE, value, COVERAGE_COMPLETE);
	}
	public function get tone():String {
		return color;
	}
	public function get color():String {
		return skinValue(base.color, coat.color);
	}
	public function get color2():String {
		return skinValue(base.color2, coat.color2);
	}
	public function get desc():String {
		return skinValue(base.desc, coat.desc);
	}
	public function get adj():String {
		return skinValue(base.adj, coat.adj);
	}
	/**
	 * Returns `s` (default "is") if the skin main layer noun is singular (skin,fur,chitin)
	 * and `p` (default "are") if plural (scales)
	 */
	public function isAre(s:String = "is", p:String = "are"):String {
		return skinValue(base.isAre(s, p), coat.isAre(s, p));
	}
	override public function get type():int {
		if (coverage >= COVERAGE_HIGH) return coat.type;
		return base.type;
	}
	/**
	 * Checks both layers against property set
	 * @param p {color, type, adj, desc}
	 * @return this.base, this.coat, or null
	 */
	public function findLayer(p:Object):SkinLayer {
		if (coverage < COVERAGE_COMPLETE && base.checkProps(p)) return base;
		if (coverage > COVERAGE_NONE && coat.checkProps(p)) return coat;
		return null;
	}
	/**
	 * @param options = {color,adj,desc}
	 */
	public function growCoat(type:int,options:Object=null,coverage:int=COVERAGE_HIGH):SkinLayer {
		this.coverage = coverage;
		this.coat.type = type;
		this.coat.color = creature.hairColor;
		if (options) this.coat.setProps(options);
		return this.coat;
	}
	/**
	 * @param options = {color,adj,desc}
	 */
	public function growFur(options:Object=null,coverage:int=COVERAGE_HIGH):SkinLayer {
		this.coverage = coverage;
		this.coat.setProps({color: creature.hairColor, type: FUR});
		if (options) this.coat.setProps(options);
		return this.coat;
	}
	/**
	 * @param baseOptions = {color,adj,desc,type}
	 */
	public function setBaseOnly(baseOptions:Object =null):void {
		coverage = Skin.COVERAGE_NONE;
		if (baseOptions) base.setAllProps(baseOptions);
	}
	/**
	 * @param layer 'base','coat','skin' (both layer if MEDIUM, else major),'full' (both layers if present)
	 * @return
	 */
	public function describe(layer:String = 'skin', noAdj:Boolean = false, noTone:Boolean = false):String {
		var s_base:String = base.describe(noAdj, noTone);
		var s_coat:String = coat.describe(noAdj, noTone);
		switch (coverage) {
			case COVERAGE_NONE:
				return s_base;
			case COVERAGE_LOW:
				switch (layer) {
					case 'coat':
						return s_coat;
					case 'full':
						return s_base + " with patches of " + s_coat;
					case 'skin':
					case 'base':
					default:
						return s_base;
				}
				break;
			case COVERAGE_MEDIUM:
				switch (layer) {
					case 'coat':
						return s_coat;
					case 'full':
					case 'skin':
						return s_base + " and " + s_coat;
					case 'base':
					default:
						return s_base;
				}
				break;
			case COVERAGE_HIGH:
				switch (layer) {
					case 'base':
						return s_base;
					case 'full':
						return s_base + " under " + s_coat;
					case 'skin':
					case 'coat':
					default:
						return s_coat;
				}
				break;
			case COVERAGE_COMPLETE:
				switch (layer) {
					case 'base':
						return s_base;
					case 'full':
						return s_base + " under " + s_coat;
					case 'skin':
					case 'coat':
					default:
						return s_coat;
				}
				break;
			default:
				return s_coat;
		}
	}
	override public function descriptionFull():String {
		return describe("full");
	}
	public function hasAny(...types:Array):Boolean {
		if (types.length === 1 && types[0] is Array) types = types[0];
		return (coverage < COVERAGE_COMPLETE && base.isAny(types)) ||
			   (coverage > COVERAGE_NONE && coat.isAny(types));
	}
	public function isCoverLowMid():Boolean {
		return coverage > COVERAGE_NONE && coverage < COVERAGE_HIGH;
	}
	public function coatType():int {
		return hasCoat() ? coat.type : -1;
	}
	public function baseType():int {
		return base.type;
	}
	public function hasCoat():Boolean {
		return coverage > COVERAGE_NONE && coverage <= COVERAGE_COMPLETE;
	}
	public function hasFullCoat():Boolean {
		return coverage >= COVERAGE_HIGH && coverage <= COVERAGE_COMPLETE;
	}
	public function hasFullCoatOfType(...types:Array):Boolean {
		return hasFullCoat() && coat.isAny(types);
	}
	public function hasCoatOfType(...types:Array):Boolean {
		return hasCoat() && coat.isAny(types);
	}
	public function hasPartialCoat(coat_type:int):Boolean {
		return coverage == COVERAGE_LOW && coat.type == coat_type;
	}
	public function hasFur():Boolean {
		return hasCoatOfType(FUR);
	}
	public function get fur():SkinLayer {
		return hasFur() ? coat : null;
	}
	public function hasChitin():Boolean {
		return hasCoatOfType(CHITIN);
	}
	public function hasScales():Boolean {
		return hasCoatOfType(SCALES, AQUA_SCALES, DRAGON_SCALES);
	}
	public function hasReptileScales():Boolean {
		return hasCoatOfType(SCALES, DRAGON_SCALES);
	}
	public function hasDragonScales():Boolean {
		return hasCoatOfType(DRAGON_SCALES);
	}
	public function hasLizardScales():Boolean {
		return hasCoatOfType(SCALES);
	}
	public function hasNonLizardScales():Boolean {
		return hasScales() && !hasLizardScales();
	}
	public function hasBark():Boolean {
		return coat.isAny(BARK);
	}
	public function hasGooSkin():Boolean {
		return base.isAny(GOO);
	}
	public function hasFeather():Boolean {
		return coat.isAny(FEATHER);
	}
	public function hasMostlyPlainSkin():Boolean {
		return coverage <= COVERAGE_LOW && base.type == PLAIN;
	}
	public function hasPlainSkinOnly():Boolean {
		return coverage == COVERAGE_NONE && base.type == PLAIN;
	}
	public function hasBaseOnly(baseType:int):Boolean {
		return coverage == COVERAGE_NONE && base.type == baseType;
	}
	public function hasPlainSkin():Boolean {
		return coverage < COVERAGE_COMPLETE && base.type == PLAIN;
	}
	public function hasMagicalTattoo():Boolean {
		return base.pattern == PATTERN_MAGICAL_TATTOO;
	}
	public function hasBattleTattoo():Boolean {
		return base.pattern == PATTERN_BATTLE_TATTOO;
	}
	public function hasLightningShapedTattoo():Boolean {
		return base.pattern == PATTERN_LIGHTNING_SHAPED_TATTOO;
	}
	override public function restore(keepTone:Boolean = true):void {
		coverage = COVERAGE_NONE;
		base.restore(keepTone);
		coat.restore(keepTone);
	}
	override public function setProps(p:Object):void {
		super.setProps(p);
		if ("base" in p) base.setProps(p.base);
		if ("coat" in p) base.setProps(p.coat);
	}
	private function skinValue(inBase:String, inCoat:String):String {
		switch (coverage) {
			case COVERAGE_NONE:
			case COVERAGE_LOW:
				return inBase;
			case COVERAGE_MEDIUM:
				return inBase + " and " + inCoat;
			case COVERAGE_HIGH:
			case COVERAGE_COMPLETE:
			default:
				return inCoat;
		}
	}
	//noinspection JSDeprecatedSymbols
	private static const PARTIAL_TO_FULL:Object            = createMapFromPairs([
		[PARTIAL_CHITIN, CHITIN],
		[PARTIAL_SCALES, SCALES],
		[PARTIAL_FUR, FUR],
		[PARTIAL_BARK, BARK],
		[PARTIAL_AQUA_SCALES, AQUA_SCALES],
		[PARTIAL_DRAGON_SCALES, DRAGON_SCALES],
		[PARTIAL_STONE, PARTIAL_STONE]
	]);
	private static const TYPE_TO_BASE_COVERAGE_COAT:Object = multipleMapsFromPairs([
		[PLAIN,
		 PLAIN, COVERAGE_NONE, 0],
		[FUR,
		 PLAIN, COVERAGE_HIGH, FUR],
		[SCALES,
		 PLAIN, COVERAGE_HIGH, SCALES],
		[GOO,
		 GOO, COVERAGE_NONE, 0],
		[UNDEFINED,
		 PLAIN, COVERAGE_NONE, 0],
		[CHITIN,
		 PLAIN, COVERAGE_HIGH, CHITIN],
		[BARK,
		 PLAIN, COVERAGE_HIGH, BARK],
		[STONE,
		 STONE, COVERAGE_NONE, 0],
		[TATTOED,
		 PLAIN, COVERAGE_NONE, 0],
		[AQUA_SCALES,
		 PLAIN, COVERAGE_HIGH, AQUA_SCALES],
		[PARTIAL_FUR,
		 PLAIN, COVERAGE_LOW, FUR],
		[PARTIAL_SCALES,
		 PLAIN, COVERAGE_LOW, SCALES],
		[PARTIAL_CHITIN,
		 PLAIN, COVERAGE_LOW, CHITIN],
		[PARTIAL_BARK,
		 PLAIN, COVERAGE_LOW, BARK],
		[DRAGON_SCALES,
		 PLAIN, COVERAGE_HIGH, DRAGON_SCALES],
		[MOSS,
		 PLAIN, COVERAGE_HIGH, MOSS],
		[PARTIAL_DRAGON_SCALES,
		 PLAIN, COVERAGE_LOW, DRAGON_SCALES],
		[PARTIAL_STONE,
		 PLAIN, COVERAGE_LOW, STONE],
		[PARTIAL_AQUA_SCALES,
		 PLAIN, COVERAGE_LOW, AQUA_SCALES],
		[AQUA_RUBBER_LIKE,
		 PLAIN, COVERAGE_NONE, 0],
		[TATTOED_ONI,
		 PLAIN, COVERAGE_NONE, 0],
		[FEATHER,
		 PLAIN, COVERAGE_HIGH, FEATHER],
	]);
	private static const TYPE_TO_BASE:Object               = TYPE_TO_BASE_COVERAGE_COAT[0];
	private static const TYPE_TO_COVERAGE:Object           = TYPE_TO_BASE_COVERAGE_COAT[1];
	private static const TYPE_TO_COAT:Object               = TYPE_TO_BASE_COVERAGE_COAT[2];
	[Deprecated]
	public override function set type(value:int):void {
		coverage  = TYPE_TO_COVERAGE[value];
		base.type = TYPE_TO_BASE[value];
		coat.type = TYPE_TO_COAT[value];
		if (value == TATTOED) {
			base.pattern = PATTERN_MAGICAL_TATTOO;
			base.adj = "sexy tattooed";
		} else if (value == AQUA_RUBBER_LIKE) {
			base.adj = "slippery rubber-like";
		} else if (value == TATTOED_ONI) {
			base.pattern = PATTERN_BATTLE_TATTOO;
			base.adj = "battle tattooed";
		}
	}
	override protected function loadFromOldSave(savedata:Object):void {
		//Convert from old skinDesc to new skinAdj + skinDesc!
		var type:int = intOr(savedata.skinType, PLAIN);
		//noinspection JSDeprecatedSymbols
		if (type === UNDEFINED) type = PLAIN;
		var desc:String = stringOr(savedata.skinDesc, "");
		var adj:String  = stringOr(savedata.skinAdj, "");
		for each (var legacyAdj:String in ["smooth", "thick", "rubber", "latex", "slimey"]) {
			if (desc.indexOf(legacyAdj) != -1) {
				adj = legacyAdj;
				if (type == FUR) {
					desc = "fur";
				} else if (type == GOO) {
					desc = "goo";
				} else if ([
							SCALES,
							AQUA_SCALES,
							DRAGON_SCALES
						   ].indexOf(type) >= 0) {
					desc = "scales";
				} else {
					desc = "skin";
				}
			}
		}
		var tone:String        = stringOr(savedata.skinTone, "albino");
		var furColor:String    = stringOr(savedata.furColor, stringOr(savedata.hairColor, ""));
		var chitinColor:String = stringOr(savedata.chitinColor, "");
		var scalesColor:String = stringOr(savedata.scalesColor, "");
		if (furColor === "no") furColor = "";
		if (chitinColor === "no") chitinColor = "";
		if (scalesColor === "no") scalesColor = "";
		//noinspection JSDeprecatedSymbols
		if (InCollection(type, PLAIN, GOO, TATTOED, STONE, SCALES, AQUA_SCALES, PARTIAL_DRAGON_SCALES, AQUA_RUBBER_LIKE, TATTOED_ONI)) {
			coverage   = COVERAGE_NONE;
			base.type  = type;
			base.color = (type == SCALES && scalesColor) ? scalesColor : tone;
			base.adj   = adj;
			base.desc  = desc;
			coat.type  = FUR;
			if (coat.color == "no") coat.color = savedata.hairColor;
		} else {
			coverage = COVERAGE_HIGH;
			if (type in PARTIAL_TO_FULL) {
				coverage = COVERAGE_LOW;
				type     = PARTIAL_TO_FULL[type];
			}
			coat.type  = type;
			coat.adj   = adj;
			coat.desc  = desc;
			base.color = tone;
			if (type === FUR) {
				coat.color = furColor;
			} else if (type === SCALES) {
				coat.color = scalesColor;
			} else if (type === CHITIN) {
				coat.color = chitinColor;
			}
			if (!coat.color) coat.color = furColor || scalesColor || chitinColor || "white";
		}
	}
	override protected function saveToOldSave(savedata:Object):void {
		savedata.skinType    = type;
		savedata.skinDesc    = desc;
		savedata.skinAdj     = adj;
		savedata.skinTone    = tone;
		savedata.furColor    = coat.color;
		savedata.scalesColor = coat.color;
		savedata.chitinColor = coat.color;
	}
}
}
