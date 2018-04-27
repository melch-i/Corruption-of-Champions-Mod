﻿/**
 * Created by aimozg on 05.01.14.
 */
package classes.Scenes
{
import classes.*;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Beach;
import classes.Scenes.Areas.BlightRidge;
import classes.Scenes.Areas.BlightRidge.*;
import classes.Scenes.Areas.DeepSea;
import classes.Scenes.Areas.Ocean;
import classes.Scenes.Explore.ExploreDebug;
import classes.Scenes.Monsters.*;
import classes.Scenes.NPCs.RyuBiDragon;

//import classes.Scenes.Areas.nazwa lokacji;
	//import classes.Scenes.Areas.nazwa lokacji;
public class Exploration extends BaseContent
	{
		public var exploreDebug:ExploreDebug = new ExploreDebug();
		public var blightridge:BlightRidge = new BlightRidge();
		public var beach:Beach = new Beach();
		public var ocean:Ocean = new Ocean();
		public var deepsea:DeepSea = new DeepSea();
		//public var blightridge:BlightRidge = new BlightRidge();	//dla nowych lokacji
		public var TrueDemons:DemonScene = new DemonScene();

		public function Exploration()
		{
		}

		public function furriteMod():Number {
			return furriteFnGen()();
		}
		
		public function lethiteMod():Number {
			return lethiteFnGen()();
		}
		
		// Why? Because what if you want to alter the iftrue/iffalse?
		// Default values: mods:[SceneLib.exploration.furriteMod]
		// Non-default:    mods:[SceneLib.exploration.furriteFnGen(4,0)]

		public function furriteFnGen(iftrue:Number = 3, iffalse:Number = 1):Function {
			return function ():Number {
				return player.hasPerk(PerkLib.PiercedFurrite) ? iftrue : iffalse;
			}
		}
		
		public function lethiteFnGen(iftrue:Number = 3, iffalse:Number = 1):Function {
			return function ():Number {
				return player.hasPerk(PerkLib.PiercedLethite) ? iftrue : iffalse;
			}
		}
		//const MET_OTTERGIRL:int = 777;
		//const HAS_SEEN_MINO_AND_COWGIRL:int = 892;
		//const EXPLORATION_PAGE:int = 1015;
		//const BOG_EXPLORED:int = 1016;
		public function doExplore():void
		{
			clearOutput();
			if (player.explored <= 0) {
				outputText("You tentatively step away from your campsite, alert and scanning the ground and sky for danger.  You walk for the better part of an hour, marking the rocks you pass for a return trip to your camp.  It worries you that the portal has an opening on this side, and it was totally unguarded...\n\n...Wait a second, why is your campsite in front of you? The portal's glow is clearly visible from inside the tall rock formation.   Looking carefully you see your footprints leaving the opposite side of your camp, then disappearing.  You look back the way you came and see your markings vanish before your eyes.  The implications boggle your mind as you do your best to mull over them.  Distance, direction, and geography seem to have little meaning here, yet your campsite remains exactly as you left it.  A few things click into place as you realize you found your way back just as you were mentally picturing the portal!  Perhaps memory influences travel here, just like time, distance, and speed would in the real world!\n\nThis won't help at all with finding new places, but at least you can get back to camp quickly.  You are determined to stay focused the next time you explore and learn how to traverse this gods-forsaken realm.");
				tryDiscover();
				return;
			} else if (player.explored == 1) {
				outputText("You walk for quite some time, roaming the hard-packed and pink-tinged earth of the demon-realm.  Rust-red rocks speckle the wasteland, as barren and lifeless as anywhere else you've been.  A cool breeze suddenly brushes against your face, as if gracing you with its presence.  You turn towards it and are confronted by the lush foliage of a very old looking forest.  You smile as the plants look fairly familiar and non-threatening.  Unbidden, you remember your decision to test the properties of this place, and think of your campsite as you walk forward.  Reality seems to shift and blur, making you dizzy, but after a few minutes you're back, and sure you'll be able to return to the forest with similar speed.\n\n<b>You have discovered the Forest!</b>");
				tryDiscover();
				player.exploredForest++;
				return;
			} else if (player.explored > 1) outputText("You can continue to search for new locations, or explore your previously discovered locations.");

			if (flags[kFLAGS.EXPLORATION_PAGE] == 2) {
				explorePageII();
				return;
			}
			hideMenus();
			menu();
			addButton(0, "Explore", tryDiscover).hint("Explore to find new regions and visit any discovered regions.");
			if (SceneLib.forest.isDiscovered()) addButton(1, "Forest", SceneLib.forest.exploreForest).hint("Visit the lush forest. \n\nRecommended level: 1" + (player.level < 12 ? "\n\nBeware of Tentacle Beasts!" : "") + (debug ? "\n\nTimes explored: " + SceneLib.forest.timesExplored() : ""));
			if (player.exploredLake > 0) addButton(2, "Lake", SceneLib.lake.exploreLake).hint("Visit the lake and explore the beach. \n\nRecommended level: 1" + (player.level < 3 ? "\n\nLooks like it's still quiet here!" : "") + (debug ? "\n\nTimes explored: " + player.exploredLake : ""));
			if (player.exploredDesert > 0) addButton(3, "Desert", SceneLib.desert.exploreDesert).hint("Visit the dry desert. \n\nRecommended level: 5" + (debug ? "\n\nTimes explored: " + player.exploredDesert : ""));
			
			//if (flags[kFLAGS.DISCOVERED_] > 0) addButton(5, "Battlefield", battlefield.exploreBattlefield).hint("Visit the battlefield. \n\nRecommended level: 6" + (player.level < 18 ? "\n\nBut it's still too dangerous place to visit lightly!" : "") + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_] : ""));
			if (player.exploredMountain > 0) addButton(6, "Mountain", SceneLib.mountain.exploreMountain).hint("Visit the mountain. \n\nRecommended level: 10" + (debug ? "\n\nTimes explored: " + player.exploredMountain : ""));
			if (flags[kFLAGS.TIMES_EXPLORED_PLAINS] > 0) addButton(7, "Plains", SceneLib.plains.explorePlains).hint("Visit the plains. \n\nRecommended level: 14" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.TIMES_EXPLORED_PLAINS] : ""));
			if (flags[kFLAGS.TIMES_EXPLORED_SWAMP] > 0) addButton(8, "Swamp", SceneLib.swamp.exploreSwamp).hint("Visit the wet swamplands. \n\nRecommended level: 18" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.TIMES_EXPLORED_SWAMP] : ""));
			
			if (flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE] > 0) addButton(10, "Blight Ridge", blightridge.exploreBlightRidge).hint("Visit the corrupted blight ridge. \n\nRecommended level: 26" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE] : ""));
			if (flags[kFLAGS.DISCOVERED_BEACH] > 0) addButton(11, "Beach", beach.exploreBeach).hint("Visit the sunny beach. \n\nRecommended level: 30" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_BEACH] : ""));
			if (flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] > 0) addButton(12, "Glacial Rift", SceneLib.glacialRift.exploreGlacialRift).hint("Visit the chilly glacial rift. \n\nRecommended level: 30" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] : ""));
			if (flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] > 0) addButton(13, "Volcanic Crag", SceneLib.volcanicCrag.exploreVolcanicCrag).hint("Visit the infernal volcanic crag. \n\nRecommended level: 30" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] : ""));
			
			if (debug) addButton(9, "Debug", exploreDebug.doExploreDebug);
			addButton(4, "Next", explorePageII);
			addButton(14, "Back", playerMenu);
		}

		private function explorePageII():void
		{
			flags[kFLAGS.EXPLORATION_PAGE] = 2;
			menu();
			if (SceneLib.forest.deepwoodsDiscovered()) addButton(0, "Deepwoods", SceneLib.forest.exploreDeepwoods).hint("Visit the dark, bioluminescent deepwoods. \n\nRecommended level: 12" + (debug ? "\n\nTimes explored: " + SceneLib.forest.timesExploredDeepwoods() : ""));
			if (flags[kFLAGS.DISCOVERED_OCEAN] > 0) addButton(1, "Ocean", ocean.exploreOcean).hint("Explore the ocean surface. But beware of... sharks. \n\nRecommended level: 50" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_OCEAN] : ""));
			if (flags[kFLAGS.DISCOVERED_OCEAN] <= 0 && flags[kFLAGS.DISCOVERED_BEACH] > 0) addButtonDisabled(1, "Ocean", "You need to find first some way to sail over the water surface to explore this area.");
			if (flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN] > 0) addButton(2, "High Mountain", SceneLib.highMountains.exploreHighMountain).hint("Visit the high mountains where basilisks and harpies are found. \n\nRecommended level: 20" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN] : ""));
			if (flags[kFLAGS.BOG_EXPLORED] > 0) addButton(3, "Bog", SceneLib.bog.exploreBog).hint("Visit the dark bog. \n\nRecommended level: 28" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.BOG_EXPLORED] : ""));
			
			//if (flags[kFLAGS.DISCOVERED_] > 0) addButton(5, "",	//Wuxia related area - ?latająca wyspa?
		//	if (flags[kFLAGS.DISCOVERED_DEEP_SEA] > 0 && player.canSwimUnderwater()) addButton(6, "Deep Sea", deepsea.exploreDeepSea).hint("Visit the 'almost virgin' deep sea. But beware of... krakens. \n\nRecommended level: 75" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_DEEP_SEA] : ""));
		//	if (player.gills.type == 0 && flags[kFLAGS.DISCOVERED_BEACH] > 0) addButtonDisabled(6, "Deep Sea", "(Not yet ready to be unlockable - it wil happen after few more mod builds after 0.7c) Without any way to breathe underwater you can't explore this area!");
			//if (flags[kFLAGS.DISCOVERED_PIT] > 0) addButton(7, "Pit", CoC.instance.abyss.explorePit).hint("Visit the pit. \n\nRecommended level: 36" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_PIT] : ""));
			
			//if (flags[kFLAGS.DISCOVERED_] > 0) addButton(10, "",	//Wuxia related area - ?latająca wyspa?
			//if (flags[kFLAGS.DISCOVERED_ABYSS] > 0) addButton(12, "Abyss", CoC.instance.abyss.exploreAbyss).hint("Visit the abyss. \n\nRecommended level: 51" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_ABYSS] : ""));
			
			if (debug) addButton(4, "Debug", exploreDebug.doExploreDebug);
			addButton(9, "Previous", goBackToPageI);
			addButton(14, "Back", playerMenu);
		}

		private function goBackToPageI():void
		{
			flags[kFLAGS.EXPLORATION_PAGE] = 1;
			doExplore();
		}
		
		public function genericGolGobImpEncounters(even:Boolean = false):void {
			var impGobGol:Number = 5;
			if (!even) {
				if (player.cockTotal() > 0) impGobGol--;
				if (player.hasVagina()) impGobGol++;
				if (player.totalFertility() >= 30) impGobGol++;
				if (player.cumQ() >= 200) impGobGol--;
				if (player.hasPerk(PerkLib.PiercedLethite)) {
					if (impGobGol <= 3) impGobGol += 2;
					else if (impGobGol < 7) impGobGol = 7;
				}
			}
			//Imptacular Encounter
			if (rand(10) < impGobGol) {
				var impChooser:int = rand(100);
				//Level modifier
				if (player.level < 20) impChooser += player.level;
				else impChooser += 20;
				//Limit chooser ranges
				if (impChooser > 100) impChooser = 100;
				if (player.level < 8 && impChooser >= 40) impChooser = 39;
				else if (player.level < 12 && impChooser >= 60) impChooser = 59;
				else if (player.level < 16 && impChooser >= 80) impChooser = 79;
				//Imp Lord
				if (impChooser >= 50 && impChooser < 70) {
					SceneLib.impScene.impLordEncounter();
					spriteSelect(29);
					return;
				}
				//Imp Warlord
				else if (impChooser >= 70 && impChooser < 90) {
					SceneLib.impScene.impWarlordEncounter();
					spriteSelect(125);
					return;
				}
				//Imp Overlord (Rare!)
				else if (impChooser >= 90) {
					SceneLib.impScene.impOverlordEncounter();
					spriteSelect(126);
					return;
				}
				else {
					clearOutput();
					outputText("An imp wings out of the sky and attacks!");
					if (flags[kFLAGS.CODEX_ENTRY_IMPS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_IMPS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Imps!</b>")
					}
					startCombat(new Imp());
					spriteSelect(29);
				}
				return;
			}
			else {
				var goblinChooser:int = rand(100);
				//Level modifier
				if (player.level < 20) goblinChooser += player.level;
				else goblinChooser += 20;
				//Limit chooser range
				if (goblinChooser > 100) goblinChooser = 100;
				if (player.level < 10 && goblinChooser >= 20) goblinChooser = 29;
				else if (player.level < 12 && goblinChooser >= 60) goblinChooser = 49;
				else if (player.level < 16 && goblinChooser >= 80) goblinChooser = 79;
				//Goblin assassin!
				if (goblinChooser >= 30 && goblinChooser < 50) {
					SceneLib.goblinAssassinScene.goblinAssassinEncounter();
					spriteSelect(24);
					return;
				}
				//Goblin warrior! (Equal chance with Goblin Shaman)
				else if (goblinChooser >= 50 && goblinChooser < 65) {
					SceneLib.goblinWarriorScene.goblinWarriorEncounter();
					spriteSelect(123);
					return;
				}
				//Goblin shaman!
				else if (goblinChooser >= 65 && goblinChooser < 80) {
					SceneLib.goblinShamanScene.goblinShamanEncounter();
					spriteSelect(124);
					return;
				}
				//Goblin elder!
				else if (goblinChooser >= 80) {
					SceneLib.goblinElderScene.goblinElderEncounter();
					spriteSelect(122);
					return;
				}
				if (player.gender > 0) {
					clearOutput();
					outputText("A goblin saunters out of the bushes with a dangerous glint in her eyes.\n\nShe says, \"<i>Time to get fucked, " + player.mf("stud", "slut") + ".</i>\"");
					if (flags[kFLAGS.CODEX_ENTRY_GOBLINS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_GOBLINS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Goblins!</b>")
					}
					startCombat(new Goblin());
					spriteSelect(24);
					return;
				}
				else {
					clearOutput();
					outputText("A goblin saunters out of the bushes with a dangerous glint in her eyes.\n\nShe says, \"<i>Time to get fuc-oh shit, you don't even have anything to play with!  This is for wasting my time!</i>\"");
					if (flags[kFLAGS.CODEX_ENTRY_GOBLINS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_GOBLINS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Goblins!</b>")
					}
					startCombat(new Goblin());
					spriteSelect(24);
					return;
				}
			}
		}
		public function genericImpEncounters2(even:Boolean = false):void {
			//Imptacular Encounter
			var impChooser:int = rand(100);
			//Level modifier
			if (player.level < 20) impChooser += player.level;
			else impChooser += 20;
			//Limit chooser ranges
			if (impChooser > 100) impChooser = 100;
			if (player.level < 16 && impChooser >= 75) impChooser = 74;
			//Imp Warlord
			if (impChooser >= 50 && impChooser < 75) {
				SceneLib.impScene.impWarlordEncounter();
				spriteSelect(125);
				return;
			}
			//Imp Overlord
			else if (impChooser >= 75) {
				SceneLib.impScene.impOverlordEncounter();
				spriteSelect(126);
				return;
			}
			//Pack of Imps
			else {
				SceneLib.impScene.impPackEncounter();
				return;
			}
		}
		public function genericDemonsEncounters1(even:Boolean = false):void {
			//Imptacular Encounter
			var demonChooser:int = rand(100);
			//Succubus
			//if (demonChooser >= 30 && demonChooser < 55) {
			if (demonChooser >= 40 && demonChooser < 70) {
				TrueDemons.SuccubusEncounter();
				return;
			}
			//Incubus
			//else if (demonChooser >= 55 && demonChooser < 80) {
			else if (demonChooser >= 70) {
				TrueDemons.IncubusEncounter();
				return;
			}
			//Cow-Succubus
			//else if (demonChooser >= 80 && demonChooser < 90) {
				//startCombat(new CowSuccubus());
				//return;
			//}
			//Mino-Incubus
			//else if (demonChooser >= 90) {
				//startCombat(new MinoIncubus());
				//return;
			//}
			//Omnibus
			else {
				TrueDemons.OmnibusEncounter();
				return;
			}
		}
		
		//Try to find a new location - called from doExplore once the first location is found
		public function tryDiscover():void
		{

			// CoC.instance.goblinAssassinScene.goblinAssassinEncounter();
			// return;

			if (player.level > 2 && player.hasKeyItem("Sky Poison Pearl") < 0 && flags[kFLAGS.SKY_POISON_PEARL] < 1 && rand(10) == 0) {
				pearldiscovery();
				return;
			}
/*			if (player.level > 5 && flags[kFLAGS.RYUBI_LVL_UP] < 1 && rand(4) == 0) {
				ryubifirstenc();
				return;
			}
			if (player.level > 5 && flags[kFLAGS.RYUBI_LVL_UP] >= 1 && rand(4) == 0) {
				ryubirepenc();
				return;
			}
*/			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !SceneLib.helFollower.followerHel()) {
				SceneLib.helScene.helSexualAmbush();
				return;
			}
			if (player.explored > 1) {

				clearOutput();
				if (player.exploredForest <= 0) {
					outputText("You walk for quite some time, roaming the hard-packed and pink-tinged earth of the demon-realm.  Rust-red rocks speckle the wasteland, as barren and lifeless as anywhere else you've been.  A cool breeze suddenly brushes against your face, as if gracing you with its presence.  You turn towards it and are confronted by the lush foliage of a very old looking forest.  You smile as the plants look fairly familiar and non-threatening.  Unbidden, you remember your decision to test the properties of this place, and think of your campsite as you walk forward.  Reality seems to shift and blur, making you dizzy, but after a few minutes you're back, and sure you'll be able to return to the forest with similar speed.\n\n<b>You've discovered the Forest!</b>");
					player.exploredForest = 1;
					player.exploredForest++;
					doNext(camp.returnToCampUseOneHour);
					return;
				}
				if (player.exploredLake <= 0) {
					outputText("Your wanderings take you far and wide across the barren wasteland that surrounds the portal, until the smell of humidity and fresh water alerts you to the nearby lake.  With a few quick strides you find a lake so massive the distant shore cannot be seen.  Grass and a few sparse trees grow all around it.\n\n<b>You've discovered the Lake!</b>");
					player.exploredLake = 1;
					player.explored++;
					doNext(camp.returnToCampUseOneHour);
					return;
				}
				if (player.exploredLake >= 1 && rand(3) == 0 && player.exploredDesert <= 0) {
					outputText("You stumble as the ground shifts a bit underneath you.  Groaning in frustration, you straighten up and discover the rough feeling of sand ");
					if (player.lowerBody == LowerBody.HUMAN) outputText("inside your footwear, between your toes");
					if (player.lowerBody == LowerBody.HOOFED) outputText("in your hooves");
					if (player.lowerBody == LowerBody.DOG) outputText("in your paws");
					if (player.lowerBody == LowerBody.NAGA) outputText("in your scales");
					outputText(".\n\n<b>You've discovered the Desert!</b>");
					player.exploredDesert = 1;
					player.explored++;
					doNext(camp.returnToCampUseOneHour);
					return;
				}
				if (player.exploredDesert >= 1 && player.exploredMountain <= 0 && rand(3) == 0 && player.level >= 5) {
					outputText("Thunder booms overhead, shaking you out of your thoughts.  High above, dark clouds encircle a distant mountain peak.  You get an ominous feeling in your gut as you gaze up at it.\n\n<b>You've discovered the Mountain!</b>");
					player.explored++;
					player.exploredMountain = 1;
					doNext(camp.returnToCampUseOneHour);
					return;
				}
				if (player.exploredMountain >= 1 && flags[kFLAGS.TIMES_EXPLORED_PLAINS] <= 0 && rand(3) == 0 && player.level >= 9) {
					flags[kFLAGS.TIMES_EXPLORED_PLAINS] = 1;
					player.explored++;
					outputText("You find yourself standing in knee-high grass, surrounded by flat plains on all sides.  Though the mountain, forest, and lake are all visible from here, they seem quite distant.\n\n<b>You've discovered the plains!</b>");
					doNext(camp.returnToCampUseOneHour);
					return;
				}
				//EXPLOOOOOOORE
				if (flags[kFLAGS.TIMES_EXPLORED_SWAMP] <= 0 && flags[kFLAGS.TIMES_EXPLORED_PLAINS] > 0 && rand(3) <= 0 && player.level >= 13) {
					flags[kFLAGS.TIMES_EXPLORED_SWAMP] = 1;
					player.explored++;
					clearOutput();
					outputText("All things considered, you decide you wouldn't mind a change of scenery.  Gathering up your belongings, you begin a journey into the wasteland.  The journey begins in high spirits, and you whistle a little traveling tune to pass the time.  After an hour of wandering, however, your wanderlust begins to whittle away.  Another half-hour ticks by.  Fed up with the fruitless exploration, you're nearly about to head back to camp when a faint light flits across your vision.  Startled, you whirl about to take in three luminous will-o'-the-wisps, swirling around each other whimsically.  As you watch, the three ghostly lights begin to move off, and though the thought of a trap crosses your mind, you decide to follow.\n\n");
					outputText("Before long, you start to detect traces of change in the environment.  The most immediate difference is the increasingly sweltering heat.  A few minutes pass, then the will-o'-the-wisps plunge into the boundaries of a dark, murky, stagnant swamp; after a steadying breath you follow them into the bog.  Once within, however, the gaseous balls float off in different directions, causing you to lose track of them.  You sigh resignedly and retrace your steps, satisfied with your discovery.  Further exploration can wait.  For now, your camp is waiting.\n\n");
					outputText("<b>You've discovered the Swamp!</b>");
					doNext(camp.returnToCampUseTwoHours);
					return;
				}
				//Discover Blight Ridge
				if (flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE] <= 0 && flags[kFLAGS.TIMES_EXPLORED_SWAMP] > 0 && rand(3) == 0 && player.level >= 21) {
					flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE] = 1;
					player.explored++;
					clearOutput();
					outputText("You wander around the mountain area thinking over this whole ‘demonic’ realm affair.  You're not sure how widespread this entire thing is, everything seems to be isolated to certain areas, you've only really seen the demons in small groups or alone, and even then it's usually comprised of imps.  As far as you know it IS a demonic realm so there should be some area where demons live normally, they can't all be hold up in lethice's stronghold right?  You question whether or not the demons could even hold together a city long enough before 'water' damage ruined the place.");
					if (flags[kFLAGS.BAZAAR_ENTERED] > 0) outputText("  Then again you have been to that Bizarre Bazaar, they seem to exist there to an extent without any trouble...");
					outputText("  As you think the random topic over in your head you spy a path you've never noticed before.\n\n");
					outputText("Being the adventurous champion you are you start down the path, as you walk down this sketchy path, carved through a section of the mountain a ridge comes into view.  Walking onwards until you're at the ridge a somewhat would-be beautiful sight lies before you.\n\n");
					if (player.cor < 66) {
						outputText("That would be if it wasn't corrupted to all hell, the scent of sweat, milk and semen invade your nose as you peer across the corrupted glade.  And you thought that the main forest was bad.");
						if (flags[kFLAGS.MET_MARAE] >= 1) outputText("  Gods... If Marae could see this.");
						outputText("\n\n");
					}
					else if (player.cor >= 66) {
						outputText("And it is!  Lush fields of corrupted glades consume the land, giving the heavy scent of sweat, milk and semen as you take a deep breath.  Taking it all in and relishing in the corruption.  Truly this is how the world should be.");
						if (flags[kFLAGS.MET_MARAE] >= 1) outputText("  Heh, if Marae could see this she'd flip her shit.");
						outputText("\n\n");
					}
					outputText("<b>You've discovered the Blight Ridge!</b>");
					doNext(camp.returnToCampUseTwoHours);
					return;
				}				
				//Discover Beach / Ocean/ Deep Sea
				if (flags[kFLAGS.DISCOVERED_BEACH] <= 0 && flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE] > 0 && rand(3) == 0 && player.level >= 25) {
					flags[kFLAGS.DISCOVERED_BEACH] = 1;
					player.explored++;
					clearOutput();
					outputText("You hear seagulls in the distance and run on the grass to look what is beyond. There is a few dunes of sand with patch of grass that you eagerly cross over as you discover what you hoped to find.");
					outputText("\n\nFinally, after stepping over another dune, in the distance before you a shore of water spreads. Its surely way bigger than the lake you found some time ago. As far as you look to the side you can't see the shores end.  Mesmerized by the view you continue walking towards the ocean until you stand in the shallow water with waves passing by around your waist. Despite the corruption of Mareth this water turns out to be quite clear and who knows, maybe it’s not even that much tainted... yet. But that would probably require submerging deeper to check it out.\n\n<b>You've discovered the Beach, the Ocean and the Deep Sea!</b>");
					doNext(camp.returnToCampUseTwoHours);
					return;
				}
				//Discover Glacial Rift!
				if (flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] <= 0 && flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE] > 0 && rand(3) == 0 && player.level >= 25) {
					flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] = 1;
					player.explored++;
					clearOutput();
					outputText("You walk for some time, roaming the hard-packed and pink-tinged earth of the demon-realm of Mareth. As you progress, a cool breeze suddenly brushes your cheek, steadily increasing in intensity and power until your clothes are whipping around your body in a frenzy. Every gust of wind seems to steal away part of your strength, the cool breeze having transformed into a veritable arctic gale. You wrap your arms around yourself tightly, shivering fiercely despite yourself as the hard pink dirt slowly turns to white; soon you’re crunching through actual snow, thick enough to make you stumble with every other step. You come to a stop suddenly as the ground before you gives way to a grand ocean, many parts of it frozen in great crystal islands larger than any city.\n\n");
					outputText("<b>You've discovered the Glacial Rift!</b>");
					doNext(camp.returnToCampUseTwoHours);
					return;
				}
				//Discover Volcanic Crag!
				if (flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] <= 0 && flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] > 0 && rand(3) == 0 && player.level >= 25) {
					flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] = 1;
					player.explored++;
					clearOutput();
					outputText("You walk for some time, roaming the hard-packed and pink-tinged earth of the demon-realm of Mareth. As you progress, you can feel the air getting warm. It gets hotter as you progress until you finally stumble across a blackened landscape. You reward yourself with a sight of the endless series of a volcanic landscape. Crags dot the landscape.\n\n");
					outputText("<b>You've discovered the Volcanic Crag!</b>");
					doNext(camp.returnToCampUseTwoHours);
					return;
				}/*
				//Discover Abyss
				if (player.exploredMountain >= 1 && rand(3) == 0 && flags[kFLAGS.TIMES_EXPLORED_ABYSS] <= 0 && flags[CoC.instance.dungeons.checkFactoryClear()] > 0 && (player.level >= 10) {
					flags[kFLAGS.DISCOVERED_ABYSS] = 1;
					player.explored++;
					clearOutput();
					outputText("You walk \n\n");
					outputText("<b>You've discovered the Abyss!</b>");
					doNext(camp.returnToCampUseTwoHours);
					return;
				}
				//Discover Pit
				if (player.exploredAbyss >= 1 && rand(3) == 0 && flags[kFLAGS.TIMES_EXPLORED_PIT] <= 0 && (player.level >= 16) {
					flags[kFLAGS.DISCOVERED_PIT] = 1;
					player.explored++;
					clearOutput();
					outputText("You walk \n\n");
					outputText("<b>You've discovered the Pit!</b>");
					doNext(camp.returnToCampUseTwoHours);
					return;
				}
				*/
				//Used for chosing 'repeat' encounters.
				var choosey:Number = rand(6);
				//2 (gargoyle) is never chosen once cathedral is discovered.
				if(choosey == 2 && flags[kFLAGS.FOUND_CATHEDRAL] == 1)
				{
					choosey = rand(5);
					if(choosey >= 2) choosey++;
				}
				if (choosey == 3)
				{
					choosey = rand(5);
					if(choosey == 2) choosey += 2;
					if(choosey >= 3) choosey++;
				}
				//Chance of encountering Giacomo!
				if (choosey == 0) {
					player.explored++;
					SceneLib.giacomoShop.giacomoEncounter();
					return;
				}
				else if (choosey == 1) {
					player.explored++;
					if (flags[kFLAGS.LUMI_MET] == 0) SceneLib.lumi.lumiEncounter();
					else genericGolGobImpEncounters(true);
					return;
				}
				else if (choosey == 2) {
					player.explored++;
					if (flags[kFLAGS.GAR_NAME] == 0) SceneLib.gargoyle.gargoylesTheShowNowOnWBNetwork();
					else SceneLib.gargoyle.returnToCathedral();
					return;
				}
				else if (choosey == 3 && flags[kFLAGS.PRISON_CAPTURE_COUNTER] < 1 && rand(4) == 0) {
					player.explored++;
					clearOutput();
					outputText("Your curiosity draws you towards the smoke of a campfire on the edges of the forest. In the gloom ahead you see what appears to be a cage wagon surrounded by several tents, and hear the sounds of guttural voices engaged in boisterous conversation. Inexplicably you find yourself struck by an unwholesome sense of foreboding. <b>Even from here that cage looks like it is designed to carry people off to somewhere very unpleasant, some place where your life could be turned upside down and the rules you have become accustomed to in this world may no longer apply.</b> You take a long moment to consider turning back. Do you throw caution to the wind and investigate further?");
					//outputText("\n\n(<b>NOTE:</b> Prisoner mod is currently under development and not all scenes are available.)");
					doYesNo(SceneLib.prison.goDirectlyToPrisonDoNotPassGoDoNotCollect200Gems, camp.returnToCampUseOneHour);
					return;
				}
				//Monster - 50/50 imp/gob split.
				else {
					player.explored++;
					genericGolGobImpEncounters(true);
					return;
				}
			}
			player.explored++;
			doNext(camp.returnToCampUseOneHour);
		}

		public function pearldiscovery():void {
			flags[kFLAGS.SKY_POISON_PEARL] = 1;
			clearOutput();
			outputText("While exploring, you feel something is off.  Wary of meeting new things in this world after your previous experiences, you decide to cautiously locate the source of this feeling.  Soon the object comes into view and you can see that it is an ordinary looking pearl.  Knowing that it may be more then it looks to be you check the suroundings next to it for a while before deciding to touch it.  Nothing happens so since it somehow attracted your attention you pocket this pearl.\n\n");
			inventory.takeItem(consumables.SPPEARL, camp.returnToCampUseOneHour);
		}

		public function ryubifirstenc():void {
			flags[kFLAGS.RYUBI_LVL_UP] = 1;
			clearOutput();
			outputText("While exploring (rest is placeholder atm).\n\n");
			startCombat(new RyuBiDragon());
		}
		
		public function ryubirepenc():void {
			clearOutput();
			outputText("While exploring (rest is placeholder atm).\n\n");
			startCombat(new RyuBiDragon());
		}
		
		public function debugOptions():void
		{
			inventory.takeItem(consumables.W_FRUIT, playerMenu);
		}

		//Massive bodyparts scene
