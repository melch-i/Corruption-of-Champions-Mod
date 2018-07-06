package classes.Scenes.Areas.Mountain
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;
import classes.internals.*;
import classes.lists.DamageType;

public class HellHound extends Monster
	{
	private var thisType:Object;  // type of hellhound to use
	private var timeshunt:int;   //used for the hunt function
		protected function hellhoundFire():void {
			//Blind dodge change
			if(hasStatusEffect(StatusEffects.Blind)) {
				outputText("The blinded hound rears its head back and drops it only to blow flames in the complete wrong direction. Poor hound couldn’t tell left from right at the moment and its attempt to hit you really shows that.");
				return;
			}

			if(player.hasPerk(PerkLib.Evade) && player.spe >= 35 && rand(3) != 0) {
				outputText("The hellhound blows of a pillar of flames at you from its maw, but you just skate out of the way. The heat of it still runs along your side though and you can’t help but " +
				"give out a gasp of surprise. It wasn’t hot like any other fire. It had a slight bit of heat to it, but a strange attraction as well. Something that would set alight a different " +
				"flame found within. Maybe it wouldn’t have been so painful to let it hit you…");
			}
			else if(player.hasPerk(PerkLib.Misdirection) && rand(100) < 20 && player.armorName == "red, high-society bodysuit") {
				outputText("Using Raphael's teachings and the movement afforded by your bodysuit, you anticipate and sidestep " + a + short + "'s fire.\n");
			}
			else if(player.hasPerk(PerkLib.Flexibility) && player.spe > 30 && rand(10) != 0) {
				outputText("The Hellhound breathes in deeply before blasting a wave of dark fire at you.  You twist and drop with incredible flexibility, watching the fire blow harmlessly overhead.");
			}
			else {
				//Determine the damage to be taken
				var damage:Number = 15 + rand(10);
				if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 3;
				if (player.hasPerk(PerkLib.FireAffinity)) damage *= 0.3;
				damage = Math.round(damage);
				if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				player.addStatusValue(StatusEffects.Blizzard,1,-1);
				damage *= 0.2;
				outputText("The hellhound breathes in deeply before blasting a wave of dark fire at you. While the flames don't burn much due to protection of blizzard, the unnatural heat fills your body with arousal. ");
				}
				else {
				outputText("The hound opens its muzzle right in front of your face, letting out of a breath of hot air all over it. Instinctively you grimace before turning your head away, worrying that they’d" +
				" go for another bite. The bite never comes though, this time a pillar of flames coming down hard all over your face and nice. You squirm and let out sounds of pain, but it doesn’t hurt as much " +
				"as it normally does. In fact it even starts to spark a certain desire in your body. You start to blush hard as that desire only gets stronger by the second before just shaking your head. You need" +
				" to shake off this arousal before it gets you in trouble.. ");
				}
				damage = Math.round(damage);
				DamageType.FIRE.damage(player, damage);
				player.dynStats("lus", 20+(player.sens/10));
				statScreenRefresh();
				if(SceneLib.combat.combatIsOver()){return;}
				if(player.lust >= player.maxLust()) {
					doNext(SceneLib.combat.endLustLoss);
					return;
				}
			}
			doNext(EventParser.playerMenu);
		}
		protected function hellhoundScent():void {
			if(player.hasStatusEffect(StatusEffects.NoFlee)) {
				if(spe == 100) {
					hellhoundFire();
					return;
				}
				else {
					outputText("The hellhound sniffs your scent again, seemingly gaining more and more energy as he circles faster around you.");
					spe = 100;	
				}
			}
			else {
				spe += 40;
				outputText("The hellhound keeps his four eyes on you as he sniffs the ground where you were moments ago. He raises his heads back up and gives you a fiery grin - he seems to have acquired your scent!  It'll be hard to get away now...");
				player.createStatusEffect(StatusEffects.NoFlee,0,0,0,0);
			}

		}
		

		override public function defeated(hpVictory:Boolean):void
		{
			if (hpVictory) {
				outputText("The hellhound's flames dim and the heads let out a whine before the creature slumps down, defeated and nearly unconscious.", true);
				//Rape if not naga, turned on, and girl that can fit!
				if (player.hasVagina() && player.lust >= 33 && !player.isNaga()) {
					outputText("  You find yourself musing that you could probably take advantage of the poor 'doggy'.  Do you fuck it?");
					EngineCore.simpleChoices("Fuck it", SceneLib.mountain.hellHoundScene.hellHoundPropahRape, "", null, "", null, "", null, "Leave", SceneLib.combat.cleanupAfterCombatImpl);
				} else {
					SceneLib.combat.cleanupAfterCombatImpl();
				}
			} else {
				outputText("Unable to bear hurting you anymore, the hellhound's flames dim as he stops his attack. The two heads look at you, whining plaintively.  The hellhound slowly pads over to you and nudges its noses at your crotch.  It seems he wishes to pleasure you.\n\n", true);
				var temp2:Function =null;
				if (player.gender > 0 && player.lust >= 33) {
					outputText("You realize your desires aren't quite sated.  You could let it please you");
					//Rape if not naga, turned on, and girl that can fit!
					if (player.hasVagina() && player.lust >= 33 && !player.isNaga()) {
						outputText(" or make it fuck you");
						temp2 = SceneLib.mountain.hellHoundScene.hellHoundPropahRape;
					}
					outputText(".  What do you do?");
					EngineCore.simpleChoices("Lick", SceneLib.mountain.hellHoundScene.hellHoundGetsRaped, "Fuck", temp2, "", null, "", null, "Leave", SceneLib.combat.cleanupAfterCombatImpl);
				}
				else {
					outputText("You turn away, not really turned on enough to be interested in such an offer.");
					SceneLib.combat.cleanupAfterCombatImpl();
				}
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nThe hellhound snorts and leaves you to your fate.");
				doNext(SceneLib.combat.cleanupAfterCombatImpl);
			} else {
				SceneLib.mountain.hellHoundScene.hellhoundRapesPlayer();
			}
		}
		public static function randomHellhound():HellHound {
			return new HellHound(Utils.randomChoice(types));
		}

		public function HellHound(noInit:Boolean=false,thisType:Object = null)//rand hellhound passes which type it should be
		{
			if (noInit) return;
			this.thisType = thisType;
			trace("HellHound Constructor!");
			this.a = "the ";
			this.short = thisType.short;
			this.imageName = "hellhound";
			this.long = thisType.long;
	//		this.long = "It looks like a large demon on all fours with two heads placed side-by-side. The heads are shaped almost like human heads, but they have dog ears on the top and have a long dog snout coming out where their mouths and noses would be.  Its eyes and mouth are filled with flames and its hind legs capped with dog paws, but its front ones almost look like human hands.  Its limbs end in large, menacing claws. A thick layer of dark fur covers his entire body like armor.  Both heads look at you hungrily as the hellhound circles around you. You get the feeling that reasoning with this beast will be impossible.";
			this.createCock(8,2,CockTypesEnum.DOG);
			this.createCock(8,2,CockTypesEnum.DOG);
			this.balls = 2;
			this.ballSize = 4;
			this.cumMultiplier = 5;
			this.createBreastRow();
			this.createBreastRow();
			this.createBreastRow();
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 47;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE + 1;
			this.lowerBody = LowerBody.DOG;
			this.skin.growFur({color:"black"});
			this.hairColor = "red";
			this.hairLength = 3;
			initStrTouSpeInte(64, 64, 50, 1);
			initWisLibSensCor(1, 95, 20, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 10;
			this.armorName = "thick fur";
			this.armorDef = 7;
			this.bonusLust = 10;
			this.lust = 25;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 10;
			this.gems = 15+rand(12);
			this.drop = new WeightedDrop().add(consumables.CANINEP, 3)
					.addMany(1, consumables.BULBYPP,
							consumables.KNOTTYP,
							consumables.BLACKPP,
							consumables.DBLPEPP,
							consumables.LARGEPP);
			this.tailType = Tail.DOG;
			this.special1 =  this[thisType.special1];
			this.special2 =  this[thisType.special2];
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
		
	
		private static var types:Array = [FERAL_MALE,FERAL_FEMALE,PACK,ALPHA,HUNTER];
			public static const FERAL_MALE:Object = {
					short : "Feral male Hellhound", 
				    long : "The creature before you looks eerily similar to that of a wolf, but there are some distinct differences. Not only does its eyes " +
					"have a strange fire behind them, but you can see the traces of fiery veins rushing through its near ebony black fur. There is an intelligence" +
					" behind those eyes as well, those motions not one of a wild hunter, but a demon that  has found its prey. \n\n"+
                    "Head low to the ground, claws fully extended, and fangs bared to represent something of a sinister smile, you recognize this as a hellhound.",
					special1 : "pounce",
					special2 : "hunt",
					lustreaction : ([ "The beast is starting to flick his ears some, tail wagging in a way more playful than sinister. His flames dim just enough to be noticed, but still be dangerous.", 
									"You notice that he isn’t circling you as much as he was at the beginning of the fight. He seems to be more focused on looking at your rear and genitals.", 
									"The hellhound is using all of his effort to still focus on the fight. His arousal is clearly showing between his haunches, however, and the look in his eyes is"+
			" not nearly as dangerous. Softly panting and whining with a need you didn’t expect when this encounter started, it’s not hard to tell that he’s close to giving up this fight." ]),
					balls : 2,
					ballsize : 4

				}
			
			public static const FERAL_FEMALE:Object = {
					short : "Feral female Hellhound",
					long : "The creature before you looks eerily similar to that of a wolf, but there are some distinct differences. Not only does its eyes " +
					"have a strange fire behind them, but you can see the traces of fiery veins rushing through its near ebony black fur. There is an intelligence" +
					" behind those eyes as well, those motions not one of a wild hunter, but a demon that  has found its prey. \n\n"+
                    "Head low to the ground, claws fully extended, and fangs bared to represent something of a sinister smile, you recognize this as a hellhound.",
					special1 : "pounce",
					special2 : "hunt",
					lustreaction : ([ "The beast is starting to falter in her movements, not as hostile as when this first started. Even as her flames dim some, she still seems willing to fight.", 
					"A scent is in the air now, the hell hound’s need starting to become more prominent. Regardless of if she did before or not, she clearly wants more than just a meal now. The look" +
					" in her eyes become more sultry, her desires clearer.", 
					"Where she had started with an air of dominant need, her arousal is clearly starting to get the best of her. A light drip comes from between her haunches, her eyes flickering " +
					"between wanting to be in control and wanting to sate her needs by any means necessary. She is on the verge of submitting."])
				
			}
			public static const PACK:Object = {
					short : "Pack of Hellhounds",
					long : "It’s hard to catch sight of all of the hounds due to their movements, but they all seem to be standard in their own right. No real major" +
					" difference from other hounds, but they do move as a team, something you rarely see from other hounds. Not just that, but two of the hounds seem" +
					" to be a bit bigger than the others. The clear leaders, though no commands are given out through any method that you understand. The rest of the " +
					"hounds varied in sizes quite similar to one another, but it doesn’t matter much to try and decipher that now."

				
			}
			public static const ALPHA:Object = {
					short : "Alpha Hellhound",
					long : "The creature before you looks eerily similar to that of a wolf, but there are some distinct differences. Not only does its eyes " +
					"have a strange fire behind them, but you can see the traces of fiery veins rushing through its near ebony black fur. There is an intelligence" +
					" behind those eyes as well, those motions not one of a wild hunter, but a demon that  has found its prey. \n\n"+
                    "Head low to the ground, claws fully extended, and fangs bared to represent something of a sinister smile, you recognize this as a hellhound.",
					special1 : "pounce",
					special2 : "hunt"
			}
			public static const HUNTER:Object = {
					short : "Hellhound Hunter",
					long : "An eerie silence is over the area as you face off against the hellhound. Physically, the hound looks very similar to that of a normal hound," +
					" but its actions is a bit more out of the norm. It’s eyes don’t shine as brightly as others and the way it moves around you comes with nothing but " +
					"the slightest sound of crunching rocks. Something you need to strain to hear and will certainly be missing in the heat of combat. Their fangs are not" +
					" bared and their expression is a focused one. This hound is most certainly not like the others. This hound is a hunter, focused on the task of bringing you down.",
					special1 : "pounce",
					special2 : "hunt"
			}
				
			override public function teased(lustDelta:Number):void		{
				var lusty:int ;
			if (lust <= maxLust() * 0.99) {
				if (lustDelta <= maxLust() *0.25) lusty = 0 ;
				else if (lustDelta < maxLust() * 0.75) lusty = 1;
				else lusty = 2;
				outputText(thisType.lustreaction[lusty]);
				
			}
			outputText("[name] cannot take it anymore and succubs to lust.");
			applyTease(lustDelta);
		}
		//pounce can chain into 3 types of attacks
		protected function pounce():void {
			var pouncetype : String;
			var lustDmg:int = player.lib / 10 + player.cor / 10 + 10;
			var damage:int = str + weaponAttack + rand(40);
			damage = player.reduceDamage(damage);
			if (damage < 10) damage = 10;
			pouncetype = randomChoice("bite","hellfire","grind")
			if (!player.getEvasionRoll() ) {
				if (pouncetype == "hellfire")
				outputText("The hound snarls at you to try and catch you off guard, but you’re ready for it. As they pounce to try and pin you to the " +
				"ground, you grip their body and shift the weight so they slide right back off of you. Pushing back after that, you reinstate your " +
				"fighting position against the hound.");
				else
				outputText("The hellhound gives a sudden surprise snarl before pouncing at you. Caught by surprise by " +
				"the action, the hound crashes the full of his weight against you. Forcing you back some as you pushed" +
				" but eventually overpowering you in the process. You trip and fall back, slamming your back into the " +
				"ground as the hound looks you right in the eyes. You’re pinned beneath the hound.\n\n");
			}
			else {
				outputText("The dodge the hellhounds pounce attack.");
				return;
			}
			switch (pouncetype){
			
			case "bite":
				outputText("Using their new leverage over you, the hound bites at your face and neck. Your hands come up to keep them at bay, " +
				"but you still sustain some bites and marks along your neck and face.");

				player.takePhysDamage(damage);
				
			case "hellfire":
				outputText("The hound opens its muzzle right in front of your face, letting out of a breath of hot air all over it. Instinctively you" +
				" grimace before turning your head away, worrying that they’d go for another bite. The bite never comes though, this time a pillar of " +
				"flames coming down hard all over your face and nice. You squirm and let out sounds of pain, but it doesn’t hurt as much as it normally " +
				"does. In fact it even starts to spark a certain desire in your body. You start to blush hard as that desire only gets stronger by the " +
				"second before just shaking your head. You need to shake off this arousal before it gets you in trouble.");
				player.takeLustDamage(lustDmg, true);
				player.takePhysDamage(damage);
			case "grind":
				outputText("You bring your hands to push back against the hound, but they continue to keep a firm grip atop of you. Squirming some, " +
				"you try to get from underneath them, but their grip is solid. They don’t strike back at you though, instead deciding to bring their " +
				"paws up to press your hands into the ground. You fight against it only to be overpowered for the moment and the hound responds in a way" +
				" you’re not prepared for. They start to pant in an aroused fashion as their hips start to rock back and forth.Grinding their sex against " +
				"you and starting to fill the air with an aroused musk, the hound takes clear advantage of their position atop of you. All you can do is " +
				"let out a whimper as a blush comes to your cheek. By the time your hands are free from their paws and you can keep pushing, you’re already" +
				" feeling a bit hotter under the collar. Best not to let them do that for very long.");
				player.takeLustDamage(lustDmg, true);
			}
		}
		protected function hunt():void {
			var huntmsg:Array;
			if(spe == 100) {
				hellhoundFire();
				return;
			}
					
			huntmsg = ["The hellhound places their nose to the ground and starts to sniff at it. Their ears twitch as it catches onto your scent, their paws" +
				" kneading lightly into the ground as they commit it to memory. When they raise their head once again to stare back at you, the look in its eyes" +
				" tells you that it has no intention of letting you run.",
				"A glimt flashes in the hellhounds eyes as they lower their frame. Their tail gives a twitch of anticipation as they start to look your" +
				" body up and down. Your scent already committed to memory, it seems the hound is watching your motions now. Finding what little habits and nervous" +
				" twitches you have. When the hound moves again, they seem a lot more confident about the situation.",
				"The hound bares their fangs and lets out a low growl. Their tail gives another twitch and they start to slowly circle around you. You" +
				" follow its movements as it follows yours, but you can’t help but let out a shudder. There is something about the way they are moving. The Alpha " +
				"isn’t taking anymore chances anymore. He’s looking for the killing strike."	];
			
			if (!timeshunt ){
				timeshunt++;
				outputText(huntmsg[0]);
				spe += 40;
				return;
			}
			if (timeshunt == 1 || thisType != ALPHA){
				timeshunt++;
				outputText(huntmsg[1]);
				spe == 100;
				player.createStatusEffect(StatusEffects.NoFlee,0,0,0,0);
				return;
			}
			if (timeshunt > 1 && thisType == ALPHA) { //alpha only hunt message
				spe += 100;
				outputText(huntmsg[2]);
				player.createStatusEffect(StatusEffects.NoFlee,0,0,0,0);
			}
		

	}
}
}