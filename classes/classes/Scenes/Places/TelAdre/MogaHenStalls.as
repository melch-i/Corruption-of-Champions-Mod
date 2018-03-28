package classes.Scenes.Places.TelAdre
{
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	import classes.ItemType;
	import classes.Items.ConsumableLib;
	import classes.Scenes.SceneLib;

	import coc.view.ButtonDataList;

	public class MogaHenStalls extends BaseContent
	{
		public function MogaHenStalls()
		{
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

		public function mogahenmerchant():void {
			var buyItem:Function = curry(confirmBuy,mogahenmerchant,"Moga",3);
			var introText:String = "While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace the ";
			var costText:String = " in you.  Interested?  It is merely <b>";
			var endText:String = " gems</b></i>.\"";
			var onBuyString:String="\n\nAfter you give Hen gems he hand over to you purchased transformative item. ";
			var consLib:ConsumableLib = consumables;
			var tierOne:Array = [
				[consLib.B_GOSSR,"drider"], [consLib.BEEHONY, "bee"],[consLib.BLADEGR,"mantis"],
				[consLib.CANINEP,"dog"],[consLib.EQUINUM,"horse"],[consLib.FOXBERY,"fox"],
				[consLib.FRRTFRT,"ferret"],[consLib.GLDRIND,"deer"],[consLib.GLDSEED,"harpy"],
				[consLib.GOB_ALE,"goblin"],[consLib.INCUBID,"incubus"],[consLib.KANGAFT,"kangaroo"],
				[consLib.LABOVA_,"cow"],[consLib.MOUSECO,"mouse"]
			];
			var tierTwo:Array = [
				[consLib.MINOBLO,"bull"],[consLib.PIGTRUF,"pig"],[consLib.REPTLUM,"lizan"],
				[consLib.RINGFIG,"raccoon"],[consLib.S_GOSSR,"spider"],[consLib.SALAMFW,"salamander"],
				[consLib.SCORICO,"scorpion"],[consLib.SHARK_T,"shark"],[consLib.SNAKOIL,"snake"],
				[consLib.SUCMILK,"sucubus"],[consLib.TSTOOTH,"tigershark"],[consLib.W_FRUIT,"cat"],
				[consLib.WETCLTH,"goo"],[consLib.YETICUM,"yeti"]
			];
			var tierThree:Array = [
				[consLib.BLACKIN,"female scylla"],[consLib.BLACKPP,"dog"],[consLib.BULBYPP,"dog"],
				[consLib.DBLPEPP,"dog"],[consLib.KNOTTYP,"dog"],[consLib.LARGEPP,"dog"],
				[consLib.CHILLYP,"winter wolf"],[consLib.MARAFRU,"plant"],[consLib.SKYSEED,"avian"]
			];
			var tierFour:Array = [
				[consLib.SPHONEY,"bee"],[consLib.SATYR_W,"satyr"],[consLib.DRAKHRT,"dragon"],
				[consLib.HUMMUS_,"humanity"]
			];
			var tierFive:Array = [
				[consLib.COAL___,"heat or rut"],[consLib.DRYTENT,"anemone"],[consLib.ECTOPLS,"ghost"],
				[consLib.TRAPOIL,"sand trap"],[consLib.ICICLE_,"ice shard"]
			];

			clearOutput();
			outputText("You enter a shop that got sign over the entrance titled 'Transformative Items and Exchanges'.  Inside you see few stalls with many types of the items put on the display.  Most of them you have already seen somewhere but few seems to been quite rare ones as you not seen many of them so far or at least never seen in such large amounts gathered in one place.");
			outputText("\n\nWhen you're looking over the stalls human owner almost silently approched you but compared to other shop you have seen in this islands Moga Hen by clearing his throat attracts your attention to himself.  After you turned toward him, smiling at you like a cat at the mouse, he first breaks the silence.");
			outputText("\n\n\"<i>Welcome to my humble shop dear and precious customer. What need bring you here today? To repair some damage by using casual picked item or some specific change to attain? Or maybe you need to exchange some gems or spirit stones? I could even give you a fair price on special items that are useless for non-cultivators.</i>\" Each word sounds almost like it was repeated endless times.\n\n");
			menu();
			addButton(0, "1st Stall", buyMenu,tierOne).hint("Check out first of stalls with a cheapest TF items.");
			addButton(1, "2nd Stall", buyMenu,tierTwo).hint("Check out second of stalls with a cheapest TF items.");
			addButton(2, "3rd Stall", buyMenu,tierThree).hint("Check out stall with more expensive TF items.");
			addButton(3, "4th Stall", buyMenu,tierFour).hint("Check out stall with most expensive TF items.");
			addButton(5, "5th Stall", buyMenu,tierFive).hint("Check out stall with most exotic TF items.");		//specjalne type TF jak ectoplasm ^^
			//addButton(10, "Talk", TalkWithMogaHen).hint("Talk with shopkeeper.");
			addButton(12, "Exchange", exchangeGemsToSpiritStonesorReverse).hint("Exchange gems to spirit stones or spirit stones to gems.");
			addButton(14, "Back", SceneLib.telAdre.telAdreMenu);
			statScreenRefresh();

			function sayLine(itype:ItemType,desc:String):String{
				return introText+desc+costText+(itype.value*3)+endText;
			}

			function buyMenu(items:Array):void{
				var buttons:ButtonDataList = new ButtonDataList();
				for each(var item:Array in items){
					buttons.add(item[0].shortName,curry(buyItem,item[0],sayLine(item[0],item[1]),onBuyString),"Buy "+item[0].longName);
				}
				submenu(buttons,mogahenmerchant,0,false);
				statScreenRefresh();
			}
		}
		private function exchangeGemsToSpiritStonesorReverse():void {
			clearOutput();
			outputText("When you ask about this exchange that was mentioned on the sign over the entrance Moga  think for a moment before reaching to the desk near him. After handing you over a piece of paper he adds.");
			outputText("\n\n\"<i>Here are my exchange rates. Pick the one you want and let me know. If you don't like those rates you can go and try to find someone else... not like there is anyone else here that want to deal with those exchanges aside me.</i>\"");
			menu();
			if (player.gems >= 20) addButton(0, "20 Gems", exchange,1).hint("Exchange 20 gems to 1 spirit stone.");
			if (player.gems >= 100) addButton(1, "100 Gems", exchange,5).hint("Exchange 100 gems to 5 spirit stones.");
			if (player.gems >= 200) addButton(2, "200 Gems", exchange,10).hint("Exchange 200 gems to 10 spirit stones.");
			if (player.gems >= 1000) addButton(3, "1000 Gems", exchange,50).hint("Exchange 1000 gems to 50 spirit stones.");
			if (player.gems >= 2000) addButton(4, "2000 Gems", exchange, 100).hint("Exchange 2000 gems to 100 spirit stones.");
			if (flags[kFLAGS.SPIRIT_STONES] >= 1) addButton(5, "1 SS", exchange,1,false).hint("Exchange 1 spirit stone to 5 gems.");
			if (flags[kFLAGS.SPIRIT_STONES] >= 5) addButton(6, "5 SS", exchange,5,false).hint("Exchange 5 spirit stones to 25 gems.");
			if (flags[kFLAGS.SPIRIT_STONES] >= 10) addButton(7, "10 SS", exchange,10,false).hint("Exchange 10 spirit stones to 50 gems.");
			if (flags[kFLAGS.SPIRIT_STONES] >= 50) addButton(8, "50 SS", exchange,50,false).hint("Exchange 50 spirit stones to 250 gems.");
			if (flags[kFLAGS.SPIRIT_STONES] >= 100) addButton(9, "100 SS", exchange,100,false).hint("Exchange 100 spirit stones to 500 gems.");
			addButton(14, "Back", mogahenmerchant);
		}
		private function exchange(value:int,toStones:Boolean=true):void{
			if(toStones){
				switch(value){
					case 1:outputText("After picking the lowers one rate for gems to stones you count gems before giving them to the merchant. With noticable mumbling about customer been stingy he without haste finishing transaction by giving you one spirit stone.");break;
					case 5:outputText("After picking the low one rate for gems to stones you count gems before giving them to the merchant. With barely noticable mumbling about customer been stingy he without haste finishing transaction by giving you five spirit stones.");break;
					case 10:outputText("After picking the middle one rate for gems to stones you count gems before giving them to merchant. Without haste he finishing transaction by giving you ten spirit stones.");break;
					case 50:outputText("After picking the high one rate for gems to stones you count gems before giving them to merchant. With slight haste he finishing transaction by giving you fifty spirit stones.");break;
					case 100:outputText("After picking the highest one rate for gems to stones you count gems before giving them to merchant. With haste he finishing transaction by giving you hundred spirit stones.");break;
				}
				player.gems -= 20*value;
				flags[kFLAGS.SPIRIT_STONES]+=value;
			} else {
				switch(value){
					case 1:outputText("After picking the lowers one rate for stones to gems you hand over one stone to the merchant. With noticable mumbling about customer been stingy he without haste finishing transaction by giving you gems.");break;
					case 5:outputText("After picking the low one rate for stones to gems you hand over five stones to the merchant. With barely noticable mumbling about customer been stingy he without haste finishing transaction by giving you gems.");break;
					case 10:outputText("After picking the middle one rate for stones to gems you hand over ten stones to the merchant. Without haste he finishing transaction by giving you gems.");break;
					case 50:outputText("After picking the high one rate for stones to gems you hand over fifty stones to the merchant. With slight haste he finishing transaction by giving you gems.");break;
					case 100:outputText("After picking the highest one rate for stones to gems you hand over hundred stones to the merchant. With haste he finishing transaction by giving you gems.");break;
				}
				player.gems += 5*value;
				flags[kFLAGS.SPIRIT_STONES]-=value;
			}
			statScreenRefresh();
			doNext(exchangeGemsToSpiritStonesorReverse);

		}
	}
}
