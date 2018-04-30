/**
 * Created by aimozg on 26.01.14.
 */
package classes
{
import classes.BodyParts.Face;
import classes.BodyParts.Tail;
import classes.Perks.*;

public class PerkLib
	{

		// UNSORTED perks TODO these are mostly incorrect perks: tested but never created
		public static const Buttslut:PerkType = mk("Buttslut", "Buttslut",
				"");
		public static const Focused:PerkType = mk("Focused", "Focused",
				"");
		// Player creation perks
		public static const Fast:PerkType = mk("Fast", "Fast",
				"Gains speed 25% faster.", null, true);
		public static const Lusty:PerkType = mk("Lusty", "Lusty",
				"Gains lust 25% faster.", null, true);
		public static const Pervert:PerkType = mk("Pervert", "Pervert",
				"Gains corruption 25% faster. Reduces corruption requirement for high-corruption variant of scenes.", null, true);
		public static const Sensitive:PerkType = mk("Sensitive", "Sensitive",
				"Gains sensitivity 25% faster.", null, true);
		public static const Smart:PerkType = mk("Smart", "Smart",
				"Gains intelligence 25% faster.", null, true);
		public static const Strong:PerkType = mk("Strong", "Strong",
				"Gains strength 25% faster.", null, true);
		public static const Tough:PerkType = mk("Tough", "Tough",
				"Gains toughness 25% faster.", null, true);
		// Female creation perks
		public static const BigClit:PerkType = mk("Big Clit", "Big Clit",
				"Allows your clit to grow larger more easily and faster.", null, true);
		public static const BigTits:PerkType = mk("Big Tits", "Big Tits",
				"Makes your tits grow larger more easily.", null, true);
		public static const Fertile:PerkType = mk("Fertile", "Fertile",
				"Makes you 15% more likely to become pregnant.", null, true);
		public static const WetPussy:PerkType = mk("Wet Pussy", "Wet Pussy",
				"Keeps your pussy wet and provides a bonus to capacity.", null, true);
		// Male creation perks
		public static const BigCock:PerkType = mk("Big Cock", "Big Cock",
				"Gains cock size 25% faster and with less limitations.", null, true);
		public static const MessyOrgasms:PerkType = mk("Messy Orgasms", "Messy Orgasms",
				"Produces 50% more cum volume.", null, true);
				
		// Ascension perks
		public static const AscensionDesires:AscensionDesiresPerk = new AscensionDesiresPerk();
		public static const AscensionEndurance:AscensionEndurancePerk = new AscensionEndurancePerk();
		public static const AscensionHardiness:AscensionHardinessPerk = new AscensionHardinessPerk();
		public static const AscensionFertility:AscensionFertilityPerk = new AscensionFertilityPerk();
		public static const AscensionFortune:AscensionFortunePerk = new AscensionFortunePerk();
		public static const AscensionFury:AscensionFuryPerk = new AscensionFuryPerk();
		public static const AscensionInnerPower:AscensionInnerPowerPerk = new AscensionInnerPowerPerk();
		public static const AscensionMoralShifter:AscensionMoralShifterPerk = new AscensionMoralShifterPerk();
		public static const AscensionMysticality:AscensionMysticalityPerk = new AscensionMysticalityPerk();
		public static const AscensionSoulPurity:AscensionSoulPurityPerk = new AscensionSoulPurityPerk();
		public static const AscensionSpiritualEnlightenment:AscensionSpiritualEnlightenmentPerk = new AscensionSpiritualEnlightenmentPerk();
		public static const AscensionTolerance:AscensionTolerancePerk = new AscensionTolerancePerk();
		public static const AscensionTranshumanism:AscensionTranshumanismPerk = new AscensionTranshumanismPerk();
		public static const AscensionVirility:AscensionVirilityPerk = new AscensionVirilityPerk();
		public static const AscensionWisdom:AscensionWisdomPerk = new AscensionWisdomPerk();
		
		// Ascension Rare perks
		public static const AscensionHerosHeritage:PerkType = mk("Ascension: Hero's Heritage", "Ascension: Hero's Heritage",
				"After reincarnation you ended in body of local hero descendant possesing much more firm body and resolve giving you a slight easier start of your quest in Mareth.");
		public static const AscensionHerosLineage:PerkType = mk("Ascension: Hero's Lineage", "Ascension: Hero's Lineage",
				"Body in which you ends up after next incarnation have much more thicker hero linage than before giving you even better start before venturing into Mareth. You would probably need it.");
		public static const AscensionHybridTheory:PerkType = mk("Ascension: Hybrid Theory", "Ascension: Hybrid Theory",
				"Allows you to reduce by one needed to accumulate mutations into non-human species to attain race specific enhancing effects.");
		public static const AscensionNaturalMetamorph:PerkType = mk("Ascension: Natural Metamorph", "Ascension: Natural Metamorph",
				"When others needs to work hard on unlocking their metamorph potential you never had to do it. Whatever the reason for that is... truth be told you try not to think about it, affraid of what it might mean for you. You do not want to care about it as long as it's nothing harmfull for you in the long run.");
		public static const AscensionUnderdog:PerkType = mk("Ascension: Underdog", "Ascension: Underdog",
				"You're underdog. Gains twice more exp for beating up enemies above your current level with doubled limit after which increase to gained exp stops.");
				// Also allow to use 'accidentally' finding all forgotten or hidden legacies from times before the demon invasion.");
		public static const AscensionUnlockedPotential:PerkType = mk("Ascension: Unlocked Potential", "Ascension: Unlocked Potential",
				"Due to reincarnation experience your body becoming strong faster than in previous life (increased passive hp, fatigue, mana gains at lvl-up).");
		public static const AscensionUnlockedPotential2ndStage:PerkType = mk("Ascension: Unlocked Potential (2nd Stage)", "Ascension: Unlocked Potential (2nd Stage)",
				"Due to reincarnation experience your body becoming strong faster than in previous life (increased passive lust, wrath, Ki gains at lvl-up).");
		
		// History perks
		public static const HistoryAlchemist:PerkType = mk("History: Alchemist", "History: Alchemist",
				"Alchemical experience makes items more reactive to your body.");
		public static const PastLifeAlchemist:PerkType = mk("Past Life: Alchemist", "Past Life: Alchemist",
				"Alchemical experience makes items more reactive to your body.", null, true);
		public static const HistoryCultivator:PerkType = mk("History: Cultivator", "History: Cultivator",
				"Ki is easier to kept giving you 10% increase to it maximum amount.");
		public static const PastLifeCultivator:PerkType = mk("Past Life: Cultivator", "Past Life: Cultivator",
				"Ki is easier to kept giving you 10% increase to it maximum amount.", null, true);
		public static const HistoryFighter:PerkType = mk("History: Fighter", "History: Fighter",
				"A Past full of conflict increases physical melee damage dealt by 10%.");
		public static const PastLifeFighter:PerkType = mk("Past Life: Fighter", "Past Life: Fighter",
				"A Past full of conflict increases physical melee damage dealt by 10%.", null, true);
		public static const HistoryFortune:PerkType = mk("History: Fortune", "History: Fortune",
				"Your luck and skills at gathering currency allows you to get 15% more gems from victories.");
		public static const PastLifeFortune:PerkType = mk("Past Life: Fortune", "Past Life: Fortune",
				"Your luck and skills at gathering currency allows you to get 15% more gems from victories.", null, true);
		public static const HistoryHealer:PerkType = mk("History: Healer", "History: Healer",
				"Healing experience increases HP gains by 20%.");
		public static const PastLifeHealer:PerkType = mk("Past Life: Healer", "Past Life: Healer",
				"Healing experience increases HP gains by 20%.", null, true);
		public static const HistoryReligious:PerkType = mk("History: Religious", "History: Religious",
				"Replaces masturbate with meditate when corruption less than or equal to 66. Reduces minimum libido slightly.");
		public static const PastLifeReligious:PerkType = mk("Past Life: Religious", "Past Life: Religious",
				"Replaces masturbate with meditate when corruption less than or equal to 66. Reduces minimum libido slightly.", null, true);
		public static const HistoryScholar:PerkType = mk("History: Scholar", "History: Scholar",
				"Time spent focusing your mind makes spellcasting use 20% less mana.");
		public static const PastLifeScholar:PerkType = mk("Past Life: Scholar", "Past Life: Scholar",
				"Time spent focusing your mind makes spellcasting use 20% less mana.", null, true);
		public static const HistoryScout:PerkType = mk("History: Scout", "History: Scout",
				"A Past full of archery training increases physical range damage dealt by 10% and acc by 20%.");
		public static const PastLifeScout:PerkType = mk("Past Life: Scout", "Past Life: Scout",
				"A Past full of archery training increases physical range damage dealt by 10% and acc by 20%.", null, true);
		public static const HistorySlacker:PerkType = mk("History: Slacker", "History: Slacker",
				"Regenerate fatigue 20% faster.");
		public static const PastLifeSlacker:PerkType = mk("Past Life: Slacker", "Past Life: Slacker",
				"Regenerate fatigue 20% faster.", null, true);
		public static const HistorySlut:PerkType = mk("History: Slut", "History: Slut",
				"Sexual experience has made you more able to handle large insertions and more resistant to stretching.");
		public static const PastLifeSlut:PerkType = mk("Past Life: Slut", "Past Life: Slut",
				"Sexual experience has made you more able to handle large insertions and more resistant to stretching.", null, true);
		public static const HistorySmith:PerkType = mk("History: Smith", "History: Smith",
				"Knowledge of armor and fitting increases armor effectiveness by roughly 10%.");
		public static const PastLifeSmith:PerkType = mk("Past Life: Smith", "Past Life: Smith",
				"Knowledge of armor and fitting increases armor effectiveness by roughly 10%.", null, true);
		public static const HistoryWhore:PerkType = mk("History: Whore", "History: Whore",
				"Seductive experience causes your tease attacks to be 15% more effective.");
		public static const PastLifeWhore:PerkType = mk("Past Life: Whore", "Past Life: Whore",
				"Seductive experience causes your tease attacks to be 15% more effective.", null, true);
		
		// Ordinary (levelup) perks
		public static const Acclimation:PerkType = mk("Acclimation", "Acclimation",
				"Reduces lust gain by 15%.",
				"You choose the 'Acclimation' perk, making your body 15% more resistant to lust, up to a maximum of 75%.");
		public static const Agility:PerkType = mk("Agility", "Agility",
				"Boosts armor points by a portion of your speed on light/medium armors.",
				"You choose the 'Agility' perk, increasing the effectiveness of Light/Medium armors by a portion of your speed.");
		public static const ArcaneLash:PerkType = mk("Arcane Lash", "Arcane Lash",
				"Your whip act as a catalyst for your lust inducing spells as well as for magic weapon.",
				"You choose the 'Arcane Lash' perk, causing you to increase effects of lust inducing spells and weapon when using whip.");
		public static const ArouseTheAudience:PerkType = mk("Arouse the audience", "Arouse the audience",
				"Increase the damage of non periodic tease against groups by 50% and periodic by 20%.",
				"You choose the 'Arouse the audience' perk, increasing the damage of tease against groups.");
		public static const ArousingAura:PerkType = mk("Arousing Aura", "Arousing Aura",
				"Exude a lust-inducing aura (Req's corruption of 70 or more)",
				"You choose the 'Arousing Aura' perk, causing you to radiate an aura of lust when your corruption is over 70.");
		public static const Battleflash:PerkType = mk("Battleflash", "Battleflash",
				"Start every battle with Blink enabled, if you meet Black Magic requirements before it starts.",
				"You choose the 'Battleflash' perk. You start every battle with Blink effect, as long as your Lust is sufficient to cast it before battle.");
		public static const Battlemage:PerkType = mk("Battlemage", "Battlemage",
				"Start every battle with Might enabled, if you meet Black Magic requirements before it starts.",
				"You choose the 'Battlemage' perk. You start every battle with Might effect, as long as your Lust is sufficient to cast it before battle.");
		public static const Berzerker:PerkType = mk("Berzerker", "Berserker",
				"[if(player.str>=75)" +
						"Grants 'Berserk' ability." +
						"|" +
						"<b>You aren't strong enough to benefit from this anymore.</b>" +
						"]",
				"You choose the 'Berserker' perk, which unlocks the 'Berserk' magical ability.  Berserking increases attack and lust resistance but reduces physical defenses.");
		public static const BlackHeart:PerkType = mk("Black Heart", "Black Heart",
				"You intelligence to increase power of lust strike as well making fascinate slightly stronger.",
				"You choose the 'Black Heart' perk. Your heart due to repeadly exposition to corruption turned black.");
		public static const Blademaster:PerkType = mk("Blademaster", "Blademaster",
				"Gain +5% to critical strike chance when wielding a sword and not using a shield.",
				"You choose the 'Blademaster' perk.  Your chance of critical hit is increased by 5% as long as you're wielding a sword and not using a shield.");
		public static const Brawler:PerkType = mk("Brawler", "Brawler",
				"Brawling experience allows you to make two unarmed attacks in a turn.",
				"You choose the 'Brawler' perk, allowing you to make two unarmed attacks in a turn!");
		public static const BrutalBlows:PerkType = mk("Brutal Blows", "Brutal Blows",
				"[if(player.str>=75)" +
						"Reduces enemy armor with each hit." +
						"|" +
						"<b>You aren't strong enough to benefit from this anymore.</b>" +
						"]",
				"You choose the 'Brutal Blows' perk, which reduces enemy armor with each hit.");
		public static const CatchTheBlade:PerkType = mk("Catch the blade", "Catch the blade",
				"[if(player.spe>=50)" +
						"Increases deflect chance by up to 15% while using only fists/fist weapons. (Speed-based)." +
						"|" +
						"<b>You are not fast enough to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Catch the blade' perk, giving you a chance to deflect blow with your fists. (Speed-based).");
		public static const CatlikeNimbleness:PerkType = mk("Cat-like Nimbleness", "Cat-like Nimbleness",
				"Your transformed joins allows you to move more swiftly and with greater nimbleness.",
				"You choose the 'Cat-like Nimbleness' perk. Your body joints due to repeadly usage of cat-like flexibility became more nimble.");
		public static const CatlikeNimblenessEvolved:PerkType = mk("Cat-like Nimbleness (Evolved)", "Cat-like Nimbleness (Evolved)",
				"Your nimble body allows you to move more swiftly and with greater nimbleness than before.",
				"You choose the 'Cat-like Nimbleness (Evolved)' perk. Continuous usage of cat-like flexibility caused it to undergone change.");
		public static const ChimericalBodyAdvancedStage:PerkType = mk("Chimerical Body: Advanced Stage", "Chimerical Body: Advanced Stage",
				"You feel naturaly adept at using every new appendage you gain as if they were yours from birth.",
				"You choose the 'Chimerical Body: Advanced Stage' perk. Constant mutations rised your body adaptiveness to new level.");	
		public static const ChimericalBodyBasicStage:PerkType = mk("Chimerical Body: Basic Stage", "Chimerical Body: Basic Stage",
				"Your metabolic adaptation reached level possesed by most simplest and weakest chimeras.",
				"You choose the 'Chimerical Body: Basic Stage' perk. Your body reach adaptation stage for most base type of chimera.");	
		public static const ChimericalBodyInitialStage:PerkType = mk("Chimerical Body: Initial Stage", "Chimerical Body: Initial Stage",
				"Constant mutations resulted in your body developing the most basic resistance to increased stress put on your metabolism by that.",
				"You choose the 'Chimerical Body: Initial Stage' perk. Constant mutations causing your body to forcefully adapt to increased metabolism needs.");	
		public static const ChimericalBodyPerfectStage:PerkType = mk("Chimerical Body: Perfect Stage", "Chimerical Body: Perfect Stage",
				".",
				"You choose the 'Chimerical Body: Perfect Stage' perk.  Coś coś!");	
		public static const ChimericalBodySemiPerfectStage:PerkType = mk("Chimerical Body: Semi-Perfect Stage", "Chimerical Body: Semi-Perfect Stage",
				"prless lub completed stage.",
				"You choose the 'Chimerical Body: Semi-Perfect Stage' perk.  Coś coś!");	
		public static const ChimericalBodyUltimateStage:PerkType = mk("Chimerical Body: Ultimate Stage", "Chimerical Body: Ultimate Stage",
				".",
				"You choose the 'Chimerical Body: Ultimate Stage' perk.  Coś coś!");	
		public static const ChimericalBodyStage:PerkType = mk("Chimerical Body:  Stage", "Chimerical Body:  Stage",
				"prless lub completed stage.",
				"You choose the 'Chimerical Body:  Stage' perk.  Coś coś!");
		public static const ColdBlooded:PerkType = mk("Cold Blooded", "Cold Blooded",
				"Reduces minimum lust by up to 20, down to min of 20. Caps min lust at 80.",
				"You choose the 'Cold Blooded' perk.  Thanks to increased control over your desires, your minimum lust is reduced! (Caps minimum lust at 80. Won't reduce minimum lust below 20 though.)");
		public static const ColdFury:PerkType = mk("Cold Fury", "Cold Fury",
				"Berserking does not reduce your armor.",
				"You choose the 'Cold Fury' perk, causing Berserking to not reduce your armor.");
		public static const ColdLust:PerkType = mk("Cold Lust", "Cold Lust",
				"Lustzerking does not reduce your lust resistance.",
				"You choose the 'Cold Lust' perk, causing Lustzerking to not reduce your lust resistance.");
		public static const CorruptedLibido:PerkType = mk("Corrupted Libido", "Corrupted Libido",
				"Reduces lust gain by 10%.",
				"You choose the 'Corrupted Libido' perk.  As a result of your body's corruption, you've become a bit harder to turn on. (Lust gain reduced by 10%!)");
		public static const CriticalPerformance:PerkType = mk("Critical performance", "Critical performance",
				"Allows your non periodic tease damage to critically hit based on your libido, maximum +20%.",
				"You choose the 'Critical performance' perk, allowing your non periodic tease damage to critically hit based on your libido.");
		public static const Cupid:PerkType = mk("Cupid", "Cupid",
				"You arrows are charged with heavy black magic inflicting lust on those pierced by them.",
				"You choose the 'Cupid' perk, allowing you to shoot arrows inflicting lust.");
		public static const DazzlingDisplay:PerkType = mk("Dazzling display", "Dazzling display",
				"Teasing can stun enemy for one round or increase lust damage for grapple-type teases.",
				"You choose 'Dazzling display' perk, allowing to increse tease dmg a little bit or even stun enemy for short moment.");
		public static const DeadlyAim:PerkType = mk("Deadly Aim", "Deadly Aim",
				"Arrows/Bolts ignore damage reductions piercing right through your opponent armor weak points (ignore enemy dmg red).",
				"You choose the 'Deadly Aim' perk, causing arrows/bolts to ignore the damage reductions of opponent.");
		public static const DraconicLungs:PerkType = mk("Draconic Lungs", "Draconic Lungs",
				"Draconic Lungs giving you slight increased speed and allows to use breath attack more often.",
				"You choose the 'Draconic Lungs' perk. Your lungs due to repeadly usage of dragon breath attacks turned into draconic lungs.");
		public static const DraconicLungsEvolved:PerkType = mk("Draconic Lungs (Evolved)", "Draconic Lungs (Evolved)",
				"Draconic Lungs (Evolved) giving you slight increased speed/toughness and increased threefold power of the dragon breath attacks.",
				"You choose the 'Draconic Lungs (Evolved)' perk. Continuous exposition to draconic changes caused your lungs evolution into more complete form.");
		public static const ElementalArrows:PerkType = mk("Elemental Arrows", "Elemental Arrows",
				"Shoot elemental arrows adding your intelligence to your damage.",
				"You choose the 'Elemental Arrows' perk, allowing you to shoot elemental arrows.");
		public static const ElementalBondFlesh:PerkType = mk("Elemental Bond: Flesh", "Elemental Bond: Flesh",
				"You gains bonus to max HP depending on amount of summoned elementals and their ranks.",
				"You choose the 'Elemental Bond: Flesh' perk, allowing you to form bond with summoned elementals to share recived damage.");
		public static const ElementalBondUrges:PerkType = mk("Elemental Bond: Urges", "Elemental Bond: Urges",
				"You gains bonus to max Lust depending on amount of summoned elementals and their ranks.",
				"You choose the 'Elemental Bond: Urges' perk, allowing you to form bond with summoned elementals to share recived lust damage.");
		public static const ElementalConjurerDedication:PerkType = mk("Elemental Conjurer Dedication", "Elemental Conjurer Dedication",
				"Your intelligence and wisdom is greatly enhanced at the cost of physical body fragility.",
				"You choose 'Elemental Conjurer Dedication' perk, dedicating yourself to pursue path of elemental conjuring at the cost of physical fragility.");
		public static const ElementalConjurerResolve:PerkType = mk("Elemental Conjurer Resolve", "Elemental Conjurer Resolve",
				"Your mental attributes are greatly enhanced at the cost of weakening physical ones.",
				"You choose 'Elemental Conjurer Resolve' perk, showing your resolve to purse mental perfection at the cost of physical weakening.");
		public static const ElementalConjurerSacrifice:PerkType = mk("Elemental Conjurer Sacrifice", "Elemental Conjurer Sacrifice",
				"Your mental attributes are enhanced beyond limits at the cost of similar weakening physical ones.",
				"You choose 'Elemental Conjurer Sacrifice' perk, showing your will to sacrifice everything in reaching beyond mental perfection.");
		public static const ElementalContractRank1:PerkType = mk("Elemental Contract Rank 1", "Elemental Contract Rank 1",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 1.",
				"You choose 'Elemental Contract Rank 1' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank2:PerkType = mk("Elemental Contract Rank 2", "Elemental Contract Rank 2",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 2.",
				"You choose 'Elemental Contract Rank 2' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank3:PerkType = mk("Elemental Contract Rank 3", "Elemental Contract Rank 3",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 3.",
				"You choose 'Elemental Contract Rank 3' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank4:PerkType = mk("Elemental Contract Rank 4", "Elemental Contract Rank 4",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 4.",
				"You choose 'Elemental Contract Rank 4' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank5:PerkType = mk("Elemental Contract Rank 5", "Elemental Contract Rank 5",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 5.",
				"You choose 'Elemental Contract Rank 5' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank6:PerkType = mk("Elemental Contract Rank 6", "Elemental Contract Rank 6",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 6.",
				"You choose 'Elemental Contract Rank 6' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank7:PerkType = mk("Elemental Contract Rank 7", "Elemental Contract Rank 7",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 7.",
				"You choose 'Elemental Contract Rank 7' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank8:PerkType = mk("Elemental Contract Rank 8", "Elemental Contract Rank 8",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to 3rd elder rank.",
				"You choose 'Elemental Contract Rank 8' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank9:PerkType = mk("Elemental Contract Rank 9", "Elemental Contract Rank 9",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to 2nd elder rank.",
				"You choose 'Elemental Contract Rank 9' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank10:PerkType = mk("Elemental Contract Rank 10", "Elemental Contract Rank 10",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to 1st elder rank.",
				"You choose 'Elemental Contract Rank 10' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank11:PerkType = mk("Elemental Contract Rank 11", "Elemental Contract Rank 11",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to grand elder rank.",
				"You choose 'Elemental Contract Rank 11' perk, rising your ability to command more and stronger elementals.");
		public static const ElementsOfMarethBasics:PerkType = mk("Elements of Mareth: Basics", "Elements of Mareth: Basics",
				"You can now summon and command ice, lightning and darkness elementals. Also increase elementals command limit by 1.",
				"You choose 'Elements of Mareth: Basics' perk, your time spent in Mareth allowed you to get basic understanding of native elements that aren't classified as one of four traditional.");
		public static const ElementsOfTheOrtodoxPath:PerkType = mk("Elements of the Ortodox Path", "Elements of the Ortodox Path",
				"You can now summon and command ether, wood and metal elementals. Also increase elementals command limit by 1.",
				"You choose 'Elements of the Ortodox Path' perk, your time spent on studing elements allowed to be able clal those meantioned in more ortodox writings.");
		public static const EnvenomedBolt:PerkType = mk("Envenomed Bolt", "Envenomed Bolt",
				"By carefully collecting your venom you can apply poison to your arrows and bolts.",
				"You choose the 'Envenomed Bolt' perk, allowing you to apply your own venom to arrows and bolts.");
		public static const Evade:PerkType = mk("Evade", "Evade",
				"Increases chances of evading enemy attacks.",
				"You choose the 'Evade' perk, allowing you to avoid enemy attacks more often!");
		public static const FeralArmor:PerkType = mk("Feral Armor", "Feral Armor",
				"Gain extra armor based on your toughness so long as you’re naked and have any form of natural armor.",
				"You choose the 'Feral Armor' perk, gaining extra armor as long you are naked and have any natural armor!");
		public static const FertilityMinus:PerkType = mk("Fertility-", "Fertility-",
				"Decreases fertility rating by 15 and cum volume by up to 30%. (Req's libido of less than 25.)",
				"You choose the 'Fertility-' perk, making it harder to get pregnant.  It also decreases your cum volume by up to 30% (if appropriate)!");
		public static const FertilityPlus:PerkType = mk("Fertility+", "Fertility+",
				"Increases fertility rating by 15 and cum volume by up to 50%.",
				"You choose the 'Fertility+' perk, making it easier to get pregnant.  It also increases your cum volume by up to 50% (if appropriate)!");
		public static const FirstAttackElementals:PerkType = mk("First Attack: Elementals", "First Attack: Elementals",
				"Instead of melee attacking in PC place one of summoned elementals will attack before PC allowing latter to take any action even personaly attaking with melee weapon.",
				"You choose the 'First Attack: Elementals' perk, allowing your summoned elementals to attack independly from you.");
		public static const GorgonsEyes:PerkType = mk("Gorgon's Eyes", "Gorgon's Eyes",
				"Your eyes mutated and now even with any type of eyes you can use petrifying gaze. Additionaly it makes you more immune to all types of attack that are related to sight.",
				"You choose the 'Gorgon's Eyes' perk. Prolonged using petrifying caused your eyes to change even more like those of gorgons.");
		public static const HeavyArmorProficiency:PerkType = mk("Heavy Armor Proficiency", "Heavy Armor Proficiency",
				"Wearing Heavy Armor's grants 10% damage reduction.",
				"You choose the 'Heavy Armor Proficiency' perk.  Due to your specialization in wearing heavy armor's you gain a little bit of damage reduction.");
		public static const Heroism:PerkType = mk("Heroism", "Heroism",
				"Allows you to deal double damage toward boss or gigant sized enemies.",
				"You choose the 'Heroism' perk. Due to your heroic stance you can now deal more damage toward boss or gigant type enemies.");
		public static const HiddenMomentum:PerkType = mk("Hidden Momentum", "Hidden Momentum",
				"You've trained in using your speed to enhance power of your single large weapons swings.",
				"You choose 'Hidden Momentum' perk, allowing to use your speed to enhance power of your attacks with single large weapons.");
		public static const HoldWithBothHands:PerkType = mk("Hold With Both Hands", "Hold With Both Hands",
				"Gain +20% strength modifier with melee weapons when not using a shield.",
				"You choose the 'Hold With Both Hands' perk.  As long as you're wielding a melee weapon and you're not using a shield, you gain 20% strength modifier to damage.");
		public static const HotBlooded:PerkType = mk("Hot Blooded", "Hot Blooded",
				"Raises minimum lust by 20.",
				"You choose the 'Hot Blooded' perk.  As a result of your enhanced libido, your lust no longer drops below 20!");
		public static const ImmovableObject:PerkType = mk("Immovable Object", "Immovable Object",
				"[if(player.tou>=75)" +
						"Grants 10% physical damage reduction.</b>" +
						"|" +
						"<b>You aren't tough enough to benefit from this anymore.</b>" +
						"]",
				"You choose the 'Immovable Object' perk, granting 10% physical damage reduction.</b>");
		public static const Impale:PerkType = mk("Impale", "Impale",
				"Damage bonus of spears and lances critical hits is doubled as long speed is high enough.",
				"You've chosen the 'Impale' perk. Your spear and lance critical hit attacks bonus damages are doubled.");
		public static const IronFists:PerkType = mk("Iron Fists", "Iron Fists",
				"Hardens your fists to increase attack rating by 10.",
				"You choose the 'Iron Fists' perk, hardening your fists. This increases attack power by 10.");
		public static const IronMan:PerkType = mk("Iron Man", "Iron Man",
				"Reduces the fatigue cost of physical specials by 50%.",
				"You choose the 'Iron Man' perk, reducing the fatigue cost of physical special attacks by 50%");
		public static const IronStomach:PerkType = mk("Iron Stomach", "Iron Stomach",
				"Reduces the fatigue cost of physical specials by 50%.",
				"You choose the 'Iron Stomach' perk, reducing the fatigue cost of physical special attacks by 50%");
		public static const JobCourtesan:PerkType = mk("Job: Courtesan", "Job: Courtesan",
				"You've mastered all various uses of tease.",
				"You choose 'Job: Courtesan' perk, training yourself to became Courtesan.");
		public static const JobDefender:PerkType = mk("Job: Defender", "Job: Defender",
				"You've trained in withstanding even the heaviest attacks head on.",
				"You choose 'Job: Defender' perk, training yourself to became Defender.");
		public static const JobDervish:PerkType = mk("Job: Dervish", "Job: Dervish",
				"You've trained in multi meele attacks combat and using of medium sized dual weapons.",
				"You choose 'Job: Dervish' perk, training yourself to became Dervish.");
		public static const JobElementalConjurer:PerkType = mk("Job: Elemental Conjurer", "Job: Elemental Conjurer",
				"You've trained in summoning various types of elementals.",
				"You choose 'Job: Elemental Conjurer' perk, training yourself to call elementals.");
		public static const JobEnchanter:PerkType = mk("Job: Enchanter", "Job: Enchanter",
				"You've trained in casting empowered buffs.",
				"You choose 'Job: Enchanter' perk, training yourself to became Enchanter.");
		public static const JobEromancer:PerkType = mk("Job: Eromancer", "Job: Eromancer",
				"You've mastered the power of erotic magics.",
				"You choose 'Job: Eromancer' perk, training yourself to became Eromancer.");
		public static const JobGuardian:PerkType = mk("Job: Guardian", "Job: Guardian",
				"You've trained in defensive combat.",
				"You choose 'Job: Guardian' perk, training yourself to became Guardian.");
		public static const JobHunter:PerkType = mk("Job: Hunter", "Job: Hunter",
				"You've trained in hunter combat.",
				"You choose 'Job: Hunter' perk, training yourself to became Hunter.");
		public static const JobKnight:PerkType = mk("Job: Knight", "Job: Knight",
				"You've trained in combat using shields and heaviest armors.",
				"You choose 'Job: Knight' perk, training yourself to became Knight.");
		public static const JobMonk:PerkType = mk("Job: Monk", "Job: Monk",
				"You've trained in unarmed combat.",
				"You choose 'Job: Monk' perk, training yourself to became Monk.");
		public static const JobRanger:PerkType = mk("Job: Ranger", "Job: Ranger",
				"You've trained in ranged combat.",
				"You choose 'Job: Ranger' perk, training yourself to became Ranger.");
		public static const JobSeducer:PerkType = mk("Job: Seducer", "Job: Seducer",
				"You've trained the art of seduction.",
				"You choose 'Job: Seducer' perk, training yourself to became Seducer.");
		public static const JobSorcerer:PerkType = mk("Job: Sorcerer", "Job: Sorcerer",
				"You've trained in magic combat.",
				"You choose 'Job: Sorcerer' perk, training yourself to became Sorcerer.");
		public static const JobWarrior:PerkType = mk("Job: Warrior", "Job: Warrior",
				"You've trained in melee combat.",
				"You choose 'Job: Warrior' perk, training yourself to became Warrior.");
		public static const Juggernaut:PerkType = mk("Juggernaut", "Juggernaut",
				"When wearing heavy armor, you have extra 10% damage resistance and are immune to damage from being constricted/squeezed (req. 100+ tou).",
				"You choose the 'Juggernaut' perk, granting extra 10% damage resistance when wearing heavy armor and immunity to damage from been constricted/squeezed.");
		public static const KitsuneThyroidGland:PerkType = mk("Kitsune Thyroid Gland", "Kitsune Thyroid Gland",
				"Kitsune Thyroid Gland lower cooldowns for Illusion and Terror by three turns, increase speed of the recovery after using magic and slightly boost PC speed.",
				"You choose the 'Kitsune Thyroid Gland' perk. Some time after you become kitsune part of your body changed allowing to boost your kitsune powers.");
		public static const KitsuneThyroidGlandEvolved:PerkType = mk("Kitsune Thyroid Gland (Evolved)", "Kitsune Thyroid Gland (Evolved)",
				"Kitsune Thyroid Gland (Evolved) increase speed of the recovery after using magic, boost PC speed and wisdom. And make fox fire specials 50% stronger when having 9 tails (both fire and lust damage).",
				"You choose the 'Kitsune Thyroid Gland (Evolved)' perk. Continued using of kitsune powers caused your thyroid gland to evolve.");
		public static const LightningStrikes:PerkType = mk("Lightning Strikes", "Lightning Strikes",
				"[if(player.spe>=60)" +
						"Increases the attack damage for non-heavy weapons.</b>" +
						"|" +
						"<b>You are too slow to benefit from this perk.</b>" +
						"]",
				"You choose the 'Lightning Strikes' perk, increasing the attack damage for non-heavy weapons.</b>");
		public static const LizanMarrow:PerkType = mk("Lizan Marrow", "Lizan Marrow",
				"Regenerates 0.5% of HP per round in combat and 1% of HP per hour. Additionaly your limit for innate self-regeneration rate increased.",
				"You choose the 'Lizan Marrow' perk. Constant regenerating your body caused pernamently change to your body marrow.");
		public static const LizanMarrowEvolved:PerkType = mk("Lizan Marrow (Evolved)", "Lizan Marrow (Evolved)",
				"Regenerates 0.5% of HP per round in combat and 1% of HP per hour. Additionaly your limit for innate self-regeneration rate increased.",
				"You choose the 'Lizan Marrow (Evolved)' perk. Constant use of your lizan marrow caused it to change.");
		public static const LungingAttacks:PerkType = mk("Lunging Attacks", "Lunging Attacks",
				"[if(player.spe>=75)" +
						"Grants 50% armor penetration for standard attacks." +
						"|" +
						"<b>You are too slow to benefit from this perk.</b>" +
						"]",
				"You choose the 'Lunging Attacks' perk, granting 50% armor penetration for standard attacks.");
		public static const ManticoreMetabolism:PerkType = mk("Manticore Metabolism", "Manticore Metabolism",
				"Allows you to gain a boost of speed for a few hours after an intake of cum and allow attack twice with tail spike per turn.",
				"You choose the 'Manticore Metabolism' perk, allows you to gain a boost of speed after an intake of cum and allow atack more often with tail spike.");
		public static const MantislikeAgility:PerkType = mk("Mantis-like Agility", "Mantis-like Agility",
				"Your altered musculature allows to increase your natural agility and speed. If somehow you would have some type of natural armor or even thicker skin this increase could be even greater...",
				"You choose the 'Mantis-like Agility' perk, by becoming much more mantis-like your body musculature started to slowly adapt to existance of exoskeleton.");
		public static const MantislikeAgilityEvolved:PerkType = mk("Mantis-like Agility (Evolved)", "Mantis-like Agility (Evolved)",
				"Your altered musculature providing you with even higher increase to agility and speed. If somehow you would have some type of natural armor or even thicker skin this increase would be even bigger.",
				"You choose the 'Mantis-like Agility (Evolved)' perk, by becoming much more mantis-like your body musculature started to slowly adapt to existance of exoskeleton.");
		public static const Manyshot:PerkType = mk("Manyshot", "Manyshot",
				"You always shoot two arrows instead of one on your first strike.",
				"You choose the 'Manyshot' perk, to always shoot two arrows instead of one on your first strike.");
		public static const Masochist:PerkType = mk("Masochist", "Masochist",
				"Take 20% less physical damage but gain lust when you take damage.",
				"You choose the 'Masochist' perk, reducing the damage you take but raising your lust each time!  This perk only functions while your libido is at or above 60!");
		public static const NakedTruth:PerkType = mk("Naked Truth", "Naked Truth",
				"Opponent have a hard time dealing serious damage as the sight of your naked body distract them (+10% dmg reduction).",
				"You choose the 'Naked Truth' perk, causing opponent have a hard time dealing serious damage as the sight of your naked body distract them.");
		public static const Naturaljouster:PerkType = mk("Natural jouster", "Natural jouster",
				"Increase attack power of spears/lances when you attack once each turn and have taur/drider lower body or 2,5x higher speed if you not have one of this specific lower body types (60+ for taurs/drider and 150+ for others).",
				"You've chosen the 'Natural jouster' perk. As long you will have taur or drider lower body and attack once per turn your spear/lance attack power will be three time higher.");
		public static const NaturaljousterMastergrade:PerkType = mk("Natural jouster (Master grade)", "Natural jouster (Master grade)",
				"Increase attack power of spears/lances when you attack once each turn and have taur/drider lower body or 2,5x higher speed if you not have one of this specific lower body types (180+ for taurs/drider and 450+ for others).",
				"You've chosen the 'Natural jouster (Master grade)' perk. As long you will have taur or drider lower body and attack once per turn your spear/lance attack power will be five time higher.");
		public static const Nymphomania:PerkType = mk("Nymphomania", "Nymphomania",
				"Raises minimum lust by up to 30.",
				"You've chosen the 'Nymphomania' perk.  Due to the incredible amount of corruption you've been exposed to, you've begun to live in a state of minor constant arousal.  Your minimum lust will be increased by 30.");
		public static const Parry:PerkType = mk("Parry", "Parry",
				"[if(player.spe>=50)" +
						"Increases deflect chance by up to 10% while wielding a weapon. (Speed-based)." +
						"|" +
						"<b>You are not fast enough to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Parry' perk, giving you a chance to deflect blow with your weapon. (Speed-based).");
		public static const Precision:PerkType = mk("Precision", "Precision",
				"Reduces enemy armor by 10. (Req's 25+ Intelligence)",
				"You've chosen the 'Precision' perk.  Thanks to your intelligence, you're now more adept at finding and striking an enemy's weak points, reducing their damage resistance from armor by 10.  If your intelligence ever drops below 25 you'll no longer be smart enough to benefit from this perk.");
		public static const PrestigeJobArcaneArcher:PerkType = mk("Prestige Job: Arcane Archer", "Prestige Job: Arcane Archer",
				"You've trained in prestige art of combining magic and arrows.",
				"You choose 'Prestige Job: Arcane Archer' perk, training yourself to became Arcane Archer.");
		public static const PrestigeJobBerserker:PerkType = mk("Prestige Job: Berserker", "Prestige Job: Berserker",
				"You've trained in prestige art of perfect mastery over all forms of berserking.",
				"You choose 'Prestige Job: Berserker' perk, training yourself to became Berserker.");
		public static const PrestigeJobSentinel:PerkType = mk("Prestige Job: Sentinel", "Prestige Job: Sentinel",
				"You've trained in prestige art that brings 'tanking' to a whole new level.",
				"You choose 'Prestige Job: Sentinel' perk, training yourself to became Sentinel.");
		public static const PrestigeJobKiArtMaster:PerkType = mk("Prestige Job: Ki Art Master", "Prestige Job: Ki Art Master",
				"You've trained in prestige art of combine Ki with physical attacks to various deadly effect.",
				"You choose 'Prestige Job: Ki Art Master' perk, training yourself to became Ki Art Master.");
		public static const PrimalFury:PerkType = mk("Primal Fury", "Primal Fury",
				"Raises max Wrath by 10, generates 1 point of Wrath out of combat and double this amount during fight.",
				"You choose the 'Primal Fury' perk, increasing passive wrath generation and max Wrath.");
		public static const Rage:PerkType = mk("Rage", "Rage",
				"Increasing crit chance by up to 50% in berserk state that would reset after succesful crit attack.",
				"You choose the 'Rage' perk, increasing crit chance by up to 50% in berserk state until next crit attack.");
		public static const Regeneration :RegenerationPerk = new RegenerationPerk();
		public static const Resistance:PerkType = mk("Resistance", "Resistance",
				"Reduces lust gain by 5%.",
				"You choose the 'Resistance I' perk, reducing the rate at which your lust increases by 5%.");
		public static const Resolute:PerkType = mk("Resolute", "Resolute",
				"[if(player.tou>=75)" +
						"Grants immunity to stuns and some statuses.</b>" +
						"|" +
						"<b>You aren't tough enough to benefit from this anymore.</b>" +
						"]",
				"You choose the 'Resolute' perk, granting immunity to stuns and some statuses.</b>");
		public static const Runner:PerkType = mk("Runner", "Runner",
				"Increases chances of escaping combat.",
				"You choose the 'Runner' perk, increasing your chances to escape from your foes when fleeing!");
		public static const Sadist:PerkType = mk("Sadist", "Sadist",
				"Deal 20% more damage, but gain lust at the same time.",
				"You choose the 'Sadist' perk, increasing damage by 20 percent but causing you to gain lust from dealing damage.");
		public static const SalamanderAdrenalGlands:PerkType = mk("Salamander Adrenal Glands", "Salamander Adrenal Glands",
				"Your Salamander adrenal glands giving you slight boost to your natural stamina and libido.",
				"You choose the 'Salamander Adrenal Glands' perk, due to repeadly exposure to effects of lustzerk your adrenal glands mutated.");
		public static const SalamanderAdrenalGlandsEvolved:PerkType = mk("Salamander Adrenal Glands (Evolved)", "Salamander Adrenal Glands (Evolved)",
				"Your Salamander adrenal glands giving you slight boost to your natural strength, stamina, speed and libido and extend lustzerker and berserker duration by 2 turns.",
				"You choose the 'Salamander Adrenal Glands (Evolved)' perk, repeadly use of lustzerk caused your adrenal glands mutate even more.");
		public static const ScyllaInkGlands:PerkType = mk("Scylla Ink Glands", "Scylla Ink Glands",
				"Your Scylla Ink Glands increase rate at which your body produce ink and slight boost to your natural strength.",
				"You choose the 'Scylla Ink Glands' perk, due to repeadly use of ink attack leading to denveloping ink glands!");
		public static const SecondWind:PerkType = mk("SecondWind", "SecondWind",
				"Using ... fatigue increase by 5% regeneration in combat for ... turns.",
				"You choose the 'SecondWind' perk, allowing to once per fight increase for few turns natural regeneration at cost of some fatigue.");
		public static const Seduction:PerkType = mk("Seduction", "Seduction",
				"Upgrades your tease attack, making it more effective.",
				"You choose the 'Seduction' perk, upgrading the 'tease' attack with a more powerful damage and a higher chance of success.");
		public static const ShieldMastery:PerkType = mk("Shield Mastery", "Shield Mastery",
				"[if(player.tou>=50)" +
						"Increases block chance by up to 10% while using a shield (Toughness-based)." +
						"|" +
						"<b>You are not durable enough to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Shield Mastery' perk, increasing block chance by up to 10% as long as you're wielding a shield (Toughness-based).");
		public static const ShieldSlam:PerkType = mk("Shield Slam", "Shield Slam",
				"Reduces shield bash diminishing returns by 50% and increases bash damage by 20%.",
				"You choose the 'Shield Slam' perk.  Stun diminishing returns is reduced by 50% and shield bash damage is increased by 20%.");
		public static const SluttySimplicity:PerkType = mk("Slutty Simplicity", "Slutty Simplicity",
				"Increases by 10% tease effect when you are naked. (Undergarments won't disable this perk.)",
				"You choose the 'Slutty Simplicity' perk, granting increased tease effect when you are naked.");
		public static const SpeedyRecovery:PerkType = mk("Speedy Recovery", "Speedy Recovery",
				"Regain fatigue +50% out of combat / +100% in combat faster.",
				"You choose the 'Speedy Recovery' perk, boosting your fatigue recovery rate!");
		public static const Spellarmor:PerkType = mk("Spellarmor", "Spellarmor",
				"Start every battle with Charge Armor enabled, if you meet White Magic requirements before it starts.",
				"You choose the 'Spellarmor' perk. You start every battle with Charge Armor effect, as long as your Lust is not preventing you from casting it before battle.");
		public static const Spellpower:PerkType = mk("Spellpower", "Spellpower",
				"[if (player.inte>=50)" +
						"Increases base spell strength by 10% and mana pool by 15." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Spellpower' perk.  Thanks to your sizeable intellect and willpower, you are able to more effectively use magic, boosting base spell effects by 10% and mana pool by 15.");
		public static const Spellsword:PerkType = mk("Spellsword", "Spellsword",
				"Start every battle with Charge Weapon enabled, if you meet White Magic requirements before it starts.",
				"You choose the 'Spellsword' perk. You start every battle with Charge Weapon effect, as long as your Lust is not preventing you from casting it before battle.");
		public static const SteelImpact:PerkType = mk("Steel Impact", "Steel Impact",
				"Add a part of your toughness to your weapon and shield damage.",
				"You choose the 'Steel Impact' perk. Increasing damage of your weapon and shield.");
		public static const StrongElementalBond:PerkType = mk("Strong Elemental Bond", "Strong Elemental Bond",
				"You lower by 10 needed mana to sustain active elemental in combat.",
				"You choose the 'Strong Elemental Bond' perk, enhancing your connection with elementals and lowering mana needed to maintain bonds.");
		public static const StrongerElementalBond:PerkType = mk("Stronger Elemental Bond", "Stronger Elemental Bond",
				"You lower by 30 needed mana to sustain active elemental in combat.",
				"You choose the 'Stronger Elemental Bond' perk, futher enhancing your connection with elementals.");
		public static const StrongestElementalBond:PerkType = mk("Strongest Elemental Bond", "Strongest Elemental Bond",
				"You lower by 90 needed mana to sustain active elemental in combat.",
				"You choose the 'Strongest Elemental Bond' perk, reaching near the peak of connection strength with your elementals.");
		public static const StaffChanneling:PerkType = mk("Staff Channeling", "Staff Channeling",
				"Basic attack with wizard's staff is replaced with ranged magic bolt.",
				"You choose the 'Staff Channeling' perk. Basic attack with wizard's staff is replaced with ranged magic bolt.");
		public static const StrongBack:PerkType = mk("Strong Back", "Strong Back",
				"Enables fourth and fifth item slots.",
				"You choose the 'Strong Back' perk, enabling a fourth and fifth item slot.");
		public static const Tactician:PerkType = mk("Tactician", "Tactician",
				"[if(player.inte>=50)" +
						"Increases critical hit chance by up to 10% (Intelligence-based)." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Tactician' perk, increasing critical hit chance by up to 10% (Intelligence-based).");
		public static const Tank:PerkType = mk("Tank", "Tank",
				"+3 extra HP per point of toughness.",
				"You choose the 'Tank' perk, granting +3 extra maximum HP for each point of toughness.");
		public static const ThirstForBlood:PerkType = mk("Thirst for blood", "Thirst for blood",
				"Weapon and effect that causes bleed damage have this damage increased by 50%.",
				"You choose the 'Thirst for blood' perk, increasing damage done by bleed effects.");
		public static const ThunderousStrikes:PerkType = mk("Thunderous Strikes", "Thunderous Strikes",
				"+20% 'Attack' damage while strength is at or above 80.",
				"You choose the 'Thunderous Strikes' perk, increasing normal damage by 20% while your strength is over 80.");
		public static const TitanGrip:PerkType = mk("Titan Grip", "Titan Grip",
				"Gain an ability to wield large weapons in one hand.",
				"You choose the 'Titan Grip' perk, gaining an ability to wield large weapons in one hand.");
		public static const ToughHide:PerkType = mk("Tough Hide", "Tough Hide",
				"Increase your natural armor by 2 so long as you have scale chitin fur or other natural armor.",
				"You choose the 'Tough Hide' perk, increase your natural armor as long you have any natural armor!");
		public static const TrachealSystem:PerkType = mk("Tracheal System", "Tracheal System",
				"Your body posses rudimentary respiratory system of the insects.",
				"You choose the 'Tracheal System' perk, by becoming much more insect-like your body started to denvelop crude version of insects breathing system.");
		public static const TrachealSystemFinalForm:PerkType = mk("Tracheal System (Final Form)", "Tracheal System (Final Form)",
				"Your body posses fully developed respiratory system of the insects.",
				"You choose the 'Tracheal System (Final Form)' perk, continued exposition to insectoidal changes caused your tracheal system evolution into it final form.");
		public static const TrachealSystemEvolved:PerkType = mk("Tracheal System (Evolved)", "Tracheal System (Evolved)",
				"Your body posses half developed respiratory system of the insects.",
				"You choose the 'Tracheal System (Evolved)' perk, continuous exposition to insectoidal changes caused your tracheal system evolution into more complete form.");
		public static const TraditionalMage:PerkType = mk("Traditional Mage", "Traditional Mage",
				"You gain 100% spell effect multiplier while using a staff and either a tome or no ranged weapon.",
				"You choose the 'Traditional Mage I' perk, boosting your base spell effects while using a staff and either a tome or no ranged weapon.");
		public static const Trance:PerkType = mk("Trance", "Trance",
				"Unlocked ability to enter a state in which PC assumes a crystalline form, enhancing physical and mental abilities at constant cost of Ki.",
				"You choose the 'Trance' perk, which unlock 'Trance' special. It enhancing physical and mental abilities at constant cost of Ki.");
		public static const Transference:PerkType = mk("Transference", "Transference",
				"Your mastery of lust and desire allows you to transfer 15% of your current arousal to your opponent.",
				"You choose the 'Transference' perk, granting ability to transfer your own arousal to your opponent.");
		public static const Unhindered:PerkType = mk("Unhindered", "Unhindered",
				"Increases chances of evading enemy attacks when you are naked. (Undergarments won't disable this perk.)",
				"You choose the 'Unhindered' perk, granting chance to evade when you are naked.");
		public static const VitalShot:PerkType = mk("Vital Shot", "Vital Shot",
				"Gain a +10% chance to do a critical strike with arrows.",
				"You choose the 'Vital Shot' perk, gaining an additional +10% chance to cause a critical hit with arrows.");
		public static const WeaponMastery:PerkType = mk("Weapon Mastery", "Weapon Mastery",
				"[if(player.str>99)" +
						"One and half damage bonus of weapons classified as 'Large'. Additionaly 10% higher chance to crit with those weapons." +
						"|" +
						"<b>You aren't strong enough to benefit from this anymore.</b>" +
						"]",
				"You choose the 'Weapon Mastery' perk, getting one and half of the effectiveness of large weapons.");
		public static const WellAdjusted:PerkType = mk("Well Adjusted", "Well Adjusted",
				"You gain half as much lust as time passes in Mareth.",
				"You choose the 'Well Adjusted' perk, reducing the amount of lust you naturally gain over time while in this strange land!");
		public static const JobArcaneArcher:PerkType = mk("Job: Arcane Archer", "Job: Arcane Archer",
				"You've trained in art of combining magic and arrows.",
				"You choose 'Job: Arcane Archer' perk, training yourself to became Arcane Archer.");
		public static const JobArcher:PerkType = mk("Job: Archer", "Job: Archer",
				"You've trained in ranged combat.",
				"You choose 'Job: Archer' perk, training yourself to became Archer.");//perk później do usuniecia
		

		// Needlework perks
		public static const ChiReflowAttack:PerkType = mk("Chi Reflow - Attack", "Chi Reflow - Attack",
				"Regular attacks boosted, but damage resistance decreased.");
		public static const ChiReflowDefense:PerkType = mk("Chi Reflow - Defense", "Chi Reflow - Defense",
				"Passive damage resistance, but caps speed");
		public static const ChiReflowLust:PerkType = mk("Chi Reflow - Lust", "Chi Reflow - Lust",
				"Lust resistance and Tease are enhanced, but Libido and Sensitivity gains increased.");
		public static const ChiReflowMagic:PerkType = mk("Chi Reflow - Magic", "Chi Reflow - Magic",
				"Magic attacks boosted, but regular attacks are weaker.");
		public static const ChiReflowSpeed:PerkType = mk("Chi Reflow - Speed", "Chi Reflow - Speed",
				"Speed reductions are halved but caps strength");

		// Piercing perks
		public static const PiercedCrimstone:PiercedCrimstonePerk = new PiercedCrimstonePerk();
		public static const PiercedIcestone:PiercedIcestonePerk = new PiercedIcestonePerk();
		public static const PiercedFertite:PiercedFertitePerk = new PiercedFertitePerk();
		public static const PiercedFurrite:PerkType = mk("Pierced: Furrite", "Pierced: Furrite",
				"Increases chances of encountering 'furry' foes.");
		public static const PiercedLethite:PerkType = mk("Pierced: Lethite", "Pierced: Lethite",
				"Increases chances of encountering demonic foes.");

		// Cock sock perks
		public static const LustyRegeneration:PerkType = mk("Lusty Regeneration", "Lusty Regeneration",
				"Regenerates 0,5% of HP per round in combat and 1% of HP per hour.");
		public static const MidasCock:PerkType = mk("Midas Cock", "Midas Cock",
				"Increases the gems awarded from victory in battle.");
		public static const PentUp:PentUpPerk = new PentUpPerk();
		public static const PhallicPotential:PerkType = mk("Phallic Potential", "Phallic Potential",
				"Increases the effects of penis-enlarging transformations.");
		public static const PhallicRestraint:PerkType = mk("Phallic Restraint", "Phallic Restraint",
				"Reduces the effects of penis-enlarging transformations.");

		// Non-weapon equipment perks
		public static const Ambition:AmbitionPerk = new AmbitionPerk();
		public static const DexterousSwordsmanship:PerkType = mk("Dexterous swordsmanship", "Dexterous swordsmanship",
				"Increases parry chance by 10% while wielding a weapon.",null,true);
		public static const BloodMage:PerkType = mk("Blood Mage", "Blood Mage",
				"Spellcasting now consumes health instead of mana!",null,true);
		public static const LastResort:PerkType = mk("Last Resort", "Last Resort",
				"When mana is too low to cast a spell, automatically cast from hp instead.",null,true);
		public static const Obsession:ObsessionPerk = new ObsessionPerk();
		public static const Sanctuary:PerkType = mk("Sanctuary", "Sanctuary", "Regenerates up to 1% of HP scaling on purity");
		public static const SeersInsight:SeersInsightPerk = new SeersInsightPerk();
		public static const SluttySeduction:SluttySeductionPerk = new SluttySeductionPerk();
		public static const WellspringOfLust:PerkType = mk("Wellspring of Lust", "Wellspring of Lust",
				"At the beginning of combat, gain lust up to black magic threshold if lust is bellow black magic threshold.",null,true);
		public static const WizardsEnduranceAndSluttySeduction:WizardsEnduranceAndSluttySeductionPerk = new WizardsEnduranceAndSluttySeductionPerk();
		public static const WizardsAndDaoistsEndurance:WizardsAndDaoistsEndurancePerk = new WizardsAndDaoistsEndurancePerk();
		public static const WizardsEndurance:WizardsEndurancePerk = new WizardsEndurancePerk();

		// Melee & Range weapon perks
		public static const Accuracy1:Accuracy1Perk = new Accuracy1Perk();
		public static const Accuracy2:Accuracy2Perk = new Accuracy2Perk();
		public static const BladeWarden:PerkType = mk("Blade-Warden", "Blade-Warden",
				"Enables Resonance Volley ki power while equipped: Perform a ranged attack where each arrow after the first gets an additional 10% accuracy for every arrow before it.",null,true);
		public static const BodyCultivatorsFocus:BodyCultivatorsFocusPerk = new BodyCultivatorsFocusPerk();
		public static const DaoistsFocus:DaoistsFocusPerk = new DaoistsFocusPerk();
		public static const MageWarden:PerkType = mk("Mage-Warden", "Mage-Warden",
				"Enables Resonance Volley ki power while equipped: Perform a ranged attack where each arrow after the first gets an additional 10% accuracy for every arrow before it.",null,true);
		public static const SagesKnowledge:SagesKnowledgePerk = new SagesKnowledgePerk();
		public static const StrifeWarden:PerkType = mk("Strife-Warden", "Strife-Warden",
				"Enables Beat of War ki power while equipped: Attack with low-moderate additional soul damage, gain strength equal to 15% your base strength until end of battle. This effect stacks.",null,true);
		public static const WildWarden:PerkType = mk("Wild-Warden", "Wild-Warden",
				"Enables Resonance Volley ki power while equipped: Perform a ranged attack where each arrow after the first gets an additional 10% accuracy for every arrow before it.",null,true);
		public static const WizardsAndDaoistsFocus:WizardsAndDaoistsFocusPerk = new WizardsAndDaoistsFocusPerk();
		public static const WizardsFocus:WizardsFocusPerk = new WizardsFocusPerk();

		// Achievement perks
		public static const BowShooting:BowShootingPerk = new BowShootingPerk();
		public static const BroodMother:PerkType = mk("Brood Mother", "Brood Mother",
				"Pregnancy moves twice as fast as a normal woman's.");
		public static const SpellcastingAffinity:SpellcastingAffinityPerk = new SpellcastingAffinityPerk();

		// Mutation perks
		public static const Androgyny:PerkType = mk("Androgyny", "Androgyny",
				"No gender limits on facial masculinity or femininity.");
		public static const AquaticAffinity:PerkType = mk("Aquatic Affinity", "Aquatic Affinity",
				"When in an aquatic battle you gains a +30 to strength and speed.");
		public static const BasiliskWomb:PerkType = mk("Basilisk Womb", "Basilisk Womb",
				"Enables your eggs to be properly fertilized into basilisks of both genders!");
		public static const BeeOvipositor:PerkType = mk("Bee Ovipositor", "Bee Ovipositor",
				"Allows you to lay eggs through a special organ on your insect abdomen, though you need at least 10 eggs to lay.");
		public static const BicornBlessing:PerkType = mk("Bicorn Blessing", "Bicorn Blessing",
				"Your are blessed with the unholy power of a bicorn and while above 80 corruption your black magic  is increased by 20% and lust resistance by 10%.");
		public static const BimboBody:PerkType = mk("Bimbo Body", "Bimbo Body",
				"Gives the body of a bimbo.  Tits will never stay below a 'DD' cup, libido is raised, lust resistance is raised, and upgrades tease.");
		public static const BimboBrains:PerkType = mk("Bimbo Brains", "Bimbo Brains",
				"Now that you've drank bimbo liquer, you'll never, like, have the attention span and intelligence you once did!  But it's okay, 'cause you get to be so horny an' stuff!");
		public static const BroBody:PerkType = mk("Bro Body", "Bro Body",
				"Grants an ubermasculine body that's sure to impress.");
		public static const BroBrains:PerkType = mk("Bro Brains", "Bro Brains",
				"Makes thou... thin... fuck, that shit's for nerds.");
		public static const BunnyEggs:PerkType = mk("Bunny Eggs", "Bunny Eggs",
				"Laying eggs has become a normal part of your bunny-body's routine.");
		public static const ColdAffinity:PerkType = mk("Cold Affinity", "Cold Affinity",
				"You have high resistance to cold effects, immunity to the frozen condition, and mastery over ice abilities and magic. However, you are highly susceptible to fire.");
		public static const ColdMastery:PerkType = mk("Cold Mastery", "Cold Mastery",
				"You now have complete control over the ice element adding your own inner power to all cold based attack.");
		public static const CorruptedKitsune:PerkType = mk("Corrupted Kitsune", "Corrupted Kitsune",
				"The mystical energy of the kitsunes surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly after casting spells, but your method of attaining it has corrupted the transformation, preventing you from achieving true enlightenment.",null,true);
		public static const CorruptedNinetails:PerkType = mk("Corrupted Nine-tails", "Corrupted Nine-tails",
				"The mystical energy of the nine-tails surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly after casting spells, but your method of attaining it has corrupted the transformation, preventing you from achieving true enlightenment.",null,true);
		public static const DarkCharm:PerkType = mk("Dark Charm", "Dark Charm",
				"Allows access to demons charm attacks.");
		public static const Diapause:PerkType = mk("Diapause", "Diapause",
				"Pregnancy does not advance normally, but develops quickly after taking in fluids.");
		public static const DragonDarknessBreath:PerkType = mk("Dragon darkness breath", "Dragon darkness breath",
				"Allows access to a dragon darkness breath attack.");
		public static const DragonFireBreath:PerkType = mk("Dragon fire breath", "Dragon fire breath",
				"Allows access to a dragon fire breath attack.");
		public static const DragonIceBreath:PerkType = mk("Dragon ice breath", "Dragon ice breath",
				"Allows access to a dragon ice breath attack.");
		public static const DragonLightningBreath:PerkType = mk("Dragon lightning breath", "Dragon lightning breath",
				"Allows access to a dragon lightning breath attack.");
		public static const ElectrifiedDesire:PerkType = mk("Electrified Desire", "Electrified Desire",
				"Masturbating only makes you hornier. Furthermore, your ability to entice, tease and zap thing is enhanced the more horny you are.");
		public static const EnlightenedKitsune:PerkType = mk("Enlightened Kitsune", "Enlightened Kitsune",
				"The mystical energy of the kitsunes surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly after casting spells.",null,true);
		public static const EnlightenedNinetails:PerkType = mk("Enlightened Nine-tails", "Enlightened Nine-tails",
				"The mystical energy of the nine-tails surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly after casting spells.",null,true);
		public static const Feeder:PerkType = mk("Feeder", "Feeder",
				"Lactation does not decrease and gives a compulsion to breastfeed others.");
		public static const FenrirSpikedCollar:PerkType = mk("Fenrir spiked collar", "Fenrir spiked collar",
				"The magical chain as well as the strongly enchanted collar increase damage reduction by 10%.");
		public static const FireAffinity:PerkType = mk("Fire Affinity", "Fire Affinity",
				"You have high resistance to fire effects, immunity to the burn condition, and mastery over fire abilities and magic. However, you are highly susceptible to ice.");
		public static const Flexibility:PerkType = mk("Flexibility", "Flexibility",
				"Grants cat-like flexibility.  Useful for dodging and 'fun'.");
		public static const FreezingBreath:PerkType = mk("Freezing Breath (F)", "Freezing Breath (F)",
				"Allows access to Fenrir (AoE) freezing breath attack.");
		public static const FreezingBreathYeti:PerkType = mk("Freezing Breath (Y)", "Freezing Breath (Y)",
				"Allows access to Yeti freezing breath attack.");
		public static const FromTheFrozenWaste:PerkType = mk("From the frozen waste", "From the frozen waste",
				"You are resistant to cold but gain a weakness to fire.");
		public static const FutaFaculties:PerkType = mk("Futa Faculties", "Futa Faculties",
				"It's super hard to think about stuff that like, isn't working out or fucking!");
		public static const FutaForm:PerkType = mk("Futa Form", "Futa Form",
				"Ensures that your body fits the Futa look (Tits DD+, Dick 8\"+, & Pussy).  Also keeps your lusts burning bright and improves the tease skill.");
		public static const GeneticMemory:PerkType = mk("Genetic Memory", "Genetic Memory",
				"Your body can remember almost any transformation it undergone.");
		public static const HarpyWomb:PerkType = mk("Harpy Womb", "Harpy Womb",
				"Increases all laid eggs to large size so long as you have harpy legs and a harpy tail.");
		public static const ImprovedVenomGland:PerkType = mk("Improved venom gland", "Improved venom gland",
				"Empower your racial venoms, Increasing their effect potencies.");
		public static const Incorporeality:PerkType = mk("Incorporeality", "Incorporeality",
				"Allows you to fade into a ghost-like state and temporarily possess others.");
		public static const InkSpray:PerkType = mk("Ink Spray", "Ink Spray",
				"Allows you to shoot blinding and probably slightly arousing ink out of your genitalia similar like octopus.");
		public static const JunglesWanderer:PerkType = mk("Jungle’s Wanderer", "Jungle’s Wanderer",
				"Your nimble body has adapted to moving through jungles and forests, evading enemy attacks with ease and making yourself harder to catch. (+35 to the Evasion percentage)");
		public static const Lycanthropy:PerkType = mk("Lycanthropy", "Lycanthropy",
				"Your strength and urges are directly tied to the cycle of the moon. Furthermore, your skin is resistant to normal damage and your claws are sharper than normal.");
		public static const LycanthropyDormant:PerkType = mk("Dormant Lycanthropy", "Dormant Lycanthropy",
				"You sometimes hear echoes of the call of the moon. If you were more of a werebeast you likely would feel its pull again. A lycanthrope is never truly cured.");
		public static const LightningAffinity:PerkType = mk("Lightning Affinity", "Lightning Affinity",
				"Increase all damage dealt with lightning spells by 100% and reduce lightning damage taken by 50%.");
		public static const LizanRegeneration:PerkType = mk("Lizan Regeneration", "Lizan Regeneration",
				"Regenerates 1.5% of HP per round in combat and 3% of HP per hour and additional slightly increasing maximal attainable natural healing rate.");
		public static const Lustzerker:PerkType = mk("Lustzerker", "Lustzerker",
				"Lustserking increases attack and physical defenses resistance but reduces lust resistance.");
		public static const ManticoreCumAddict:PerkType = mk("Manticore Cum Addict", "Manticore Cum Addict",
				"Causes you to crave cum frequently.  Yet at the same time grants you immunity to Minotaur Cum addiction.");
		public static const MantisOvipositor:PerkType = mk("Mantis Ovipositor", "Mantis Ovipositor",
				"Allows you to lay eggs through a special organ on your insect abdomen, though you need at least 10 eggs to lay.");
		public static const MilkMaid:MilkMaidPerk = new MilkMaidPerk();
		public static const MinotaurCumAddict:PerkType = mk("Minotaur Cum Addict", "Minotaur Cum Addict",
				"Causes you to crave minotaur cum frequently.  You cannot shake this addiction.");
		public static const MinotaurCumResistance:PerkType = mk("Minotaur Cum Resistance", "Minotaur Cum Resistance",
				"You can never become a Minotaur Cum Addict. Grants immunity to Minotaur Cum addiction.");
		public static const NinetailsKitsuneOfBalance:PerkType = mk("Nine-tails Kitsune of Balance", "Nine-tails Kitsune of Balance",
				"The mystical energy of the nine-tails surges through you, filling you with phenomenal cosmic power!  You tread narrow path between corruption and true enlightment maintaining balance that allow to fuse both sides powers.",null,true);
		public static const Oviposition:PerkType = mk("Oviposition", "Oviposition",
				"Causes you to regularly lay eggs when not otherwise pregnant.");
		public static const PhoenixFireBreath:PerkType = mk("Phoenix fire breath", "Phoenix fire breath",
				"Allows access to a phoenix fire breath attack.");
		public static const PurityBlessing:PerkType = mk("Purity Blessing", "Purity Blessing",
				"Reduces the rate at which your corruption, libido, and lust increase. Reduces minimum libido and lust slightly.");
		public static const RapierTraining:PerkType = mk("Rapier Training", "Rapier Training",
				"After finishing of your training, increase attack power of any rapier you're using.");
		public static const SatyrSexuality:PerkType = mk("Satyr Sexuality", "Satyr Sexuality",
				"Thanks to your satyr biology, you now have the ability to impregnate both vaginas and asses. Also increases your virility rating. (Anal impregnation not implemented yet)");
		public static const SlimeCore:PerkType = mk("Slime Core", "Slime Core",
				"Grants more control over your slimy body, allowing you to go twice as long without fluids.");
		public static const SpiderOvipositor:PerkType = mk("Spider Ovipositor", "Spider Ovipositor",
				"Allows you to lay eggs through a special organ on your arachnid abdomen, though you need at least 10 eggs to lay.");
		public static const ThickSkin:PerkType = mk("Thick Skin", "Thick Skin",
				"Toughens your dermis to provide 2 points of armor.");
		public static const TransformationResistance:PerkType = mk("Transformation Resistance", "Transformation Resistance",
				"Reduces the likelihood of undergoing a transformation. Disables Bad Ends from transformative items.");
				
		// Quest, Event & NPC perks
		public static const BasiliskResistance:PerkType = mk("Basilisk Resistance", "Basilisk Resistance",
				"Grants immunity to Basilisk's paralyzing gaze. Disables Basilisk Bad End.");
		public static const BulgeArmor:PerkType = mk("Bulge Armor", "Bulge Armor",
				"Grants a 5 point damage bonus to dick-based tease attacks.");
		public static const Cornucopia:PerkType = mk("Cornucopia", "Cornucopia",
				"Vaginal and Anal capacities increased by 30.");
		public static const ElvenBounty:ElvenBountyPerk = new ElvenBountyPerk();
		public static const FerasBoonAlpha:PerkType = mk("Fera's Boon - Alpha", "Fera's Boon - Alpha",
				"Increases the rate your cum builds up and cum production in general.");
		public static const FerasBoonBreedingBitch:PerkType = mk("Fera's Boon - Breeding Bitch", "Fera's Boon - Breeding Bitch",
				"Increases fertility and reduces the time it takes to birth young.");
		public static const FerasBoonMilkingTwat:PerkType = mk("Fera's Boon - Milking Twat", "Fera's Boon - Milking Twat",
				"Keeps your pussy from ever getting too loose and increases pregnancy speed.");
		public static const FerasBoonSeeder:PerkType = mk("Fera's Boon - Seeder", "Fera's Boon - Seeder",
				"Increases cum output by 1,000 mLs.");
		public static const FerasBoonWideOpen:PerkType = mk("Fera's Boon - Wide Open", "Fera's Boon - Wide Open",
				"Keeps your pussy permanently gaped and increases pregnancy speed.");
		public static const FireLord:PerkType = mk("Fire Lord", "Fire Lord",
				"Akbal's blessings grant the ability to breathe burning green flames.");
		public static const GargoyleCorrupted:PerkType = mk("Corrupted Gargoyle", "Corrupted Gargoyle",
				"You need constant intakes of sexual fluids to stay alive.");
		public static const GargoylePure:PerkType = mk("Gargoyle", "Gargoyle",
				"Need to gain sustenance from Ki to stay alive.");
		public static const Hellfire:PerkType = mk("Hellfire", "Hellfire",
				"Grants a corrupted fire breath attack, like the hellhounds in the mountains.");
		public static const LuststickAdapted:PerkType = mk("Luststick Adapted", "Luststick Adapted",
				"Grants immunity to the lust-increasing effects of lust-stick and allows its use.");
		public static const MagicalFertility:MagicalFertilityPerk = new MagicalFertilityPerk();
		public static const MagicalVirility:MagicalVirilityPerk = new MagicalVirilityPerk();
		public static const MaraesGiftButtslut:PerkType = mk("Marae's Gift - Buttslut", "Marae's Gift - Buttslut",
				"Makes your anus provide lubrication when aroused.");
		public static const MaraesGiftFertility:PerkType = mk("Marae's Gift - Fertility", "Marae's Gift - Fertility",
				"Greatly increases fertility and halves base pregnancy speed.");
		public static const MaraesGiftProfractory:PerkType = mk("Marae's Gift - Profractory", "Marae's Gift - Profractory",
				"Causes your cum to build up at 3x the normal rate.");
		public static const MaraesGiftStud:PerkType = mk("Marae's Gift - Stud", "Marae's Gift - Stud",
				"Increases your cum production and potency greatly.");
		public static const MarbleResistant:PerkType = mk("Marble Resistant", "Marble Resistant",
				"Provides resistance to the addictive effects of bottled LaBova milk.");
		public static const MarblesMilk:PerkType = mk("Marble's Milk", "Marble's Milk",
				"Requires you to drink LaBova milk frequently or eventually die.  You cannot shake this addiction.");
		public static const MightyFist:PerkType = mk("Mighty Fist", "Mighty Fist",
				"Regular fist attacks now have a chance to cause stun and fist damage is increased by 5 (x NG tier).");
		public static const Misdirection:PerkType = mk("Misdirection", "Misdirection",
				"Grants additional evasion chances while wearing Raphael's red bodysuit.");
		public static const OmnibusGift:PerkType = mk("Omnibus' Gift", "Omnibus' Gift",
				"Increases minimum lust but provides some lust resistance.");
		public static const OneTrackMind:PerkType = mk("One Track Mind", "One Track Mind",
				"Your constant desire for sex causes your sexual organs to be able to take larger insertions and disgorge greater amounts of fluid.");
		public static const PilgrimsBounty:PerkType = mk("Pilgrim's Bounty", "Pilgrim's Bounty",
				"Causes you to always cum as hard as if you had max lust.");
		public static const ProductivityDrugs:PerkType = new ProductivityDrugsPerk();
		public static const PureAndLoving:PerkType = mk("Pure and Loving", "Pure and Loving",
				"Your caring attitude towards love and romance makes you slightly more resistant to lust and corruption.");
		public static const SensualLover:PerkType = mk("Sensual Lover", "Sensual Lover",
				"Your sensual attitude towards love and romance makes your tease ability slightly more effective.");
		public static const TransformationImmunity:PerkType = mk("Transformation immunity", "Transformation immunity",
				"As a magical construct you are immune to all effects that change the body of living beings, including most transformatives on Mareth (work as the regular transformative resistance except it reduce the odds of getting a body part tfed to 0 although score increasers do still works).");
		public static const UnicornBlessing:PerkType = mk("Unicorn Blessing", "Unicorn Blessing",
				"You are blessed with the power of a unicorn and while below 20 corruption all white magic spells are 20% stronger and lust resistance increased by 10%.");
		public static const Whispered:PerkType = mk("Whispered", "Whispered",
				"Akbal's blessings grant limited telepathy that can induce fear.");
				
		public static const ControlledBreath:ControlledBreathPerk = new ControlledBreathPerk();
		public static const CleansingPalm:CleansingPalmPerk = new CleansingPalmPerk();
		public static const Enlightened:EnlightenedPerk = new EnlightenedPerk();
		public static const StarSphereMastery:StarSphereMasteryPerk = new StarSphereMasteryPerk();

		// Monster perks
		public static const Acid:PerkType = mk("Acid", "Acid", "");
		public static const DarknessNature:PerkType = mk("Darkness Nature", "Darkness Nature", "");
		public static const DarknessVulnerability:PerkType = mk("Darkness Vulnerability", "Darkness Vulnerability", "");
		public static const EnemyBeastOrAnimalMorphType:PerkType = mk("Beast or Animal-morph enemy type", "Beast or Animal-morph enemy type", "");
		public static const EnemyBossType:PerkType = mk("Boss-type enemy", "Boss-type enemy", "");
		public static const EnemyConstructType:PerkType = mk("Construct-type enemy", "Construct-type enemy", "");
		public static const EnemyGigantType:PerkType = mk("Gigant-sized type enemy", "Gigant-sized type enemy", "");
		public static const EnemyGodType:PerkType = mk("God-type enemy", "God-type enemy", "");
		public static const EnemyGroupType:PerkType = mk("Group-type enemy", "Group-type enemy", "");
		public static const EnemyPlantType:PerkType = mk("Plant-type enemy", "Plant-type enemy", "");
		public static const EnemyTrueDemon:PerkType = mk("True Demon-type enemy", "True Demon-type enemy", "");
		public static const FireNature:PerkType = mk("Fire Nature", "Fire Nature", "");
		public static const FireVulnerability:PerkType = mk("Fire Vulnerability", "Fire Vulnerability", "");
		public static const IceNature:PerkType = mk("Ice Nature", "Ice Nature", "");
		public static const IceVulnerability:PerkType = mk("Ice Vulnerability", "Ice Vulnerability", "");
		public static const LightningNature:PerkType = mk("Lightning Nature", "Lightning Nature", "");
		public static const LightningVulnerability:PerkType = mk("Lightning Vulnerability", "Lightning Vulnerability", "");
		public static const MonsterRegeneration:PerkType = mk("Monster Regeneration", "Monster Regeneration", "");
		public static const NoGemsLost:PerkType = mk("No Gems Lost", "No Gems Lost", "");
		public static const ShieldWielder:PerkType = mk("Shield wielder", "Shield wielder", "");
		public static const TeaseResistance:PerkType = mk("Tease Resistance", "Tease Resistance", "");

		private static function mk(id:String, name:String, desc:String, longDesc:String = null, keepOnAscension:Boolean = false):PerkType
		{
			return new PerkType(id, name, desc, longDesc, keepOnAscension);
		}

	// Perk requirements
	private static function initDependencies():void {
        try {
			//------------
            // STRENGTH
            //------------
            StrongBack.requireStr(25);
            //Tier 1 Strength Perks
            ThunderousStrikes.requireLevel(6)
                    .requireStr(80)
                    .requirePerk(JobWarrior);
            BrutalBlows.requireLevel(6)
                    .requireStr(75)
                    .requirePerk(JobWarrior);
            IronFists.requireLevel(6)
                    .requireStr(60);
            Parry.requireLevel(6)
                    .requireStr(50)
                    .requireSpe(50);
            ThirstForBlood.requireLevel(6)
                    .requireStr(75)
                    .requirePerk(JobWarrior);
            //Tier 2 Strength Perks
            Berzerker.requireLevel(12)
                    .requireStr(75);
            HoldWithBothHands.requireLevel(12)
                    .requireStr(80)
                    .requirePerk(JobWarrior);
            ShieldSlam.requireLevel(12)
                    .requireStr(80)
                    .requireTou(60);
            WeaponMastery.requireLevel(12)
                    .requireStr(100);
            //Tier 3 Strength Perks
            ColdFury.requireLevel(18)
                    .requirePerk(Berzerker)
                    .requireStr(75);
            TitanGrip.requireLevel(18)
                    .requirePerk(WeaponMastery)
                    .requireStr(100);
            HiddenMomentum.requireLevel(18)
                    .requireStr(75)
                    .requireSpe(50);
            //Tier 4 Strength Perks
            //Tier 5 Strength Perks
            //Tier 6 Strength Perks
            //Tier 7 Strength Perks
            //Tier 8 Strength Perks
            Rage.requirePerk(PrestigeJobBerserker)
                    .requireLevel(48);
            //------------
            // TOUGHNESS
            //------------
            Regeneration.requireTou(50);
            //Tier 1 Toughness Perks
            Tank.requireTou(60)
                    .requireLevel(6);
            ShieldMastery.requirePerk(JobKnight)
                    .requireTou(50)
                    .requireLevel(6);
            //Tier 2 Toughness Perks
            ImmovableObject.requirePerk(JobDefender)
                    .requireTou(75)
                    .requireLevel(12);
            Resolute.requirePerk(JobDefender)
                    .requireTou(75)
                    .requireLevel(12);
            HeavyArmorProficiency.requirePerk(JobKnight)
                    .requireTou(75)
                    .requireLevel(12);
            IronMan.requireTou(60)
                    .requireLevel(12);
            //Tier 3 Toughness Perks
            Juggernaut.requireTou(100)
                    .requirePerk(HeavyArmorProficiency)
                    .requireLevel(18);
            //Tier 4 Toughness Perks
            //Tier 5 Toughness Perks
            //Tier 6 Toughness Perks
            //Tier 7 Toughness Perks
            //Tier 8 Toughness Perks
            SteelImpact.requirePerk(PrestigeJobSentinel)
                    .requireLevel(48);
            //Tier 9 Toughness Perks
            //Tier 10 Toughness Perks
            SecondWind.requireLevel(60);
            //------------
            // SPEED
            //------------
            Runner.requireSpe(25);
            //slot 3 - speed perk
            Evade.requirePerk(JobRanger)
                    .requireSpe(25);
            //Tier 1 Speed Perks
            //Agility - A small portion of your speed is applied to your defense rating when wearing light armors.
            Agility.requireSpe(75)
                    .requirePerk(Runner)
                    .requireLevel(6);
            //slot 3 - Double Attack perk
            Unhindered.requireSpe(75)
                    .requirePerk(Evade)
                    .requirePerk(Agility)
                    .requireLevel(6);
            LightningStrikes.requireSpe(60)
                    .requireLevel(6);
            Naturaljouster.requireSpe(60)
                    .requireLevel(6);
            VitalShot.requireSpe(60)
                    .requirePerk(JobRanger)
                    .requirePerk(Tactician)
                    .requireLevel(6);
            DeadlyAim.requireSpe(60)
                    .requirePerk(JobRanger)
                    .requirePerk(Precision)
                    .requireLevel(6);
            //Tier 2 Speed Perks
            LungingAttacks.requirePerk(JobRanger)
                    .requireSpe(75)
                    .requireLevel(12);
            Blademaster.requirePerk(JobRanger)
                    .requireSpe(80)
                    .requireStr(60)
                    .requireLevel(12);
            SluttySimplicity.requireSpe(80)
                    .requireLib(50)
                    .requirePerk(Unhindered)
                    .requireLevel(12);
            NakedTruth.requireSpe(80)
                    .requireLib(50)
                    .requirePerk(Unhindered)
                    .requirePerk(JobEromancer)
                    .requireLevel(12);
            //Tier 3 Speed Perks
            Manyshot.requirePerk(JobHunter)
                    .requireSpe(100)
                    .requireLevel(18);
            EnvenomedBolt.requireLevel(18)
                    .requirePerk(JobHunter)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.tail.isAny(Tail.BEE_ABDOMEN, Tail.SCORPION, Tail.MANTICORE_PUSSYTAIL)
                                || player.facePart.isAny(Face.SNAKE_FANGS, Face.SPIDER_FANGS);
                    }, "Venom-producing tail, abdomen, or fangs");
            Impale.requirePerk(Naturaljouster)
                    .requireSpe(100)
                    .requireLevel(18);
            //Tier 4 Speed Perks
            //Tier 5 Speed Perks
            //Tier 6 Speed Perks
            NaturaljousterMastergrade.requirePerk(Naturaljouster)
                    .requireSpe(180)
                    .requireLevel(36);
            //Tier 7 Speed Perks
            //Tier 8 Speed Perks
            ElementalArrows.requireLevel(48)
                    .requirePerk(PrestigeJobArcaneArcher)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.hasStatusEffect(StatusEffects.KnowsWhitefire) || player.hasStatusEffect(StatusEffects.KnowsIceSpike);
                    }, "Whitefire or Ice Spike spell");
            //Tier 9 Speed Perks
            Cupid.requireLevel(54)
                    .requirePerk(PrestigeJobArcaneArcher)
                    .requireStatusEffect(StatusEffects.KnowsArouse, "Arouse spell");
            //------------
            // INTELLIGENCE
            //------------
            //Slot 4 - precision - -10 enemy toughness for damage calc
            Precision.requireInt(25);
            //Spellpower - boosts spell power
            Spellpower.requirePerk(JobSorcerer)
                    .requireInt(50);
            //Tier 1 Intelligence Perks
            Tactician.requireInt(50)
                    .requireLevel(6);
            StaffChanneling.requireInt(60)
                    .requireLevel(6);
            //Tier 2 Intelligence perks
            // Spell-boosting perks
            // Battlemage: auto-use Might
            Battlemage.requireLevel(12)
                    .requirePerk(JobEnchanter)
                    .requireInt(80)
                    .requireStatusEffect(StatusEffects.KnowsMight, "Might spell");
            // Spellsword: auto-use Charge Weapon
            Spellsword.requireLevel(12)
                    .requirePerk(JobEnchanter)
                    .requireInt(80)
                    .requireStatusEffect(StatusEffects.KnowsCharge, "Charge spell");
            //Tier 3 Intelligence perks
            // Battleflash: auto-use Blink
            Battleflash.requireLevel(18)
                    .requirePerk(Battlemage)
                    .requireInt(90)
                    .requireStatusEffect(StatusEffects.KnowsBlink, "Blink spell");
            // Spellarmor: auto-use Charge Armor
            Spellarmor.requireLevel(18)
                    .requirePerk(Spellsword)
                    .requireInt(90)
                    .requireStatusEffect(StatusEffects.KnowsChargeA, "Charge Armor spell");
            TraditionalMage.requireLevel(18)
                    .requireInt(80);
            //------------
            // WISDOM
            //------------
            ElementalConjurerResolve.requirePerk(JobElementalConjurer)
                    .requireWis(20);
            ElementalContractRank1.requirePerk(ElementalConjurerResolve)
                    .requireWis(25);
            ElementsOfTheOrtodoxPath.requirePerk(ElementalContractRank1)
                    .requireWis(30);
            ElementsOfMarethBasics.requirePerk(ElementsOfTheOrtodoxPath)
                    .requireWis(35);
            //Tier 1 Wisdom perks
            ElementalContractRank2.requirePerk(ElementalContractRank1)
                    .requireWis(50)
                    .requireLevel(6);
            ElementalBondFlesh.requirePerk(ElementalContractRank1)
                    .requireWis(50)
                    .requireLevel(6);
            //Tier 2 Wisdom perks
            ElementalContractRank3.requirePerk(ElementalContractRank2)
                    .requireWis(75)
                    .requireLevel(12);
            ElementalBondUrges.requirePerk(ElementalContractRank2)
                    .requireWis(75)
                    .requireLevel(12);
            StrongElementalBond.requirePerk(ElementalContractRank3)
                    .requireWis(75)
                    .requireLevel(12);
            //Tier 3 Wisdom perks
            ElementalContractRank4.requirePerk(ElementalContractRank3)
                    .requireWis(100)
                    .requireLevel(18);
            CatchTheBlade.requirePerk(JobMonk)
                    .requireWis(80)
                    .requireSpe(100)
                    .requireLevel(18);

            //Tier 4 Wisdom perks
            ElementalContractRank5.requirePerk(ElementalContractRank4)
                    .requirePerk(ElementalConjurerDedication)
                    .requireWis(125)
                    .requireLevel(24);
            StrongerElementalBond.requirePerk(StrongElementalBond)
                    .requirePerk(ElementalContractRank5)
                    .requireWis(125)
                    .requireLevel(24);
            ElementalConjurerDedication.requirePerk(ElementalConjurerResolve)
                    .requireWis(120)
                    .requireLevel(24);
            FirstAttackElementals.requirePerk(StrongElementalBond)
                    .requirePerk(ElementalContractRank4)
                    .requireLevel(24);
            //Tier 5 Wisdom perks
            ElementalContractRank6.requirePerk(ElementalContractRank5)
                    .requireWis(150)
                    .requireLevel(30);
            //Tier 6 Wisdom perks
            ElementalContractRank7.requirePerk(ElementalContractRank6)
                    .requirePerk(ElementalConjurerSacrifice)
                    .requireWis(175)
                    .requireLevel(36);
            StrongestElementalBond.requirePerk(StrongerElementalBond)
                    .requirePerk(ElementalContractRank7)
                    .requireWis(175)
                    .requireLevel(36);
            //Tier 7 Wisdom perks
            ElementalContractRank8.requirePerk(ElementalContractRank7)
                    .requireWis(200)
                    .requireLevel(42);
            //Tier 8 Wisdom perks
            ElementalContractRank9.requirePerk(ElementalContractRank8)
                    .requirePerk(ElementalConjurerSacrifice)
                    .requireWis(225)
                    .requireLevel(48);
            ElementalConjurerSacrifice.requirePerk(ElementalConjurerDedication)
                    .requireWis(220)
                    .requireLevel(48);
            //Tier 9 Wisdom perks
            ElementalContractRank10.requirePerk(ElementalContractRank9)
                    .requireWis(250)
                    .requireLevel(54);
            //Tier 10 Wisdom perks
            ElementalContractRank11.requirePerk(ElementalContractRank10)
                    .requireWis(275)
                    .requireLevel(60);
            //------------
            // LIBIDO
            //------------
            //slot 5 - libido perks

            //Slot 5 - Fertile+ increases cum production and fertility (+15%)
            FertilityPlus.requireLib(25);
            FertilityPlus.defaultValue1 = 15;
            FertilityPlus.defaultValue2 = 1.75;

            //Slot 5 - minimum libido
            ColdBlooded.requireMinLust(20);
            ColdBlooded.defaultValue1 = 20;
            HotBlooded.requireLib(50);
            HotBlooded.defaultValue1 = 20;
            //Tier 1 Libido Perks
            //Slot 5 - minimum libido
            //Slot 5 - Fertility- decreases cum production and fertility.
            FertilityMinus.requireLibLessThan(25)
                    .requireLevel(6);
            FertilityMinus.defaultValue1 = 15;
            FertilityMinus.defaultValue2 = 0.7;
            WellAdjusted.requireLib(60)
                    .requireLevel(6);
            //Slot 5 - minimum libido
            Masochist.requireLib(60)
                    .requireCor(50)
                    .requireLevel(6);
            ArcaneLash.requirePerk(JobEromancer).requireLevel(6);

            //Tier 2 Libido Perks
            Transference.requirePerk(JobEromancer)
                    .requireLevel(12)
                    .requireLib(50)
                    .requireStatusEffect(StatusEffects.KnowsArouse, "Arouse spell");
            DazzlingDisplay.requirePerk(JobCourtesan)
                    .requireLib(50)
                    .requireLevel(12);
            //Tier 3 Libido Perks
            ColdLust.requirePerk(Lustzerker)
                    .requireLib(75)
                    .requireLevel(18);
            ArouseTheAudience.requirePerk(JobCourtesan)
                    .requireLib(75)
                    .requireLevel(18);
            //Tier 4 Libido Perks
            CriticalPerformance.requirePerk(JobCourtesan)
                    .requireLib(100)
                    .requireLevel(24);
            //------------
            // SENSITIVITY
            //------------
            //Tier 3
            //------------
            // CORRUPTION
            //------------
            //Slot 7 - Corrupted Libido - lust raises 10% slower.
            CorruptedLibido.requireCor(10);
            CorruptedLibido.defaultValue1 = 20;
            //Slot 7 - Seduction (Must have seduced Jojo)
            Seduction.requireCor(15);
            //Slot 7 - Nymphomania
            Nymphomania.requireCor(15)
                    .requirePerk(CorruptedLibido);
            //Slot 7 - UNFINISHED :3
            Acclimation.requireCor(15)
                    .requirePerk(CorruptedLibido)
                    .requireMinLust(20);
            //Tier 1 Corruption Perks - acclimation over-rides
            Sadist.requireCor(20)
                    .requirePerk(CorruptedLibido)
                    .requireLevel(6);
            ArousingAura.requireCor(25)
                    .requirePerk(CorruptedLibido)
                    .requireLevel(6);

	        // ------------
            // MISCELLANEOUS
            //------------
            //Tier 0
            BlackHeart.requirePerk(DarkCharm).requireCor(90).requireCustomFunction(function (player:Player):Boolean {
                return player.demonScore() >= 6;
            }, "Demon race");
            CatlikeNimbleness.requirePerk(Flexibility).requireCustomFunction(function (player:Player):Boolean {
                return player.catScore() >= 4 || player.nekomataScore() >= 4 || player.cheshireScore() >= 4;
            }, "Any cat race");
            DraconicLungs.requirePerk(DragonFireBreath)
                    .requirePerk(DragonIceBreath)
                    .requirePerk(DragonLightningBreath)
                    .requirePerk(DragonDarknessBreath).requireCustomFunction(function (player:Player):Boolean {
                return player.dragonScore() >= 4;
            }, "Dragon race");
            GorgonsEyes.requireCustomFunction(function (player:Player):Boolean {
                return player.gorgonScore() >= 5 && player.eyes.type == 4;
            }, "Gorgon race and eyes");
            KitsuneThyroidGland.requireAnyPerk(EnlightenedKitsune, CorruptedKitsune).requireCustomFunction(function (player:Player):Boolean {
                return player.kitsuneScore() >= 5;
            }, "Kitsune race");
            LizanMarrow.requirePerk(LizanRegeneration).requireCustomFunction(function (player:Player):Boolean {
                return player.lizardScore() >= 4;
            }, "Lizan race");
            ManticoreMetabolism.requireCustomFunction(function (player:Player):Boolean {
                return player.manticoreScore() >= 6 && player.tailType == Tail.MANTICORE_PUSSYTAIL;
            }, "Manticore race and tail");
            MantislikeAgility.requirePerk(TrachealSystem).requireCustomFunction(function (player:Player):Boolean {
                return player.mantisScore() >= 6;
            }, "Mantis race");
            SalamanderAdrenalGlands.requirePerk(Lustzerker).requireCustomFunction(function (player:Player):Boolean {
                return player.salamanderScore() >= 4;
            }, "Salamander race");
            ScyllaInkGlands.requirePerk(InkSpray).requireCustomFunction(function (player:Player):Boolean {
                return player.scyllaScore() >= 5;
            }, "Scylla race");
            TrachealSystem.requireCustomFunction(function (player:Player):Boolean {
                return player.beeScore() >= 4 || player.mantisScore() >= 4 || player.scorpionScore() >= 4 || player.spiderScore() >= 4;
            }, "Any insect race");

	        PrimalFury.requireStr(20)
					.requireTou(20)
					.requireSpe(20);
			ToughHide.requireTou(30);
            //Tier 1
            //Speedy Recovery - Regain Fatigue 50% faster.
            SpeedyRecovery.requireLevel(6);
            Resistance.requireLevel(6);
            Heroism.requireLevel(6);
            ChimericalBodyInitialStage.requireLevel(6)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.internalChimeraScore() >= 1;
                    }, "Any racial perk");
            TrachealSystemEvolved.requireLevel(6).requirePerk(TrachealSystem).requireCustomFunction(function (player:Player):Boolean {
                return player.beeScore() >= 8 || player.mantisScore() >= 8 || player.scorpionScore() >= 8 || player.spiderScore() >= 8;
            }, "Any insect race");
            FeralArmor.requirePerk(ToughHide)
					.requireLevel(6)
					.requireTou(60);
            //Tier 2
            ChimericalBodyBasicStage.requirePerk(ChimericalBodyInitialStage)
                    .requireLevel(12)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.internalChimeraScore() >= 3;
                    }, "Three racial perks");
            CatlikeNimblenessEvolved.requireLevel(12)
					.requirePerk(CatlikeNimbleness)
					.requireCustomFunction(function (player:Player):Boolean {
						return player.catScore() >= 8 || player.nekomataScore() >= 8 || player.cheshireScore() >= 8;
					}, "Any cat race");
            DraconicLungsEvolved.requireLevel(12)
                    .requirePerk(DraconicLungs)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.dragonScore() >= 10;
                    }, "Dragon race");
            KitsuneThyroidGlandEvolved.requireLevel(12)
                    .requirePerk(KitsuneThyroidGland)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.kitsuneScore() >= 6;
                    }, "Kitsune race");
            LizanMarrowEvolved.requirePerk(LizanMarrow).requireCustomFunction(function (player:Player):Boolean {
                return player.lizardScore() >= 8
            }, "Lizan race");
            MantislikeAgilityEvolved.requirePerk(MantislikeAgility).requireCustomFunction(function (player:Player):Boolean {
                return player.mantisScore() >= 12
            }, "Mantis race");
            SalamanderAdrenalGlandsEvolved.requirePerk(SalamanderAdrenalGlands).requireCustomFunction(function (player:Player):Boolean {
                return player.salamanderScore() >= 7
            }, "Salamander race");
            //Tier 3
            ChimericalBodyAdvancedStage.requirePerk(ChimericalBodyBasicStage)
                    .requireLevel(18)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.internalChimeraScore() >= 6;
                    }, "Six racial perks");
            //Tier 4
            //Tier 5
            //Tier 6
            //Tier 7
        } catch (e:Error) {
            trace(e.getStackTrace());
        }
	}
	initDependencies();
}
}
