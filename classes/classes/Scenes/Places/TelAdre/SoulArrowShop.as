package classes.Scenes.Places.TelAdre
{
	import classes.ItemType;

	public class SoulArrowShop extends TelAdreAbstractContent
	{
		public function SoulArrowShop()
		{
		}
		public function soularrowmerchant():void {
			clearOutput();//później zamienić soulequipment na imie sprzedawczyni ^^ female centaur npc
			outputText("After entering the shop with a sign saying 'Swift Arrow' over the doors you see a few shelves filled with various ranged weapons of all sorts from bows, to crossbows to exotic ones that you can't identify. ");
			outputText("A centauress tends the shop behind a desk. She doesn't have fancy or provocative clothes.  Her build is average.  She moves quite gracesfully around stalls with items for sale despite her naturaly larger body.");
			outputText("\n\n\"<i>Greeting dear customer.  Look around and if something catch your eyes let me know,</i>\" she says all that almost on one breath after noticing your near.");
			menu();
			addButton(0, weaponsrange.BOWLIGH.shortName, weaponrangeBuy, weaponsrange.BOWLIGH);
			addButton(1, weaponsrange.BOWHUNT.shortName, weaponrangeBuy, weaponsrange.BOWHUNT);
			addButton(2, weaponsrange.BOWLONG.shortName, weaponrangeBuy, weaponsrange.BOWLONG);
			addButton(3, weaponsrange.BOWKELT.shortName, weaponrangeBuy, weaponsrange.BOWKELT);
			addButton(5, weaponsrange.LCROSBW.shortName, weaponrangeBuy, weaponsrange.LCROSBW);
			addButton(6, weaponsrange.HUXBOW_.shortName, weaponrangeBuy, weaponsrange.HUXBOW_);
			addButton(7, weaponsrange.HEXBOW_.shortName, weaponrangeBuy, weaponsrange.HEXBOW_);
			addButton(10, weaponsrange.FLINTLK.shortName, weaponrangeBuy, weaponsrange.FLINTLK);
			addButton(11, weaponsrange.BLUNDER.shortName, weaponrangeBuy, weaponsrange.BLUNDER);
			addButton(12, weaponsrange.IVIARG_.shortName, weaponrangeBuy, weaponsrange.IVIARG_);
			addButton(14, "Back", telAdre.telAdreMenu);
			statScreenRefresh();
		}

		private function weaponrangeBuy(itype:ItemType):void {
			clearOutput();
			outputText("\"<i>That'll be " + itype.value + " gems.</i>\"");
			//outputText("The gruff metal-working husky gives you a slight nod and slams the weapon down on the edge of his stand.  He grunts, \"<i>That'll be " + itype.value + " gems.</i>\"");
			if(player.gems < itype.value) {
				outputText("\n\nYou count out your gems and realize it's beyond your price range.");
				//Goto shop main menu
				doNext(soularrowmerchant);
				return;
			}
			else outputText("\n\nDo you buy it?\n\n");
			//Go to debit/update function or back to shop window
			doYesNo(curry(debitWeaponRange,itype), soularrowmerchant);
		}
		private function debitWeaponRange(itype:ItemType):void {
			player.gems -= itype.value;
			statScreenRefresh();
			inventory.takeItem(itype, soularrowmerchant);
		}
	}
}
