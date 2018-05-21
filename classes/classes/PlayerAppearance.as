﻿package classes {
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Beard;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.NPCs.JojoScene;

import coc.xxc.BoundStory;
import coc.xxc.Story;

public class PlayerAppearance extends BaseContent {


	public function PlayerAppearance() {
		onGameInit(init);
	}
	private var story:BoundStory;
	private function init():void {
        story = new Story("story", CoC.instance.rootStory, "appearance").bind(CoC.instance.context);
    }
	public function appearance():void {
        //Temp vars
		var temp:Number  = 0;
		var rando:Number = 0;
		//Determine race type:

		clearOutput();
		outputText("<font size=\"36\" face=\"Georgia\"><u>Appearance</u></font>\n");
		if (CoC.instance.gameSettings.charviewEnabled) {
			mainViewManager.showPlayerDoll(debug);
		}
		describeRace();
		describeGear();
		describeFaceShape();
		outputText("  It has " + player.faceDesc() + "."); //M/F stuff!
		describeEyes();
		describeHairAndEars();
		describeBeard();
		describeTongue();
		describeHorns();
		outputText("[pg]");
		describeBodyShape();
		describeWings();
		describeRearBody();
		describeArms();
		describeLowerBody();

		outputText("\n");
	if (player.hasStatusEffect(StatusEffects.GooStuffed))

	{
		outputText("\n<b>Your gravid-looking belly is absolutely stuffed full of goo. There's no way you can get pregnant like this, but at the same time, you look like some fat-bellied breeder.</b>\n");
	}
	//Pregnancy Shiiiiiitz
	if((player.buttPregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL) || (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR) || player.isPregnant())
	{
		if (player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS)
		{
			outputText("<b>");
			//Compute size
			temp = player.statusEffectv3(StatusEffects.Eggs) + player.statusEffectv2(StatusEffects.Eggs) * 10;
			if(player.pregnancyIncubation <= 50 && player.pregnancyIncubation > 20)
			{
				outputText("Your swollen pregnant belly is as large as a ");
				if(temp < 10)
					outputText("basketball.");
				if(temp >= 10 && temp < 20)
					outputText("watermelon.");
				if(temp >= 20)
					outputText("beach ball.");
			}
			if(player.pregnancyIncubation <= 20)
			{
				outputText("Your swollen pregnant belly is as large as a ");
				if(temp < 10)
					outputText("watermelon.");
				if(temp >= 10 && temp < 20)
					outputText("beach ball.");
				if(temp >= 20)
					outputText("large medicine ball.");
			}
			outputText("</b>");
			temp = 0;
		}
		//Satur preggos - only shows if bigger than regular pregnancy or not pregnancy
		else if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR && player.buttPregnancyIncubation > player.pregnancyIncubation)
		{
			if(player.buttPregnancyIncubation < 125 && player.buttPregnancyIncubation >= 75)
			{
				outputText("<b>You've got the beginnings of a small pot-belly.</b>");
			}
			else if(player.buttPregnancyIncubation >= 50)
			{
				outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy, yet it feels odd inside you - wrong somehow.</b>");
			}
			else if(player.buttPregnancyIncubation >= 30)
			{
				outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>");
			}
			else
			{ //Surely Benoit and Cotton deserve their place in this list
				if (player.pregnancyType == PregnancyStore.PREGNANCY_IZMA || player.pregnancyType == PregnancyStore.PREGNANCY_MOUSE || player.pregnancyType == PregnancyStore.PREGNANCY_AMILY || (player.pregnancyType == PregnancyStore.PREGNANCY_JOJO && (JojoScene.monk <= 0 || flags[kFLAGS.JOJO_BIMBO_STATE] >= 3)) || player.pregnancyType == PregnancyStore.PREGNANCY_EMBER || player.pregnancyType == PregnancyStore.PREGNANCY_BENOIT || player.pregnancyType == PregnancyStore.PREGNANCY_COTTON || player.pregnancyType == PregnancyStore.PREGNANCY_URTA || player.pregnancyType == PregnancyStore.PREGNANCY_BEHEMOTH)
					outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>");
				else if(player.pregnancyType != PregnancyStore.PREGNANCY_MARBLE)
					outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the unclean spawn of some monster or beast.</b>");
				else outputText("\n<b>Your belly protrudes unnaturally far forward, bulging outwards with Marble's precious child.</b>");
			}
		}
		//URTA PREG
		else if (player.pregnancyType == PregnancyStore.PREGNANCY_URTA)
		{
			if(player.pregnancyIncubation <= 432 && player.pregnancyIncubation > 360)
			{
				outputText("<b>Your belly is larger than it used to be.</b>\n");
			}
			if(player.pregnancyIncubation <= 360 && player.pregnancyIncubation > 288)
			{
				outputText("<b>Your belly is more noticeably distended.   You're pretty sure it's Urta's.</b>");
			}
			if(player.pregnancyIncubation <= 288 && player.pregnancyIncubation > 216)
			{
				outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy, and the baby within is kicking nowadays.</b>");
			}
			if(player.pregnancyIncubation <= 216 && player.pregnancyIncubation > 144)
			{
				outputText("<b>Your belly is large and very obviously pregnant to anyone who looks at you.  It's gotten heavy enough to be a pain to carry around all the time.</b>");
			}
			if(player.pregnancyIncubation <= 144 && player.pregnancyIncubation > 72)
			{
				outputText("<b>It would be impossible to conceal your growing pregnancy from anyone who glanced your way.  It's large and round, frequently moving.</b>");
			}
			if(player.pregnancyIncubation <= 72 && player.pregnancyIncubation > 48)
			{
				outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>");
			}
			if(player.pregnancyIncubation <= 48)
			{
				outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>");
			}
		}
		else if (player.buttPregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL)
		{
			if(player.buttPregnancyIncubation >= 8)
				outputText("<b>Your stomach is so full of frog eggs that you look about to birth at any moment, your belly wobbling and shaking with every step you take, packed with frog ovum.</b>");
			else outputText("<b>You're stuffed so full with eggs that your belly looks obscenely distended, huge and weighted with the gargantuan eggs crowding your gut. They make your gait a waddle and your gravid tummy wobble obscenely.</b>");
		}
		else if (player.pregnancyType == PregnancyStore.PREGNANCY_FAERIE) { //Belly size remains constant throughout the pregnancy
			outputText("<b>Your belly remains swollen like a watermelon. ");
			if (player.pregnancyIncubation <= 100)
				outputText("It's full of liquid, though unlike a normal pregnancy the passenger you’re carrying is tiny.</b>");
			else if (player.pregnancyIncubation <= 140)
				outputText("It feels like it’s full of thick syrup or jelly.</b>");
			else outputText("It still feels like there’s a solid ball inside your womb.</b>");
		}
		else
		{
			if(player.pregnancyIncubation <= 336 && player.pregnancyIncubation > 280)
			{
				outputText("<b>Your belly is larger than it used to be.</b>");
			}
			if(player.pregnancyIncubation <= 280 && player.pregnancyIncubation > 216)
			{
				outputText("<b>Your belly is more noticeably distended.   You are probably pregnant.</b>");
			}
			if(player.pregnancyIncubation <= 216 && player.pregnancyIncubation > 180)
			{
				outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy.</b>");
			}
			if(player.pregnancyIncubation <= 180 && player.pregnancyIncubation > 120)
			{
				outputText("<b>Your belly is very obviously pregnant to anyone who looks at you.</b>");
			}
			if(player.pregnancyIncubation <= 120 && player.pregnancyIncubation > 72)
			{
				outputText("<b>It would be impossible to conceal your growing pregnancy from anyone who glanced your way.</b>");
			}
			if(player.pregnancyIncubation <= 72 && player.pregnancyIncubation > 48)
			{
				outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>");
			}
			if (player.pregnancyIncubation <= 48)
			{ //Surely Benoit and Cotton deserve their place in this list
				if(player.pregnancyType == PregnancyStore.PREGNANCY_IZMA || player.pregnancyType == PregnancyStore.PREGNANCY_MOUSE || player.pregnancyType == PregnancyStore.PREGNANCY_AMILY || (player.pregnancyType == PregnancyStore.PREGNANCY_JOJO && JojoScene.monk <= 0) || player.pregnancyType == PregnancyStore.PREGNANCY_EMBER || player.pregnancyType == PregnancyStore.PREGNANCY_BENOIT || player.pregnancyType == PregnancyStore.PREGNANCY_COTTON || player.pregnancyType == PregnancyStore.PREGNANCY_URTA || player.pregnancyType == PregnancyStore.PREGNANCY_MINERVA || player.pregnancyType == PregnancyStore.PREGNANCY_BEHEMOTH)
					outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>");
				else if (player.pregnancyType != PregnancyStore.PREGNANCY_MARBLE)
					outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the unclean spawn of some monster or beast.</b>");
				else outputText("\n<b>Your belly protrudes unnaturally far forward, bulging outwards with Marble's precious child.</b>");
			}
		}
		outputText("\n");
	}
	outputText("\n");
	if(player.gills.type == Gills.ANEMONE)
		outputText("A pair of feathery gills are growing out just below your neck, spreading out horizontally and draping down your chest.  They allow you to stay in the water for quite a long time.  ");
	//Chesticles..I mean bewbz.
	if(player.breastRows.length == 1)
	{
		outputText("You have " + num2Text(player.breastRows[temp].breasts) + " " + breastDescript(temp) + ", each supporting ");
		outputText(num2Text(player.breastRows[temp].nipplesPerBreast) + " "); //Number of nipples.
		outputText(Measurements.shortSuffix(int(player.nippleLength *10)/10)+" ");
		//if (flags[kFLAGS.USE_METRICS] > 0 ) outputText(int(player.nippleLength * 2.54 * 10) / 10 + "-cm "); //Centimeter display
		//else outputText(int(player.nippleLength * 10) / 10 + "-inch "); //Inches display
		outputText(nippleDescript(temp) + (player.breastRows[0].nipplesPerBreast == 1 ? "." : "s.")); //Nipple description and plural
		if(player.breastRows[0].milkFullness > 75)
			outputText("  Your " + breastDescript(temp) + " are painful and sensitive from being so stuffed with milk.  You should release the pressure soon.");
		if(player.breastRows[0].breastRating >= 1)
			outputText("  You could easily fill a " + player.breastCup(temp) + " bra.");
		//Done with tits.  Move on.
		outputText("\n");
	}
	//many rows
	else
	{
		outputText("You have " + num2Text(player.breastRows.length) + " rows of breasts, the topmost pair starting at your chest.\n");
		while (temp < player.breastRows.length)
		{
			if(temp == 0)
				outputText("--Your uppermost rack houses ");
			if(temp == 1)
				outputText("\n--The second row holds ");
			if(temp == 2)
				outputText("\n--Your third row of breasts contains ");
			if(temp == 3)
				outputText("\n--Your fourth set of tits cradles ");
			if(temp == 4)
				outputText("\n--Your fifth and final mammary grouping swells with ");
			outputText(num2Text(player.breastRows[temp].breasts) + " " + breastDescript(temp) + " with ");
			outputText(num2Text(player.breastRows[temp].nipplesPerBreast) + " "); //Number of nipples per breast
			outputText(Measurements.shortSuffix(int(player.nippleLength*10)/10));
			//if (flags[kFLAGS.USE_METRICS] > 0 ) outputText(int(player.nippleLength * 2.54 * 10) / 10 + "-cm "); //Centimeter
			//else outputText(int(player.nippleLength * 10) / 10 + "-inch "); //Inches
			outputText(nippleDescript(temp) + (player.breastRows[0].nipplesPerBreast == 1 ? " each." : "s each.")); //Description and Plural
			if(player.breastRows[temp].breastRating >= 1)
				outputText("  They could easily fill a " + player.breastCup(temp) + " bra.");
			if(player.breastRows[temp].milkFullness > 75)
				outputText("  Your " + breastDescript(temp) + " are painful and sensitive from being so stuffed with milk.  You should release the pressure soon.");
			temp++;
		}
		//Done with tits.  Move on.
		outputText("\n");
	}
	//Crotchial stuff - mention snake
	if(player.lowerBody == LowerBody.NAGA && player.gender > 0)
	{
		outputText("\nYour sex");
		if(player.gender == 3 || player.cockTotal() > 1)
			outputText("es are ");
		else outputText(" is ");
		outputText("concealed within a cavity in your tail when not in use, though when the need arises, you can part your concealing slit and reveal your true self.\n");
	}
	//Crotchial stuff - mention scylla
	if(player.lowerBody == LowerBody.SCYLLA)
	{
		if(player.gender == 1)
		{
			outputText("\nYour sex is concealed between your front octopus tentacle legs dangling freely when not in use.\n");
		}
		if(player.gender == 2)
		{
			outputText("\nYour sex is concealed underneath your octopus tentacle legs when not in use, though when the need arises, you can rise some of the tentacles and reveal your true self.\n");
		}
		if(player.gender == 3)
		{
			outputText("\nYour sex");
			if(player.cockTotal() > 1)
				outputText("es are ");
			else outputText(" is ");
			outputText("concealed between your front octopus tentacle legs dangling freely. Other set is concealed underneath your octopus tentacle legs when not in use, though when the need arises, you can rise some of the tentacles and reveal it.\n");
		}
	}
	//Cock stuff!
	temp       = 0;
	var cock:* = player.cocks[temp];
	if(player.cocks.length == 1)
	{
		if(player.isTaur())
			outputText("\nYour equipment has shifted to lie between your hind legs, like a feral animal.");
		if (player.isScylla())
			outputText("\nYour equipment has shifted to lie between your front tentacles.");
		if (player.isAlraune())
			outputText("\nYour equipment has shifted to lie below your pitcher now in the form of a mass of tentacle vine.");
		outputText("\nYour " + cockDescript(temp) + " is " + Measurements.inchesOrCentimetres(int(10*cock.cockLength)/10) + " long and ");

        outputText(Measurements.inchesOrCentimetres(Math.round(10*cock.cockThickness)/10));
		outputText((Math.round(10*cock.cockThickness)/10) < 10 ? " thick.":" wide.");

		//Horsecock flavor
		if(cock.cockType == CockTypesEnum.HORSE)
		{
			outputText("  It's mottled black and brown in a very animalistic pattern.  The 'head' of your shaft flares proudly, just like a horse's.");
		}
		//dog cock flavor
		if((cock.cockType == CockTypesEnum.DOG) || (cock.cockType == CockTypesEnum.FOX) || (cock.cockType == CockTypesEnum.WOLF))
		{
			if(cock.knotMultiplier >= 1.8)
				outputText("  The obscenely swollen lump of flesh near the base of your " + player.cockDescript(temp) + " looks almost too big for your cock.");
			else if(cock.knotMultiplier >= 1.4)
				outputText("  A large bulge of flesh nestles just above the bottom of your " + player.cockDescript(temp) + ", to ensure it stays where it belongs during mating.");
			else if(cock.knotMultiplier > 1)
				outputText("  A small knot of thicker flesh is near the base of your " + player.cockDescript(temp) + ", ready to expand to help you lodge it inside a female.");
			//List thickness
			outputText("  The knot is " + Math.round(cock.cockThickness * cock.knotMultiplier * 10)/10 + " inches wide when at full size.");
		}
		//
		//Demon cock flavor
		if(cock.cockType == CockTypesEnum.DEMON)
		{
			outputText("  The crown is ringed with a circle of rubbery protrusions that grow larger as you get more aroused.  The entire thing is shiny and covered with tiny, sensitive nodules that leave no doubt about its demonic origins.");
		}
		//Tentacle cock flavor
		if(cock.cockType == CockTypesEnum.TENTACLE)
		{
			outputText("  The entirety of its green surface is covered in perspiring beads of slick moisture.  It frequently shifts and moves of its own volition, the slightly oversized and mushroom-like head shifting in coloration to purplish-red whenever you become aroused.");
		}
		//Stamen cock flavor
		if(cock.cockType == CockTypesEnum.STAMEN)
		{
			outputText("  It is dark green, tampered, and crowned by several colorful balls near the tip that secrete pollen when aroused.");
		}
		//Cat cock flavor
		if(cock.cockType == CockTypesEnum.CAT)
		{
			outputText("  It ends in a single point, much like a spike, and is covered in small, fleshy barbs. The barbs are larger at the base and shrink in size as they get closer to the tip.  Each of the spines is soft and flexible, and shouldn't be painful for any of your partners.");
		}
		//Snake cock flavor
		if(cock.cockType == CockTypesEnum.LIZARD)
		{
			outputText("  It's a deep, iridescent purple in color.  Unlike a human penis, the shaft is not smooth, and is instead patterned with multiple bulbous bumps.");
		}
		//Anemone cock flavor
		if(cock.cockType == CockTypesEnum.ANEMONE)
		{
			outputText("  The crown is surrounded by tiny tentacles with a venomous, aphrodisiac payload.  At its base a number of similar, longer tentacles have formed, guaranteeing that pleasure will be forced upon your partners.");
		}
		//Kangawang flavor
		if(cock.cockType == CockTypesEnum.KANGAROO)
		{
			outputText("  It usually lies coiled inside a sheath, but undulates gently and tapers to a point when erect, somewhat like a taproot.");
		}
		//Draconic Cawk Flava flav
		if(cock.cockType == CockTypesEnum.DRAGON)
		{
			outputText("  With its tapered tip, there are few holes you wouldn't be able to get into.  It has a strange, knot-like bulb at its base, but doesn't usually flare during arousal as a dog's knot would.");
		}
		//Bee flavor
		if (cock.cockType == CockTypesEnum.BEE) {
			outputText("  It's a long, smooth black shaft that's rigid to the touch.  Its base is ringed with a layer of four inch long soft bee hair.  The tip has a much finer layer of short yellow hairs.  The tip is very sensitive, and it hurts constantly if you don’t have bee honey on it.");
		}
		//Pig flavor
		if (cock.cockType == CockTypesEnum.PIG) {
			outputText("  It's bright pinkish red, ending in a prominent corkscrew shape at the tip.");
		}
		//Avian flavor
		if (cock.cockType == CockTypesEnum.AVIAN) {
			outputText("  It's a red, tapered cock that ends in a tip.  It rests nicely in a sheath.");
		}
		//Rhino flavor
		if (cock.cockType == CockTypesEnum.RHINO) {
			outputText("  It's a smooth, tough pink colored and takes on a long and narrow shape with an oval shaped bulge along the center.");
		}
		//Echidna flavor
		if (cock.cockType == CockTypesEnum.ECHIDNA) {
			outputText("  It is quite a sight to behold, coming well-equiped with four heads.");
		}
		//Red Panda flavor
		if (cock.cockType == CockTypesEnum.ECHIDNA) {
			outputText("  It lies protected in a soft, fuzzy sheath.");
		}
		//Worm flavor
		if(player.hasStatusEffect(StatusEffects.Infested))
			outputText("  Every now and again a slimy worm coated in spunk slips partway out of your [cock], tasting the air like a snake's tongue.");
		if(cock.sock)
			sockDescript(temp);
		//DONE WITH COCKS, moving on!
		outputText("\n");
	}
	if(player.cocks.length > 1)
	{
		temp = 0;
		rando = rand(4);
		if(player.isTaur())
			outputText("\nBetween hind legs of your bestial body you have grown " + player.multiCockDescript() + "!\n");
		else if (player.isScylla())
			outputText("\nBetween front tentacles of your bestial body you have grown " + player.multiCockDescript() + "!\n");
		else outputText("\nWhere a penis would normally be located, you have instead grown " + player.multiCockDescript() + "!\n");
		while(temp < player.cocks.length)

		{

			//middle cock description
			if(rando == 0)
			{
				if(temp == 0)outputText("--Your first ");
				else outputText("--Your next ");
				outputText(player.cockDescript(temp));
				outputText(" is ");
				outputText(int(10*cock.cockLength)/10 + " inches long and ");
				if(Math.floor(cock.cockThickness) >= 2)
					outputText(num2Text(Math.round(cock.cockThickness * 10)/10) + " inches wide.");
				else
				{
					if(cock.cockThickness == 1)
						outputText("one inch wide.");
					else outputText(Math.round(cock.cockThickness*10)/10 + " inches wide.");
				}
			}
			if(rando == 1)
			{
				outputText("--One of your ");
				outputText(player.cockDescript(temp) + "s is " + Math.round(10*cock.cockLength)/10 + " inches long and ");
				if(Math.floor(cock.cockThickness) >= 2)
					outputText(num2Text(Math.round(cock.cockThickness * 10)/10) + " inches thick.");
				else
				{
					if(cock.cockThickness == 1)
						outputText("one inch thick.");
					else outputText(Math.round(cock.cockThickness*10)/10 + " inches thick.");
				}
			}
			if(rando == 2)
			{
				if(temp > 0)
					outputText("--Another of your ");
				else outputText("--One of your ");
				outputText(player.cockDescript(temp) + "s is " + Math.round(10*cock.cockLength)/10 + " inches long and ");
				if(Math.floor(cock.cockThickness) >= 2)
					outputText(num2Text(Math.round(cock.cockThickness * 10)/10) + " inches thick.");
				else
				{
					if(cock.cockThickness == 1)
						outputText("one inch thick.");
					else outputText(Math.round(cock.cockThickness*10)/10 + " inches thick.");
				}
			}
			if(rando == 3)
			{
				if(temp > 0)
					outputText("--Your next ");
				else outputText("--Your first ");
				outputText(player.cockDescript(temp) + " is " + Math.round(10*cock.cockLength)/10 + " inches long and ");
				if(Math.floor(cock.cockThickness) >= 2)
					outputText(num2Text(Math.round(cock.cockThickness * 10)/10) + " inches in diameter.");
				else
				{
					if(Math.round(cock.cockThickness*10)/10 == 1)
						outputText("one inch in diameter.");
					else outputText(Math.round(cock.cockThickness*10)/10 + " inches in diameter.");
				}
			}
			//horse cock flavor
			if(cock.cockType == CockTypesEnum.HORSE)
			{
				outputText("  It's mottled black and brown in a very animalistic pattern.  The 'head' of your " + player.cockDescript(temp) + " flares proudly, just like a horse's.");
			}
			//dog cock flavor
			if((cock.cockType == CockTypesEnum.DOG) || (cock.cockType == CockTypesEnum.WOLF) || (cock.cockType == CockTypesEnum.FOX))
			{
				outputText("  It is shiny, pointed, and covered in veins, just like a large ");
				if (cock.cockType == CockTypesEnum.DOG)
					outputText("dog's cock.");
				else if (cock.cockType == CockTypesEnum.WOLF)
					outputText("wolf's cock.");
				else
					outputText("fox's cock.");
			}
			//Demon cock flavor
			if(cock.cockType == CockTypesEnum.DEMON)
			{
				outputText("  The crown is ringed with a circle of rubbery protrusions that grow larger as you get more aroused.  The entire thing is shiny and covered with tiny, sensitive nodules that leave no doubt about its demonic origins.");
			}
			//Tentacle cock flavor
			if(cock.cockType == CockTypesEnum.TENTACLE)
			{
				outputText("  The entirety of its green surface is covered in perspiring beads of slick moisture.  It frequently shifts and moves of its own volition, the slightly oversized and mushroom-like head shifting in coloration to purplish-red whenever you become aroused.");
			}
			//Stamen cock flavor
			if(cock.cockType == CockTypesEnum.STAMEN)
			{
				outputText("  It is dark green, tampered, and crowned by several colorful balls near the tip that secrete pollen when aroused.");
			}
			//Cat cock flavor
			if(cock.cockType == CockTypesEnum.CAT)
			{
				outputText("  It ends in a single point, much like a spike, and is covered in small, fleshy barbs. The barbs are larger at the base and shrink in size as they get closer to the tip.  Each of the spines is soft and flexible, and shouldn't be painful for any of your partners.");
			}
			//Snake cock flavor
			if(cock.cockType == CockTypesEnum.LIZARD)
			{
				outputText("  It's a deep, iridescent purple in color.  Unlike a human penis, the shaft is not smooth, and is instead patterned with multiple bulbous bumps.");
			}
			//Anemone cock flavor
			if(cock.cockType == CockTypesEnum.ANEMONE)
			{
				outputText("  The crown is surrounded by tiny tentacles with a venomous, aphrodisiac payload.  At its base a number of similar, longer tentacles have formed, guaranteeing that pleasure will be forced upon your partners.");
			}
			//Kangwang flavor
			if(cock.cockType == CockTypesEnum.KANGAROO)
			{
				outputText("  It usually lies coiled inside a sheath, but undulates gently and tapers to a point when erect, somewhat like a taproot.");
			}
			//Draconic Cawk Flava flav
			if(cock.cockType == CockTypesEnum.DRAGON)
			{
				outputText("  With its tapered tip, there are few holes you wouldn't be able to get into.  It has a strange, knot-like bulb at its base, but doesn't usually flare during arousal as a dog's knot would.");
			}
			//Bee flavor
			if (cock.cockType == CockTypesEnum.BEE) {
				outputText("  It's a long, smooth black shaft that's rigid to the touch.  Its base is ringed with a layer of four inch long soft bee hair.  The tip has a much finer layer of short yellow hairs.  The tip is very sensitive, and it hurts constantly if you don’t have bee honey on it.");
			}
			//Pig flavor
			if (cock.cockType == CockTypesEnum.PIG) {
				outputText("  It's bright pinkish red, ending in a prominent corkscrew shape at the tip.");
			}
			//Avian flavor
			if (cock.cockType == CockTypesEnum.AVIAN) {
				outputText("  It's a red, tapered cock that ends in a tip.  It rests nicely in a sheath.");
			}

			if(cock.knotMultiplier > 1) {
				if(cock.knotMultiplier >= 1.8)
					outputText("  The obscenely swollen lump of flesh near the base of your " + player.cockDescript(temp) + " looks almost comically mismatched for your " + player.cockDescript(temp) + ".");
				else if(cock.knotMultiplier >= 1.4)
					outputText("  A large bulge of flesh nestles just above the bottom of your " + player.cockDescript(temp) + ", to ensure it stays where it belongs during mating.");
				else
					outputText("  A small knot of thicker flesh is near the base of your " + player.cockDescript(temp) + ", ready to expand to help you lodge your " + player.cockDescript(temp) + " inside a female.");
				//List knot thickness
				outputText("  The knot is " + Math.floor(cock.cockThickness * cock.knotMultiplier * 10) / 10 + " inches thick when at full size.");
			}

			if(cock.sock != "" && cock.sock != null)	// I dunno what was happening, but it looks like .sock is null, as it doesn't exist. I guess this is probably more left over from some of the restucturing.
			{																		// Anyways, check against null values, and stuff works again.
				trace("Found a sock description (WTF even is a sock?)", cock.sock);
				sockDescript(temp);
			}
			temp++;
			rando++;
			outputText("\n");
			if(rando > 3) rando = 0;
		}
		//Worm flavor
		if(player.hasStatusEffect(StatusEffects.Infested))
			outputText("Every now and again slimy worms coated in spunk slip partway out of your [cocks], tasting the air like tongues of snakes.\n");
		//DONE WITH COCKS, moving on!
	}
	//Of Balls and Sacks!
	if(player.balls > 0)
	{
		if(player.hasStatusEffect(StatusEffects.Uniball))
		{
			if(player.skinType != Skin.GOO)
				outputText("Your [sack] clings tightly to your groin, holding [balls] snugly against you.");
			else if(player.skinType == Skin.GOO)
				outputText("Your [sack] clings tightly to your groin, dripping and holding [balls] snugly against you.");
		}
		else {
			var sdesc:String;
			if (player.skin.hasMagicalTattoo()) {
				sdesc = " covered by magical tattoo";
			} else if (player.skin.hasBattleTattoo()) {
				sdesc = " covered by battle tattoo";
			} else if (player.skin.hasLightningShapedTattoo()) {
				sdesc = " covered with a few glowing lightning tattoos";
			} else {
				sdesc = "";
			}
			var swingsWhere:String;
			if (player.cockTotal() == 0) {
				swingsWhere = " where a penis would normally grow.";
			} else {
				swingsWhere = " under your [cocks].";
			}
			if (player.hasPlainSkinOnly())
				outputText("A [sack]" + sdesc + " with [balls] swings heavily" + swingsWhere);
			else if (player.hasFur())
				outputText("A fuzzy [sack] filled with [balls] swings low" + swingsWhere);
			else if (player.hasCoatOfType(Skin.CHITIN))
				outputText("A chitin [sack] hugs your [balls] tightly against your body.");
			else if (player.hasScales())
				outputText("A scaley [sack] hugs your [balls] tightly against your body.");
			else if (player.skinType == Skin.STONE)
				outputText("A stone-solid sack with [balls] swings heavily" + swingsWhere);
			else if (player.skinType == Skin.GOO)
				outputText("An oozing, semi-solid sack with [balls] swings heavily" + swingsWhere);
		}
		outputText("  You estimate each of them to be about " + num2Text(Math.round(player.ballSize)) + " ");
		if(Math.round(player.ballSize) == 1)
			outputText("inch");
		else outputText("inches");
		outputText(" across.\n");
	}
	//VAGOOZ
	if(player.vaginas.length > 0)
	{
		if(player.gender == 2 && player.isTaur() && player.lowerBody != 26)
			outputText("\nYour womanly parts have shifted to lie between your hind legs, in a rather feral fashion.");
		if(player.gender == 2 && player.isScylla())
			outputText("\nYour womanly parts have shifted to lie underneath your tentacle legs.");
		outputText("\n");
		if (player.vaginas.length == 1){
            outputText("You have a " + vaginaDescript(0) + ", with a " + Measurements.shortSuffix(int(player.clitLength*10)/10) + " clit");
		}
		if(player.vaginas[0].virgin)
			outputText(" and an intact hymen");
		outputText(".  ");
		if (player.vaginas.length > 1){
            outputText("You have " + player.vaginas.length+ " " + vaginaDescript(0) + "s, with " + Measurements.shortSuffix(int(player.clitLength*10)/10) + " clits each.  ");
		}
		if(player.lib < 50 && player.lust < 50) //not particularly horny

		{
			//Wetness
			if(player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_WET && player.vaginas[0].vaginalWetness< VaginaClass.WETNESS_DROOLING)
				outputText("Moisture gleams in ");
			if(player.vaginas[0].vaginalWetness>= VaginaClass.WETNESS_DROOLING)
			{
				outputText("Occasional beads of ");
				outputText("lubricant drip from ");
			}
			//Different description based on vag looseness
			if(player.vaginas[0].vaginalWetness>= VaginaClass.WETNESS_WET)
			{
				if(player.vaginas[0].vaginalLooseness< VaginaClass.LOOSENESS_LOOSE)
					outputText("your " + vaginaDescript(0) + ". ");
				if(player.vaginas[0].vaginalLooseness>= VaginaClass.LOOSENESS_LOOSE && player.vaginas[0].vaginalLooseness< VaginaClass.LOOSENESS_GAPING_WIDE)
					outputText("your " + vaginaDescript(0) + ", its lips slightly parted. ");
				if(player.vaginas[0].vaginalLooseness>= VaginaClass.LOOSENESS_GAPING_WIDE)
					outputText("the massive hole that is your " + vaginaDescript(0) + ".  ");
			}
		}
		if((player.lib>=50 || player.lust >=50) && (player.lib< 80 && player.lust < 80)) //kinda horny

		{
			//Wetness
			if(player.vaginas[0].vaginalWetness< VaginaClass.WETNESS_WET)
				outputText("Moisture gleams in ");
			if(player.vaginas[0].vaginalWetness>= VaginaClass.WETNESS_WET && player.vaginas[0].vaginalWetness< VaginaClass.WETNESS_DROOLING)
			{
				outputText("Occasional beads of ");
				outputText("lubricant drip from ");
			}
			if(player.vaginas[0].vaginalWetness>= VaginaClass.WETNESS_DROOLING)
			{
				outputText("Thin streams of ");
				outputText("lubricant occasionally dribble from ");
			}
			//Different description based on vag looseness
			if(player.vaginas[0].vaginalLooseness< VaginaClass.LOOSENESS_LOOSE)
				outputText("your " + vaginaDescript(0) + ". ");
			if(player.vaginas[0].vaginalLooseness>= VaginaClass.LOOSENESS_LOOSE && player.vaginas[0].vaginalLooseness< VaginaClass.LOOSENESS_GAPING_WIDE)
				outputText("your " + vaginaDescript(0) + ", its lips slightly parted. ");
			if(player.vaginas[0].vaginalLooseness>= VaginaClass.LOOSENESS_GAPING_WIDE)
				outputText("the massive hole that is your " + vaginaDescript(0) + ".  ");
		}
		if((player.lib> 80 || player.lust > 80)) //WTF horny!

		{
			//Wetness
			if(player.vaginas[0].vaginalWetness< VaginaClass.WETNESS_WET)

			{
				outputText("Occasional beads of ");
				outputText("lubricant drip from ");
			}
			if(player.vaginas[0].vaginalWetness>= VaginaClass.WETNESS_WET && player.vaginas[0].vaginalWetness< VaginaClass.WETNESS_DROOLING)

			{
				outputText("Thin streams of ");
				outputText("lubricant occasionally dribble from ");
			}
			if(player.vaginas[0].vaginalWetness>= VaginaClass.WETNESS_DROOLING)

			{
				outputText("Thick streams of ");
				outputText("lubricant drool constantly from ");
			}
			//Different description based on vag looseness
			if(player.vaginas[0].vaginalLooseness< VaginaClass.LOOSENESS_LOOSE)
				outputText("your " + vaginaDescript(0) + ". ");
			if(player.vaginas[0].vaginalLooseness>= VaginaClass.LOOSENESS_LOOSE && player.vaginas[0].vaginalLooseness< VaginaClass.LOOSENESS_GAPING_WIDE)
				outputText("your " + vaginaDescript(0) + ", its lips slightly parted. ");
			if(player.vaginas[0].vaginalLooseness>= VaginaClass.LOOSENESS_GAPING_WIDE)
				outputText("the massive hole that is your cunt.  ");
		}
		//Line Drop for next descript!
		outputText("\n");
	}
	//Genderless lovun'
	if(player.cockTotal() == 0 && player.vaginas.length == 0)
		outputText("\nYou have a curious lack of any sexual endowments.\n");


	//BUNGHOLIO
	if(player.ass)
	{
		outputText("\n");
		outputText("You have one " + assholeDescript() + ", placed between your butt-cheeks where it belongs.\n");
	}
	//Piercings!
	if(player.eyebrowPierced > 0)
		outputText("\nA solitary " + player.eyebrowPShort + " adorns your eyebrow, looking very stylish.");
	if(player.earsPierced > 0)
		outputText("\nYour ears are pierced with " + player.earsPShort + ".");
	if(player.nosePierced > 0)
		outputText("\nA " + player.nosePShort + " dangles from your nose.");
	if(player.lipPierced > 0)
		outputText("\nShining on your lip, a " + player.lipPShort + " is plainly visible.");
	if(player.tonguePierced > 0)
		outputText("\nThough not visible, you can plainly feel your " + player.tonguePShort + " secured in your tongue.");
	if(player.nipplesPierced == 3)
		outputText("\nYour " + nippleDescript(0) + "s ache and tingle with every step, as your heavy " + player.nipplesPShort + " swings back and forth.");
	else if(player.nipplesPierced > 0)
		outputText("\nYour " + nippleDescript(0) + "s are pierced with " + player.nipplesPShort + ".");
	if(player.cockTotal() > 0)
	{
		if(player.cocks[0].pierced > 0)
		{
			outputText("\nLooking positively perverse, a " + player.cocks[0].pShortDesc + " adorns your [cock].");
		}
	}
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00286] == 1)
		outputText("\nA magical, ruby-studded bar pierces your belly button, allowing you to summon Ceraph on a whim.");
	if(player.hasVagina())
	{
		if(player.vaginas[0].labiaPierced > 0)
			outputText("\nYour " + vaginaDescript(0) + " glitters with the " + player.vaginas[0].labiaPShort + " hanging from your lips.");
		if(player.vaginas[0].clitPierced > 0)
			outputText("\nImpossible to ignore, your " + clitDescript() + " glitters with its " + player.vaginas[0].clitPShort + ".");
	}
	//MONEY!
	if(player.gems == 0)
		outputText("\n\n<b>Your money-purse is devoid of any currency.</b>");
	if(player.gems > 1)
		outputText("\n\n<b>You have " + addComma(Math.floor(player.gems)) + " shining gems, collected in your travels.</b>");
	if(player.gems == 1)
		outputText("\n\n<b>You have " + addComma(Math.floor(player.gems)) + " shining gem, collected in your travels.</b>");
	menu();
	addButton(0, "Next", playerMenu);
	addButton(11, "Gender Set.", GenderForcedSetting);
	addButton(10, "RacialScores", RacialScores);
	flushOutputTextToGUI();
}
	public function describeBodyShape():void {
		outputText("You have a humanoid shape with the usual body");
		if (player.skin.coverage == Skin.COVERAGE_LOW) {
			outputText(" partialy covered with [skin coat]");
		} else if (player.skin.coverage >= Skin.COVERAGE_MEDIUM) {
			outputText(" covered with [skin coat]");
		}
		outputText(", arms, hands and fingers.");
		if (player.skin.base.pattern == Skin.PATTERN_ORCA_UNDERBODY) outputText(" However your skin is [skin color] with a [skin color2] underbelly that runs on the underside of your limbs and has a glossy shine, similar to that of an orca.");
		if (player.skin.base.pattern == Skin.PATTERN_RED_PANDA_UNDERBODY) outputText(" Your body is covered from head to toe in [skin color] with a [skin color2] underbelly, giving to your nimble frame a red-panda appearance.");
	}
	public function describeGear():void {
		// story.display("gear");
		outputText("  <b>You are currently " + (player.armorDescript() != "gear" ? "wearing your " + player.armorDescript() : "naked") + "" + " and using your [weapon] as a melee weapon");
		if (player.weaponRangeName != "nothing")
			outputText(",  [weaponrangename] as range weapon");
		if (player.shieldName != "nothing")
			outputText("  and [shield] as your shield");
		outputText(".");
		if (player.jewelryName != "nothing" && player.jewelryName != "fox hairpin" && player.jewelryName != "seer’s hairpin")
			outputText("  Girding one of your fingers is " + player.jewelryName + ".");
		if (player.jewelryName == "fox hairpin" || player.jewelryName == "seer’s hairpin")
			outputText("  In your hair is " + player.jewelryName + ".");
		if (player.hasKeyItem("Fenrir Collar") >= 0) outputText("  On your neck is Fenrir spiked Collar its chain still hanging down from it and clinking with an ominous metallic sound as you walk around.");
		outputText("</b>");
	}
	public function describeRace():void {
		// story.display("race");
//Discuss race
		if (player.race() != player.startingRace) outputText("You began your journey as a " + player.startingRace + ", but gave that up as you explored the dangers of this realm.  ");
		//Height and race.
		outputText("You are a ");
		outputText(Measurements.footInchOrMetres(player.tallness));
		outputText(" tall [malefemaleherm] [race], with [bodytype].");
	}
	public function describeLowerBody():void {
		if (player.isTaur() || player.lowerBody == LowerBody.DRIDER || player.lowerBody == LowerBody.SCYLLA || player.lowerBody == LowerBody.PLANT_FLOWER) {
			if (player.lowerBody == LowerBody.HOOFED)
				outputText("  From the waist down you have the body of a horse, with all " + num2Text(player.legCount) + " legs capped by hooves.");
			else if (player.lowerBody == LowerBody.PONY)
				outputText("  From the waist down you have an incredibly cute and cartoonish parody of a horse's body, with all " + num2Text(player.legCount) + " legs ending in flat, rounded feet.");
			else if (player.lowerBody == LowerBody.DRIDER)
				outputText("  Where your legs would normally start you have grown the body of a spider, with " + num2Text(player.legCount) + " spindly legs that sprout from its sides.");
			else if (player.lowerBody == LowerBody.SCYLLA)
				outputText("  Where your legs would normally start you have grown the body of an octopus, with " + num2Text(player.legCount) + " tentacle legs that sprout from your [hips].");
			else if (player.lowerBody == LowerBody.PLANT_FLOWER)
				outputText("  Around your waist, the petals of a large pink orchid expand, big enough to engulf you entirely on their own, coupled with a pitcher-like structure in the centre, which is filled with syrupy nectar straight from your loins. When you wish to rest, these petals draw up around you, encapsulating you in a beautiful bud.  While you don't technically have legs anymore, you can still move around on your " + num2Text(player.legCount) + " vine-like stamens.");
			else
				outputText("  Where your legs would normally start you have grown the body of a feral animal, with all " + num2Text(player.legCount) + " legs.");
		}
		//Hip info only displays if you aren't a centaur.
		if (player.isBiped() || player.lowerBody == LowerBody.NAGA) {
			if (player.thickness > 70) {
				outputText("  You have " + hipDescript());
				if (player.hips.type < 6) {
					if (player.tone < 65)
						outputText(" buried under a noticeable muffin-top, and");
					else outputText(" that blend into your pillar-like waist, and");
				}
				if (player.hips.type >= 6 && player.hips.type < 10)
					outputText(" that blend into the rest of your thick form, and");
				if (player.hips.type >= 10 && player.hips.type < 15)
					outputText(" that would be much more noticeable if you weren't so wide-bodied, and");
				if (player.hips.type >= 15 && player.hips.type < 20)
					outputText(" that sway and emphasize your thick, curvy shape, and");
				if (player.hips.type >= 20)
					outputText(" that sway hypnotically on your extra-curvy frame, and");
			}
			else if (player.thickness < 30) {
				outputText("  You have " + hipDescript());
				if (player.hips.type < 6)
					outputText(" that match your trim, lithe body, and");
				if (player.hips.type >= 6 && player.hips.type < 10)
					outputText(" that sway to and fro, emphasized by your trim body, and");
				if (player.hips.type >= 10 && player.hips.type < 15)
					outputText(" that swell out under your trim waistline, and");
				if (player.hips.type >= 15 && player.hips.type < 20)
					outputText(", emphasized by your narrow waist, and");
				if (player.hips.type >= 20)
					outputText(" that swell disproportionately wide on your lithe frame, and");
			}
			//STANDARD
			else {
				outputText("  You have " + hipDescript());
				if (player.hips.type < 6)
					outputText(", and");
				if (player.femininity > 50) {
					if (player.hips.type >= 6 && player.hips.type < 10)
						outputText(" that draw the attention of those around you, and");
					if (player.hips.type >= 10 && player.hips.type < 15)
						outputText(" that make you walk with a sexy, swinging gait, and");
					if (player.hips.type >= 15 && player.hips.type < 20)
						outputText(" that make it look like you've birthed many children, and");
					if (player.hips.type >= 20)
						outputText(" that make you look more like an animal waiting to be bred than any kind of human, and");
				}
				else {
					if (player.hips.type >= 6 && player.hips.type < 10)
						outputText(" that give you a graceful stride, and");
					if (player.hips.type >= 10 && player.hips.type < 15)
						outputText(" that add a little feminine swing to your gait, and");
					if (player.hips.type >= 15 && player.hips.type < 20)
						outputText(" that force you to sway and wiggle as you move, and");
					if (player.hips.type >= 20) {
						outputText(" that give your ");
						if (player.balls > 0)
							outputText("balls plenty of room to breathe");
						else if (player.hasCock())
							outputText(player.multiCockDescript() + " plenty of room to swing");
						else if (player.hasVagina())
							outputText(vaginaDescript() + " a nice, wide berth");
						else outputText("vacant groin plenty of room");
						outputText(", and");
					}
				}
			}
		}
		//ASS
		//Horse version
		if (player.isTaur()) {
			//FATBUTT
			if (player.tone < 65) {
				outputText("  Your " + buttDescript());
				if (player.butt.type < 4)
					outputText(" is lean, from what you can see of it.");
				if (player.butt.type >= 4 && player.butt.type < 6)
					outputText(" looks fairly average.");
				if (player.butt.type >= 6 && player.butt.type < 10)
					outputText(" is fairly plump and healthy.");
				if (player.butt.type >= 10 && player.butt.type < 15)
					outputText(" jiggles a bit as you trot around.");
				if (player.butt.type >= 15 && player.butt.type < 20)
					outputText(" jiggles and wobbles as you trot about.");
				if (player.butt.type >= 20)
					outputText(" is obscenely large, bordering freakish, even for a horse.");
			}
			//GIRL LOOK AT DAT BOOTY
			else {
				outputText("  Your " + buttDescript());
				if (player.butt.type < 4)
					outputText(" is barely noticeably, showing off the muscles of your haunches.");
				if (player.butt.type >= 4 && player.butt.type < 6)
					outputText(" matches your toned equine frame quite well.");
				if (player.butt.type >= 6 && player.butt.type < 10)
					outputText(" gives hints of just how much muscle you could put into a kick.");
				if (player.butt.type >= 10 && player.butt.type < 15)
					outputText(" surges with muscle whenever you trot about.");
				if (player.butt.type >= 15 && player.butt.type < 20)
					outputText(" flexes its considerable mass as you move.");
				if (player.butt.type >= 20)
					outputText(" is stacked with layers of muscle, huge even for a horse.");
			}
		}
		//Non-horse PCs
		else if (player.isBiped() || player.lowerBody == LowerBody.NAGA) {
			//TUBBY ASS
			if (player.tone < 60) {
				outputText(" your " + buttDescript());
				if (player.butt.type < 4)
					outputText(" looks great under your gear.");
				if (player.butt.type >= 4 && player.butt.type < 6)
					outputText(" has the barest amount of sexy jiggle.");
				if (player.butt.type >= 6 && player.butt.type < 10)
					outputText(" fills out your clothing nicely.");
				if (player.butt.type >= 10 && player.butt.type < 15)
					outputText(" wobbles enticingly with every step.");
				if (player.butt.type >= 15 && player.butt.type < 20)
					outputText(" wobbles like a bowl full of jello as you walk.");
				if (player.butt.type >= 20)
					outputText(" is obscenely large, bordering freakish, and makes it difficult to run.");
			}
			//FITBUTT
			else {
				outputText(" your " + buttDescript());
				if (player.butt.type < 4)
					outputText(" molds closely against your form.");
				if (player.butt.type >= 4 && player.butt.type < 6)
					outputText(" contracts with every motion, displaying the detailed curves of its lean musculature.");
				if (player.butt.type >= 6 && player.butt.type < 10)
					outputText(" fills out your clothing nicely.");
				if (player.butt.type >= 10 && player.butt.type < 15)
					outputText(" stretches your gear, flexing it with each step.");
				if (player.butt.type >= 15 && player.butt.type < 20)
					outputText(" threatens to bust out from under your kit each time you clench it.");
				if (player.butt.type >= 20)
					outputText(" is marvelously large, but completely stacked with muscle.");
			}
		}
		//TAILS
		describeTail();
		//</mod>
		//LOWERBODY SPECIAL
		if (player.lowerBody == LowerBody.HUMAN)
			outputText("  " + Num2Text(player.legCount) + " normal human legs grow down from your waist, ending in normal human feet.");
		else if (player.lowerBody == LowerBody.FERRET)
			outputText("  " + Num2Text(player.legCount) + " furry, digitigrade legs form below your [hips].  The fur is thinner on the feet, and your toes are tipped with claws.");
		else if (player.lowerBody == LowerBody.HOOFED)
			outputText("  Your " + num2Text(player.legCount) + " legs are muscled and jointed oddly, covered in [skin coat.color] fur, and end in a bestial hooves.");
		else if (player.lowerBody == LowerBody.DOG)
			outputText("  " + Num2Text(player.legCount) + " digitigrade legs grow downwards from your waist, ending in dog-like hind-paws.");
		else if (player.lowerBody == LowerBody.WOLF)
			outputText("  " + Num2Text(player.legCount) + " digitigrade legs grow downwards from your waist, ending in clawed wolf-like hind-paws.");
		else if (player.lowerBody == LowerBody.NAGA)
			outputText("  Below your waist your flesh is fused together into a very long snake-like tail.");
		//Horse body is placed higher for readability purposes
		else if (player.lowerBody == LowerBody.DEMONIC_HIGH_HEELS)
			outputText("  Your " + num2Text(player.legCount) + " perfect lissome legs end in mostly human feet, apart from the horns protruding straight down from the heel that forces you to walk with a sexy, swaying gait.");
		else if (player.lowerBody == LowerBody.DEMONIC_CLAWS)
			outputText("  Your " + num2Text(player.legCount) + " lithe legs are capped with flexible clawed feet.  Sharp black nails grow where once you had toe-nails, giving you fantastic grip.");
		else if (player.lowerBody == LowerBody.BEE)
			outputText("  Your " + num2Text(player.legCount) + " legs are covered in a shimmering insectile carapace up to mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton.  A bit of downy yellow and black fur fuzzes your upper thighs, just like a bee.");
		else if (player.lowerBody == LowerBody.GOO)
			outputText("  In place of legs you have a shifting amorphous blob.  Thankfully it's quite easy to propel yourself around on.  The lowest portions of your [armor] float around inside you, bringing you no discomfort.");
		else if (player.lowerBody == LowerBody.CAT)
			outputText("  " + Num2Text(player.legCount) + " digitigrade legs grow downwards from your waist, ending in soft, padded cat-paws.");
		else if (player.lowerBody == LowerBody.LIZARD)
			outputText("  " + Num2Text(player.legCount) + " digitigrade legs grow down from your " + hipDescript() + ", ending in clawed feet.  There are three long toes on the front, and a small hind-claw on the back.");
		else if (player.lowerBody == LowerBody.SALAMANDER)
			outputText("  " + Num2Text(player.legCount) + " digitigrade legs covered in thick, leathery red scales up to the mid-thigh grow down from your " + hipDescript() + ", ending in clawed feet.  There are three long toes on the front, and a small hind-claw on the back.");
		else if (player.lowerBody == LowerBody.BUNNY)
			outputText("  Your " + num2Text(player.legCount) + " legs thicken below the waist as they turn into soft-furred rabbit-like legs.  You even have large bunny feet that make hopping around a little easier than walking.");
		else if (player.lowerBody == LowerBody.HARPY)
			outputText("  Your " + num2Text(player.legCount) + " legs are covered with [haircolor] plumage.  Thankfully the thick, powerful thighs are perfect for launching you into the air, and your feet remain mostly human, even if they are two-toed and tipped with talons.");
		else if (player.lowerBody == LowerBody.KANGAROO)
			outputText("  Your " + num2Text(player.legCount) + " furry legs have short thighs and long calves, with even longer feet ending in prominently-nailed toes.");
		else if (player.lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS)
			outputText("  Your " + num2Text(player.legCount) + " legs are covered in a reflective black, insectile carapace up to your mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton.");
		else if (player.lowerBody == LowerBody.FOX)
			outputText("  Your " + num2Text(player.legCount) + " legs are crooked into high knees with hocks and long feet, like those of a fox; cute bulbous toes decorate the ends.");
		else if (player.lowerBody == LowerBody.DRAGON)
			outputText("  " + Num2Text(player.legCount) + " human-like legs grow down from your " + hipDescript() + ", sheathed in scales and ending in clawed feet.  There are three long toes on the front, and a small hind-claw on the back.");
		else if (player.lowerBody == LowerBody.RACCOON)
			outputText("  Your " + num2Text(player.legCount) + " legs, though covered in fur, are humanlike.  Long feet on the ends bear equally long toes, and the pads on the bottoms are quite sensitive to the touch.");
		else if (player.lowerBody == LowerBody.CLOVEN_HOOFED)
			outputText("  " + Num2Text(player.legCount) + " digitigrade legs form below your [hips], ending in cloven hooves.");
		else if (player.lowerBody == LowerBody.MANTIS)
			outputText("  Your " + num2Text(player.legCount) + " legs are covered in a shimmering green, insectile carapace up to mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton.");
		else if (player.lowerBody == LowerBody.SHARK)
			outputText("  Your " + num2Text(player.legCount) + " legs are mostly human save for the webing between your toes.");
		else if (player.lowerBody == LowerBody.GARGOYLE) {
			outputText("  Your " + num2Text(player.legCount) + " digitigrade ");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) outputText("marble");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) outputText("alabaster");
			outputText(" legs end in sharp-clawed stone feet. There are three long toes on the front, and a small hind claw on the back.");
		}
		else if (player.lowerBody == LowerBody.GARGOYLE_2) {
			outputText("  Your " + num2Text(player.legCount) + " ");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) outputText("marble");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) outputText("alabaster");
			outputText(" legs aside of their stone structure look pretty much human.");
		}
		else if (player.lowerBody == LowerBody.PLANT_HIGH_HEELS)
			outputText("  Your " + num2Text(player.legCount) + " perfect lissome legs end in human feet, apart from delicate vines covered in spade-like leaves crawling around them on the whole length.");
		else if (player.lowerBody == LowerBody.PLANT_ROOT_CLAWS)
			outputText("  Your " + num2Text(player.legCount) + " legs looks quite normal aside feet.  They turned literally into roots only vaguely retaining the shape of the feet.");
