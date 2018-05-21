package classes
{

	import classes.Scenes.Combat.Combat;
	import classes.Scenes.Combat.CombatAction;
	import classes.Scenes.Combat.CombatKiPowers;
	import classes.StatusEffects.Combat.*;
	import classes.StatusEffects.CombatStatusEffect;
	import classes.StatusEffects.KnowledgeStatusEffect;
	import classes.StatusEffects.VampireThirstEffect;
	import classes.internals.Utils;

	/**
	 * IMPORTANT NOTE:
	 * You can rename the constants BUT NOT the string ids (they are stored in saves).
	 */
	public class StatusEffects
	{
		// Non-combat player perks
		public static const AllNaturalOnaholeUsed:StatusEffectType          = mk("all-natural onahole used");
		public static const AlrauneFlower:StatusEffectType                  = mk("Alraune Flower");
		public static const AndysSmoke:StatusEffectType                     = mk("Andy's Smoke"); //v1: Hours; v2: Speed; v3: Intelligence
		public static const AteEgg:StatusEffectType                         = mk("ateEgg");
		public static const AnemoneArousal:StatusEffectType                 = mk("Anemone Arousal");
		public static const BimboChampagne:StatusEffectType                 = mk("Bimbo Champagne");
		public static const Birthed:StatusEffectType                        = mk("Birthed");
		public static const BirthedImps:StatusEffectType                    = mk("Birthed Imps");
		public static const BlackCatBeer:StatusEffectType                   = mk("Black Cat Beer");
		public static const BlackNipples:StatusEffectType                   = mk("Black Nipples");
		public static const BlessingOfDivineFenrir:StatusEffectType			= mk("Blessing of Divine Agency - Fenrir");
		public static const BlessingOfDivineFera:StatusEffectType			= mk("Blessing of Divine Agency - Fera");
		public static const BlessingOfDivineMarae:StatusEffectType			= mk("Blessing of Divine Agency - Marae");
		public static const BlessingOfDivineTaoth:StatusEffectType			= mk("Blessing of Divine Agency - Taoth");
		public static const BlowjobOn:StatusEffectType                      = mk("BlowjobOn");
		public static const BoatDiscovery:StatusEffectType                  = mk("Boat Discovery");
		public static const BonusACapacity:StatusEffectType                 = mk("Bonus aCapacity");
		public static const BonusVCapacity:StatusEffectType                 = mk("Bonus vCapacity");
		public static const BottledMilk:StatusEffectType                    = mk("Bottled Milk");
		public static const BreastsMilked:StatusEffectType                  = mk("Breasts Milked");
		public static const BSwordBroken:StatusEffectType                   = mk("BSwordBroken");
		public static const BuiltMilker:StatusEffectType                    = mk("BUILT: Milker");
		public static const BurpChanged:StatusEffectType                    = mk("Burp Changed");
		public static const ButtStretched:StatusEffectType                  = mk("ButtStretched");
		public static const CampAnemoneTrigger:StatusEffectType             = mk("Camp Anemone Trigger");
		public static const CampMarble:StatusEffectType                     = mk("Camp Marble");
		public static const CampRathazul:StatusEffectType                   = mk("Camp Rathazul");
		public static const CampLunaMishaps1:StatusEffectType				= mk("Camp Luna Mishaps 1");
		public static const CampLunaMishaps2:StatusEffectType				= mk("Camp Luna Mishaps 2");
		public static const CampLunaMishaps3:StatusEffectType				= mk("Camp Luna Mishaps 3");
		public static const CampSparingNpcsTimers1:StatusEffectType			= mk("Camp Sparing Npc's Timers 1");
		public static const CampSparingNpcsTimers2:StatusEffectType			= mk("Camp Sparing Npc's Timers 2");
		public static const CampSparingNpcsTimers3:StatusEffectType			= mk("Camp Sparing Npc's Timers 3");
		public static const ClaraCombatRounds:StatusEffectType              = mk("Clara Combat Rounds");
		public static const ClaraFoughtInCamp:StatusEffectType              = mk("Clara Fought In Camp");
		public static const CockPumped:StatusEffectType                     = mk("Cock Pumped");
		public static const Contraceptives:StatusEffectType                 = mk("Contraceptives");
		public static const CuntStretched:StatusEffectType                  = mk("CuntStretched");
		public static const DefenseCanopy:StatusEffectType                  = mk("Defense: Canopy");
		public static const DeluxeOnaholeUsed:StatusEffectType              = mk("deluxe onahole used");
		public static const DogWarning:StatusEffectType                     = mk("dog warning");
		public static const DragonBreathBoost:StatusEffectType              = mk("Dragon Breath Boost");
		public static const DragonBreathCooldown:StatusEffectType           = mk("Dragon Breath Cooldown");
		public static const DragonDarknessBreathCooldown:StatusEffectType   = mk("Dragon Darkness Breath Cooldown");
		public static const DragonFireBreathCooldown:StatusEffectType       = mk("Dragon Fire Breath Cooldown");
		public static const DragonIceBreathCooldown:StatusEffectType        = mk("Dragon Ice Breath Cooldown");
		public static const DragonLightningBreathCooldown:StatusEffectType  = mk("Dragon Lightning Breath Cooldown");
		public static const Dysfunction:StatusEffectType                    = mk("dysfunction");
		public static const Edryn:StatusEffectType                          = mk("Edryn");
		public static const Eggchest:StatusEffectType                       = mk("eggchest");
		public static const Eggs:StatusEffectType                           = mk("eggs");
		public static const EmberFuckCooldown:StatusEffectType              = mk("ember fuck cooldown");
		public static const EmberMilk:StatusEffectType                      = mk("Ember's Milk");
		public static const EmberNapping:StatusEffectType                   = mk("Ember Napping");
		public static const EverRapedJojo:StatusEffectType                  = mk("Ever Raped Jojo");
		public static const Exgartuan:StatusEffectType                      = mk("Exgartuan");
		public static const ExploredDeepwoods:StatusEffectType              = mk("exploredDeepwoods");
		public static const FaerieFemFuck:StatusEffectType                  = mk("Faerie Fem Fuck");
		public static const FaerieFucked:StatusEffectType                   = mk("Faerie Fucked");
		public static const FappedGenderless:StatusEffectType               = mk("fapped genderless");
		public static const Feeder:StatusEffectType                         = mk("Feeder");
		public static const FeedingEuphoria:StatusEffectType                = mk("Manticore's Metabolism"); //v1: Hours; v2: Speed
		public static const Fertilized:StatusEffectType                     = mk("Fertilized");
		public static const FetishOn:StatusEffectType                       = mk("fetishON");
		public static const FortressOfIntellect:StatusEffectType            = mk("Fortress of Intellect");
		public static const FoundFactory:StatusEffectType                   = mk("Found Factory");
		public static const FuckedMarble:StatusEffectType                   = mk("FuckedMarble");
		public static const Fullness:StatusEffectType                       = mk("Fullness"); //Alternative to hunger
		public static const GargoyleTFSettingTracker1:StatusEffectType      = mk("Gargoyle TF Setting Tracker 1");
		public static const GargoyleTFSettingTracker2:StatusEffectType      = mk("Gargoyle TF Setting Tracker 2");
		public static const GargoyleTFSettingTracker3:StatusEffectType      = mk("Gargoyle TF Setting Tracker 3");
		public static const Goojob:StatusEffectType                         = mk("GOOJOB");
		public static const GooStuffed:StatusEffectType                     = mk("gooStuffed");
		public static const Groundpound:StatusEffectType                    = mk("Groundpound");
		public static const HairdresserMeeting:StatusEffectType             = mk("hairdresser meeting");
		public static const Hangover:StatusEffectType                       = mk("Hangover");
		public static const Heat:StatusEffectType                           = mk("heat");
		public static const HorseWarning:StatusEffectType                   = mk("horse warning");
		public static const IcePrisonSpell:StatusEffectType                 = mk("Ice Prison Spell");
		public static const ImmolationSpell:StatusEffectType                = mk("Immolation Spell");
		public static const ImpGangBang:StatusEffectType                    = mk("Imp GangBang");
		public static const Infested:StatusEffectType                       = mk("infested");
		public static const IzmaBlowing:StatusEffectType                    = mk("IzmaBlowing");
		public static const IzumisPipeSmoke:StatusEffectType                = mk("Izumis Pipe Smoke");
		public static const JerkingIzma:StatusEffectType                    = mk("JerkingIzma");
		public static const Jizzpants:StatusEffectType                      = mk("Jizzpants");
		public static const JojoMeditationCount:StatusEffectType            = mk("Jojo Meditation Count");
		public static const JojoNightWatch:StatusEffectType                 = mk("JojoNightWatch");
		public static const JojoTFOffer:StatusEffectType                    = mk("JojoTFOffer");
		public static const Kelt:StatusEffectType                           = mk("Kelt");
		public static const KeltBJ:StatusEffectType                         = mk("KeltBJ");
		public static const KeltBadEndWarning:StatusEffectType              = mk("Kelt Bad End Warning");
		public static const KeltOff:StatusEffectType                        = mk("KeltOff");
		public static const Kindra:StatusEffectType                         = mk("Kindra");
		public static const KnowsArouse:StatusEffectType                    = mk("Knows Arouse");
		public static const KnowsBarrage:StatusEffectType                   = mk("Knows Barrage");
		public static const KnowsBlind:StatusEffectType                     = mk("Knows Blind");
		public static const KnowsBlink:StatusEffectType                     = mk("Knows Blink");
		public static const KnowsBlizzard:StatusEffectType                  = mk("Knows Blizzard");
		public static const KnowsCharge:StatusEffectType                    = mk("Knows Charge");//Charge Weapon
		public static const KnowsChargeA:StatusEffectType                   = mk("Knows Charge Armor");
		public static const KnowsComet:StatusEffectType                     = mkKnowledge("Knows Comet",
			new CombatAction("Comet", 60, CombatAction.KiAction, Combat.HPSPELL, "Project a shard of ki, which will come crashing down upon your opponent as a crystalline comet.")
					.customDamage(Utils.curry(CombatKiPowers.kiDamage,CombatKiPowers.MAGICAL))
					.disablingStatus(OniRampage, "You are too angry to think straight. Smash your puny opponents first and think later.")
					.startText("You focus for a moment, projecting a fragment of your ki above you.  A moment later, a prismatic comet crashes down on your opponents [monster a][monster name], shattering into thousands of fragments that shower anything and everything around you.")
					.enableDodge("the comet fragments")
					.hitText("The comet fragments hit [monster a][monster name]!")
					.addCustomAction(function(host:Creature, target:Creature, damage:Number, crit:Boolean):Number{
						if((target as Monster).plural){damage *= 5;}
						return damage;
					})
		);
		public static const KnowsDarknessShard:StatusEffectType             = mk("Knows Darkness Shard");
		public static const KnowsDracoSweep:StatusEffectType                = mkKnowledge("Knows Draco Sweep",
			new CombatAction("Draco Sweep", 50, CombatAction.KiAction, Combat.PHYSICAL, "Use a little bit of ki to infuse your weapon and then sweep ahead hitting as many enemies as possible.")
					.customDamage(Utils.curry(CombatKiPowers.kiDamage,CombatKiPowers.PHYSICAL))
					.startText("You ready your [weapon] and prepare to sweep it towards [monster a][monster name].")
					.enableDodge("your attack")
					.rageEnabled()
					.hitText("Your [weapon] sweeps against [monster a][monster name]!")
					.addCustomAction(function(host:Creature, target:Creature, damage:Number, crit:Boolean):Number{
						if((target as Monster).plural){damage *= 5;}
						return damage;
					})
		);
		public static const KnowsEarthStance:StatusEffectType               = mkKnowledge("Knows Earth Stance",
			new CombatAction("Earth Stance", 30, CombatAction.KiAction, 0, "Take on the stability and strength of the earth gaining 30% damage reduction for the next 3 rounds.")
					.addStatus(EarthStance, 3, true)
					.startText("Your body suddenly hardens like rock. You will be way harder to damage for a while.")
					.setCooldown(10)
		);
		public static const KnowsFirePunch:StatusEffectType                 = mkKnowledge("Knows Fire Punch",
			new CombatAction("Fire Punch", 30, CombatAction.KiAction,  Combat.HPSPELL, "Ignite your opponents dealing fire damage and setting them ablaze.")
					.customDamage(Utils.curry(CombatKiPowers.kiDamage,CombatKiPowers.UNARMED))
					.addStatus(FirePunchBurnDoT, 16)
					.hitText("Setting your fist ablaze, you rush at [monster a] [monster name] and scorch [monster him] with your searing flames.")
					.disableWhen(function(host:Creature):Boolean{return !host.isFistOrFistWeapon()}, "<b>Your current used weapon not allow to use this technique.</b>")
					.disablingPerk(PerkLib.ColdAffinity, "Try as you want, you can’t call on the power of this technique due to your close affinity to cold.")
		);
		public static const KnowsFireStorm:StatusEffectType                 = mk("Knows Fire Storm");
		public static const KnowsHeal:StatusEffectType                      = mk("Knows Heal");
		public static const KnowsHurricaneDance:StatusEffectType            = mkKnowledge("Knows Hurricane Dance",
			new CombatAction("Hurricane Dance", 30, CombatAction.KiAction, 0, "Take on the aspect of the wind dodging attacks with aerial graces for a time.")
					.startText("Your movement becomes more fluid and precise, increasing your speed and evasion.")
					.addStatus(HurricaneDance, 5, true)
					.setCooldown(10)
		);
		public static const KnowsIceFist:StatusEffectType                   = mkKnowledge("Knows Ice Fist",
			new CombatAction("Ice Fist", 30, CombatAction.KiAction, Combat.HPSPELL, "A chilling strike that can freeze an opponent solid, leaving it vulnerable to shattering soul art and hindering its movement.")
					.disablingPerk(PerkLib.FireAffinity,"Try as you want, you can’t call on the power of this technique due to your close affinity to fire.")
					.customDamage(Utils.curry(CombatKiPowers.kiDamage,CombatKiPowers.UNARMED))
					.hitText("Air seems to lose all temperature around your fist as you dash at [monster a][monster name] and shove your palm on [monster him], [monster his] body suddenly is frozen solid, encased in a thick block of ice!")
					.addCustomAction(function(host:Creature, target:Creature, damage:Number, crit:Boolean):Number{
						target.createOrFindStatusEffect(StatusEffects.Frozen);
						var spdmod:int = Utils.boundInt(0, target.spe, 20);
						target.addStatusValue(StatusEffects.Frozen, 1, spdmod);
						target.spe -= spdmod;
						return damage;
					})
					.stunAttempt(2)
		);
		public static const KnowsIceRain:StatusEffectType                   = mk("Knows Ice Rain");
		public static const KnowsIceSpike:StatusEffectType                  = mk("Knows Ice Spike");
		public static const KnowsLightningBolt:StatusEffectType             = mk("Knows Lightning Bolt");
		public static const KnowsManyBirds:StatusEffectType                 = mkKnowledge("Knows Many Birds",
			new CombatAction("Many Birds", 10, CombatAction.KiAction, Combat.HPSPELL, "Project a figment of your ki as a crystal traveling at extreme speeds.")
					.customDamage(Utils.curry(CombatKiPowers.kiDamage,CombatKiPowers.MAGICAL))
					.disablingStatus(OniRampage, "You are too angry to think straight. Smash your puny opponents first and think later.")
					.startText("[if(silly) You focus your ki, projecting it as an aura around you.  As you concentrate, dozens, hundreds, thousands of tiny, ethereal birds shimmer into existence.  As you raise your hand up, more and more appear, until the area around you and [monster a][monster name] is drowned in spectral flappy shapes." +
							"| You thrust your hand outwards with deadly intent, and in the blink of an eye a crystal shoots towards [monster a][monster name].]")
					.enableDodge("[if(silly) the birds|the crystal")
					.hitText("[if(silly) You snap your fingers, and at once every bird lends their high pitched voice to a unified, glass shattering cry:\n\n\"<i>AAAAAAAAAAAAAAAAAAAAAAAAAAAAA</i>\"" +
							"|Crystal hits [monster a][monster name]!]")

		);
		public static const KnowsManaShield:StatusEffectType                = mk("Knows Mana Shield");
		public static const KnowsMight:StatusEffectType                     = mk("Knows Might");
		public static const KnowsNosferatu:StatusEffectType                 = mk("Knows Nosferatu");
		public static const KnowsOverlimit:StatusEffectType                 = mk("Knows Overlimit");
		public static const KnowsPunishingKick:StatusEffectType	            = mkKnowledge("Knows Punishing Kick",
			new CombatAction("Punishing Kick", 30, CombatAction.KiAction, Combat.PHYSICAL, "A vicious kick that can daze an opponent, reducing its damage for a while.")
					.customDamage(Utils.curry(CombatKiPowers.kiDamage,CombatKiPowers.UNARMED))
					.disableWhen(function(host:Creature):Boolean{return !host.isBiped() || !host.isTaur()}, "<b>Your legs are not suited for this technique.</b>")
					.setCooldown(10)
					.hitText("You lash out with a devastating kick, knocking your opponent back and disorienting it. [monster a][monster name] will have a hard time recovering its balance for a while.")
					.addStatus(PunishingKick, 5)
		);
		public static const KnowsRegenerate:StatusEffectType                = mk("Knows Regenerate");
		public static const KnowsSidewinder:StatusEffectType                = mk("Knows Sidewinder");
		public static const KnowsSoulBlast:StatusEffectType                 = mkKnowledge("Knows Soul Blast",
			new CombatAction("Soul Blast", 100, CombatAction.KiAction, Combat.HPSPELL, "Take in your reserve of soul force to unleash a torrent of devastating energy and obliterate your opponent.")
					.customDamage(CombatKiPowers.SoulBlast)
					.setCooldown(15)
					.hitText("You wave the sign of the gate, tiger and serpent as you unlock all of your ki for an attack. [monster A][monster name] can’t figure out what you are doing until a small sphere of energy explodes at the end of your fist in a massive beam of condensed ki.")
					.stunAttempt(3)
		);
		public static const KnowsTripleThrust:StatusEffectType              = mkKnowledge("Knows Triple Thrust",
			new CombatAction("Triple Thrust", 30, CombatAction.KiAction, Combat.PHYSICAL, "Use a little bit of ki to infuse your weapon and thrust three times toward your enemy.")
					.customDamage(Utils.curry(CombatKiPowers.kiDamage,CombatKiPowers.PHYSICAL))
					.startText("You ready your [weapon] and prepare to thrust it towards [monster a][monster name].")
					.enableDodge("your attack")
					.rageEnabled()
					.addCustomAction(function(host:Creature, target:Creature, damage:Number, crit:Boolean):Number{
						if (target.hasStatusEffect(Frozen)) {
							damage *= 2;
							target.spe += target.statusEffectv1(Frozen);
							target.removeStatusEffect(Frozen);
							EngineCore.outputText("Your [weapon] hits the ice in three specific points, making it explode along with your frozen adversary!");
						} else {
							EngineCore.outputText("Your [weapon] hits thrice against [monster a][monster name]!");
						}
						damage *= 3;
						return damage;
					})
		);
		public static const KnowsVioletPupilTransformation:StatusEffectType = mk("Knows Violet Pupil Transformation");
		public static const KnowsWereBeast:StatusEffectType                 = mk("Knows Were-Beast");
		public static const KnowsWhitefire:StatusEffectType                 = mk("Knows Whitefire");
		public static const KonstantinArmorPolishing:StatusEffectType       = mk("Konstantin Armor Polishing");
		public static const KonstantinWeaponSharpening:StatusEffectType     = mk("Konstantin Weapon Sharpening");
		public static const LactationEndurance:StatusEffectType             = mk("Lactation Endurance");
		public static const LactationReduction:StatusEffectType             = mk("Lactation Reduction");
		public static const LactationReduc0:StatusEffectType                = mk("Lactation Reduc0");
		public static const LactationReduc1:StatusEffectType                = mk("Lactation Reduc1");
		public static const LactationReduc2:StatusEffectType                = mk("Lactation Reduc2");
		public static const LactationReduc3:StatusEffectType                = mk("Lactation Reduc3");
		public static const LootEgg:StatusEffectType                        = mk("lootEgg");
		public static const LostVillagerSpecial:StatusEffectType            = mk("lostVillagerSpecial");
		public static const Luststick:StatusEffectType                      = mk("Luststick");
		public static const LustStickApplied:StatusEffectType               = mk("Lust Stick Applied");
		public static const LustyTongue:StatusEffectType                    = mk("LustyTongue");
		public static const MalonVisitedPostAddiction:StatusEffectType      = mk("Malon Visited Post Addiction");
		public static const Marble:StatusEffectType                         = mk("Marble");
		public static const MarbleHasItem:StatusEffectType                  = mk("MarbleHasItem");
		public static const MarbleItemCooldown:StatusEffectType             = mk("MarbleItemCooldown");
		public static const MarbleRapeAttempted:StatusEffectType            = mk("Marble Rape Attempted");
		public static const MarblesMilk:StatusEffectType                    = mk("Marbles Milk");
		public static const MarbleSpecials:StatusEffectType                 = mk("MarbleSpecials");
		public static const MarbleWithdrawl:StatusEffectType                = mk("MarbleWithdrawl");
		public static const Meditated:StatusEffectType                      = mk("Meditated"); // DEPRECATED
		public static const MeanToNaga:StatusEffectType                     = mk("MeanToNaga");
		public static const MeetWanderer:StatusEffectType                   = mk("meet wanderer");
		public static const MetRathazul:StatusEffectType                    = mk("metRathazul");
		public static const MetWorms:StatusEffectType                       = mk("metWorms");
		public static const MetWhitney:StatusEffectType                     = mk("Met Whitney");
		public static const Milked:StatusEffectType                         = mk("Milked");
		public static const MinoPlusCowgirl:StatusEffectType                = mk("Mino + Cowgirl");
		public static const Naga:StatusEffectType                           = mk("Naga");
		public static const NakedOn:StatusEffectType                        = mk("NakedOn");
		public static const NoJojo:StatusEffectType                         = mk("noJojo");
		public static const NoMoreMarble:StatusEffectType                   = mk("No More Marble");
		public static const Oswald:StatusEffectType                         = mk("Oswald");
		public static const PlainOnaholeUsed:StatusEffectType               = mk("plain onahole used");
		public static const PhoukaWhiskeyAffect:StatusEffectType            = mk("PhoukaWhiskeyAffect");
		public static const PostAkbalSubmission:StatusEffectType            = mk("Post Akbal Submission");
		public static const PostAnemoneBeatdown:StatusEffectType            = mk("Post Anemone Beatdown");
		public static const PureCampJojo:StatusEffectType                   = mk("PureCampJojo");
		public static const RaijuLightningStatus:StatusEffectType           = mk("Raiju lightning status");
		public static const RathazulArmor:StatusEffectType                  = mk("RathazulArmor");
		public static const RepeatSuccubi:StatusEffectType                  = mk("repeatSuccubi");
		public static const Rut:StatusEffectType                            = mk("rut");
		public static const SharkGirl:StatusEffectType                      = mk("Shark-Girl");
		public static const ShieldingSpell:StatusEffectType                 = mk("Shielding Spell");
		public static const ShiraOfTheEastFoodBuff1:StatusEffectType        = mk("Shira of the east food buff part 1");
		public static const ShiraOfTheEastFoodBuff2:StatusEffectType        = mk("Shira of the east food buff part 2");
		public static const SlimeCraving:StatusEffectType                   = mk("Slime Craving");
		public static const SlimeCravingFeed:StatusEffectType               = mk("Slime Craving Feed");
		public static const SlimeCravingOutput:StatusEffectType             = mk("Slime Craving Output");
		public static const SoulGemCrafting:StatusEffectType                = mk("SoulGemCrafting");
		public static const SuccubiFirst:StatusEffectType                   = mk("SuccubiFirst");
		public static const SuccubiNight:StatusEffectType                   = mk("succubiNight");
		public static const SummonedElementals:StatusEffectType             = mk("Summoned Elementals");
		public static const SummonedElementalsAir:StatusEffectType          = mk("Summoned Elementals Air");
		public static const SummonedElementalsEarth:StatusEffectType        = mk("Summoned Elementals Earth");
		public static const SummonedElementalsFire:StatusEffectType         = mk("Summoned Elementals Fire");
		public static const SummonedElementalsWater:StatusEffectType        = mk("Summoned Elementals Water");
		public static const SummonedElementalsIce:StatusEffectType        	= mk("Summoned Elementals Ice");
		public static const SummonedElementalsLightning:StatusEffectType    = mk("Summoned Elementals Lightning");
		public static const SummonedElementalsDarkness:StatusEffectType     = mk("Summoned Elementals Darkness");
		public static const SummonedElementalsWood:StatusEffectType		    = mk("Summoned Elementals Wood");
		public static const SummonedElementalsMetal:StatusEffectType	    = mk("Summoned Elementals Metal");
		public static const SummonedElementalsEther:StatusEffectType       	= mk("Summoned Elementals Ether");
		public static const TakenGroPlus:StatusEffectType                   = mk("TakenGro+");
		public static const TakenLactaid:StatusEffectType                   = mk("TakenLactaid");
		public static const Tamani:StatusEffectType                         = mk("Tamani");//Used only for compatibility with old save files, otherwise no longer in use
		public static const TamaniFemaleEncounter:StatusEffectType          = mk("Tamani Female Encounter");//Used only for compatibility with old save files, otherwise no longer in use
		public static const TelAdre:StatusEffectType                        = mk("Tel'Adre");
		public static const TempleOfTheDivineTracker:StatusEffectType       = mk("Temple of the Divine Tracker");
		public static const TentacleBadEndCounter:StatusEffectType          = mk("TentacleBadEndCounter");
		public static const TentacleJojo:StatusEffectType                   = mk("Tentacle Jojo");
		public static const TensionReleased:StatusEffectType                = mk("TensionReleased");
		public static const TribulationCountdown:StatusEffectType           = mk("TribulationCountdown");
		public static const TF2:StatusEffectType                            = mk("TF2");
		public static const TookBlessedSword:StatusEffectType               = mk("Took Blessed Sword");
		public static const VampireThirst:StatusEffectType                  = VampireThirstEffect.TYPE;
		
		//Old status plots. DEPRECATED, DO NOT USE. Currently cannot be removed without breaking existing saves.
		public static const DungeonShutDown:StatusEffectType         = mk("DungeonShutDown");
		public static const FactoryOmnibusDefeated:StatusEffectType  = mk("FactoryOmnibusDefeated");
		public static const FactoryOverload:StatusEffectType         = mk("FactoryOverload");
		public static const FactoryIncubusDefeated:StatusEffectType  = mk("FactoryIncubusDefeated");
		public static const IncubusBribed:StatusEffectType           = mk("IncubusBribed");
		public static const FactorySuccubusDefeated:StatusEffectType = mk("FactorySuccubusDefeated");
		public static const MaraeComplete:StatusEffectType           = mk("Marae Complete");
		public static const MaraesLethicite:StatusEffectType         = mk("Marae's Lethicite");
		public static const MaraesQuestStart:StatusEffectType        = mk("Marae's Quest Start");
		public static const MetCorruptMarae:StatusEffectType         = mk("Met Corrupt Marae");
		public static const MetMarae:StatusEffectType                = mk("Met Marae");
		
		//Prisoner status effects.
		public static const PrisonCaptorEllyStatus:StatusEffectType  = mk("prisonCaptorEllyStatus");
		public static const PrisonCaptorEllyQuest:StatusEffectType   = mk("prisonCaptorEllyQuest");
		public static const PrisonCaptorEllyPet:StatusEffectType     = mk("prisonCaptorEllyPet");
		public static const PrisonCaptorEllyBillie:StatusEffectType  = mk("prisonCaptorEllyBillie");
		public static const PrisonCaptorEllyScruffy:StatusEffectType = mk("prisonCaptorEllyScruffy");
		public static const PrisonRestraints:StatusEffectType        = mk("prisonRestraint");
		public static const PrisonCaptorEllyScratch:StatusEffectType = mk("prisonCaptorEllyScatch");
		
		
		public static const UmasMassage:StatusEffectType         = mk("Uma's Massage"); //v1 = bonus index; v2 = bonus value; v3 = remaining time
		public static const Uniball:StatusEffectType             = mk("Uniball");
		public static const UsedNaturalSelfStim:StatusEffectType = mk("used natural self-stim");
		public static const used_self_dash_stim:StatusEffectType = mk("used self-stim");
		public static const Victoria:StatusEffectType            = mk("Victoria");
		public static const VoluntaryDemonpack:StatusEffectType  = mk("Voluntary Demonpack");
		public static const WormOffer:StatusEffectType           = mk("WormOffer");
		public static const WormPlugged:StatusEffectType         = mk("worm plugged");
		public static const WormsHalf:StatusEffectType           = mk("wormsHalf");
		public static const WormsOff:StatusEffectType            = mk("wormsOff");
		public static const WormsOn:StatusEffectType             = mk("wormsOn");
		public static const WandererDemon:StatusEffectType       = mk("wanderer demon");
		public static const WandererHuman:StatusEffectType       = mk("wanderer human");
		public static const Yara:StatusEffectType                = mk("Yara");

		// monster
		public static const AbilityChanneled:StatusEffectType   = mk("Ability Channeled");
		public static const AbilityCooldown1:StatusEffectType   = mk("Ability Cooldown 1");
		public static const AbilityCooldown2:StatusEffectType   = mk("Ability Cooldown 2");
		public static const AbilityCooldown3:StatusEffectType   = mk("Ability Cooldown 3");
		public static const Attacks:StatusEffectType            = mk("attacks");
		public static const BimboBrawl:StatusEffectType         = mk("bimboBrawl");
		public static const BowCooldown:StatusEffectType        = mk("Bow Cooldown");
		public static const BowDisabled:StatusEffectType        = mk("Bow Disabled");
		public static const Charged:StatusEffectType            = mk("Charged");
		public static const Climbed:StatusEffectType            = mk("Climbed");
		public static const Concentration:StatusEffectType      = mk("Concentration");
		public static const Constricted:StatusEffectType        = mk("Constricted");
		public static const ConstrictedScylla:StatusEffectType  = mk("Constricted Scylla");
		public static const CoonWhip:StatusEffectType           = mk("Coon Whip");
		public static const Counter:StatusEffectType            = mk("Counter");
		public static const DevourMagic:StatusEffectType        = mk("DevourMagic");
		public static const DomFight:StatusEffectType           = mk("domfight");
		public static const DrankMinoCum:StatusEffectType       = mk("drank mino cum");
		public static const DrankMinoCum2:StatusEffectType      = mk("drank mino cum2");
		public static const Drunk:StatusEffectType              = mk("Drunk");
		public static const Earthshield:StatusEffectType        = mk("Earthshield");
		public static const EmbraceVampire:StatusEffectType     = mk("Embrace (Vampire)");
		public static const Fear:StatusEffectType               = mk("Fear");
		public static const FearCounter:StatusEffectType        = mk("FearCounter");
		public static const GenericRunDisabled:StatusEffectType = mk("Generic Run Disabled");
		public static const Gigafire:StatusEffectType           = mk("Gigafire");
		public static const GooEngulf:StatusEffectType          = mk("Goo Engulf");
		public static const GottaOpenGift:StatusEffectType      = mk("Gotta Open Gift");
		public static const HolliBurning:StatusEffectType       = mk("Holli Burning");
		public static const Illusion:StatusEffectType           = mk("Illusion");
		public static const ImpSkip:StatusEffectType            = mk("ImpSkip");
		public static const ImpUber:StatusEffectType            = mk("ImpUber");
		public static const JojoIsAssisting:StatusEffectType    = mk("Jojo Is Assisting");
		public static const JojoPyre:StatusEffectType           = mk("Jojo Pyre");
		public static const Keen:StatusEffectType               = mk("keen");
		public static const Level:StatusEffectType              = mk("level");
		public static const KitsuneFight:StatusEffectType       = mk("Kitsune Fight");
		public static const LustAura:StatusEffectType           = mk("Lust Aura");
		public static const LustStick:StatusEffectType          = mk("LustStick");
		public static const Milk:StatusEffectType               = mk("milk");
		public static const MilkyUrta:StatusEffectType          = mk("Milky Urta");
		public static const MinoMilk:StatusEffectType           = mk("Mino Milk");
		public static const MinotaurEntangled:StatusEffectType  = mk("Minotaur Entangled");
		public static const MissFirstRound:StatusEffectType     = mk("miss first round");
		public static const MonsterRegen:StatusEffectType       = mk("Monster Regeneration");//% regen
		public static const MonsterRegen2:StatusEffectType      = mk("Monster Regeneration2");//flat regen
		public static const NoLoot:StatusEffectType             = mk("No Loot");
		public static const PCTailTangle:StatusEffectType       = mk("PCTailTangle");
		public static const PeachLootLoss:StatusEffectType      = mk("Peach Loot Loss");
		// @aimozg i don't know and do not fucking care if these two should be merged
		public static const PhyllaFight:StatusEffectType        = mk("PhyllaFight");
		public static const phyllafight:StatusEffectType        = mk("phyllafight");
		public static const Platoon:StatusEffectType            = mk("platoon");
		public static const QueenBind:StatusEffectType          = mk("QueenBind");
		public static const TailSlamWhip:StatusEffectType       = mk("Tail Slam Whip");
		public static const IgnisCastedNuke:StatusEffectType  	= mk("Ignis Casted Nuke");
		public static const IgnisCounter:StatusEffectType  		= mk("Ignis Counter");
		public static const Pounce:StatusEffectType  			= mk("Pounce");
		public static const RaijuUltReady:StatusEffectType      = mk("Raiju Ult Ready");
		public static const Round:StatusEffectType              = mk("Round");
		public static const round:StatusEffectType              = mk("round");
		public static const RunDisabled:StatusEffectType        = mk("Run Disabled");
		public static const Shell:StatusEffectType              = mk("Shell");
		public static const SirenSong:StatusEffectType          = mk("Siren Song");
		public static const Spar:StatusEffectType               = mk("spar");
		public static const Sparring:StatusEffectType           = mk("sparring");
		public static const spiderfight:StatusEffectType        = mk("spiderfight");
		public static const StunCooldown:StatusEffectType       = mk("Stun Cooldown");
		public static const TentacleCoolDown:StatusEffectType   = mk("TentacleCoolDown");
		public static const Timer:StatusEffectType              = mk("Timer");
		public static const TimesBashed:StatusEffectType        = mk("TimesBashed");
		public static const TimesCharmed:StatusEffectType       = mk("TimesCharmed");
		public static const Uber:StatusEffectType               = mk("Uber");
		public static const UrtaSecondWinded:StatusEffectType   = mk("Urta Second Winded");
		public static const UsedTitsmother:StatusEffectType     = mk("UsedTitsmother");
		public static const Vala:StatusEffectType               = mk("vala");
		public static const Vapula:StatusEffectType             = mk("Vapula");
		public static const WhipReady:StatusEffectType          = mk("Whip Ready");
		
		//metamorph
		public static const UnlockedFur:StatusEffectType				 = mk("Unlocked Fur");
		public static const UnlockedScales:StatusEffectType				 = mk("Unlocked Scales");
		public static const UnlockedChitin:StatusEffectType				 = mk("Unlocked Chitin");
		public static const UnlockedDragonScales:StatusEffectType		 = mk("Unlocked Dragon Scales");
		public static const UnlockedTattoed:StatusEffectType			 = mk("Unlocked Tattoed");
		public static const UnlockedBattleTattoed:StatusEffectType		 = mk("Unlocked Battle Tattoed");
		public static const UnlockedLightningTattoed:StatusEffectType	 = mk("Unlocked Lightning Tattoed");
		public static const UnlockedFishGills:StatusEffectType			 = mk("Unlocked Fish Gills");
		
		public static const UnlockedFoxLowerBody:StatusEffectType        = mk("Unlocked Fox Lower Body");
		public static const UnlockedFoxArms:StatusEffectType             = mk("Unlocked Fox Arms");
		public static const UnlockedFoxEars:StatusEffectType             = mk("Unlocked Fox Ears");
		public static const UnlockedFoxTail:StatusEffectType             = mk("Unlocked Fox Tail");
		public static const UnlockedFoxFace:StatusEffectType             = mk("Unlocked Fox Face");
		public static const UnlockedFoxEyes:StatusEffectType             = mk("Unlocked Fox Eyes");
		public static const UnlockedFoxTail2nd:StatusEffectType          = mk("Unlocked Fox Tail 2nd");
		public static const UnlockedFoxTail3rd:StatusEffectType          = mk("Unlocked Fox Tail 3rd");
		public static const UnlockedFoxTail4th:StatusEffectType          = mk("Unlocked Fox Tail 4th");
		public static const UnlockedFoxTail5th:StatusEffectType          = mk("Unlocked Fox Tail 5th");
		public static const UnlockedFoxTail6th:StatusEffectType          = mk("Unlocked Fox Tail 6th");
		public static const UnlockedKitsuneArms:StatusEffectType         = mk("Unlocked Kitsune Arms");
		public static const UnlockedDemonTail:StatusEffectType           = mk("Unlocked Demon Tail");
		public static const UnlockedDemonHorns:StatusEffectType          = mk("Unlocked Demon Horns");
		public static const UnlockedDemonTonuge:StatusEffectType         = mk("Unlocked Demon Tonuge");
		public static const UnlockedDemonHighHeels:StatusEffectType      = mk("Unlocked Demon High Heels");
		public static const UnlockedDemonClawedLegs:StatusEffectType     = mk("Unlocked Demon Clawed Legs");
		public static const UnlockedDemonTinyBatWings:StatusEffectType   = mk("Unlocked Tiny Bat Wings");
		public static const UnlockedDemonLargeBatWings:StatusEffectType  = mk("Unlocked Large Bat Wings");
		public static const UnlockedDemonLargeBatWings2:StatusEffectType = mk("Unlocked Large Bat Wings (2nd pair)");
		public static const UnlockedLizardLegs:StatusEffectType          = mk("Unlocked Lizard Legs");
		public static const UnlockedLizardArms:StatusEffectType          = mk("Unlocked Lizard Arms");
		public static const UnlockedLizardTail:StatusEffectType          = mk("Unlocked Lizard Tail");
		public static const UnlockedLizardEyes:StatusEffectType          = mk("Unlocked Lizard Eyes");
		public static const UnlockedLizardEars:StatusEffectType          = mk("Unlocked Lizard Ears");
		public static const UnlockedLizardFace:StatusEffectType          = mk("Unlocked Lizard Face");
		public static const UnlockedBeeAntennae:StatusEffectType         = mk("Unlocked Bee Antennae");
		public static const UnlockedBeeArms:StatusEffectType             = mk("Unlocked Bee Arms");
		public static const UnlockedBeeLegs:StatusEffectType             = mk("Unlocked Bee Legs");
		public static const UnlockedBeeTail:StatusEffectType             = mk("Unlocked Bee Tail");
		public static const UnlockedBeeWingsSmall:StatusEffectType       = mk("Unlocked Bee Wings Small");
		public static const UnlockedBeeWingsLarge:StatusEffectType       = mk("Unlocked Bee Wings Large");
		public static const UnlockedHarpyLegs:StatusEffectType           = mk("Unlocked Harpy Legs");
		public static const UnlockedHarpyTail:StatusEffectType           = mk("Unlocked Harpy Tail");
		public static const UnlockedHarpyArms:StatusEffectType           = mk("Unlocked Harpy Arms");
		public static const UnlockedHarpyHair:StatusEffectType           = mk("Unlocked Harpy Hair");
		public static const UnlockedHarpyWings:StatusEffectType          = mk("Unlocked Harpy Wings");
		public static const UnlockedElfinEars:StatusEffectType           = mk("Unlocked Elfin Ears");
		public static const UnlockedSpiderFourEyes:StatusEffectType      = mk("Unlocked Spider Four Eyes");
		public static const UnlockedSpiderFangs:StatusEffectType         = mk("Unlocked Spider Fangs");
		public static const UnlockedSpiderArms:StatusEffectType          = mk("Unlocked Spider Arms");
		public static const UnlockedSpiderLegs:StatusEffectType          = mk("Unlocked Spider Legs");
		public static const UnlockedSpiderTail:StatusEffectType          = mk("Unlocked Spider Tail");
		public static const UnlockedDriderLegs:StatusEffectType          = mk("Unlocked Drider Legs");
		public static const UnlockedSharkTeeth:StatusEffectType          = mk("Unlocked Shark Teeth");
		public static const UnlockedSharkTail:StatusEffectType           = mk("Unlocked Shark Tail");
		public static const UnlockedSharkLegs:StatusEffectType           = mk("Unlocked Shark Legs");
		public static const UnlockedSharkArms:StatusEffectType           = mk("Unlocked Shark Arms");
		public static const UnlockedSharkFin:StatusEffectType            = mk("Unlocked Shark Fin");
		public static const UnlockedDraconicX2:StatusEffectType 		 = mk("Unlocked Draconic Horns");
		public static const UnlockedDraconicX4:StatusEffectType 		 = mk("Unlocked Draconic Horns (2nd pair)");
		public static const UnlockedFoxTail7th:StatusEffectType 		 = mk("Unlocked Fox Tail 7th");
		public static const UnlockedFoxTail8th:StatusEffectType 		 = mk("Unlocked Fox Tail 8th");
		public static const UnlockedFoxTail9th:StatusEffectType 		 = mk("Unlocked Fox Tail 9th");
		public static const UnlockedSalamanderTail:StatusEffectType 	 = mk("Unlocked Salamander Tail");
		public static const UnlockedSalamanderLegs:StatusEffectType 	 = mk("Unlocked Salamander Legs");
		public static const UnlockedSalamanderArms:StatusEffectType 	 = mk("Unlocked Salamander Arms");
		public static const UnlockedSalamanderFace:StatusEffectType 	 = mk("Unlocked Salamander Face");
		public static const UnlockedPhoenixArms:StatusEffectType		 = mk("Unlocked Phoenix Arms");
		public static const UnlockedPhoenixWings:StatusEffectType		 = mk("Unlocked Phoenix Wings");
		public static const UnlockedOrcaLegs:StatusEffectType			 = mk("Unlocked Orca Legs");
		public static const UnlockedOrcaArms:StatusEffectType			 = mk("Unlocked Orca Arms");
		public static const UnlockedOrcaTail:StatusEffectType			 = mk("Unlocked Orca Tail");
		public static const UnlockedOrcaEars:StatusEffectType			 = mk("Unlocked Orca Ears");
		public static const UnlockedOrcaFace:StatusEffectType			 = mk("Unlocked Orca Face");
		public static const UnlockedOrcaBlowhole:StatusEffectType		 = mk("Unlocked Orca Blowhole");
		public static const UnlockedSnakeTongue:StatusEffectType		 = mk("Unlocked Snake Tongue");
		public static const UnlockedSnakeFangs:StatusEffectType			 = mk("Unlocked Snake Fangs");
		public static const UnlockedSnakeLowerBody:StatusEffectType		 = mk("Unlocked Snake Lower Body");
		public static const UnlockedSnakeEyes:StatusEffectType			 = mk("Unlocked Snake Eyes");
		public static const UnlockedSnakeEars:StatusEffectType			 = mk("Unlocked Snake Ears");
		public static const UnlockedGorgonHair:StatusEffectType			 = mk("Unlocked Gorgon Hair");
		public static const UnlockedGorgonEyes:StatusEffectType			 = mk("Unlocked Gorgon Eyes");
		public static const UnlockedDraconicEars:StatusEffectType		 = mk("Unlocked Draconic Ears");
		public static const UnlockedDraconicWingsSmall:StatusEffectType	 = mk("Unlocked Draconic Wings Small");
		public static const UnlockedDraconicWingsLarge:StatusEffectType	 = mk("Unlocked Draconic Wings Large");
		public static const UnlockedDraconicWingsHuge:StatusEffectType	 = mk("Unlocked Draconic Wings Huge");
		public static const UnlockedDraconicEyes:StatusEffectType		 = mk("Unlocked Draconic Eyes");
		public static const UnlockedDraconicTongue:StatusEffectType		 = mk("Unlocked Draconic Tongue");
		public static const UnlockedDraconicFace:StatusEffectType		 = mk("Unlocked Draconic Face");
		public static const UnlockedDraconicFangs:StatusEffectType		 = mk("Unlocked Draconic Fangs");
		public static const UnlockedDraconicLegs:StatusEffectType		 = mk("Unlocked Draconic Legs");
		public static const UnlockedDraconicArms:StatusEffectType		 = mk("Unlocked Draconic Arms");
		public static const UnlockedDraconicTail:StatusEffectType		 = mk("Unlocked Draconic Tail");
		public static const UnlockedHoofedLegs:StatusEffectType 		 = mk("Unlocked Hoofed Legs");
		public static const UnlockedCowTail:StatusEffectType 			 = mk("Unlocked Cow Tail");
		public static const UnlockedCowEars:StatusEffectType 			 = mk("Unlocked Cow Ears");
		public static const UnlockedCowMinotaurFace:StatusEffectType 	 = mk("Unlocked Cow/Minotaur Face");
		public static const UnlockedCowMinotaurHorns:StatusEffectType 	 = mk("Unlocked Cow/Minotaur Horns");
		public static const UnlockedClovenHoofedLegs:StatusEffectType 	 = mk("Unlocked Cloven Hoofed Legs");
		public static const UnlockedGoatTail:StatusEffectType 			 = mk("Unlocked Goat Tail");
		public static const UnlockedGoatHorns:StatusEffectType 			 = mk("Unlocked Goat Horns");
		public static const UnlockedGoatEars:StatusEffectType			 = mk("Unlocked Goat Ears");
		public static const UnlockedDevilArms:StatusEffectType			 = mk("Unlocked Devil Arms");
		public static const UnlockedDevilFangs:StatusEffectType			 = mk("Unlocked Devil Fangs");
		public static const UnlockedDevilEyes:StatusEffectType			 = mk("Unlocked Devil Eyes");
		public static const UnlockedMantisAntennae:StatusEffectType		 = mk("Unlocked Mantis Antennae");
		public static const UnlockedMantisLegs:StatusEffectType			 = mk("Unlocked Mantis Legs");
		public static const UnlockedMantisArms:StatusEffectType			 = mk("Unlocked Mantis Arms");
		public static const UnlockedMantisTail:StatusEffectType			 = mk("Unlocked Mantis Tail");
		public static const UnlockedMantisWingsSmall:StatusEffectType	 = mk("Unlocked Mantis Wings Small");
		public static const UnlockedMantisWingsLarge:StatusEffectType	 = mk("Unlocked Mantis Wings Large");
		public static const UnlockedElfLegs:StatusEffectType			 = mk("Unlocked Elf Legs");
		public static const UnlockedElfArms:StatusEffectType			 = mk("Unlocked Elf Arms");
		public static const UnlockedElfEars:StatusEffectType			 = mk("Unlocked Elf Ears");
		public static const UnlockedElfEyes:StatusEffectType			 = mk("Unlocked Elf Eyes");
		public static const UnlockedElfHair:StatusEffectType			 = mk("Unlocked Elf Hair");
		public static const UnlockedElfTongue:StatusEffectType			 = mk("Unlocked Elf Tongue");
		public static const UnlockedOniLegs:StatusEffectType			 = mk("Unlocked Oni Legs");
		public static const UnlockedOniArms:StatusEffectType			 = mk("Unlocked Oni Arms");
		public static const UnlockedOniEyes:StatusEffectType			 = mk("Unlocked Oni Eyes");
		public static const UnlockedOniEars:StatusEffectType			 = mk("Unlocked Oni Ears");
		public static const UnlockedOniFace:StatusEffectType			 = mk("Unlocked Oni Face");
		public static const UnlockedOniSingleHorn:StatusEffectType		 = mk("Unlocked Oni Single Horn");
		public static const UnlockedOniTwinHorns:StatusEffectType		 = mk("Unlocked Oni Twin Horns");
		public static const UnlockedRaijuLegs:StatusEffectType			 = mk("Unlocked Raiju Legs");
		public static const UnlockedRaijuArms:StatusEffectType			 = mk("Unlocked Raiju Arms");
		public static const UnlockedRaijuTail:StatusEffectType			 = mk("Unlocked Raiju Tail");
		public static const UnlockedRaijuMane:StatusEffectType			 = mk("Unlocked Raiju Mane");
		public static const UnlockedRaijuFace:StatusEffectType			 = mk("Unlocked Raiju Face");
		public static const UnlockedRaijuEars:StatusEffectType			 = mk("Unlocked Raiju Ears");
		public static const UnlockedRaijuEyes:StatusEffectType			 = mk("Unlocked Raiju Eyes");
		public static const UnlockedRaijuHair:StatusEffectType			 = mk("Unlocked Raiju Hair");

		// universal combat debuffs

		public static const GenericCombatStrBuff:StatusEffectType  = CombatStrBuff.TYPE;
		public static const GenericCombatSpeBuff:StatusEffectType  = CombatSpeBuff.TYPE;
		public static const GenericCombatTouBuff:StatusEffectType  = CombatTouBuff.TYPE;
		public static const GenericCombatInteBuff:StatusEffectType = CombatInteBuff.TYPE;
		public static const GenericCombatWisBuff:StatusEffectType  = CombatWisBuff.TYPE;
		// combat
		public static const AcidSlap:StatusEffectType                  = mkCombat("Acid Slap");
		public static const AlrauneEntangle:StatusEffectType           = mkCombat("Alraune Entangle");
		public static const AlraunePollen:StatusEffectType             = mkCombat("Alraune Pollen");
		public static const AmilyVenom:StatusEffectType                = AmilyVenomDebuff.TYPE;
		public static const AnemoneVenom:StatusEffectType              = AnemoneVenomDebuff.TYPE;
		public static const AttackDisabled:StatusEffectType            = mkCombat("Attack Disabled");
		public static const BarkSkin:StatusEffectType                  = mkCombat("Bark Skin");
		public static const BasiliskCompulsion:StatusEffectType        = mkCombat("Basilisk Compulsion");
		public static const BasiliskSlow:StatusEffectType              = BasiliskSlowDebuff.TYPE;
		public static const BathedInHotSpring:StatusEffectType         = mkCombat("Bathed In Hot Spring");
		public static const BeatOfWar:StatusEffectType                 = mkCombat("Beat of War");
		public static const Berzerking:StatusEffectType                = mkCombat("Berzerking");
		public static const BladeDance:StatusEffectType                = mkCombat("Blade Dance");
		public static const Blind:StatusEffectType                     = mkCombat("Blind");
		public static const Blink:StatusEffectType                     = mkCombat("Blink");
		public static const Blizzard:StatusEffectType                  = mkCombat("Blizzard");
		public static const Bloodlust:StatusEffectType                 = mkCombat("Bloodlust");
		public static const Bound:StatusEffectType                     = mkCombat("Bound");
		public static const BurnDoT:StatusEffectType                   = mkCombat("Burn DoT");
		public static const CalledShot:StatusEffectType                = CalledShotDebuff.TYPE;
		public static const CastedSpell:StatusEffectType               = mkCombat("Casted Spell");
		public static const ChanneledAttack:StatusEffectType           = mkCombat("Channeled Attack");
		public static const ChanneledAttackType:StatusEffectType       = mkCombat("Channeled Attack Type");
		public static const ChargeArmor:StatusEffectType               = mkCombat("Charge Armor");
		public static const ChargeWeapon:StatusEffectType              = mkCombat("Charge Weapon");
		public static const Chokeslam:StatusEffectType                 = mkCombat("Chokeslam");
		public static const Confusion:StatusEffectType                 = mkCombat("Confusion");
		public static const CrinosShape:StatusEffectType               = mkCombat("Crinos Shape");
		public static const Defend:StatusEffectType                    = mkCombat("Defend");
		public static const DefendMonsterVer:StatusEffectType          = mkCombat("Defend Monster Ver");
		public static const DemonSeed:StatusEffectType                 = mkCombat("DemonSeed");
		public static const Disarmed:StatusEffectType                  = mkCombat("Disarmed");
		public static const DriderKiss:StatusEffectType                = mkCombat("Drider Kiss");
		public static const DwarfRage:StatusEffectType                 = mkCombat("Dwarf Rage");
		public static const EarthStance:StatusEffectType	           = mkCombat("Earth Stance");
		public static const EverywhereAndNowhere:StatusEffectType      = mkCombat("Everywhere and nowhere");
		public static const EzekielCurse:StatusEffectType              = mkCombat("Ezekiel Curse");
		public static const FirePunchBurnDoT:StatusEffectType          = mkCombat("Fire Punch Burn DoT");
		public static const FirstAttack:StatusEffectType               = mkCombat("FirstAttack");
		public static const FirstAttackMantis:StatusEffectType         = mkCombat("FirstAttackMantis");
		public static const FirstStrike:StatusEffectType               = mkCombat("FirstStrike");
		public static const Flying:StatusEffectType                    = mkCombat("Flying");
		public static const FlyingNoStun:StatusEffectType              = mkCombat("FlyingNoStun");
		public static const FreezingBreathStun:StatusEffectType        = mkCombat("FreezingBreathStun");
		public static const Frostbite:StatusEffectType                 = mkCombat("Frostbite");
		public static const Frozen:StatusEffectType	                   = mkCombat("Frozen");
		public static const GiantBoulder:StatusEffectType              = mkCombat("Giant Boulder");
		public static const GiantGrabbed:StatusEffectType              = mkCombat("Giant Grabbed");
		public static const GooArmorBind:StatusEffectType              = mkCombat("GooArmorBind");
		public static const GooArmorSilence:StatusEffectType           = mkCombat("GooArmorSilence");
		public static const GooBind:StatusEffectType                   = mkCombat("GooBind");
		public static const GoreBleed:StatusEffectType                 = mkCombat("Gore Bleed");
		public static const HarpyBind:StatusEffectType                 = mkCombat("HarpyBind");
		public static const Hemorrhage:StatusEffectType                = mkCombat("Hemorrhage");
		public static const HeroBane:StatusEffectType                  = mkCombat("HeroBane");
		public static const HolliConstrict:StatusEffectType            = mkCombat("Holli Constrict");
		public static const HurricaneDance:StatusEffectType	           = mkCombat("Hurricane Dance");
		public static const ImmolationDoT:StatusEffectType             = mkCombat("Immolation DoT");
		public static const InfestAttempted:StatusEffectType           = mkCombat("infestAttempted");
		public static const InkBlind:StatusEffectType                  = mkCombat("Ink Blind");
		public static const IsabellaStunned:StatusEffectType           = mkCombat("Isabella Stunned");
		public static const IzmaBleed:StatusEffectType                 = mkCombat("Izma Bleed");
		public static const KissOfDeath:StatusEffectType               = mkCombat("Kiss of Death");
		public static const LizanBlowpipe:StatusEffectType             = LizanBlowpipeDebuff.TYPE;
		public static const LustStones:StatusEffectType                = mkCombat("lust stones");
		public static const lustvenom:StatusEffectType                 = mkCombat("lust venom");
		public static const Lustzerking:StatusEffectType               = mkCombat("Lustzerking");
		public static const Maleficium:StatusEffectType                = mkCombat("Maleficium");
		public static const ManaShield:StatusEffectType                = mkCombat("Mana Shield");
		public static const MedusaVenom:StatusEffectType               = mkCombat("Medusa Venom");
		public static const MetalSkin:StatusEffectType                 = mkCombat("Metal Skin");
		public static const Might:StatusEffectType                     = mkCombat("Might");
		public static const MonsterAttacksDisabled:StatusEffectType    = mkCombat("Monster Attacks Disabled");
		public static const NagaBind:StatusEffectType                  = mkCombat("Naga Bind");
		public static const NagaVenom:StatusEffectType                 = mkCombat("Naga Venom");
		public static const NoFlee:StatusEffectType                    = mkCombat("NoFlee");
		public static const OniRampage:StatusEffectType                = mkCombat("Oni Rampage");
		public static const Overlimit:StatusEffectType                 = mkCombat("Overlimit");
		public static const ParalyzeVenom:StatusEffectType             = ParalyzeVenomDebuff.TYPE;
		public static const PhysicalDisabled:StatusEffectType          = mkCombat("Physical Disabled");
		public static const PlayerRegenerate:StatusEffectType		   = mkCombat("Player Regenerate");
		public static const Poison:StatusEffectType                    = mkCombat("Poison");
		public static const PunishingKick:StatusEffectType	           = mkCombat("Punishing Kick");
		public static const Rage:StatusEffectType                      = mkCombat("Rage");
		public static const RaijuStaticDischarge:StatusEffectType      = mkCombat("Raiju Static Discharge");
		public static const ResonanceVolley:StatusEffectType           = mkCombat("Resonance Volley");
		public static const Sandstorm:StatusEffectType                 = mkCombat("sandstorm");
		public static const ScyllaBind:StatusEffectType                = mkCombat("Scylla Bind");
		public static const Sealed:StatusEffectType                    = mkCombat("Sealed");
		public static const Sealed2:StatusEffectType                   = mkCombat("Sealed2");
		public static const SecondWindRegen:StatusEffectType           = mkCombat("Second Wind Regen");
		public static const SharkBiteBleed:StatusEffectType            = mkCombat("Shark Bite Bleed");
		public static const SheilaOil:StatusEffectType                 = mkCombat("Sheila Oil");
		public static const Shielding:StatusEffectType                 = mkCombat("Sheilding");
		public static const StoneLust:StatusEffectType                 = mkCombat("Stone Lust");
		public static const StoneSkin:StatusEffectType                 = mkCombat("Stone Skin");
		public static const Stunned:StatusEffectType                   = mkCombat("Stunned");
		public static const StunnedTornado:StatusEffectType            = mkCombat("Stunned (Tornado)");
		public static const TailWhip:StatusEffectType                  = mkCombat("Tail Whip");
		public static const TemporaryHeat:StatusEffectType             = mkCombat("Temporary Heat");
		public static const TentacleBind:StatusEffectType              = mkCombat("TentacleBind");
		public static const ThroatPunch:StatusEffectType               = mkCombat("Throat Punch");
		public static const Titsmother:StatusEffectType                = mkCombat("Titsmother");
		public static const TranceTransformation:StatusEffectType      = mkCombat("Trance Transformation");
		public static const TwuWuv:StatusEffectType                    = mkCombat("Twu Wuv");
		public static const UBERWEB:StatusEffectType                   = mkCombat("UBERWEB");
		public static const UnderwaterCombatBoost:StatusEffectType     = mkCombat("UnderwaterCombatBoost");
		public static const UnderwaterOutOfAir:StatusEffectType        = mkCombat("UnderwaterOutOfAir");
		public static const VioletPupilTransformation:StatusEffectType = mkCombat("Violet Pupil Transformation");
		public static const Web:StatusEffectType                       = WebDebuff.TYPE;
		public static const WebSilence:StatusEffectType                = mkCombat("Web-Silence");
		public static const Whispered:StatusEffectType                 = mkCombat("Whispered");
		public static const WindWall:StatusEffectType                  = mkCombat("Wind Wall");
		public static const WolfHold:StatusEffectType                  = mkCombat("Wolf Hold");
		
		public static const CooldownCompellingAria:StatusEffectType     = mkCombat("Cooldown Compelling Aria");
		public static const CooldownCumCannon:StatusEffectType          = mkCombat("Cooldown Cum Cannon");
		public static const CooldownCursedRiddle:StatusEffectType       = mkCombat("Cooldown Cursed Riddle");
		public static const CooldownEAspectAir:StatusEffectType         = mkCombat("Cooldown Elemental Aspect Air");
		public static const CooldownEAspectEarth:StatusEffectType       = mkCombat("Cooldown Elemental Aspect Earth");
		public static const CooldownEAspectFire:StatusEffectType        = mkCombat("Cooldown Elemental Aspect Fire");
		public static const CooldownEAspectWater:StatusEffectType       = mkCombat("Cooldown Elemental Aspect Water");
		public static const CooldownEAspectIce:StatusEffectType         = mkCombat("Cooldown Elemental Aspect Ice");
		public static const CooldownEAspectLightning:StatusEffectType   = mkCombat("Cooldown Elemental Aspect Lightning");
		public static const CooldownEAspectDarkness:StatusEffectType    = mkCombat("Cooldown Elemental Aspect Darkness");
		public static const CooldownEAspectWood:StatusEffectType        = mkCombat("Cooldown Elemental Aspect Wood");
		public static const CooldownEAspectMetal:StatusEffectType       = mkCombat("Cooldown Elemental Aspect Metal");
		public static const CooldownEAspectEther:StatusEffectType       = mkCombat("Cooldown Elemental Aspect Ether");
		public static const CooldownEclipsingShadow:StatusEffectType    = mkCombat("Cooldown Eclipsing shadow");
		public static const CooldownEveryAndNowhere:StatusEffectType    = mkCombat("Cooldown Everywhere And Nowhere");
		public static const CooldownFascinate:StatusEffectType          = mkCombat("Cooldown Fascinate");
		public static const CooldownFreezingBreath:StatusEffectType     = mkCombat("Cooldown Freezing Breath (F)");
		public static const CooldownFreezingBreathYeti:StatusEffectType = mkCombat("Cooldown Freezing Breath (Y)");
		public static const CooldownIllusion:StatusEffectType           = mkCombat("Cooldown Illusion");
		public static const CooldownInkSpray:StatusEffectType           = mkCombat("Cooldown Ink Spray");
		public static const CooldownKick:StatusEffectType               = mkCombat("Cooldown Kick");
		public static const CooldownMilkBlast:StatusEffectType          = mkCombat("Cooldown Milk Blast");
		public static const CooldownOniRampage:StatusEffectType         = mkCombat("Cooldown Oni Rampage");
		public static const CooldownPhoenixFireBreath:StatusEffectType  = mkCombat("Cooldown Phoenix Fire Breath");
		public static const CooldownSecondWind:StatusEffectType         = mkCombat("Cooldown Second Wind");
		public static const CooldownSideWinder:StatusEffectType         = mkCombat("Cooldown Sidewinder");
		public static const CooldownSonicScream:StatusEffectType        = mkCombat("Cooldown Sonic scream");
		public static const CooldownStoneClaw:StatusEffectType          = mkCombat("Cooldown Stone Claw");
		public static const CooldownTailSlam:StatusEffectType           = mkCombat("Cooldown Tail Slam");
		public static const CooldownTailSmack:StatusEffectType          = mkCombat("Cooldown Tail Smack");
		public static const CooldownTornadoStrike:StatusEffectType      = mkCombat("Cooldown Tornado Strike");
		public static const CooldownTerror:StatusEffectType             = mkCombat("Cooldown Terror");
		public static const CooldownWingBuffet:StatusEffectType         = mkCombat("Cooldown Wing Buffet");
		
		public static const RemovedArmor:StatusEffectType          = mkCombat("Removed Armor");
		public static const JCLustLevel:StatusEffectType           = mkCombat("JC Lust Level");
		public static const MirroredAttack:StatusEffectType        = mkCombat("Mirrored Attack");
		public static const KnockedBack:StatusEffectType           = mkCombat("Knocked Back");
		public static const Tentagrappled:StatusEffectType         = mkCombat("Tentagrappled");
		public static const TentagrappleCooldown:StatusEffectType  = mkCombat("Tentagrapple Cooldown");
		public static const ShowerDotEffect:StatusEffectType       = mkCombat("Shower Dot Effect");
		public static const GardenerSapSpeed:StatusEffectType      = GardenerSapSpeedDebuff.TYPE;
		public static const VineHealUsed:StatusEffectType          = mkCombat("Vine Heal Used");
		public static const DriderIncubusVenom:StatusEffectType    = mkCombat("Drider Incubus Venom");
		public static const TaintedMind:StatusEffectType           = mkCombat("Tainted Mind");
		public static const PurpleHaze:StatusEffectType            = mkCombat("Purple Haze");
		public static const MinotaurKingMusk:StatusEffectType      = mkCombat("Minotaur King Musk");
		public static const MinotaurKingsTouch:StatusEffectType    = mkCombat("Minotaur Kings Touch");
		public static const LethicesRapeTentacles:StatusEffectType = mkCombat("Lethices Rape Tentacles");
		public static const OnFire:StatusEffectType                = mkCombat("On Fire");
		public static const LethicesShell:StatusEffectType         = mkCombat("Lethices Magic Shell");
		public static const WhipSilence:StatusEffectType           = mkCombat("Whip Silence");
		public static const PigbysHands:StatusEffectType           = mkCombat("Pigbys Hands");

		/**
		 * Creates status affect
		 */
		private static function mk(id:String, clazz:Class = null, arity: int = 1):StatusEffectType
		{
			return new StatusEffectType(id,clazz ? clazz : StatusEffectClass,arity);
		}
		/**
		 * Creates combat status affect
		 */
		private static function mkCombat(id:String):StatusEffectType
		{
			return new StatusEffectType(id,CombatStatusEffect,1);
		}

		/**
		 * Creates an knowledge status effect type, which unlocks a combat action when given to a creature
		 * @param id perk ID
		 * @param action CombatAction to unlock when this status is gained
		 * @return
		 */
		private static function mkKnowledge(id:String, action:CombatAction):StatusEffectType{
			var stype:StatusEffectType =  new StatusEffectType(id,KnowledgeStatusEffect,1);
			KnowledgeStatusEffect.registerAction(stype, action);
			return stype;
		}
	}
}
