package classes.Scenes.Places.TelAdre
{
	import classes.GlobalFlags.kFLAGS;
	import classes.ItemType;
	import classes.PerkLib;

	public class GolemMerchant extends TelAdreAbstractContent
	{
		public function GolemMerchant()
		{
		}
		public function golemmerchant():void {
			clearOutput();
			outputText("You enter a shop that got sign over the entrance titled 'Soul Items'.  Inside you see few stalls with similar looking items put on the display.  Actually it not seems this merchant got 'a wide' choice of things but for someone at the beginning of soul cultivator road it's probably enough.  Sensing some movements from the corner of the shop that is pernamently covered in darkness a person appearing without making any sound.  'He' is around five feet tall with outer appearance of some kind of demonic monster. ");
			if (flags[kFLAGS.FOUND_CATHEDRAL] > 0) outputText("But he do looks quite similar to the gargoyle from the cathedral.");
			outputText("\n\n\"<i>Welcome to my master's shop dear customer. Feel free to look around,</i>\" he says. \n\n");
			if (flags[kFLAGS.CODEX_ENTRY_GOLEMS] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_GOLEMS] = 1;
				outputText("<b>New codex entry unlocked: Golems!</b>\n\n")
			}
			menu();
			var buyItem:Function = curry(confirmBuy,golemmerchant,"Golem",1);
			var introText:String = "\"While you reach toward the one of the pills on the display golem says, \\\"<i>";
			var costText:String = " Interested?  It is <b>";
			var endText:String = " gems</b></i>.\"";
			function sayLine(itype:ItemType,desc:String):String{
				return introText+desc+costText+itype.value+endText;
			}
			addButton(0, "LGSFRecovPill", buyItem,consumables.LG_SFRP,
					sayLine(consumables.LG_SFRP,"It's quite useful item for all soul cultivators, this little pill can help you restore some of used up soulforce.")).hint("Low-grade Soulforce Recovery Pill.");
			addButton(1, "Bag of Cosmos", buyItem,consumables.BAGOCOS,
					sayLine(consumables.BAGOCOS,"It's quintessential item for all soul cultivators, this little bag can hold much more things inside that it own size.")).hint("Bag of Cosmos.");
			if (player.findPerk(PerkLib.JobSoulCultivator) >= 0) {
				addButton(2, "Triple Thrust", buyItem,consumables.TRITMAN,
						sayLine(consumables.TRITMAN,"It's manual for Triple Thrust, this simple technique allows to unleash three thrusts that will became stronger and stronger as you train your body and soul."),
						"\n\nWherever you gonna try to go deeper into all that 'soulforce' stuff or not at least you now got something to begin.  Although seems even name of the manual mentioning thrusting seems like it could have been influenced by this realm nature...or it's just a coincidence.  "
				).hint("Triple Thrust Manual.");
				addButton(3, "Draco Sweep", buyItem,consumables.DRASMAN,
						sayLine(consumables.DRASMAN,"It's manual for Draco Sweep, this simple technique allows to unleash attack that would strike in wide arc before you.  Perfect when you fight group of enemies and it also becoming more powerful as long you would train your body and soul."),
						"\n\nWherever you gonna try to go deeper into all that 'soulforce' stuff or not at least you now got something to use when figthing group of enemies.  Although you not meet often so far more than singular enemy at once you're sure that deeper in this forsaken realm you will face groups or maybe even hordes of demons at once and would need something to deal with them.  "
				).hint("Draco Sweep Manual.");
				addButton(4, "Many Birds", buyItem,consumables.MABIMAN,
						sayLine(consumables.MABIMAN,"It's manual for Many Birds, this simple technique allows to project a figment of your soulforce as a crystal traveling at extreme speeds that will became stronger and stronger as you train your body and soul."),
						"\n\nWherever you gonna try to go deeper into all that 'soulforce' stuff or not at least you now got something to begin.  Although seems name of the manual is odd but it makes you remember something...but what and from where you not certain.  "
				).hint("Many Birds Manual.");
			}
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) {
				addButton(5, "MGSFRecovPill", buyItem,consumables.MG_SFRP,
						sayLine(consumables.MG_SFRP,"It's quite useful item for all cultivators at Soul Personage or above stage, this small pill can help you restore some of used up soulforce and it would be much more than the low-grade one.")).hint("Mid-grade Soulforce Recovery Pill.");
				addButton(6, "Comet", buyItem,consumables.COMETMA,
						sayLine(consumables.COMETMA,"It's manual for Comet, this technique allows to project a shard of soulforce, which will come crashing down upon your opponent as a crystalline comet.  Perfect when you fight group of enemies and it also becoming more powerful as long you would train your body and soul."),
						"\n\nWherever you gonna try to go deeper into all that 'soulforce' stuff or not at least you now got something to use when figthing group of enemies.  Although you not meet often so far more than singular enemy at once you're sure that deeper in this forsaken realm you will face groups or maybe even hordes of demons at once and would need something to deal with them.  "
				).hint("Comet Manual.");
				addButton(7, "V P Trans", buyItem,consumables.VPTRMAN,
						sayLine(consumables.VPTRMAN,"It's manual for Violet Pupil Transformation, this advanced technique allows to channel soulforce into regenerative power that would fill whole body allowing recovering even from a brink of a death.  It only flaw is that it constantly drain cultivator soulforce so you could end in a tight situation without enough soulforce to use other skills."),
						"\n\nSeems like it's similar to healing spell soul skill and on top of that the one which isn't one time used one time healed but with enough soulforce could be kept active for very long period of time.  It should give you another edge during your crusade against demons.  Additionaly ability to healing from brink of death could prove to be usefull in future fights.  "
				).hint("Violet Pupil Transformation Manual.");
			}
			if (player.findPerk(PerkLib.SoulOverlord) >= 0) {
				addButton(10, "HGSFRecovPill", buyItem,consumables.HG_SFRP,
						sayLine(consumables.HG_SFRP,"It's quite useful item for all cultivators at Soul Personage or above stage, this small pill can help you restore some of used up soulforce and it would be much more than the low-grade one.")).hint("High-grade Soulforce Recovery Pill.");
			}
			addButton(13, "IncenOfInsig", buyItem,consumables.INCOINS,
					sayLine(consumables.INCOINS,"These incenses are quite special. They will grant you visions if only for a moment while meditating. This should help you find the wisdom and insight you need.")).hint("Incense of Insight.");
			addButton(14, "Back", telAdre.telAdreMenu);
			statScreenRefresh();
		}
		private function debitItem(returnFunc:Function,shopKeep:String,priceRate:Number,itype:ItemType,onBuy:String):void{
			var value:int = itype.value * priceRate;
			if (player.gems < value) {
				clearOutput();
				outputText("\n\n"+shopKeep+" shakes his head, indicating you need " + String(value - player.gems) + " more gems to purchase this item.");
				doNext(returnFunc);
			}
			else {
				player.gems -= value;
				outputText(onBuy);
				inventory.takeItem(itype, returnFunc);
				statScreenRefresh();
			}
		}
		private function confirmBuy(returnFunc:Function,shopKeep:String,priceRate:Number,itype:ItemType,descString:String,onBuyString:String="\n"):void{
			clearOutput();
			outputText(descString);
			doYesNo(curry(debitItem,returnFunc,shopKeep,priceRate,itype,onBuyString),returnFunc);
		}
	}
}