//[DESERT]
//[RANDOM SCENE IF CHARACTER HAS AT LEAST ONE COCK LARGER THAN THEIR HEIGHT,
//AND THE TOTAL COMBINED WIDTH OF ALL THEIR COCKS IS TWELVE INCHES OR GREATER]
		public function bigJunkDesertScene():void
		{
			clearOutput();
			var x:Number = player.longestCock();
			//PARAGRAPH 1
			outputText("Walking along the sandy dunes of the desert you find yourself increasingly impeded by the bulk of your " + cockDescript(x) + " dragging along the sandscape behind you.  The incredibly hot surface of the desert causes your loins to sweat heavily and fills them with relentless heat.");

			if (player.cocks.length == 1) outputText("  As it drags along the dunes, the sensation forces you to imagine the rough textured tongue of a monstrous animal sliding along the head of your " + Appearance.cockNoun(player.cocks[x].cockType) + ".");
			else if (player.cocks.length >= 2) outputText("  With all of your [cocks] dragging through the sands they begin feeling as if the rough textured tongues of " + num2Text(player.cockTotal()) + " different monstrous animals were slobbering over each one.");
			outputText("\n\n");

			//PARAGRAPH 2

			//FOR NON-CENTAURS]
			if (!player.isTaur()) {
				outputText("The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your [cocks], which forces your torso to the ground.  Normally your erection would merely raise itself skyward but your genitals have grown too large and heavy for your " + hipDescript() + " to hold them aloft.  Instead you feel your body forcibly pivoting at the hips until your torso is compelled to rest face down on top of your obscene [cocks].");

				//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
				if (player.biggestTitSize() >= 35)  outputText("  Your " + Appearance.allBreastsDescript(player) + " hang lewdly off your torso to rest on the desert sands, seeming to bury the dunes on either side of you.  Their immense weight anchors your body, further preventing your torso from lifting itself up.  The burning heat of the desert teases your " + nippleDescript(0) + "s mercilessly as they grind in the sand.");
				//IF CHARACTER HAS A BALLS ADD SENTENCE
				if (player.balls > 0) outputText("  Your " + player.skinTone + sackDescript() + " rests beneath your raised " + buttDescript() + ".  The fiery warmth of the desert caresses it, causing your [balls] to pulse with the need to release their sperm through your [cocks].");
				//IF CHARACTER HAS A VAGINA ADD SENTENCE
				if (player.vaginas.length >= 1) {
					outputText("  Your " + vaginaDescript() + " and " + clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the " + buttDescript() + " above.");
					//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
					if (player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_DROOLING) outputText("  Juices stream from your womanhood and begin pooling on the hot sand beneath you.  Wisps of steam rise up into the air only to tease your genitals further.  ");
				}
			}
			//FOR CENTAURS
			else {
				outputText("The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your [cocks], which forces the barrel of your horse-like torso to the ground.  Normally your erection would merely hover above the ground in between your centaurian legs, but your genitals have grown too large and heavy for your " + hipDescript() + " to hold them aloft.  Instead, you feel your body being forcibly pulled down at your hindquarters until you rest atop your [cocks].");
				//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
				if (player.biggestTitSize() >= 35)  outputText("  Your " + Appearance.allBreastsDescript(player) + " pull your human torso forward until it also is forced to rest facedown, just like your horse half.  Your tits rest, pinned on the desert sand to either side of you.  Their immense weight anchors you, further preventing any part of your equine body from lifting itself up.  The burning heat of the desert teases your " + nippleDescript(0) + "s incessantly.");
				//IF CHARACTER HAS A BALLS ADD SENTENCE
				if (player.balls > 0) outputText("  Your " + player.skinTone + sackDescript() + " rests beneath your raised " + buttDescript() + ".  The airy warmth of the desert teases it, causing your [balls] pulse with the need to release their sperm through your [cocks].");
				//IF CHARACTER HAS A VAGINA ADD SENTENCE
				if (player.vaginas.length >= 1) {
					outputText("  Your " + vaginaDescript() + " and " + clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the " + buttDescript() + " above.");
					//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
					if (player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_DROOLING) outputText("  The desert sun beats down on your body, its fiery heat inflaming the senses of your vaginal lips.  Juices stream from your womanhood and begin pooling on the hot sand beneath you.");
				}
			}
			outputText("\n\n");
			//PARAGRAPH 3
			outputText("You realize you are effectively trapped here by your own body.");
			//CORRUPTION BASED CHARACTER'S VIEW OF SITUATION
			if (player.cor < 33) outputText("  Panic slips into your heart as you realize that if any dangerous predator were to find you in this state, you'd be completely defenseless.  You must find a way to regain your mobility immediately!");
			else if (player.cor < 66) outputText("  You realize that if any dangerous predator were to find you in this state you'd be completely defenseless.  You must find a way to regain your mobility... yet there is a certain appeal to imagining how pleasurable it would be for a sexual predator to take advantage of your obscene body.");
			else outputText("  Your endowments have rendered you completely helpless should any predators find you.  Somewhere in your heart, you're exhilarated at the prospect.  The idea of being a helpless fucktoy for a wandering beast is unusually inviting to you.  Were it not for the thought that you might die of thirst in the desert, you'd be incredibly tempted to remain right where you are.");

			//SCENE END = IF CHARACTER HAS FULL WINGS ADD SENTENCE
			if (player.canFly()) outputText("  You extend your wings and flap as hard as you can, until at last you manage to lighten the bulk of your body somewhat - enough to allow yourself to drag your genitals across the hot sands and back to camp.  The ordeal takes nearly an hour.");
			//SCENE END IF CHARACTER HAS CENTAUR BODY
			else if (player.isTaur()) outputText("  You struggle and work your equine legs against the surface of the dune you are trapped on.  Your [feet] have consistent trouble finding footing, the soft sand failing to provide enough leverage to lift your bulk.  You breath in deeply and lean from side to side, trying to find some easier vertical leverage.  Eventually, with a crude crawl, your legs manage to push the bulk of your body onto more solid ground.  With great difficulty, you spend the next hour shuffling your genitals across the sandscape and back to camp.");
			//SCENE END = FOR ALL OTHER CHARACTERS
			else outputText("  You struggle and push with your [legs] as hard as you can, but it's no use.  You do the only thing you can and begin stroking your [cocks] with as much vigor as you can muster.  Eventually your body tenses and a light load of jizz erupts from your body, but the orgasm is truly mild compared to what you need.  You're simply too weary from struggling to give yourself the masturbation you truly need, but you continue to try.  Nearly an hour later " + sMultiCockDesc() + " softens enough to allow you to stand again, and you make your way back to camp, still dragging your genitals across the warm sand.");
			dynStats("lus", 25 + rand(player.cor / 5), "scale", false);
			fatigue(5);
			doNext(camp.returnToCampUseOneHour);
		}

	}
}
