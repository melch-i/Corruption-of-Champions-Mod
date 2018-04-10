//Spriggan Scene
package classes.Scenes.Areas.Forest 
{
	import classes.BaseContent;
	import classes.display.SpriteDb;
	import classes.Scenes.SceneLib;

	public class DryadScene extends BaseContent
	{
		
		public function DryadScene() {}
		
		public function encounterdryad():void {
			clearOutput();
			//rustle in the bushes
			outputText("While walking through the  glade you notice a rustling in the bushes.   Do you investigate?\n\n");
			doYesNo( fightagainstdryad,camp.returnToCampUseTwoHours);
			
						
		}
		public  function fightagainstdryad(): void {
			spriteSelect(SpriteDb.s_dryad);
			outputText("Walking up to where you heard the rustling, you notice what looks like a tree.   This tree appears to be wearing a dress made of leaves and straw.  You take a step closer and notice the tree has the silhouette of a slender woman.   Taking yet another step closer, you see this tree looks more like a person than a tree.   Her hair is thin vines with leaves growing off of them and she has a human-like face,  mouth, wooden arms, hands with claw-like fingers, legs and feet.   Before you can decide what to think her eyes pop open, glowing red, hungry eyes. . . Her lips curl into a wicked smile and she lunges at you! ");
				startCombat(new Dryad());
			}
		public function winagainstdryad():void {
			clearOutput();
			outputText("The spriggan creaks like old wood as she collapses to the ground, too [if (monster.HP <= 0)injured|aroused] to continue fighting. ");
			if (player.hasCock() && player.lust >= 33) {
				outputText("\n\nWhile gazing on her prone figure carnal desire wells up inside you.   Do you have your way with her? ");
				doYesNo( winAgainstdryadRape , cleanupAfterCombat);
			}
			else {
				cleanupAfterCombat();
			}
		}
		
		public  function winAgainstdryadRape():void {
			clearOutput();

			if (player.hasCock()) {
				outputText("Crouching down beside her, you run your hands up her legs pulling her dress up while doing so.   Seeing her girly parts exposed, you remove your armor and whip out your member.  You roll her onto her stomach and place both hands on her hips.   Throwing caution into the wind, you roughly plow her and immediately regret it.   Your [cock] receives numerous splinters and pull out receiving even more.   You stagger from the pain and limp back to camp. ");
			} 
			else
			   outputText("You saunter over to the defeated spriggan and roughly grab her by the hair.  \n  'Lick it!' you demand and she she complies.   You keep her licking until you are satisfied then toss her aside and head back to camp smelling of tree sap.");
			dynStats("lib", -2, "cor", 3);
			cleanupAfterCombat();
		}
		
		public  function loseTodryad(fromBattle:Boolean = true):void {
			clearOutput();
			if (fromBattle) outputText("Too badly " + (player.HP <= 0 ? "injured" : "aroused") + " by the spriggan, you give in  and let her do what she wants to you.\n\n");
			if (player.hasCock()) {
				outputText("The spriggan rushes towards you and wraps her arms around you.   Her bark-like skin is cold and rough.   Your bodies entangle as her sap rubs onto your person.    She places a hand behind your head and locks eyes with you.   Her glowing red eyes burn desire into your skull.   Her lips part and she frenchs you deeply.\n\n"); 
				outputText("Seeing you suitablely aroused, she tears into your clothing until your [cock]  is exposed.\n"); 
				outputText("'Pollinate me' !  she demands hungrily.");
				outputText("She places her hand on your [cock] and sticky sap oozes from her palm lubricates your member.\n");
				outputText("Greedily, her hand jerks your member until you feel like you are about to burst.   She senses this and kneels in front of your [cock].   Her leaf hair falls down in front of her face as you spray all over her hair and face.\n");
				outputText("Satisfied, she stands up and looks at you one last time 'I will to shed a thousand seeds.'   As she steps away her leaf-hair seems to brighten and flowers start to bud from her locks.\n");
				outputText("You wake up several hours later wondering what just happened.\n");
			} else {
				//yuri scene
				outputText("The spriggan sees that you no longer have the ability to fight. Her glowing red eyes now bristling with hunger, roving your weak form strewn before her. Her smile one " +
				"of malicious intent, and pure, unfettered want. Futility attempting to distance yourself from the clearly deranged creature, you try to crawl away. Yet with the quick pace of the " +
				"spriggan compared to your pitiful scrambles, the corrupted wood catches you easily. \n\n"+

				"You open your mouth to say something but she kisses you to keep you from talking. Her rough lips slick with a sweet, enriched, sugary substance that binds your lips to her, not due " +
				"to the cohesion, but the delectable taste is too great to seek detachment. Her tongue pierces the veil of your lips, now roaming freely within your maw, transferring " +
				"more of that warm, caramel sap to you. A rebellious shiver runs down your spine; your body now betraying your quickly fading mind pleading with you to pull away from this woman!\n\n"+  

				"And yet...you can’t. No. You just don’t want to. The binding substance being excreted from her lips, her tongue, slowly dripping onto your form, coating your [breasts] in" + 
				"more of this inviting warmth...it’s simply too alluring to even conjure the faintest wish of detachment. And who would you be to pull away from a benevolent being such as this" +
				" creature; having entrapped you with her arms. Loving enough to fill you with her soothing sap, your lips sealed by her own. \n\n "+

				"The enchanting scent of of warm, viscous liquid only adds to the spell holding your form. Intoxicating would have been an atrocious euphemism. It was the ambrosia of the Gods that " +
				"was carried along by the winds. It was all encompassing, rapturous, exhilarating, tantalizing, utterly salacious! \n\n"+

				"Who would you be to deny this godly nectar? A fool. A poor, blind, selfish, pathetic, rude, wasteful creature. Marae, her tongue feels so good! You can feel it, slowly crawling through" +
				" your mouth, roving over every inch, prodding every corner, searching every crevice, and leaving behind a generous amount of exquisite, enthralling sap. Your mouth’s interior now hosting" +
				" a thin coat of the enfeebling nectar. \n\n"+

				"Through the haze of pleasure, you can feel your breasts have been thoroughly coated in the warm liquid, now being kneaded by calloused extensions. The spriggan’s woody fingers pressing " +
				"into the flesh of your [breasts], squeezing it almost lovingly as she molds your glorious mounds to form perfectly in between her ligneous digits. Her other roams your form," +
				" memorizing every seamless curve, bump and imperfection. \n\n"+

				"She ran through your form, tasting, touching and molding as she pleased. At the small sacrifice of your pride, you have been placed in such a complete state of bliss. And now the spriggan" +
				" was going to offer you ever greater ecstasy; her free hand having finished memorizing the contours of your torso, now seekings to burrow itself deep within your [pussy]. \n\n"+

				"You’re already so far gone that the faintest touch, her tips grazing your moist lips has you seize up; your neurons nearly overloading from the stimulus given. Through the kiss you can hear " +
				"the creature give off a dark chuckle, two of her fingers now piercing your slick veil. As she penetrates deeper, her fingers digging deep in search of your most sensitive area, your back arcs" +
				" in agonizing rapture. You can’t even moan, having now been too far gone as you’ve lost yourself to this veridian goddess’ loving embrace. \n\n"+

				"Her fingers root themselves deep, pressing themselves against your G-spot and slowly rubbing the dry patch. Mind melting ecstasy burns through your form, no doubt in a large part due to the sap." +
				" It has weakened you, placated you, but you don’t care. The pleasure you have garnered from her actions is next to nothing you have ever experienced before. Every push only pulls you further away" +
				" from your body, everything becoming lighter and lighter, the corrupt creature hurdling you towards an explosive finish. \n\n"+

				"Push after push, thrust after thrust forces you closer and closer to bliss you seek. Motions now speeding up, moving away from the gradual growth she previously subjected you to. It wasn’t long" +
				" before you scream out, the pure white of the dawn now coating your vision as you let go. Your convulsing form spasming sporadically, your love canal now clamping down onto those rough digits, " +
				"milking them as if they were a cock. Surprisingly, your cunt’s ministrations are rewarded, a flow of thick and warm sap now flooding your sex, filling your core with the leeching nectar. \n\n"+

				"It almost feels like your body is...absorbing the strange substance. Yet before a coherent query can be formed, the woman begins thrusting those calloused digits deep within you again. She " +
				"continues working away until you are a shuddering mess in her arms. Your body having given up at some point, your vision fading to white as more of that sap is fed to you...");
			}
			player.orgasm('Generic');
			dynStats("lib", -2, "cor", 3);
			if (fromBattle)
				cleanupAfterCombat();
			else
				doNext(camp.returnToCampUseTwoHours);
		}
	}
}
