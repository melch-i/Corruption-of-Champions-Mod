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
	}
}
