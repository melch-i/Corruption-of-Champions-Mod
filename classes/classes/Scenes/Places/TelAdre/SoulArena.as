package classes.Scenes.Places.TelAdre
{
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Areas.Forest.TentacleBeast;
	import classes.Scenes.Areas.Mountain.HellHound;
	import classes.Scenes.Areas.Swamp.CorruptedDrider;
	import classes.Scenes.Dungeons.HiddenCave.BossGolems;
	import classes.Scenes.Monsters.DarkElfScout;
	import classes.Scenes.Monsters.GoblinAssassin;
	import classes.Scenes.Monsters.GolemsDummy;
	import classes.Scenes.Places.TelAdre.IgnisArenaSeerScene;
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
				outputText("\n\n\"<i>Greeting to the Soul Arena. Don't pick up fights outside of the proper place or you will be thrown out. If you break any rule here you will be kicked out. Knowing this go pick the area where you want to train or maybe go to the challenges area,</i>\" without wasting time the nekomata overseer of this place explains you all that is needed and walk away.");
				outputText("\n\nSo which one of the three possible sub areas you gonna visit this time?");
				if (flags[kFLAGS.IGNIS_ARENA_SEER] >= 1) outputText("\n\nYou notice Ignis sitting in the stands, a notebook in his paws. The kitsune seems to be watching the fights and taking notes as he does so.");
				if (flags[kFLAGS.CHI_CHI_AFFECTION] < 1) flags[kFLAGS.CHI_CHI_AFFECTION] = 0;
				menu();//statuseffect(soulArena) dodać na początku walk co pozwoli dać inne dropy itp. w stosuku do spotkania podobnego wroga w innym miejscu a nawet łatwo pozwoli zrobić wersje soulforce niektórych ras bez tworzenia nowych opisów monsterów - zrobić to dla trybu challenge, w który walka z wrogie da określony drop a nawet można na niej grać aby uzyskać nagro...np. nowego camp member ^^
				addButton(0, "Solo", soularenaSolo).hint("Go to the section of soul arena for 1 on 1 fights.");
				addButton(1, "Group", soularenaGroup).hint("Go to the section of soul arena for group fights.");
				addButton(2, "Challenge", soularenaChallenge).hint("Go to the section of soul arena for challenges. (Who knows what reward you may get after winning any of the challenges there...)");
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

		private function arenaSelection(mon:Class):void{
			player.createStatusEffect(StatusEffects.SoulArena, 0, 0, 0, 0);
			if (flags[kFLAGS.CHI_CHI_AFFECTION] < 10) flags[kFLAGS.CHI_CHI_AFFECTION]++;
			startCombat(new mon());
			monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
			monster.XP = Math.round(monster.XP / 2);
		}
		public function gaunletsinbetween():void {
			cleanupAfterCombat();
			player.createStatusEffect(StatusEffects.SoulArena, 0, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SoulArenaGaunlet, 0, 0, 0, 0);
		}
		//TODO @Oxdeception Replace this fight with a different monster?
		public function gaunletchallange1fight1():void {
			clearOutput();
			outputText("You register for the gauntlet challenge then when called, move out beyond the arena gate to face your opponent. The crowd is big, you sure will have quite the audience. A man with a necktie and a weird stick screams across the area.\n\n");
			outputText("\"<i>Ladies and gentlemen! Today a new gladiator enter the arena seeking glory of the gauntlet! A triple battle for gold and fame!</i>\"\n\n");
			outputText("The crowd cheers for you loudly.\n\n");
			outputText("\"<i>We start with an old timer everyone know about yet even if it is only the warm up do beware... the Dummy golems!!!</i>\"\n\n");
			outputText("A set of walking stone statues enter the arena, ready for battle. It seems you are to fight these first.\n\n");
			player.createStatusEffect(StatusEffects.SoulArena, 0, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SoulArenaGaunlet, 0, 0, 0, 0);
			if (flags[kFLAGS.CHI_CHI_AFFECTION] < 10) flags[kFLAGS.CHI_CHI_AFFECTION]++;
			startCombat(new GolemsDummy());
		}
		public function gaunletchallange1fight2():void {
			clearOutput();
			gaunletsinbetween();
			outputText("As the last of the golem falls down, the commentator resumes.\n\n");
			outputText("\"<i>This one is straight from the woods. Freshly caught and horny to boot. Can our champion’s strength overcome the beast’s lust? LET'S FIND OUT!!</i>\"\n\n");
			outputText("A shadow moves out behind the gate, revealing the shape of a fluid starved tentacle beast.\n\n");
			startCombat(new TentacleBeast());
		}
		public function gaunletchallange1fight3():void {
			clearOutput();
			gaunletsinbetween();
			outputText("As the tentacle beast whimpers and crawls away, the crowd cheers for you. Here comes the final round.\n\n");
			outputText("\"<i>This contestant is smaller than the last two... Smarter too, and most of all extremely deadly. She’s paid a handsome sack of gems daily to kick the ass of anyone who reach this stage, yet is by far the deadliest combatant of her division. She’s your favorite and an expert huntress. Here she comes... Merisiel the dark elf!!!</i>\"\n\n");
			outputText("A woman with dark skin walks by the entrance of the arena with only a bow for a weapon. She sure does look like an elf, however. She’s nothing like the gentle creature from your childhood stories as she observes you with a cruel, calculative gaze. The dark elf readies her bow, smirking.\n\n");
			startCombat(new DarkElfScout());
		}
		public function gaunletchallange1postfight():void {
			clearOutput();
			outputText("You exit the arena, victorious, basking in the cheering of the crowd and go to the prize counter for your reward. A woman greets you.\n\n");
			if (flags[kFLAGS.SOUL_ARENA_FINISHED_GAUNLETS] >= 1) {
				outputText("\"<i>Good show, champion. As a reward for your performance, please accept these 15 spirit stones. Please do come back again and maybe next time you could even try the harder challenge.</i>\"\n\n");
				flags[kFLAGS.SPIRIT_STONES] += 15;
				cleanupAfterCombat();
			}
			else {
				outputText("\"<i>Good show, champion. As a reward for your performance, please accept this magical bow. Please do come back again and maybe next time you could even try the harder challenge.</i>\"\n\n");
				flags[kFLAGS.SOUL_ARENA_FINISHED_GAUNLETS] = 1;
				inventory.takeItem(weaponsrange.BOWGUID, cleanupAfterCombat);
			}
		}
		public function gaunletchallange2fight1():void {
			clearOutput();
			outputText("As you enter the arena you spot your opponent at the other edge of the battlefield. It’s a goblin not unlike those you can meet in the wilderness, however she’s armed with a set of throwing knife and other gear you don’t see normally on those critters.\n\n");
			outputText("The voice of the announcer ring into the stadium.\n\n");
			outputText("\"<i>Ladies and gentlemans today someone challenged the second ranking gladiatorial test. Can this would be hero defeat all three opponent and earn not only a large sum of gems as well as the right to brag for a full month?! LET'S FIND OUT!</i>\"\n\n");
			outputText("The gates open and the goblin charge at you weapon at the ready.\n\n");
			player.createStatusEffect(StatusEffects.SoulArena, 0, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SoulArenaGaunlet, 0, 0, 0, 0);
			if (flags[kFLAGS.CHI_CHI_AFFECTION] < 10) flags[kFLAGS.CHI_CHI_AFFECTION]++;
			startCombat(new GoblinAssassin());
		}
		public function gaunletchallange2fight2():void {
			clearOutput();
			gaunletsinbetween();
			outputText("As the goblin falls unconscious to the ground the crowd cheer for you.\n\n");
			outputText("\"<i>It would seems the hero squashed that midget good but were only beginning. If I may the next contestant has been sex starved for two consecutive month and is desperate to sow his seed hence now we release... THE HOUND!!!</i>\"\n\n");
			outputText("A massive hellhound of proportion larger than normal rush out of an opening gate. Its eye burns with lust.\n\n");
			startCombat(new HellHound());
		}
		public function gaunletchallange2fight3():void {
			clearOutput();
			gaunletsinbetween();
			outputText("The mutt fall defeated to the floor as the crowd scream your name. The announcer announce the next contestant.\n\n");
			outputText("\"<i>The next opponent is a fighter known and loved by the public. You have heard her name told in shallow whispers for the next opponent is an expert of the terrible art known as BDSM. Yes you have all been waiting for her so cheer up for Malady the drider!!!</i>\"\n\n");
			outputText("A drider in bondage suit comes out of the gate and eyes you amused.\n\n");
			outputText("\"<i>You are my opponent uh? Doesn’t look like much. Little pet, by the time I’m done binding you, you will seldom call me mistress!</i>\"\n\n");
			startCombat(new CorruptedDrider());
		}
		//todo @Oxdeception replace this fight
		public function gaunletchallange2fight4():void {
			clearOutput();
			gaunletsinbetween();
			outputText("As the drider falls defeated the crowd cheer to your victory. That said the battle is far from over yet. A large amount of shadows mass behind the opposite gate and already you can guess what's coming up for you.\n\n");
			outputText("\"<i>The final contestant is both a new opponent and a test! The town golemancer has been working extra shifts on these thing she calls her babies!! Using the traditional gargoyle model but deprived of soul so for the purpose of mass production these living weapons will mercilessly beat the hell out of the contestant. Who do you think will win the living or the artificial creation? LEEEEETS FIND OUT!!!!!!</i>\"\n\n");
			outputText("A full squad of stone gargoyle pour out of the gate their mace like tail trailing in the sands. Their claws are sharp and their soulless gaze tells you it will end poorly should you lose.\n\n");
			startCombat(new BossGolems());
		}
		public function gaunletchallange2postfight():void {
			clearOutput();
			outputText("The last gargoyle crumble to rubble and you hold its head up toward the public in victory.\n\n");
			outputText("\"<i>The challenger defeated all of his opponent what a miracle! Challenger you may now exit the arena and claim your prize, well done!</i>\"\n\n");
			outputText("You make your way toward the exit and to your surprise meet face to face with the town golemancer. She grudgingly handle you your reward.\n\n");
			outputText("\"<i>I’m supposed to reward you ");
			if (flags[kFLAGS.SOUL_ARENA_FINISHED_GAUNLETS] >= 2) {
				outputText("a full chest of soulstone. Tsk I guess my golems were not ready yet. Next time if you do show up be ready because my future creation will definitely make a bloody mess out of you.</i>\"\n\n");
				flags[kFLAGS.SPIRIT_STONES] += 20;
				cleanupAfterCombat();
			}
			else {
				outputText("with this scepter. Tsk I guess my golems were not ready yet. Next time if you do show up be ready because my future creation will definitely make a bloody mess out of you.</i>\"\n\n");
				flags[kFLAGS.SOUL_ARENA_FINISHED_GAUNLETS] = 2;
				inventory.takeItem(weapons.SCECOMM, cleanupAfterCombat);
			}
		}
	}
}
