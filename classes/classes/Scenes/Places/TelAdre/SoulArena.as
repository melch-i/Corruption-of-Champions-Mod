package classes.Scenes.Places.TelAdre
{

	import classes.GlobalFlags.kFLAGS;
	import classes.Monster;
	import classes.Scenes.Areas.Desert.Naga;
	import classes.Scenes.Areas.Forest.TentacleBeast;
	import classes.Scenes.Areas.GlacialRift.Valkyrie;
	import classes.Scenes.Areas.Mountain.HellHound;
	import classes.Scenes.Areas.Swamp.CorruptedDrider;
	import classes.Scenes.Areas.Swamp.MaleSpiderMorph;
	import classes.Scenes.Monsters.DarkElfScout;
	import classes.Scenes.Monsters.GoblinAssassin;
	import classes.Scenes.Monsters.Imp;
	import classes.Scenes.SceneLib;
	import classes.StatusEffects;

	public class SoulArena extends TelAdreAbstractContent
	{

		private var ignisarenaseer:IgnisArenaSeerScene = new IgnisArenaSeerScene();

		public function SoulArena()
		{
		}

		public function soularena():void {
			clearOutput();//arena do walk z przeciwnikami na exp tylko - zadnych sex scenes tylko walk do wygranej niewazne czy przez hp czy lust - przeciwnicy: dummy golem, grupa dummy golems, true golem, ?group of true golems, weak deviant golem?, niskopoziomowi przeciwnicy uzywajacy soul skills (moze po prostu wesje zwyklych przeciwnikow ale z dodanymi soul attakami?)
			if (flags[kFLAGS.CHI_CHI_AFFECTION] >= 10 && flags[kFLAGS.CHI_CHI_AFFECTION] < 15) SceneLib.chichiScene.EnterOfTheChiChi();
			else {
				outputText("Coming closer to the arena you see two muscular tigersharks standing on each side of the entrance, which only briefly glance at you the moment you pass by them. Inside after few a moment a tall slightly muscular male cat-morph approaches you. Most of its body is covered by armor yet two long tails waves behind him from time to time.");//osoba zarządzająca areną bedzie male nekomanta npc
				outputText("\n\n\"<i>Greeting to the Arena. Don't pick up fights outside of the proper place or you will be thrown out. If you break any rule here you will be kicked out. Knowing this go pick the area where you want to train or maybe go to the challenges area,</i>\" without wasting time the nekomata overseer of this place explains you all that is needed and walk away.");
				outputText("\n\nSo which one of the three possible sub areas you gonna visit this time?");
				if (flags[kFLAGS.IGNIS_ARENA_SEER] >= 1) outputText("\n\nYou notice Ignis sitting in the stands, a notebook in his paws. The kitsune seems to be watching the fights and taking notes as he does so.");
				if (flags[kFLAGS.CHI_CHI_AFFECTION] < 1) flags[kFLAGS.CHI_CHI_AFFECTION] = 0;
				menu();
				addButton(0, "Solo", soularenaSolo).hint("Go to the section of the arena for 1 on 1 fights.");
				// addButton(1, "Group", soularenaGroup).hint("Go to the section of the arena for group fights.");
				addButton(2, "Challenge", soularenaChallenge).hint("Go to the section of the arena for challenges. (Who knows what reward you may get after winning any of the challenges there...)");
				if (flags[kFLAGS.IGNIS_ARENA_SEER] >= 1) addButton(10, "Ignis", ignisarenaseer.mainIgnisMenu);
				addButton(14, "Back", telAdre.telAdreMenu);
				statScreenRefresh();
			}
		}

		//FIXME @Oxdeception need more combatants.
		public function soularenaSolo():void {
			clearOutput();
			outputText("Picking the one on the left prepared for solo fight you enter there and looking around checking who is currently avialable for sparring session.");
			menu();
			addButton(0,"Imp", arenaSelection, Imp);
			addButton(1,"Tentacle Beast", arenaSelection, TentacleBeast);
			addButton(2, "Spider Morph", arenaSelection, MaleSpiderMorph);
			addButton(3, "Naga", arenaSelection, Naga);
			addButton(4, "Valkyrie", arenaSelection, Valkyrie);
			addButton(14, "Back", soularena);
		}
		public function soularenaGroup():void {
			clearOutput();
			outputText("Picking the one on the right prepared for group fight you enter there and looking around checking who is currently avialable for sparring session.");
			menu();
			addButton(14, "Back", soularena);
		}
		public function soularenaChallenge():void {
			clearOutput();
			outputText("Picking the one in the middle prepared for challanges you enter there and looking around checking who if there is currently anyone up for a challange.");
			menu();
			addButton(0, "Gaunlet 1", gaunletchallange1fight1).hint("Fight 3 diff enemies one after another.");
			if (flags[kFLAGS.SOUL_ARENA_FINISHED_GAUNLETS] == 1) addButton(1, "Gaunlet 2", gaunletchallange2fight1).hint("Fight 4 diff enemies one after another.");
			addButton(14, "Back", soularena);
		}

		private function arenaSelection(mon:Class, onVictoryNext:Function = null):void{
			if (flags[kFLAGS.CHI_CHI_AFFECTION] < 10) flags[kFLAGS.CHI_CHI_AFFECTION]++;

			var monster:Monster = new mon();
			monster.onWon = onMonsterWon;
			monster.onDefeated = onMonsterDefeated;
			monster.onPcRunAttempt = onPCRunAttempt;

			if(onVictoryNext == null){
				clearOutput();
				outputText("The roar of the crowd gets your blood boiling, it fills you unwavering determination, as you enter the middle of the arena, you call out for your challenge. In comes "+monster.a+" " +monster.short+" and you both get into a battle stance.");
			}

			startCombat(monster);

			monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
			monster.XP = Math.round(monster.XP / 2);

			function onMonsterWon(hpVictory:Boolean, pcCameWorms:Boolean):void {
				clearOutput();
				if(hpVictory) {
					outputText("As your enemies hit knocks the wind out of you, the cheers of the crowd and the victory roar of your enemy is the last thing you hear before you fall unconscious...");
				} else {
					outputText("The roar of the crowd is drowned out by the blood rushing down to your loins, you drop to your knees unable to continue fighting as your enemy rallies the crowd.");
				}
				SceneLib.combat.inCombat = false;
				player.clearStatuses(false);
				player.HP = player.maxHP();
				player.lust = player.minLust();
				outputText("\n\nYou wake later in the infirmary before returning to camp.");
				doNext(camp.returnToCampUseOneHour);
			}
			function onMonsterDefeated(hpVictory:Boolean):void {
				if(onVictoryNext != null){
					player.XP += monster.XP;
					onVictoryNext();
					return;
				}
				clearOutput();
				if (hpVictory) {
					outputText("With a final blow, your enemy lowers [monster hisher] [monster weapon], kneeling in defeat before you and the crowd.\nYou won.");
				} else {
					outputText("The smirk on your face is evident to the entire crowd, jeering on as your enemy falls to their more primal instincts, collapsing and masturbating feverishly.");
				}
				player.clearStatuses(false);
				combat.awardPlayer(soularena)
			}
			function onPCRunAttempt():void {
				clearOutput();
				outputText("You’re unable to continue fighting, your spirit is broken for now and the sound of the crowd’s boos flood your ears as you lower your weapon and turn back towards the gate.");
				SceneLib.combat.inCombat = false;
				player.clearStatuses(false);
				doNext(soularena);
			}
		}

		public function gaunletchallange1fight1():void {
			clearOutput();
			outputText(
					"You walk to the sandy center of the Tel’Adre Arena. The city folks are watching you with keen interest likely trying to figure if you will succeed or fail. An announcer using some kind of magical device address the audience.\n\n" +
					"\"<i>Ladies and gentlemens welcome to the Arena! Today a new combatant has decided to attempt the gauntlet trials and defeat four consecutive opponents. I present you [name] champion of Ignam!</i>\"\n\n" +
					"The crowd is agitated now the show is about to begin.\n\n" +
					"\"<i>Ah but a contestant is nothing without the trial. You all love him, and he hates you all in return. This pit dog only lives to beat the crap out of our new would-be gladiator. His name…. BRUTUS!</i>\"\n\n" +
					"A massive dog morph with the face of a pitbull enters the arena. He holds in his hand a chain linked to a spiked ball he pulls around like an anchor, leaving a deep trail in the arena sand. Your opponent examines you and starts to growl, lifting the steel ball like a kids toy."
			);
			arenaSelection(ArenaBrutus, gaunletchallange1fight2);
		}
		public function gaunletchallange1fight2():void {
			clearOutput();
			outputText("The dog morphs defeated, falls over and is escorted out of the arena by a pair of healers. That said the fights are only beginning as the announcer’s voice rings out again.\n\n");
			outputText("\"<i>This one is straight from the woods. Freshly caught and horny to boot. Can our champion’s strength overcome the beast’s lust? LET'S FIND OUT!!</i>\"\n\n");
			outputText("A shadow moves out behind the gate, revealing the shape of a fluid starved tentacle beast.\n\n");
			arenaSelection(TentacleBeast, gaunletchallange1fight3);
		}
		public function gaunletchallange1fight3():void {
			clearOutput();
			outputText("As the tentacle beast whimpers and crawls away, the crowd cheers for you. Here comes the final round.\n\n");
			outputText("\"<i>This contestant is smaller than the last two... Smarter too, and most of all extremely deadly. She’s paid a handsome sack of gems daily to kick the ass of anyone who reach this stage, yet is by far the deadliest combatant of her division. She’s your favorite and an expert huntress. Here she comes... Merisiel the dark elf!!!</i>\"\n\n");
			outputText("A woman with dark skin walks by the entrance of the arena with only a bow for a weapon. She sure does look like an elf, however. She’s nothing like the gentle creature from your childhood stories as she observes you with a cruel, calculative gaze. The dark elf readies her bow, smirking.\n\n");
			arenaSelection(DarkElfScout, gaunletchallange1postfight);
		}
		public function gaunletchallange1postfight():void {
			clearOutput();
			outputText("You exit the arena, victorious, basking in the cheering of the crowd and go to the prize counter for your reward. A woman greets you.\n\n");
			if (flags[kFLAGS.SOUL_ARENA_FINISHED_GAUNLETS] >= 1) {
				outputText("\"<i>Good show, champion. As a reward for your performance, please accept these 75 gems. Please do come back again and maybe next time you could even try the harder challenge.</i>\"\n\n");
				player.gems += 75;
				cleanupAfterCombat();
			}
			else {
				outputText("\"<i>Good show, champion. As a reward for your performance, please accept this magical bow. Please do come back again and maybe next time you could even try the harder challenge.</i>\"\n\n");
				flags[kFLAGS.SOUL_ARENA_FINISHED_GAUNLETS] = 1;
				inventory.takeItem(weaponsrange.BOWGUID, cleanupAfterCombat);
				if(flags[kFLAGS.CHI_CHI_AFFECTION] < 10){
					flags[kFLAGS.CHI_CHI_AFFECTION] = 10;
				}
			}
		}
		public function gaunletchallange2fight1():void {
			clearOutput();
			outputText("As you enter the arena you spot your opponent at the other edge of the battlefield. It’s a goblin not unlike those you can meet in the wilderness, however she’s armed with a set of throwing knife and other gear you don’t see normally on those critters.\n\n");
			outputText("The voice of the announcer ring into the stadium.\n\n");
			outputText("\"<i>Ladies and gentlemans today someone challenged the second ranking gladiatorial test. Can this would be hero defeat all three opponent and earn not only a large sum of gems as well as the right to brag for a full month?! LET'S FIND OUT!</i>\"\n\n");
			outputText("The gates open and the goblin charge at you weapon at the ready.\n\n");
			arenaSelection(GoblinAssassin,gaunletchallange2fight2);
		}
		public function gaunletchallange2fight2():void {
			clearOutput();
			outputText("As the goblin falls unconscious to the ground the crowd cheer for you.\n\n");
			outputText("\"<i>It would seems the hero squashed that midget good but were only beginning. If I may the next contestant has been sex starved for two consecutive month and is desperate to sow his seed hence now we release... THE HOUND!!!</i>\"\n\n");
			outputText("A massive hellhound of proportion larger than normal rush out of an opening gate. Its eye burns with lust.\n\n");
			arenaSelection(HellHound,gaunletchallange2fight3);
		}
		public function gaunletchallange2fight3():void {
			clearOutput();
			outputText("The mutt fall defeated to the floor as the crowd scream your name. The announcer announce the next contestant.\n\n");
			outputText("\"<i>The next opponent is a fighter known and loved by the public. You have heard her name told in shallow whispers for the next opponent is an expert of the terrible art known as BDSM. Yes you have all been waiting for her so cheer up for Malady the drider!!!</i>\"\n\n");
			outputText("A drider in bondage suit comes out of the gate and eyes you amused.\n\n");
			outputText("\"<i>You are my opponent uh? Doesn’t look like much. Little pet, by the time I’m done binding you, you will seldom call me mistress!</i>\"\n\n");
			arenaSelection(CorruptedDrider,gaunletchallange2fight4);
		}

		public function gaunletchallange2fight4():void {
			var raphMet:Boolean = flags[kFLAGS.RAPHAEL_MET] == 1;
			clearOutput();
			outputText(
					"Your opponent is defeated, the arena cheers for you as the announcer resumes his speech.\n\n"+
					"\"<i>Magnificent!!! The Champion of Ignam managed to obtain victory again! However, one final opponent remains! A man shrouded in mystery that is on everyone lips whenever this tournament is initiated. His true name, no one knows, for he is… The Red Avenger!!</i>\"\n\n" +
					"A sleek, agile figure with a red fox mask moves past the arena gate. He wields a rapier and what could be called clothes with no armor. Whoever wears such low protection is either a fool or a dangerous opponent."
			);
			if (raphMet){
				outputText(" Wait, you know him... That fox morph is Raphael! How did the russet rogue manage to enter the arena undetected by the guards?! Raphael addresses you as well, recognising you the moment he’s within reach.")
			}
			outputText(
					"\"<i>I did not expect to meet you here, senior[if(isfemale)ita]. I go to this place to relax and keep my style sharp. That said, the people paid for this show so I shall not disappoint.[if(isfemale) Such a shame that my opponent has to be you [name], the arena sadly is no place for a lady, so I would ask your pardon for what I am going to do.]</i>\""
			);
			if(raphMet){
				outputText("You never expected you would have to fight with your teacher someday, but so be it. ");
			}
			outputText("The fox makes a duel bow, and gets into a fighting stance.");
			arenaSelection(ArenaRaphael,gaunletchallange2postfight);
		}
		public function gaunletchallange2postfight():void {
			var raphMet:Boolean = flags[kFLAGS.RAPHAEL_MET] == 1;
			clearOutput();
			outputText(
					(raphMet? "The Red Avenger ":"Raphael ") + "bows down in defeat.\n\n" +
					"\"<i>Well played senior[if(isfemale)ita], I am outmatched. I will be leaving the arena now."
			);
			if(flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] == -2 && SceneLib.raphael.RaphaelLikes()){
				outputText(" Hope we meet again, you know where to find me.")
			}
			outputText(
					"</i>\"\n\n" +
					"As the fox leaves the arena, the crowd cheers for you as the announcer declares your victory. You head back to the main lobby to claim your prize which awaits you in the form of a chest filled with gems."
			);
			if (flags[kFLAGS.SOUL_ARENA_FINISHED_GAUNLETS] > 2) {
				flags[kFLAGS.SOUL_ARENA_FINISHED_GAUNLETS] = 2
			}
			player.gems += 200;
			cleanupAfterCombat();
		}
	}
}
