package classes.Items 
{
	/**
	 * ...
	 * @author Kitteh6660
	 */
	import classes.Items.Jewelries.*;
	import classes.PerkLib;
	import classes.PerkType;

	//Enchantment IDs
	/*
	 * 0: Nothing
	 * 1: Minimum lust
	 * 2: Fertility
	 * 3: Ki
	 * 4: Fatigue
	 * 5: HP
	 * 6: Attack power
	 * 7: Spell power
	 * 8: Purity 
	 * 9: Corruption 
	 
	 */
	
	public final class JewelryLib
	{
		public static const MODIFIER_MINIMUM_LUST:int = 1;
		public static const MODIFIER_FERTILITY:int = 	2;
		public static const MODIFIER_SF:int = 			3;
		public static const MODIFIER_MP:int = 			4;
		public static const MODIFIER_HP:int = 			5;
		public static const MODIFIER_ATTACK_POWER:int = 6;
		public static const MODIFIER_SPELL_POWER:int = 	7;
		public static const PURITY:int = 				8;
		public static const CORRUPTION:int = 			9;
		
		public static const DEFAULT_VALUE:Number = 6;
		
		public static const NOTHING:Nothing = new Nothing();
		
		//Pre-Enchanted rings
		public const CRIMRNG:Jewelry = new Jewelry("CrimRng", "Crimst.Ring", "crimstone ring", "an enchanted crimstone ring", MODIFIER_MINIMUM_LUST, 10, 1000, "This ring is topped with crimstone. It is said that this will help to keep your desires burning. \n\nType: Jewelry (Ring) \nBase value: 1,000 \nSpecial: Increases minimum lust by 10.","Ring");
		public const FERTRNG:Jewelry = new Jewelry("FertRng", "FertiteRing", "fertite ring", "an enchanted fertite ring", MODIFIER_FERTILITY, 20, 1000, "This ring is topped with fertite. It is said that this will make you more virile and fertile. \n\nType: Jewelry (Ring) \nBase value: 1,000 \nSpecial: Increases cum production by 20 percent and ferility by 20.","Ring");
		public const ICE_RNG:Jewelry = new Jewelry("Ice_Rng", "Icestn.Ring", "icestone ring", "an enchanted icestone ring", MODIFIER_MINIMUM_LUST, -10, 2000, "This ring is topped with icestone. It is said that this will counter ever-burning desires. \n\nType: Jewelry (Ring) \nBase value: 2,000 \nSpecial: Reduces minimum lust by 10.","Ring");
		public const SOULRNG:Jewelry = new Jewelry("SoulRng", "Soul Ring", "soulmetal ring", "a soulmetal ring", MODIFIER_SF, 20, 100, "This simple ring is made of low quality soulmetal. Despite it seemly simplicity it allow for slight compresion of it weaver ki allowing storing a little bit more of it. \n\nType: Jewelry (Ring) \nBase value: 100 \nSpecial: Increases maximum Ki by 20.","Ring");
		public const MANARNG:Jewelry = new Jewelry("ManaRng", "Mana Ring", "ring of mana", "an enchanted alexandrite ring of mana", MODIFIER_MP, 20, 1250, "This ring is topped with alexandrite gemstone. It is said that this will make you feel having a bit more mana. \n\nType: Jewelry (Ring) \nBase value: 1,250 \nSpecial: Increases maximum Fatigue by 20.","Ring");
		public const LIFERNG:Jewelry = new Jewelry("LifeRng", "Life Ring", "ring of life", "an enchanted emerald ring of life force", MODIFIER_HP, 35, 1000, "This ring is topped with emerald gemstone. It is said that this will make you feel a bit healthier. \n\nType: Jewelry (Ring) \nBase value: 1,000 \nSpecial: Increases maximum HP by 35.","Ring");
		public const MYSTRNG:Jewelry = new Jewelry("MystRng", "Mystic Ring", "ring of mysticality", "an enchanted sapphire ring of mysticality", MODIFIER_SPELL_POWER, 25, 1500, "This ring is topped with sapphire gemstone. It is said that this will make your spells more powerful. \n\nType: Jewelry (Ring) \nBase value: 1,500 \nSpecial: Increases spellpower by 25 percent.","Ring");
		public const POWRRNG:Jewelry = new Jewelry("PowrRng", "Power Ring", "ring of power", "an enchanted ruby ring of power", MODIFIER_ATTACK_POWER, 10, 1500, "This ring is topped with ruby gemstone. It is said that this will make you feel a bit powerful. \n\nType: Jewelry (Ring) \nBase value: 1,500 \nSpecial: Increases damage by 10 percent.","Ring");
		public const PURERNG:Jewelry = new Jewelry("PureRng", "Purity Ring", "purity ring", "an enchanted purity ring", PURITY, 10, 3000, "This ring symbolizes chastity and purity. When worn, it reduces minimum libido and makes it harder for you to get turned on. \n\nType: Jewelry (Ring) \nBase value: 3,000 \nSpecial: Slowly decreases the corruption of the wearer over time. Reduces minimum libido by 10.","Ring");
		public const MSIGNIT:MediusSignet = new MediusSignet();
			
		//Normal ring
		public const DIAMRNG:Jewelry = new Jewelry("DiamRng", "Diam Ring", "gold and diamond ring", "a shining gold and diamond ring", 0, 0, 1000, "This shining ring is made of gold and topped with diamond. Truly expensive. \n\nType: Jewelry (Ring) \nBase value: 1,000","Ring");
		public const GOLDRNG:Jewelry = new Jewelry("GoldRng", "Gold Ring", "gold ring", "a shining gold ring", 0, 0, 400, "This shining ring is made of gold. \n\nType: Jewelry (Ring) \nBase value: 400","Ring");
		public const LTHCRNG:Jewelry = new Jewelry("LthcRng", "Lethic.Ring", "lethicite ring", "a glowing lethicite ring", 1, 0, 5000, "This ring appears to be made of platinum with some lethicite crystal. Very expensive as lethicite is rare. \n\nType: Jewelry (Ring) \nBase value: 5,000","Ring");
		public const PLATRNG:Jewelry = new Jewelry("PlatRng", "Plat Ring", "platinum ring", "a shining platinum ring", 0, 0, 1000, "This shining ring is made of platinum, one of the rare precious metals. It looks expensive! \n\nType: Jewelry (Ring) \nBase value: 1,000","Ring");
		public const SILVRNG:Jewelry = new Jewelry("SilvRng", "Silver Ring", "silver ring", "a normal silver ring", 0, 0, 200, "This ring looks like it's made of silver. \n\nType: Jewelry (Ring) \nBase value: 200","Ring");
		public const FOXHAIR:Jewelry = new Jewelry("FoxHair", "Fox Hairpin", "fox hairpin", "a fox hairpin", 0, 0, 800, "This hairpin, adorned with the design of a fox and blessed by Taoth, grants a kitsune increased magical power. \n\nType: Accesory (Hairpin) \nBase value: 800","Ring");
		public const SEERPIN:SeersHairpin = new SeersHairpin();
		
		/*private static function mk(id:String,shortName:String,name:String,longName:String,effectId:Number,effectMagnitude:Number,value:Number,description:String,type:String,perk:String=""):Jewelry {
			return new Jewelry(id,shortName,name,longName,effectId,effectMagnitude,value,description,type,perk);
		}*/
		/*private static function mk2(id:String,shortName:String,name:String,longName:String,def:Number,value:Number,description:String,perk:String,
				playerPerk:PerkType,playerPerkV1:Number,playerPerkV2:Number,playerPerkV3:Number,playerPerkV4:Number,playerPerkDesc:String=null):ArmorWithPerk{
			return new ArmorWithPerk(id,shortName,name,longName,def,value,description,perk,
					playerPerk,playerPerkV1,playerPerkV2,playerPerkV3,playerPerkV4);
		}*/
		public function JewelryLib()
		{
		}
	}

}