//	else if(player.lowerBody == PLANT_FLOWER)
//		outputText("  Around your waist just under your nectar coated pussy expends the petals of a large orchid big enough to engulf you entirely. While you don't technically have legs you can walk around on your " + num2Text(player.legCount)+ " vines which pretty much look like tentacle cocks.");
		else if (player.lowerBody == LowerBody.LION)
			outputText("  Your " + num2Text(player.legCount) + " legs are covered in [skin coat.color] fur up to the thigh where it fades to white. They end with digitigrade lion paws. You can dash on all fours as gracefully as you would on two legs.");
		else if (player.lowerBody == LowerBody.YETI)
			outputText("  Your " + num2Text(player.legCount) + " fur covered legs end with a pair of very large yeti feet, leaving large tracks and granting you easy mobility in the snow.");
		else if (player.lowerBody == LowerBody.ORCA)
			outputText("  Your " + num2Text(player.legCount) + " legs are mostly human save for the webbing between your toes that assists you in swimming.");
		else if (player.lowerBody == LowerBody.YGG_ROOT_CLAWS)
			outputText("  Your " + num2Text(player.legCount) + " legs looks quite normal until your feet. Your roots have condensed into a self-contained shape of three clawed toes on the front, and a small hind-claw in the back. You doubt they can gather moisture very well like this, but at least you have an excellent grip.");
		else if (player.lowerBody == LowerBody.ONI)
			outputText("  Your " + num2Text(player.legCount) + " legs are covered with a set of warlike tattoo and your feet end with sharp black nails.");
		else if (player.lowerBody == LowerBody.ELF)
			outputText("  Your " + num2Text(player.legCount) + " perfect lissom legs end in delicate, but agile elven feet allowing you to move gracefully and swiftly.");
		else if (player.lowerBody == LowerBody.RAIJU)
			outputText("  You have " + num2Text(player.legCount) + " fluffy, furred legs that look vaguely like kneehigh socks. Your pawed feet end in four thick toes, which serve as your main source of balance. You can walk on them as normally as your old plantigrade legs. A thick strand of darkly colored fur breaks out from your ankles, emulating a bolt of lighting in appearance.");
		else if (player.lowerBody == LowerBody.RED_PANDA)
			outputText("  Your " + num2Text(player.legCount) + " legs are equally covered in [skin coat.color] fur, ending on red-panda paws with short claws. They have a nimble and strong build, in case you need to escape from something.");
		else if (player.lowerBody == LowerBody.AVIAN)
			outputText("  You have strong thighs perfect for launching you into the air which end in slender, bird-like legs, covered with a [skin coat.color] plumage down to your knees and slightly rough, [skin] below. You have digitigrade feet, with toes that end in sharp talons.");
		else if (player.lowerBody == LowerBody.GRYPHON)
			outputText("  You have strong thighs perfect for launching you into the air ending in furred, feline legs, covered with a coat of soft, [skin coat.color2] fur. Your have digitigrade feet, lion-like, with soft, pink soles and paw pads, with feline toes ending in sharp, retractile claws.");
		if (player.hasPerk(PerkLib.Incorporeality))
			outputText("  Of course, your [legs] are partially transparent due to their ghostly nature."); // isn't goo transparent anyway?
	}
	public function describeTail():void {
		if (player.tailType == Tail.HORSE)
			outputText("  A long [skin coat.color] horsetail hangs from your " + buttDescript() + ", smooth and shiny.");
		if (player.tailType == Tail.FERRET)
			outputText("  A long ferret tail sprouts from above your [butt].  It is thin, tapered, and covered in shaggy [skin coat.color] fur.");
		if (player.tailType == Tail.DOG)
			outputText("  A fuzzy [skin coat.color] dogtail sprouts just above your " + buttDescript() + ", wagging to and fro whenever you are happy.");
		if (player.tailType == Tail.DEMONIC)
			outputText("  A narrow tail ending in a spaded tip curls down from your " + buttDescript() + ", wrapping around your [leg] sensually at every opportunity.");
		if (player.tailType == Tail.COW)
			outputText("  A long cowtail with a puffy tip swishes back and forth as if swatting at flies.");
		if (player.tailType == Tail.SPIDER_ADBOMEN) {
			outputText("  A large, spherical spider-abdomen has grown out from your backside, covered in shiny black chitin.  Though it's heavy and bobs with every motion, it doesn't seem to slow you down.");
			if (player.tailVenom > 50 && player.tailVenom < 80)
				outputText("  Your bulging arachnid posterior feels fairly full of webbing.");
			if (player.tailVenom >= 80 && player.tailVenom < 100)
				outputText("  Your arachnid rear bulges and feels very full of webbing.");
			if (player.tailVenom == 100)
				outputText("  Your swollen spider-butt is distended with the sheer amount of webbing it's holding.");
		}
		if (player.tailType == Tail.BEE_ABDOMEN) {
			outputText("  A large insectile bee-abdomen dangles from just above your backside, bobbing with its own weight as you shift.  It is covered in hard chitin with black and yellow stripes, and tipped with a dagger-like stinger.");
			if (player.tailVenom > 50 && player.tailVenom < 80)
				outputText("  A single drop of poison hangs from your exposed stinger.");
			if (player.tailVenom >= 80 && player.tailVenom < 100)
				outputText("  Poisonous bee venom coats your stinger completely.");
			if (player.tailVenom == 100)
				outputText("  Venom drips from your poisoned stinger regularly.");
		}
		if (player.tailType == Tail.SCORPION) {
			outputText("  A large insectile scorpion-like tail dangles from just above your backside, bobbing with its own weight as you shift.  It is covered in hard chitin and tipped with a stinger.");
			if (player.tailVenom > 75 && player.tailVenom < 120)
				outputText("  A single drop of poison hangs from your exposed stinger.");
			if (player.tailVenom >= 120 && player.tailVenom < 150)
				outputText("  Poisonous bee venom coats your stinger completely.");
			if (player.tailVenom == 150)
				outputText("  Venom drips from your poisoned stinger regularly.");
		}
		if (player.tailType == Tail.MANTICORE_PUSSYTAIL) {
			outputText("  Your tail is covered in armored chitin from the base to the tip, it ends in a flower-like bulb. You can open and close your tail tip at will and its pussy-like interior can be used to milk male organs. ");
			outputText("The deadly set of spikes covering the tip regularly drips with your potent venom. When impaling your tail spikes in a prey isn’t enough you can fling them at a target on a whim like the most talented archer.");
		}
		if (player.tailType == Tail.MANTIS_ABDOMEN)
			outputText("  A large insectile mantis-abdomen dangles from just above your backside, bobbing with its own weight as you shift.  It is covered in hard greenish chitinous material.");
		if (player.tailType == Tail.SHARK) {
			outputText("  A long shark-tail trails down from your backside, swaying to and fro while giving you a dangerous air.");
		}
		if (player.tailType == Tail.CAT) {
			outputText("  A soft [skin coat.color] cat-tail sprouts just above your " + buttDescript() + ", curling and twisting with every step to maintain perfect balance.");
		}
		if (player.tailType == Tail.LIZARD) {
			outputText("  A tapered tail hangs down from just above your " + assDescript() + ".  It sways back and forth, assisting you with keeping your balance.");
		}
		if (player.tailType == Tail.SALAMANDER) {
			outputText("  A tapered, covered in red scales tail hangs down from just above your " + assDescript() + ".  It sways back and forth, assisting you with keeping your balance. When you are in battle or when you want could set ablaze whole tail in red-hot fire.");
		}
		if (player.tailType == Tail.RABBIT)
			outputText("  A short, soft bunny tail sprouts just above your " + assDescript() + ", twitching constantly whenever you don't think about it.");
		else if (player.tailType == Tail.HARPY)
			outputText("  A tail of feathers fans out from just above your " + assDescript() + ", twitching instinctively to help guide you if you were to take flight.");
		else if (player.tailType == Tail.KANGAROO) {
			outputText("  A conical, ");
			if (player.hasFur()) outputText("furry, " + player.coatColor);
			else outputText("gooey, " + player.skinTone);
			outputText(", tail extends from your " + assDescript() + ", bouncing up and down as you move and helping to counterbalance you.");
		}
		else if (player.tailType == Tail.FOX) {
			if (player.tailCount <= 1)
				outputText("  A swishing [skin coat.color] fox's brush extends from your " + assDescript() + ", curling around your body - the soft fur feels lovely.");
			else outputText("  " + Num2Text(player.tailCount) + " swishing [skin coat.color] fox's tails extend from your " + assDescript() + ", curling around your body - the soft fur feels lovely.");
		}
		else if (player.tailType == Tail.DRACONIC) {
			outputText("  A thin, scaly, prehensile reptilian tail, almost as long as you are tall, swings behind you like a living bullwhip.  Its tip menaces with spikes of bone, meant to deliver painful blows.");
		}
		//appearance
		else if (player.tailType == Tail.RACCOON) {
			outputText("  A black-and-[skin coat.color]-ringed raccoon tail waves behind you.");
		}
		else if (player.tailType == Tail.MOUSE) {
			//appearance
			outputText("  A naked, " + player.skinTone + " mouse tail pokes from your butt, dragging on the ground and twitching occasionally.");
		}
		//<mod>
		else if (player.tailType == Tail.BEHEMOTH) {
			outputText("  A long seemingly-tapering tail pokes from your butt, ending in spikes just like behemoth's.");
		}
		else if (player.tailType == Tail.PIG) {
			outputText("  A short, curly pig tail sprouts from just above your butt.");
		}
		else if (player.tailType == Tail.GOAT) {
			outputText("  A very short, stubby goat tail sprouts from just above your butt.");
		}
		else if (player.tailType == Tail.RHINO) {
			outputText("  A ropey rhino tail sprouts from just above your butt, swishing from time to time.");
		}
		else if (player.tailType == Tail.ECHIDNA) {
			outputText("  A stumpy echidna tail forms just about your [ass].");
		}
		else if (player.tailType == Tail.DEER) {
			outputText("  A very short, stubby deer tail sprouts from just above your butt.");
		}
		else if (player.tailType == Tail.WOLF) {
			outputText("  A bushy [skin coat.color] wolf tail sprouts just above your " + assDescript() + ", wagging to and fro whenever you are happy.");
		}
		else if (player.tailType == Tail.GARGOYLE) {
			outputText("  A long spiked tail hangs down from just above your " + assDescript() + ". It sways back and forth assisting in keeping your balance.");
		}
		else if (player.tailType == Tail.GARGOYLE_2) {
			outputText("  A long tail ending with an axe blade on both sides hangs down from just above your " + assDescript() + ". It sways back and forth assisting in keeping your balance.");
		}
		else if (player.tailType == Tail.ORCA) {
			outputText("  A long, powerful Orca tail trails down from your backside, swaying to and fro, always ready to propulse you through the water or smack an opponent on the head. It has a huge fin at the end and a smaller one not so far from your ass.");
		}
		else if (player.tailType == Tail.YGGDRASIL) {
			outputText("  A thin prehensile reptilian tail swings behind, covered by [skin coat]. Adorning the tip of your tail is a leaf, bobbing with each of your tail’s movements.");
		}
		else if (player.tailType == Tail.RAIJU) {
			outputText("  Your silky tail extends out from just above your " + assDescript() + ". Its fur is lovely to the touch and almost glows at the tip, letting others know of your lightning based motif.");
		}
		else if (player.tailType == Tail.RED_PANDA) {
			outputText("  Sprouting from your [ass], you have a long, bushy tail. It has a beautiful pattern of rings in [skin coat.color] fluffy fur. It waves playfully as you walk giving to your step a mesmerizing touch.");
		}
		else if(player.tailType == Tail.LION) {
			outputText("  A soft [skin coat.color] cat-tail sprouts just above your " + assDescript() + ", curling and twisting with every step to maintain perfect balance. It ends with a small puffy hair balls like that of a lion");
		}
		else if (player.tailType == Tail.AVIAN) {
			outputText("  A tail shaped like a fan of long, [skin coat.color] feathers rests above your " + assDescript() + ", twitching instinctively to help guide you if you were to take flight.");
		}
		else if (player.tailType == Tail.GRIFFIN) {
			outputText("  From your backside hangs a long tail, leonine in shape and covered mostly by a layer of [skin coat.color2] fur with a tip made of a tuft of [skin coat.color] colored feathers. It moves sinuously as you walk.");
		}
	}
	public function describeArms():void {
//Wing arms
		var armType:Number = player.arms.type;
		if (armType == Arms.HARPY)
			outputText("  Feathers hang off your arms from shoulder to wrist, giving them a slightly wing-like look.");
		if (armType == Arms.PHOENIX)
			outputText("  Crimson feathers hang off your arms from shoulder to wrist, giving them a slightly wing-like look.");
		else if (armType == Arms.SPIDER)
			outputText("  Shining black exoskeleton covers your arms from the biceps down, resembling a pair of long black gloves from a distance.");
		else if (armType == Arms.MANTIS)
			outputText("  Shining green exoskeleton covers your arms from the biceps down with a long and sharp scythes extending from the wrists.");
		else if (armType == Arms.BEE)
			outputText("  Shining black exoskeleton covers your arms from the biceps down, resembling a pair of long black gloves ended with a yellow fuzz from a distance.");
		else if (armType == Arms.SALAMANDER)
			outputText("  Shining thick, leathery red scales covers your arms from the biceps down and your fingernails are now a short curved claws.");
		else if (armType == Arms.PLANT)
			outputText("  Delicate vines crawl down from the upper parts of your arms to your wrists covered in spade-like leaves, that bob whenever you move.");
		else if(armType == Arms.SPHINX)
			outputText("  Your arms are covered with [skin coat.color] fur. They end with somewhat human-like hands armed with lethal claws.");
		else if (armType == Arms.PLANT2)
			outputText("  Vines crawl down from your shoulders to your wrists, tipped with slits that drool precum. They look like innocent decorations from a distance.");
		else if (armType == Arms.SHARK)
			outputText("  A middle sized shark-like fin has sprouted on each of your forearms near the elbow.  Additionaly skin between your fingers forming a small webbings helpful when swimming.");
		else if (armType == Arms.GARGOYLE) {
			outputText("  Your ");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) outputText("marble");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) outputText("alabaster");
			outputText(" arms end in stone sharp clawed hands.");
		}
		else if (armType == Arms.GARGOYLE_2) {
			outputText("  Your ");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) outputText("marble");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) outputText("alabaster");
			outputText(" arms end in normal human like hands.");
		}
		else if (armType == Arms.WOLF || armType == Arms.FOX)
			outputText("  Your arms are covered in thick fur ending up with clawed hands with animal like paw pads.");
		else if (armType == Arms.LION)
			outputText("  Your arms are covered in [skin coat.color] up to your shoulder where it turns to white. They end with a pair of five-toed lion paws armed with lethal claws.");
		else if (armType == Arms.KITSUNE)
			outputText("  Your arms are somewhat human save for your sharp nails.");
		else if (armType == Arms.LIZARD || armType == Arms.DRAGON)
			outputText("  Shining thick, leathery scales covers your arms from the biceps down and your fingernails are now a short curved claws.");
		else if (armType == Arms.YETI)
			outputText("  Your two arms covered with thick fur end with large, powerful yeti hands. You can use them to smash or punch things when you're angry.");
		else if (armType == Arms.ORCA)
			outputText("  A middle sized orca-like fin has sprouted on each of your forearms near the elbow. Additionally, the skin between your fingers forms a small webbing that is helpful when swimming.");
		else if (armType == Arms.DEVIL)
			outputText("  Your forearms are covered with fur and end with four finger paws like hands, but armed with claws. Despite their weird shape you have more then enough manual dexterity to draw even the most complex magical designs when spellcasting.");
		else if (armType == Arms.ONI)
			outputText("  Your arms are mostly human, although covered in warlike tattoos. You have human hands with sharp black nails.");
		else if (armType == Arms.ELF)
			outputText("  Your delicate elven hands are almost supernaturally dexterous allowing you to manipulate objects or cast spells with inhuman agility.");
		else if (armType == Arms.RAIJU)
			outputText("  Your arms and hands are practically human save for the sharp white claws that have replaced your normal nails.");
		else if (armType == Arms.RED_PANDA)
			outputText("  Soft, black-brown fluff cover your arms. Your paws have cute, pink paw pads and short claws.");
		else if (armType == Arms.CAT)
			outputText("  Your arms are covered in [skin coat.color] up to your shoulder. They end with a pair of five-toed cat paws armed with lethal claws.");
		else if (armType == Arms.AVIAN)
			outputText("  Your arms are covered with [skin coat.color] colored feathers just a bit past your elbow. Your humanoid hands have " + player.skinTone + ", slightly rough skin and end in short claws.");
		else if (armType == Arms.GRYPHON)
			outputText("  The feathers on your arms reach a bit past your elbows, the fringe of [skin coat.color] plumage leading to your " + player.skinTone + ", slightly rough skinned hands. They end in short, avian claws.");
		if (player.wings.type == Wings.BAT_ARM ){
			outputText("  Your arm bones are thin and light in order to allow flight. You have grown a few extra fingers, which allow you to hold various items even with your abnormal hands, albeit at the cost of preventing flight while doing so.");
		}
	}
	public function describeRearBody():void {
		if (player.rearBody.type == RearBody.FENRIR_ICE_SPIKES) {
			outputText("  Jagged ice shards grows out of your back providing both excellent defence and giving you a menacing look.");
		}
		else if (player.rearBody.type == RearBody.LION_MANE) {
			outputText("  Around your neck there is a thick mane of fur. It looks great on you.");
		}
		else if (player.rearBody.type == RearBody.SHARK_FIN) {
			outputText("  A large shark-like fin has sprouted between your shoulder blades.  With it you have far more control over swimming underwater.");
		}
		else if (player.rearBody.type == RearBody.ORCA_BLOWHOLE) {
			outputText("  Between your shoulder blades is a blowhole that allows to breath in air from your back while swimming, just like an orca.");
		}
		else if (player.rearBody.type == RearBody.RAIJU_MANE) {
			outputText("  A thick collar of fur grows around your neck. Multiple strands of fur are colored in a dark shade, making it look like a lightning bolt runs along the center of your fur collar.");
		}
		if (player.rearBody.type == RearBody.BAT_COLLAR){
			outputText("  Around your neck is a thick collar of fur reminiscent of a bat's.");
		}
		if (player.rearBody.type == RearBody.WOLF_COLLAR){
			outputText("  Around your neck there is a thick coat of [skin coat.color] fur. It looks great on you. That said, you can dismiss every one of your bestial features at any time should the need arise for you to appear human.");
		}
	}
	public function describeWings():void {
//WINGS!
		var wingType:Number = player.wings.type;
		if (wingType == Wings.BEE_LIKE_SMALL)
			outputText("  A pair of tiny-yet-beautiful bee-wings sprout from your back, too small to allow you to fly.");
		if (wingType == Wings.BEE_LIKE_LARGE)
			outputText("  A pair of large bee-wings sprout from your back, reflecting the light through their clear membranes beautifully.  They flap quickly, allowing you to easily hover in place or fly.");
		if (wingType == Wings.MANTIS_LIKE_SMALL)
			outputText("  A pair of tiny mantis-wings sprout from your back, too small to allow you to fly.");
		if (wingType == Wings.MANTIS_LIKE_LARGE)
			outputText("  A pair of large mantis-wings sprout from your back, reflecting the light through their clear membranes beautifully.  They flap quickly, allowing you to easily hover in place or fly.");
		if (wingType == Wings.BAT_LIKE_TINY)
			outputText("  A pair of tiny bat-like demon-wings sprout from your back, flapping cutely, but otherwise being of little use.");
		if (wingType == Wings.BAT_LIKE_LARGE)
			outputText("  A pair of large bat-like demon-wings fold behind your shoulders.  With a muscle-twitch, you can extend them, and use them to soar gracefully through the air.");
		if (wingType == Wings.BAT_LIKE_LARGE_2)
			outputText("  Two pairs of large bat-like demon-wings fold behind your shoulders.  With a muscle-twitch, you can extend them, and use them to soar gracefully through the air.");
		if (wingType == Wings.MANTICORE_LIKE_SMALL)
			outputText("  A pair of small leathery wings covered with [skin coat.color] fur rest on your back. Despite being too small to allow flight they at least look cute on you.");
		if (wingType == Wings.MANTICORE_LIKE_LARGE)
			outputText("  A pair of large ominous leathery wings covered with [skin coat.color] fur expand from your back. You can open them wide to soar high in search of your next prey.");
		if (wingType == Wings.FEATHERED_LARGE)
			outputText("  A pair of large, feathery wings sprout from your back.  Though you usually keep the [haircolor]-colored wings folded close, they can unfurl to allow you to soar as gracefully as a harpy.");
		if (wingType == Wings.FEATHERED_ALICORN)
			outputText("  A pair of large, feathery wings sprout from your back.  Though you usually keep the [haircolor]-colored wings folded close, they can unfurl to allow you to soar as gracefully as an alicorn.");
		if (wingType == Wings.FEATHERED_SPHINX)
			outputText("  A pair of large, feathery wings sprout from your back.  Though you usually keep the [haircolor]-colored wings folded close, they can unfurl to allow you to soar as gracefully as an sphinx.");
		if (wingType == Wings.FEATHERED_PHOENIX)
			outputText("  A pair of large, feathery wings sprout from your back.  Though you usually keep the crimson-colored wings folded close, they can unfurl to allow you to soar as gracefully as a phoenix.");
		if (wingType == Wings.DRACONIC_SMALL)
			outputText("  Small, vestigial wings sprout from your shoulders.  They might look like bat's wings, but the membranes are covered in fine, delicate scales.");
		else if (wingType == Wings.DRACONIC_LARGE)
			outputText("  Large wings sprout from your shoulders.  When unfurled they stretch further than your arm span, and a single beat of them is all you need to set out toward the sky.  They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone.");
		else if (wingType == Wings.DRACONIC_HUGE)
			outputText("  Magnificent huge wings sprout from your shoulders.  When unfurled they stretch over twice further than your arm span, and a single beat of them is all you need to set out toward the sky.  They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone.");
		else if (wingType == Wings.GIANT_DRAGONFLY)
			outputText("  Giant dragonfly wings hang from your shoulders.  At a whim, you could twist them into a whirring rhythm fast enough to lift you off the ground and allow you to fly.");
		else if (wingType == Wings.GARGOYLE_LIKE_LARGE) {
			outputText("  Large stony wings sprout from your shoulders. When unfurled they stretch wider than your arm span, and a single beat of them is all you need to set out toward the sky. They look a bit like ");
			if (flags[kFLAGS.GARGOYLE_WINGS_TYPE] == 1) outputText("bird");
			if (flags[kFLAGS.GARGOYLE_WINGS_TYPE] == 2) outputText("bat");
			outputText(" wings and, although they are clearly made of stone, they allow you to fly around with excellent aerial agility.");
		}
		else if (wingType == Wings.PLANT) {
			outputText("  Three pairs of oily, prehensile phalluses sprout from your shoulders and back. From afar, they may look like innocent vines, but up close, each tentacle contain a bulbous head with a leaking cum-slit, perfect for mass breeding.");
		}
		if (wingType == Wings.BAT_ARM){
			outputText("  Your large winged arms allow you to fly in a similar fashion to the bats they resemble. You sometimes wrap them around you like a cape when you walk around, so as to keep them from encumbering you. That being said, you far prefer using them for their intended purpose, traveling by flight whenever you can.");
		}
		if (wingType == Wings.VAMPIRE){
			outputText("   Between your shoulder blades rest a pair of large, ominous black wings reminiscent of a bat’s. They can unfurl up to twice your arm’s length, allowing you to gracefully dance in the night sky.");
		}
		if (wingType == Wings.FEY_DRAGON_WINGS){
			outputText("  Magnificent huge wings sprout from your shoulders.  When unfurled they stretch over twice further than your arm span, and a single beat of them is all you need to set out toward the sky.  They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone.  While draconic in appearance the delicate frame of your fey like dragon wings allows for even better speed and maneuverability.");
		}
		if (wingType == Wings.FEATHERED_AVIAN){
			outputText("  A pair of large, feathery wings sprout from your back. Though you usually keep the [skin coat.color] wings folded close, they can unfurl to allow you to soar as gracefully as a bird.");
		}
		if (wingType == Wings.NIGHTMARE){
			outputText("  A pair of large ominous black leathery wings expand from your back. You can open them wide to soar high in the sky.");
		}
	}
	public function describeHorns():void {
//Horns
		//Demonic horns
		if (player.horns.type == Horns.DEMON) {
			if (player.horns.count == 2)
				outputText("  A small pair of pointed horns has broken through the [skin.type] on your forehead, proclaiming some demonic taint to any who see them.");
			if (player.horns.count == 4)
				outputText("  A quartet of prominent horns has broken through your [skin.type].  The back pair are longer, and curve back along your head.  The front pair protrude forward demonically.");
			if (player.horns.count == 6)
				outputText("  Six horns have sprouted through your [skin.type], the back two pairs curve backwards over your head and down towards your neck, while the front two horns stand almost eight inches long upwards and a little forward.");
			if (player.horns.count >= 8)
				outputText("  A large number of thick demonic horns sprout through your [skin.type], each pair sprouting behind the ones before.  The front jut forwards nearly ten inches while the rest curve back over your head, some of the points ending just below your ears.  You estimate you have a total of " + num2Text(player.horns.count) + " horns.");
		}
		//Minotaur horns
		if (player.horns.type == Horns.COW_MINOTAUR) {
			if (player.horns.count < 3)
				outputText("  Two tiny horns-like nubs protrude from your forehead, resembling the horns of the young livestock kept by your village.");
			if (player.horns.count >= 3 && player.horns.count < 6)
				outputText("  Two moderately sized horns grow from your forehead, similar in size to those on a young bovine.");
			if (player.horns.count >= 6 && player.horns.count < 12)
				outputText("  Two large horns sprout from your forehead, curving forwards like those of a bull.");
			if (player.horns.count >= 12 && player.horns.count < 20)
				outputText("  Two very large and dangerous looking horns sprout from your head, curving forward and over a foot long.  They have dangerous looking points.");
			if (player.horns.count >= 20)
				outputText("  Two huge horns erupt from your forehead, curving outward at first, then forwards.  The weight of them is heavy, and they end in dangerous looking points.");
		}
		//Lizard horns
		if (player.horns.type == Horns.DRACONIC_X2) {
			outputText("  A pair of " + Measurements.inchesOrCentimetres(int(player.horns.count)) + " horns grow from the sides of your head, sweeping backwards and adding to your imposing visage.");
		}
		//Super lizard horns
		if (player.horns.type == Horns.DRACONIC_X4_12_INCH_LONG)
			outputText("  Two pairs of horns, roughly a foot long, sprout from the sides of your head.  They sweep back and give you a fearsome look, almost like the dragons from your village's legends.");
		//Antlers!
		if (player.horns.type == Horns.ANTLERS) {
			if (player.horns.count > 0)
				outputText("  Two antlers, forking into " + num2Text(player.horns.count) + " points, have sprouted from the top of your head, forming a spiky, regal crown of bone.");
		}
		if (player.horns.type == Horns.GOAT) {
			if (player.horns.count == 1)
				outputText("  A pair of stubby goat horns sprout from the sides of your head.");
			else
				outputText("  A pair of tall-standing goat horns sprout from the sides of your head.  They are curved and patterned with ridges.");
		}
		if (player.horns.type == Horns.RHINO) {
			if (player.horns.count >= 2) {
				if (player.faceType == Face.RHINO)
					outputText("  A second horns sprouts from your forehead just above the horns on your nose.");
				else
					outputText("  A single horns sprouts from your forehead.  It is conical and resembles a rhino's horns.");
				outputText("  You estimate it to be about seven inches long.");
			}
			else {
				outputText("  A single horns sprouts from your forehead.  It is conical and resembles a rhino's horns.  You estimate it to be about six inches long.");
			}

		}
		if (player.horns.type == Horns.UNICORN) {
			if (player.horns.count < 3)
				outputText("  Tiny horns-like nub protrude from your forehead, resembling the horns of the young unicorn.");
			if (player.horns.count >= 3 && player.horns.count < 6)
				outputText("  One moderately sized horns grow from your forehead, similar in size to those on a young unicorn.");
			if (player.horns.count >= 6 && player.horns.count < 12)
				outputText("  One large horns sprout from your forehead, spiraling and pointing forwards like those of an unicorn.");
			if (player.horns.count >= 12 && player.horns.count < 20)
				outputText("  One very large and dangerous looking spiraling horns sprout from your forehead, pointing forward and over a foot long.  It have dangerous looking tip.");
			if (player.horns.count >= 20)
				outputText("  One huge and long spiraling horns erupt from your forehead, pointing forward.  The weight of it is heavy and ends with dangerous and sharp looking tip.");
		}
		if (player.horns.type == Horns.BICORN) {
			if (player.horns.count < 3)
				outputText("  A pair of tiny horns-like nub protrude from your forehead, resembling the horns of the young bicorns.");
			if (player.horns.count >= 3 && player.horns.count < 6)
				outputText("  Two moderately sized horns grow from your forehead, similar in size to those on a young bicorn.");
			if (player.horns.count >= 6 && player.horns.count < 12)
				outputText("  Two large horns sprout from your forehead, spiraling and pointing forwards like those of a bicorn.");
			if (player.horns.count >= 12 && player.horns.count < 20)
				outputText("  Two very large and dangerous looking spiraling horns sprout from your forehead, pointing forward and over a foot long.  They have dangerous looking tip.");
			if (player.horns.count >= 20)
				outputText("  Two huge and long spiraling horns erupt from your forehead, pointing forward.  The weight of them is heavy and ends with dangerous and sharp looking tips.");
		}
		if (player.horns.type == Horns.OAK) {
			if (player.horns.count > 0)
				outputText("  Two branches, forking into " + num2Text(player.horns.count) + " points, have sprouted from the top of your head, forming a spiky, regal crown made of oak wood.");
		}
		if (player.horns.type == Horns.GARGOYLE) {
			if (player.horns.count > 0)
				outputText("  A large pair of thick demonic looking horns sprout through the side of your head giving you a fiendish appearance.");
		}
		if (player.horns.type == Horns.ORCHID) {
			if (player.horns.count > 0)
				outputText("  A huge pair of orchids grows on each side of your head, their big long petals flopping gaily when you move.");
		}
		if (player.horns.type == Horns.ONI_X2) {
			if (player.horns.count > 0)
				outputText("  You have a pair of horns on your head warning anyone who looks that you are an oni and do mean serious business.");
		}
		if (player.horns.type == Horns.ONI) {
			if (player.horns.count > 0)
				outputText("  You have a single horns on your head warning anyone who looks that you are an oni and do mean serious business.");
		}
	}
	public function describeTongue():void {
//Tongue
		if (player.tongue.type == Tongue.SNAKE)
			outputText("  A snake-like tongue occasionally flits between your lips, tasting the air.");
		else if (player.tongue.type == Tongue.DEMONIC)
			outputText("  A slowly undulating tongue occasionally slips from between your lips.  It hangs nearly two feet long when you let the whole thing slide out, though you can retract it to appear normal.");
		else if (player.tongue.type == Tongue.DRACONIC)
			outputText("  Your mouth contains a thick, fleshy tongue that, if you so desire, can telescope to a distance of about four feet.  It has sufficient manual dexterity that you can use it almost like a third arm.");
		else if (player.tongue.type == Tongue.ECHIDNA)
			outputText("  A thin echidna tongue, at least a foot long, occasionally flits out from between your lips.");
		else if (player.tongue.type == Tongue.CAT)
			outputText("  Your tongue is rough like that of a cat. You sometimes groom yourself with it.");
		else if (player.tongue.type == Tongue.ELF)
			outputText("  One could mistake you for a human but your voice is unnaturally beautiful and melodious giving you away as something else.");
		else if (player.tongue.type == Tongue.DOG)
			outputText("  You sometime let your panting canine tongue out to vent heat.");
	}
	public function describeBeard():void {
//Beards!
		if (player.beardLength > 0) {
			outputText("  You have a " + beardDescript() + " ");
			if (player.beardStyle != Beard.GOATEE) {
				outputText("covering your ");
				if (rand(2) == 0) outputText("jaw");
				else outputText("chin and cheeks")
			}
			else {
				outputText("protruding from your chin");
			}
			outputText(".");
		}
	}
	public function describeEyes():void {
		var eyeType:Number = player.eyes.type;
		if(eyeType == Eyes.FOUR_SPIDER_EYES)
			outputText("  In addition to your primary two [eyecolor] eyes, you have a second, smaller pair on your forehead.");
		else if(eyeType == Eyes.BLACK_EYES_SAND_TRAP)
			outputText("  Your eyes are solid spheres of inky, alien darkness.");
		else if(eyeType == Eyes.CAT_SLITS)
			outputText("  Your [eyecolor] eyes have vertically slit like those of cat.");
		else if(eyeType == Eyes.GORGON)
			outputText("  Your [eyecolor] eyes are similar to those of snake-like gorgons with ability to temporally petrify.");
		else if(eyeType == Eyes.FENRIR)
			outputText("  Your eyes glows with a freezing blue light icy smoke rising in the air around it.");
		else if(eyeType == Eyes.MANTICORE)
			outputText("  Your eyes are similar to those of a cat, with slit pupil. However, their [eyecolor] iris dismiss any links to the regular felines in favor of something way more ominous.");
		else if(eyeType == Eyes.FOX)
			outputText("  Your [eyecolor] eyes looks like those of a fox with a slit in the middle.");
		else if(eyeType == Eyes.REPTILIAN)
			outputText("  Your eyes looks like those of a reptile with [eyecolor] irises and a slit.");
		else if(eyeType == Eyes.SNAKE)
			outputText("  Your [eyecolor] eyes have slitted pupils like that of a snake.");
		else if(eyeType == Eyes.DRAGON)
			outputText("  Your [eyecolor] eyes have slitted pupils like that of a dragon.");
		else if(player.eyes.type == Eyes.DEVIL)
			outputText("  Your eyes look fiendish with their black sclera and glowing [eyecolor] irises.");
		else if(eyeType == Eyes.ONI)
			outputText("  Your eyes look normal enough save for their fiendish [eyecolor] iris and slitted pupils.");
		else if(eyeType == Eyes.ELF)
			outputText("  Your [eyecolor] elven eyes looks somewhat human, save for their cat-like vertical slit which draws light right in, allowing you to see with perfect precision both at day and night time.");
		else if(eyeType == Eyes.RAIJU)
			outputText("  Your eyes are of an electric [eyecolor] hue that constantly glows with voltage power. They have slitted pupils like those of a beast.");
		else if(eyeType == Eyes.VAMPIRE){
			outputText("  Your eyes looks somewhat normal, but their blood-red irises seem to have the tendency of drawing in people’s gaze, like moths to a flame.");
		}
		else if(eyeType == Eyes.GEMSTONES){
			outputText("  Instead of regular eyes you see through a pair of gemstones that change hue based on your mood.");
		}
		else if(eyeType == Eyes.FERAL){
			outputText("  In your eyes sometime dance a green light. It encompass your entire pupil when you let the beast within loose.");
		}
		else if(eyeType == Eyes.GRYPHON){
			outputText("  Your gifted eyes have a bird-like appearance, having an [eyecolor] sclera and a large, black iris. A thin ring of black separates your sclera from your outer iris.");
		}
		else outputText("  Your eyes are [eyecolor].");
	}
	public function describeHairAndEars():void {
		//if bald
		var earType:Number = player.ears.type;
		if(player.hairLength == 0)
		{
			if(player.skinType == Skin.FUR)
				outputText("  You have no hair, only a thin layer of fur atop of your head.  ");
			else {
				outputText("  You are totally bald, showing only shiny " + player.skinTone + " [skin.type]");
				if(player.skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
				else if(player.skin.hasBattleTattoo()) outputText(" covered with battle tattoo");
				else if(player.skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos");
				outputText(" where your hair should be.");
			}
			if(earType == Ears.HORSE)
				outputText("  A pair of horse-like ears rise up from the top of your head.");
			else if(earType == Ears.FERRET)
				outputText("  A pair of small, rounded ferret ears sit on top of your head.");
			else if(earType == Ears.DOG)
				outputText("  A pair of dog ears protrude from your skull, flopping down adorably.");
			else if(earType == Ears.COW)
				outputText("  A pair of round, floppy cow ears protrude from the sides of your skull.");
			else if(earType == Ears.ELFIN)
				outputText("  A pair of large pointy ears stick out from your skull.");
			else if(earType == Ears.CAT)
				outputText("  A pair of cute, fuzzy cat ears have sprouted from the top of your head.");
			else if(earType == Ears.PIG)
				outputText("  A pair of pointy, floppy pig ears have sprouted from the top of your head.");
			else if(earType == Ears.LIZARD)
				outputText("  A pair of rounded protrusions with small holes on the sides of your head serve as your ears.");
			else if(earType == Ears.BUNNY)
				outputText("  A pair of floppy rabbit ears stick up from the top of your head, flopping around as you walk.");
			else if(earType == Ears.FOX)
				outputText("  A pair of large, adept fox ears sit high on your head, always listening.");
			else if(earType == Ears.DRAGON)
				outputText("  A pair of rounded protrusions with small holes on the sides of your head serve as your ears.  Bony fins sprout behind them.");
			else if(earType == Ears.RACCOON)
				outputText("  A pair of vaguely egg-shaped, furry raccoon ears adorns your head.");
			else if(earType == Ears.MOUSE)
				outputText("  A pair of large, dish-shaped mouse ears tops your head.");
			else if (earType == Ears.PIG)
				outputText("  A pair of pointy, floppy pig ears have sprouted from the top of your head.");
			else if (earType == Ears.RHINO)
				outputText("  A pair of open tubular rhino ears protrude from your head.");
			else if (earType == Ears.ECHIDNA)
				outputText("  A pair of small rounded openings appear on your head that are your ears.");
			else if (earType == Ears.DEER)
				outputText("  A pair of deer-like ears rise up from the top of your head.");
			else if(earType == Ears.WOLF)
				outputText("  A pair of pointed wolf ears rise up from the top of your head.");
			else if(earType == Ears.LION)
				outputText("  A pair of lion ears have sprouted from the top of your head.");
			else if(earType == Ears.YETI)
				outputText("  A pair of yeti ears, bigger than your old human ones have sprouted from the top of your head.");
			else if(earType == Ears.ORCA)
				outputText("  A pair of very large fin at least twice as large as your head which help you orient yourself underwater have sprouted from the top of your head. Their underside is white while the top is black.");
			else if(earType == Ears.SNAKE)
				outputText("  A pair of large pointy ears covered in small scales stick out from your skull.");
			else if(earType == Ears.GOAT)
				outputText("  A pair or ears looking similar to those of a goat flapping from time to time in response to sounds.");
			else if(earType == Ears.ONI)
				outputText("  A pair of pointed elf-like oni ears stick out from your skull.");
			else if(earType == Ears.ELVEN)
				outputText("  A pair of cute, long, elven, pointy ears, bigger than your old human ones and alert to every sound stick out from your skull.");
			else if(earType == Ears.WEASEL)
				outputText("  A pair of sideways leaning weasel ears that flick toward every slight sound stick out from your skull.");
			if (earType == Ears.BAT){
				outputText("  A pair of bat ears sit atop your head, always perked up to catch any stray sound.");
			}
			if (earType == Ears.VAMPIRE){
				outputText("  A pair of pointed elfin ears powerful enough to catch even the heartbeat of those around you stick out from your skull.");
			}
			if (earType == Ears.RED_PANDA){
				outputText("  Big, white furred, red-panda ears lie atop your head, keeping you well aware to your surroundings.");
			}
			if (earType == Ears.AVIAN){
				outputText("  Two small holes at each side of your head serve you as ears. Hidden by tufts of feathers, they’re almost unnoticeable.");
			}
			if (earType == Ears.GRYPHON){
				outputText("  A duo of triangular, streamlined ears are located at each side of your head, helping you to pinpoint sounds. They’re covered in soft, [skin coat.color] fur and end in tufts.");
			}
			//</mod>
			if (player.gills.type == Gills.FISH)
			{
				outputText("  A set of fish like gills reside on your neck, several small slits that can close flat against your skin."
						   +" They allow you to stay in the water for quite a long time.");
			}
			// ANEMONE are handled below
			if(player.antennae.type == Antennae.MANTIS)
				outputText("  Long prehensile antennae.type also appear on your skull, bouncing and swaying in the breeze.");
			if(player.antennae.type == Antennae.BEE)
				outputText("  Floppy antennae.type also appear on your skull, bouncing and swaying in the breeze.");
		}
		//not bald
		else
		{
			if(earType == Ears.HUMAN)
				outputText("  Your [hair] looks good on you, accentuating your features well.");
			else if(earType == Ears.FERRET)
				outputText("  A pair of small, rounded ferret ears burst through the top of your [hair].");
			else if(earType == Ears.HORSE)
				outputText("  The [hair] on your head parts around a pair of very horse-like ears that grow up from your head.");
			else if(earType == Ears.DOG)
				outputText("  The [hair] on your head is overlapped by a pair of pointed dog ears.");
			else if(earType == Ears.COW)
				outputText("  The [hair] on your head is parted by a pair of rounded cow ears that stick out sideways.");
			else if(earType == Ears.ELFIN)
				outputText("  The [hair] on your head is parted by a pair of cute pointed ears, bigger than your old human ones.");
			else if(earType == Ears.CAT)
				outputText("  The [hair] on your head is parted by a pair of cute, fuzzy cat ears, sprouting from atop your head and pivoting towards any sudden noises.");
			else if(earType == Ears.LIZARD)
				outputText("  The [hair] atop your head makes it nigh-impossible to notice the two small rounded openings that are your ears.");
			else if(earType == Ears.BUNNY)
				outputText("  A pair of floppy rabbit ears stick up out of your [hair], bouncing around as you walk.");
			else if(earType == Ears.KANGAROO)
				outputText("  The [hair] atop your head is parted by a pair of long, furred kangaroo ears that stick out at an angle.");
			else if(earType == Ears.FOX)
				outputText("  The [hair] atop your head is parted by a pair of large, adept fox ears that always seem to be listening.");
			else if(earType == Ears.DRAGON)
				outputText("  The [hair] atop your head is parted by a pair of rounded protrusions with small holes on the sides of your head serve as your ears.  Bony fins sprout behind them.");
			else if(earType == Ears.RACCOON)
				outputText("  The [hair] on your head parts around a pair of egg-shaped, furry raccoon ears.");
			else if(earType == Ears.MOUSE)
				outputText("  The [hair] atop your head is funneled between and around a pair of large, dish-shaped mouse ears that stick up prominently.");
			else if(earType == Ears.PIG)
				outputText("  The [hair] on your head is parted by a pair of pointy, floppy pig ears. They often flick about when you’re not thinking about it.");
			else if(earType == Ears.RHINO)
				outputText("  The [hair] on your head is parted by a pair of tubular rhino ears.");
			else if(earType == Ears.ECHIDNA)
				outputText("  Your [hair] makes it near-impossible to see the small, rounded openings that are your ears.");
			else if(earType == Ears.DEER)
				outputText("  The [hair] on your head parts around a pair of deer-like ears that grow up from your head.");
			else if(earType == Ears.WOLF)
				outputText("  The [hair] on your head is overlapped by a pair of pointed wolf ears.");
			else if(earType == Ears.LION)
				outputText("  The [hair] is parted by a pair of lion ears that listen to every sound.");
			else if(earType == Ears.YETI)
				outputText("  The [hair] is parted by a pair of yeti ears, bigger than your old human ones.");
			else if(earType == Ears.ORCA)
				outputText("  The [hair] on your head is parted by a pair of very large fin at least twice as large as your head which help you orient yourself underwater. Their underside is white while the top is black.");
			else if(earType == Ears.SNAKE)
				outputText("  The [hair] on your head is parted by a pair of cute pointed ears covered in small scales, bigger than your old human ones.");
			else if(earType == Ears.GOAT)
				outputText("  The [hair] on your head is parted by a pair or ears looking similar to those of a goat flapping from time to time in response to sounds.");
			else if(earType == Ears.ONI)
				outputText("  The [hair] on your head is parted by a pair of pointed elf-like oni ears.");
			else if(earType == Ears.ELVEN) {
				outputText("  The [hair] is parted by a pair of cute, long, elven, pointy ears, bigger than your old human ones and alert to every sound");
				//if (player.hairType == SILKEN) outputText(" .");
				outputText(".");
			}
			else if(earType == Ears.WEASEL)
				outputText("  Your [hair] is parted by two sideways leaning weasel ears that flick toward every slight sound.");
			if (earType == Ears.BAT){
				outputText("  The [hair] on your head is parted by large bat ears atop your head, always perked up to catch any stray sound.");
			}
			if (earType == Ears.VAMPIRE){
				outputText("  The [hair] on your head is  parted by pointed elfin ears powerful enough to catch even the heartbeat of those around you.")
			}
			if (earType == Ears.RED_PANDA) {
				outputText("  Big, white furred, red-panda ears lie atop your head, keeping you well aware to your surroundings.")
			}
			if (earType == Ears.AVIAN){
				outputText("  The [hair] atop your head compliments you quite well, and two small holes at each side of your head serve you as ears. Hidden by tufts of feathers, they’re almost unnoticeable.");
			}
			if (earType == Ears.GRYPHON){
				outputText("  Two triangular ears part your [hair] at each side of your head. They’re streamlined and adapted to fly, and are quite useful to locate sounds. They’re covered in soft, [skin coat.color] fur and end in tufts.");
			}
			//</mod>
			if(player.antennae.type == Antennae.MANTIS)
			{
				if(earType == Ears.BUNNY)
					outputText("  Long prehensile antennae.type also grow from just behind your hairline, waving and swaying in the breeze with your ears.");
				else outputText("  Long prehensile antennae.type also grow from just behind your hairline, bouncing and swaying in the breeze.");
			}
			if(player.antennae.type == Antennae.BEE)
			{
				if(earType == Ears.BUNNY)
					outputText("  Limp antennae.type also grow from just behind your hairline, waving and swaying in the breeze with your ears.");
				else outputText("  Floppy antennae.type also grow from just behind your hairline, bouncing and swaying in the breeze.");
			}
		}
	}
	public function describeFaceShape():void {
		// story.display("faceShape");
		var faceType:Number = player.faceType;
		var skin:Skin = player.skin;
		if (player.facePart.isHumanShaped()) {
			var odd:int = 0;
			var skinAndSomething:String = "";
			if (player.facePart.type == Face.BUCKTEETH) {
				skinAndSomething = " and mousey buckteeth";
				odd++;
			}
			if (skin.coverage<Skin.COVERAGE_COMPLETE) {
				outputText("  Your face is human in shape and structure, with [skin]"+skinAndSomething);
				if (skin.hasMagicalTattoo()) {
					outputText(" covered with magical tattoo");
					odd++;
				}
				else if (skin.hasBattleTattoo()) {
					outputText(" covered with battle tattoo");
					odd++;
				}
				else if (skin.hasLightningShapedTattoo()) {
					outputText(" covered with a few glowing lightning tattoos");
					odd++;
				}
				if (skin.isCoverLowMid()) {
					outputText(".");
					outputText("  On your cheek you have [skin coat]");
					odd++;
				}
			} else if (skin.hasCoatOfType(Skin.FUR)) {
				odd++;
				outputText("  Under your [skin coat] you have a human-shaped head with [skin base]"+skinAndSomething);
			} else if (skin.hasCoat() && !skinAndSomething) {
				odd++;
				outputText("  Your face is fairly human in shape, but is covered in [skin coat]");
			} else outputText("  Your face is human in shape and structure, with [skin full]"+skinAndSomething);
			outputText(".");

			if (faceType == Face.SHARK_TEETH)
				outputText("  A set of razor-sharp, retractable shark-teeth fill your mouth and gives your visage a slightly angular appearance.");
			else if (faceType == Face.BUNNY)
				outputText("  The constant twitches of your nose and the length of your incisors gives your visage a hint of bunny-like cuteness.");
			else if (faceType == Face.SPIDER_FANGS)
				outputText("  A set of retractable, needle-like fangs sit in place of your canines and are ready to dispense their venom.");
			else if (faceType == Face.FERRET_MASK)
				outputText("  The [skinFurScales] around your eyes is significantly darker than the rest of your face, giving you a cute little ferret mask.");
			else if (faceType == Face.MANTICORE)
				outputText("  You have a set of sharp cat-like teeth in your mouth.");
			else if (faceType == Face.SNAKE_FANGS) {
				if (odd==0) {
					outputText("  The only oddity is your pair of dripping fangs which often hang over your lower lip.");
				} else {
					outputText("  In addition, a pair of fangs hang over your lower lip, dripping with venom.");
				}
			} else if (faceType == Face.SALAMANDER_FANGS) {
				if (odd == 0) {
					outputText(".  The only oddity is your salamander fangs giving you a menacing smile.");
				} else {
					outputText("  In addition, a pair of salamander fangs grows out of your mouth giving you a menacing smile.");
				}
			} else if (faceType == Face.YETI_FANGS) {
				if (odd == 0){
					outputText(".  Your mouth, while human looking, has sharp yeti fangs not unlike those of a monkey.");
				} else {
					outputText("  In addition, your mouth, while human looking, has sharp yeti fangs not unlike those of a monkey.");
				}
			}
			if(faceType == Face.VAMPIRE){
				outputText("  Your mouth could pass for human if not for the pair of long and pointy canines you use to tear into your victims to get at their blood.");
			}
		} else if (faceType == Face.FERRET) {
			if (player.hasFullCoatOfType(Skin.FUR)) outputText("  Your face is coated in [skin coat] with [skin base] underneath, an adorable cross between human and ferret features.  It is complete with a wet nose and whiskers.");
			else if (player.hasCoat()) outputText("  Your face is an adorable cross between human and ferret features, complete with a wet nose and whiskers.  The only oddity is [skin base] covered with [skin coat].");
			else outputText("  Your face is an adorable cross between human and ferret features, complete with a wet nose and whiskers.  The only oddity is your lack of fur, leaving only [skin] visible on your ferret-like face.");
		}
		else if (faceType == Face.RACCOON_MASK) {
			if (!player.hasCoat()) { //appearance for skinheads
				outputText("  Your face is human in shape and structure, with [skin bases");
				if (InCollection(skin.base.color, "ebony", "black"))
					outputText(", though with your dusky hue, the black raccoon mask you sport isn't properly visible.");
				else if (skin.hasMagicalTattoo()) outputText(" covered with magical tattoo, though it is decorated with a sly-looking raccoon mask over your eyes.");
				else if(skin.hasBattleTattoo()) outputText(" covered with battle tattoo, though it is decorated with a sly-looking raccoon mask over your eyes.");
				else if(skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos, though it is decorated with a sly-looking raccoon mask over your eyes.");
				else outputText(", though it is decorated with a sly-looking raccoon mask over your eyes.");
			} else { //appearance furscales
				//(black/midnight furscales)
				if (InCollection(skin.base.color, "black", "midnight", "black", "midnight", "black", "midnight"))
					outputText("  Under your [skin coat] hides a black raccoon mask, barely visible due to your inky hue, and");
				else outputText("  Your [skin coat] are decorated with a sly-looking raccoon mask, and under them");
				outputText(" you have a human-shaped head with [skin base].");
			}
		}
		else if (faceType == Face.RACCOON) {
			outputText("  You have a triangular raccoon face, replete with sensitive whiskers and a little black nose; a mask shades the space around your eyes, set apart from your [skin coat] by a band of white.");
			//(if skin)
			if (player.hasPlainSkinOnly()) {
				outputText("  It looks a bit strange with only the skin and no fur.");
			} else if (skin.hasMagicalTattoo()) {
				outputText("  It looks a bit strange with only the skin covered with magical tattoo and no fur.");
			} else if (skin.hasBattleTattoo()) {
				outputText("  It looks a bit strange with only the skin covered with battle tattoo and no fur.");
			} else if (skin.hasLightningShapedTattoo()) {
				outputText("  It looks a bit strange with only the skin covered with a few glowing lightning tattoos and no fur.");
			} else if (player.hasScales()) {
				outputText("  The presence of said scales gives your visage an eerie look, more reptile than mammal.");
			} else if (skin.hasChitin()) {
				outputText("  The presence of said chitin gives your visage an eerie look, more insect than mammal.");
			}
		}
		else if (faceType == Face.FOX) {
			outputText("  You have a tapered, shrewd-looking vulpine face with a speckling of downward-curved whiskers just behind the nose.");
			if (!player.hasCoat()) {
				outputText("  Oddly enough, there's no fur on your animalistic muzzle, just [skin coat].");
			} else if (skin.hasMagicalTattoo()) {
				outputText("  Oddly enough, there's no fur on your animalistic muzzle, just [skin coat] covered with magical tattoo.");
			} else if (skin.hasBattleTattoo()) {
				outputText("  Oddly enough, there's no fur on your animalistic muzzle, just [skin coat] covered with battle tattoo.");
			} else if (skin.hasLightningShapedTattoo()) {
				outputText("  Oddly enough, there's no fur on your animalistic muzzle, just [skin coat] covered with a few glowing lightning tattoos.");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText("  A coat of [skin coat] decorates your muzzle.");
			} else if (skin.isCoverLowMid()) {
				outputText("  Strangely, [skin coat] adorn your animalistic visage.");
			} else {
				outputText("  Strangely, [skin coat] adorn every inch of your animalistic visage.");
			}
		} else if (faceType == Face.MOUSE) {
			//appearance
			outputText("  You have a snubby, tapered mouse's face, with whiskers, a little pink nose, and [skin full]");
			outputText(".  Two large incisors complete it.");
		}
		//horse-face
		if (faceType == Face.HORSE) {
			if (!player.hasCoat()) {
				outputText("  Your face is equine in shape and structure.  The odd visage is hairless and covered with [skin base].");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText("  Your face is almost entirely equine in appearance, even having [skin coat].  Underneath the fur, you believe you have [skin base].");
			} else {
				outputText("  You have the face and head structure of a horse, overlaid with glittering [skin coat].");
			}
		}
		//dog-face
		if (faceType == Face.DOG) {
			if (!player.hasCoat()) {
				outputText("  You have a dog-like face, complete with a wet nose.  The odd visage is hairless and covered with [skin base].");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText("  You have a dog's face, complete with wet nose and panting tongue.  You've got [skin coat], hiding your [skin base] underneath your furry visage.");
			} else {
				outputText("  You have the facial structure of a dog, wet nose and all, but overlaid with glittering [skin coat]");
			}
		}
		//wolf-face
		if (faceType == Face.WOLF) {
			if (!player.hasCoat()) {
				outputText("  You have a wolf-like face, complete with a wet nose.  ");
				if (player.hasKeyItem("Fenrir Collar") >= 0) outputText("Cold blue mist seems to periodically escape from your mouth.   ");
				outputText("The odd visage is hairless and covered with [skin coat]");
				if (skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
				else if(skin.hasBattleTattoo()) outputText(" covered with battle tattoo");
				else if(skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos");
				outputText(".");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText("  You have a wolf’s face, complete with wet nose a panting tongue and threatening teeth.  ");
				if (player.hasKeyItem("Fenrir Collar") >= 0) outputText("Cold blue mist seems to periodically escape from your mouth.   ");
				outputText("You've got [skin coat], hiding your [skin noadj] underneath your furry visage.");
			} else {
				outputText("  You have the facial structure of a wolf, wet nose and all, but overlaid with glittering [skin coat].");
				if (player.hasKeyItem("Fenrir Collar") >= 0) outputText("  Cold blue mist seems to periodically escape from your mouth.");
			}
		}
		if (faceType == Face.WOLF_FANGS) {
			if (!player.hasCoat()) {
				outputText("  Your face is human in shape and structure with [skin coat]");
				if (skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
				else if(skin.hasBattleTattoo()) outputText(" covered with battle tattoo");
				else if(skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos");
				outputText(". Your mouth is somewhat human save for your wolf-like canines.");
			} else if (player.hasPartialCoat(Skin.FUR)) {
				outputText("  Your face looks human save for your wolf-like canines.  You've got [skin coat], hiding your [skin noadj] underneath your furry visage.");
			} else {
				outputText("  Your face looks human save for your wolf-like canines, but overlaid with glittering [skin coat].");
			}
		}
		//cat-faces
		if (faceType == Face.CAT || faceType == Face.CHESHIRE) {
			if (!player.hasCoat()) {
				outputText("  You have a cat-like face, complete with a cute, moist nose and whiskers.  The [skin] that is revealed by your lack of fur looks quite unusual on so feline a face");
				if (skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
				else if(skin.hasBattleTattoo()) outputText(" covered with battle tattoo");
				else if(skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos");
				outputText(".");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText("  You have a cat-like face, complete with moist nose and whiskers.  Your [skin coat.nocolor] is [skin coat.color], hiding your [skin base] underneath.");
			} else {
				outputText("  Your facial structure blends humanoid features with those of a cat.  A moist nose and whiskers are included, but overlaid with glittering [skin coat].");
			}
			if (faceType == Face.CHESHIRE) outputText(" For some reason your facial expression is that of an everlasting yet somewhat unsettling grin.");
		}
		if (faceType == Face.CAT_CANINES || faceType == Face.CHESHIRE_SMILE) {
			outputText("  Your face is human in shape and structure with [skin coat]. Your mouth is somewhat human save for your cat-like canines.");
			if (faceType == Face.CHESHIRE_SMILE) outputText(" For some reason your facial expression is that of an everlasting yet somewhat unsettling grin.");
		}
		//Minotaaaauuuur-face
		if (faceType == Face.COW_MINOTAUR) {
			if (!player.hasCoat()) {
				outputText("  You have a face resembling that of a minotaur, with cow-like features, particularly a squared off wet nose.  Despite your lack of fur elsewhere, your visage does have a short layer of [haircolor] fuzz.");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText("  You have a face resembling that of a minotaur, with cow-like features, particularly a squared off wet nose.  Your [skin coat] thickens noticeably on your head, looking shaggy and more than a little monstrous once laid over your visage.");
			} else if (player.hasFullCoat()) {
				outputText("  Your face resembles a minotaur's, though strangely it is covered in shimmering [skin coat], right up to the flat cow-like nose that protrudes from your face.");
			} else {
				outputText("  Your face resembles a minotaur's, though strangely it is covered small patches of shimmering [skin coat], right up to the flat cow-like nose that protrudes from your face.");
			}
		}
		//Lizard-face
		if (faceType == Face.LIZARD) {
			if (!player.hasCoat()) {
				outputText("  You have a face resembling that of a lizard, and with your toothy maw, you have quite a fearsome visage.  The reptilian visage does look a little odd with just [skin].");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText("  You have a face resembling that of a lizard.  Between the toothy maw, pointed snout, and the layer of [skin coat] covering your face, you have quite the fearsome visage.");
			} else if (player.hasFullCoat()) {
				outputText("  Your face is that of a lizard, complete with a toothy maw and pointed snout.  Reflective [skin coat] complete the look, making you look quite fearsome.");
			} else {
				outputText("  You have a face resembling that of a lizard, and with your toothy maw, you have quite a fearsome visage.  The reptilian visage does look a little odd with just [skin coat].");
			}
		}
		if (faceType == Face.DRAGON) {
			outputText("  Your face is a narrow, reptilian muzzle.  It looks like a predatory lizard's, at first glance, but with an unusual array of spikes along the under-jaw.  It gives you a regal but fierce visage.  Opening your mouth reveals several rows of dagger-like sharp teeth.  The fearsome visage is decorated by [skin coat].");
		}
		if (faceType == Face.DRAGON_FANGS) {
			outputText("  Your mouth is somewhat human save for your draconic fangs giving you a menacing smile.  It's decorated by [skin coat].");
		}
		if (faceType == Face.JABBERWOCKY) {
			outputText("  Your face is a narrow, reptilian muzzle.  It looks like a predatory lizard's, at first glance, but with an unusual array of spikes along the under-jaw.  It gives you a regal but fierce visage.  Opening your mouth reveals two buck tooth, which are abnormally large.  Like a rabbit or rather a Jabberwocky.  The fearsome visage is decorated by [skin coat].");
		}
		if (faceType == Face.BUCKTOOTH) {
			outputText("  Your mouth is somewhat human save for your two buck tooth, which are abnormally large.  Like a rabbit or rather a Jabberwocky.  It's decorated by [skin coat].");
		}
		if (faceType == Face.PLANT_DRAGON) {
			outputText("  Your face is a narrow, reptilian and regal, reminiscent of a dragon.  A [skin coat] decorates your visage.");
		}
		if (faceType == Face.DEVIL_FANGS) {
			outputText("  Your mouth is somewhat human save for your fiendish canines.  It's decorated by [skin coat].");
		}
		if (faceType == Face.ONI_TEETH) {
			outputText("  Your face is human in shape and structure with [skin coat]. Your mouth could pass for human if not for your two large ogre like canines.");
		}
		if (faceType == Face.RAIJU_FANGS) {
			outputText("  Your face is human in shape and structure with [skin coat]. Your mouth could pass for human if not for your two sharp weasel canines.");
		}
		if (faceType == Face.ORCA) {
			if (skin.hasPlainSkinOnly() && player.skinAdj == "glossy" && player.skinTone == "white and black")
				outputText("  Your face is fairly human in shape save for a wider yet adorable nose. Your skin is pitch black with a white underbelly. From your neck up to your mouth and lower cheeks your face is white with two extra white circles right under and above your eyes. While at first one could mistake it for human skin, it has a glossy shine only found on sea animals.");
			else if (!player.hasFullCoat()) {
				if (skin.hasCoatOfType(Skin.SCALES, Skin.FUR)) {
					outputText("  You have a fairly normal face, with [skin base]. On your cheek you have [skin coat]");
				} else {
					outputText("  You have a fairly normal face, with [skin base]");
					if (skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
					else if(skin.hasBattleTattoo()) outputText(" covered with battle tattoo");
					else if(skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos");
				}
				outputText(".  In addition you have a wide nose similar to that of an orca, which goes well with your sharp toothed mouth, giving you a cute look.");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText("  Under your [skin coat] you have a human-shaped head with [skin base].  In addition you have a wide nose similar to that of an orca, which goes well with your sharp toothed mouth, giving you a cute look.");
			} else {
				outputText("  Your face is fairly human in shape, but is covered in [skin coat].  In addition you have a wide nose similar to that of an orca, which goes well with your sharp toothed mouth, giving you a cute look.");
			}
		}
		if (faceType == Face.KANGAROO) {
			outputText("  Your face is ");
			if (!player.hasCoat()) {
				outputText("bald");
				if (skin.base.adj == "sexy tattooed") outputText(" covered with magical tattoo");
				if (skin.base.adj == "battle tattooed") outputText(" covered with battle tattoo");
				if (skin.base.adj == "lightning shaped tattooed") outputText(" covered with a few glowing lightning tattoos");
			} else outputText("covered with [skin coat]");
			outputText(" and shaped like that of a kangaroo, somewhat rabbit-like except for the extreme length of your odd visage.");
		}
		//<mod>
		if (faceType == Face.PIG) {
			outputText("  Your face is like that of a pig, with " + player.skinTone + " skin, complete with a snout that is always wiggling.");
		}
		if (faceType == Face.BOAR) {
			outputText("  Your face is like that of a boar, ");
			if (player.skinType == Skin.FUR)
				outputText("with " + player.skinTone + " skin underneath your [skin coat.color] fur");
			outputText(", complete with tusks and a snout that is always wiggling.");
		}
		if (faceType == Face.RHINO) {
			outputText("  Your face is like that of a rhino");
			if (!player.hasCoat()) {
				outputText(", with [skin], complete with a long muzzle and a horns on your nose");
				if (skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
				else if(skin.hasBattleTattoo()) outputText(" covered with battle tattoo");
				else if(skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos");
				outputText(".");
			}
			else
				outputText(" with a long muzzle and a horns on your nose.  Oddly, your face is also covered in [skin coat].");
		}
		if (faceType == Face.ECHIDNA) {
			outputText("  Your odd visage consists of a long, thin echidna snout.");
			if (!player.hasCoat()) {
				outputText("  The [skin base]");
				if (skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
				else if(skin.hasBattleTattoo()) outputText(" covered with battle tattoo");
				else if(skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos");
				outputText(" that is revealed by your lack of fur looks quite unusual.");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText("  It's covered in [skin coat].");
			} else {
				outputText("  It's covered in [skin coat], making your face even more unusual.");
			}
		}
		if (faceType == Face.DEER) {
			outputText("  Your face is like that of a deer, with a nose at the end of your muzzle.");
			if (!player.hasCoat()) {
				outputText("  The [skin]");
				if (skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
				else if (skin.hasBattleTattoo()) outputText(" covered with battle tattoo");
				else if (skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos");
				outputText(" that is revealed by your lack of fur looks quite unusual.");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText("  It's covered in [skin coat] that covers your " + player.skinTone + " skin underneath.");
			} else {
				outputText("  It's covered in [skin coat], making your face looks more unusual.");
			}
		}
		if (faceType == Face.RED_PANDA) {
			outputText("  Your face has a distinctive animalistic muzzle, proper from a red-panda, complete with a cute pink nose.");
			if (player.hasFullCoatOfType(Skin.FUR)) outputText("   A coat of soft, [skin coat.color] colored fur covers your head, with patches of white on your muzzle, cheeks and eyebrows.")
		}
		if (faceType == Face.AVIAN) {
			outputText("  Your visage has a bird-like appearance, complete with an avian beak. A couple of small holes on it makes up for your nostrils, while a long, nimble tongue is hidden inside.");
			if (player.hasFullCoatOfType(Skin.FEATHER)) outputText("   The rest of your face is decorated with a coat of [skin coat].")
		}
		//</mod>
	}
public function RacialScores():void {
	clearOutput();
	outputText("<b>Current racial scores (and bonuses to stats if applicable):</b>\n");
	outputText("\nCHIMERA: " + player.chimeraScore());
	outputText("\nGRAND CHIMERA: " + player.grandchimeraScore());
	if (player.internalChimeraScore() >= 1) {
		outputText("\n<font color=\"#0000a0\">INTERNAL CHIMERICAL DISPOSITION: " + player.internalChimeraScore() + " (+" + (5 * player.internalChimeraScore() * (1 + player.newGamePlusMod())) + " max Str / Tou / Spe / Int / Wis / Lib)</font>");
	}
	else if (player.internalChimeraScore() < 1) outputText("\nINTERNAL CHIMERICAL DISPOSITION: 0</font>");
		var metrics:* = Race.MetricsFor(player);
		for each (var race:Race in Race.RegisteredRaces) {
			outputText("<b>" +race.name+"</b>:\n<ul>");
			var simple:* = race.explainSimpleScore(metrics);
			/*
			 * simple = object{
			 *     total:int,
			 *     items:list[
			 *         item:object{
			 *             metric:string,
			 *             actual:*,
			 *             bonus:int,
			 *             checks:list[ pair[expected,bonus] ]
			 *         }
			 *     ]
			 * }
			 */
			for each (var item:* in simple.items) {
				outputText("<li>");
				var metric:String = item.metric;
				var actual:* = item.actual;
				if (item.bonus == 0) outputText("<font color='#777777'>");
				outputText(metric+": ");
				if (item.bonus == 0) outputText("</font>");
				for (var i:int=0;i<item.checks.length;i++) {
					if (i!=0) outputText(", ");
					var check:* = item.checks[i];
					if (check[0] != actual) outputText("<font color='#777777'>");
					var bonus:String = (check[1]>0?"+":"")+check[1];
					outputText(bonus+" for "+Race.ExplainMetricValue(metric,check[0]));
					if (check[0] != actual) outputText("</font>");
				}
				
				outputText("</li>")
			}
			var complex:* = race.explainComplexScore(metrics);
			/*
			 * complex = object{
			 *     total:int,
			 *     items:list[
			 *         item:object{
			 *             checks:list[
			 *                 check:object{
			 *                     metric:string,
			 *                     actual:*,
			 *                     expected:* | list[*],
			 *                     passed:boolean
			 *                 }
			 *             ],
			 *             passed:boolean,
			 *             bonus:int
			 *         ]
			 *     ]
			 * }
			 */
			for each(item in complex.items) {
				outputText("<li>");
				if (!item.passed) outputText("<font color='#777777'>");
				bonus = (item.bonus>0?"+":"")+item.bonus;
				outputText(bonus+" for ");
				if (!item.passed) outputText("</font>");
				for (i = 0; i < item.checks.length; i++) {
					check = item.checks[i];
					if (i!=0) outputText(", ");
					if (check.passed) {
						outputText(Race.ExplainMetricValue(check.metric, check.actual));
					} else {
						outputText("<font color='#777777'>");
						if (check.expected is Array) {
							outputText(check.expected.map(function(el:*,i:int,a:Array):String {
								return Race.ExplainMetricValue(check.metric, el);
							}).join("/"));
						} else {
							outputText(Race.ExplainMetricValue(check.metric,check.expected));
						}
						outputText(" "+check.metric);
						outputText("</font>");
					}
				}
				outputText("</li>")
			}
			var total:int = race.scoreFor(player,metrics);
			if (total != simple.total + complex.total) {
				outputText("<li>+ some magic calculations</li>");
			}
			outputText("</ul>Total: "+total+"\n");
			var tierused:int = -1;
			for each(var tier:Array in race.bonusTiers) {
				if (total>=tier[0] && tier[0]>tierused) tierused = tier[0];
			}
			for each(tier in race.bonusTiers) {
				if (tier[0] != tierused) outputText("<font color='#777777'>");
				outputText("At "+tier[0]+": ");
				for (bonus in tier[1]) {
					item = tier[1][bonus];
					outputText((item>0?"+":"")+item+" "+bonus+" ");
				}
				if (tier[0] != tierused) outputText("</font>");
				outputText("\n");
			}
			outputText("\n\n");
		}
		doNext(playerMenu);
	}

public function GenderForcedSetting():void {
	clearOutput();
	outputText("This menu allows you to choose if the game will treat your character as a female or a male. Using the automatic option will let the game orginal system do the work instead of setting your sex in one or another way.");
	menu();
	addButton(0, "Next", playerMenu);
	if (flags[kFLAGS.MALE_OR_FEMALE] == 0) addButtonDisabled(1, "Auto", "It's currently used setting option.");
	else addButton(1, "Auto", GenderForcedSettingAuto);
	if (flags[kFLAGS.MALE_OR_FEMALE] == 1) addButtonDisabled(2, "Male", "It's currently used setting option.");
	else addButton(2, "Male", GenderForcedSettingMale);
	if (flags[kFLAGS.MALE_OR_FEMALE] == 2) addButtonDisabled(3, "Female", "It's currently used setting option.");
	else addButton(3, "Female", GenderForcedSettingFemale);
}

public function GenderForcedSettingAuto():void {
	flags[kFLAGS.MALE_OR_FEMALE] = 0;
	doNext(GenderForcedSetting);
}

public function GenderForcedSettingMale():void {
	flags[kFLAGS.MALE_OR_FEMALE] = 1;
	doNext(GenderForcedSetting);
}

public function GenderForcedSettingFemale():void {
	flags[kFLAGS.MALE_OR_FEMALE] = 2;
	doNext(GenderForcedSetting);
}

	public function sockDescript(index:int):void {
		outputText("  ");
		if (player.cocks[index].sock == "wool")
			outputText("It's covered by a wooly white cock-sock, keeping it snug and warm despite how cold it might get.");
		else if (player.cocks[index].sock == "alabaster")
			outputText("It's covered by a white, lacey cock-sock, snugly wrapping around it like a bridal dress around a bride.");
		else if (player.cocks[index].sock == "cockring")
			outputText("It's covered by a black latex cock-sock with two attached metal rings, keeping your cock just a little harder and [balls] aching for release.");
		else if (player.cocks[index].sock == "viridian")
			outputText("It's covered by a lacey dark green cock-sock accented with red rose-like patterns.  Just wearing it makes your body, especially your cock, tingle.");
		else if (player.cocks[index].sock == "scarlet")
			outputText("It's covered by a lacey red cock-sock that clings tightly to your member.  Just wearing it makes your cock throb, as if it yearns to be larger...");
		else if (player.cocks[index].sock == "cobalt")
			outputText("It's covered by a lacey blue cock-sock that clings tightly to your member... really tightly.  It's so tight it's almost uncomfortable, and you wonder if any growth might be inhibited.");
		else if (player.cocks[index].sock == "gilded")
			outputText("It's covered by a metallic gold cock-sock that clings tightly to you, its surface covered in glittering gems.  Despite the warmth of your body, the cock-sock remains cool.");
		else if (player.cocks[index].sock == "amaranthine") {
			outputText("It's covered by a lacey purple cock-sock");
			if (player.cocks[index].cockType != CockTypesEnum.DISPLACER)
				outputText(" that fits somewhat awkwardly on your member");
			else
				outputText(" that fits your coeurl cock perfectly");
			outputText(".  Just wearing it makes you feel stronger and more powerful.");
		}
		else if (player.cocks[index].sock == "red")
			outputText("It's covered by a red cock-sock that seems to glow.  Just wearing it makes you feel a bit powerful.");
		else if (player.cocks[index].sock == "green")
			outputText("It's covered by a green cock-sock that seems to glow.  Just wearing it makes you feel a bit healthier.");
		else if (player.cocks[index].sock == "blue")
			outputText("It's covered by a blue cock-sock that seems to glow.  Just wearing it makes you feel like you can cast spells more effectively.");

		else outputText("<b>Yo, this is an error.</b>");
	}
}
}