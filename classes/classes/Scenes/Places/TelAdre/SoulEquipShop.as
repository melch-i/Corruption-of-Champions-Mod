package classes.Scenes.Places.TelAdre
{
	import classes.GlobalFlags.kFLAGS;
	import classes.ItemType;

	import coc.view.ButtonDataList;

	public class SoulEquipShop extends TelAdreAbstractContent
	{
		public function SoulEquipShop()
		{
		}
		public function soulequipmentmerchant():void {
			clearOutput();//później zamienić soulequipment na imie sprzedawczyni ^^ female siren npc
			outputText("After entering the shop with a sign saying 'Equipment' over the doors you see a few shelves filled with various weapons, shields, armors and even more rare items like rings or necklaces. Behind the desk that looks like a central point of the shop you see a woman that seems to have mixed races traits. A shark face and a tail that sometimes show up on either side of the desk which is contrasting to its feather covered arms that are not looking at all like shark ones and more similar to bird wings.");
			outputText("\n\n\"<i>Greeting dear customer.  Look around and if something catch your eyes let me know,</i>\" she say all that almost on one breath after noticing your near.");
			menu();
			addButton(1, "Shelf 1", weaponMenu,soulequipmentmerchant,soulEquipShelfFirst);
			addButton(2, "Shelf 2", weaponMenu,soulequipmentmerchant,soulEquipShelfSecond);
			addButton(3, "Shelf 3", weaponMenu,soulequipmentmerchant,soulEquipShelfThird);//armors and consumable
			addButton(9, jewelries.SOULRNG.shortName, weaponBuy, jewelries.SOULRNG);
			addButton(14, "Back", telAdre.telAdreMenu);
			statScreenRefresh();
		}
		private var soulEquipShelfFirst:Vector.<ItemType> = new <ItemType>[
			weapons.TRASAXE,weaponsrange.TRSXBOW,shields.TRASBUC,armors.TRASARM,weapons.W_STAFF,
			weapons.GUANDAO,weapons.HSWORDS,weapons.SNAKESW,weapons.FLYWHIS,shields.MABRACE
		];
		private var soulEquipShelfSecond:Vector.<ItemType> = new <ItemType>[
			weapons.KATANA,weapons.NODACHI,weapons.OTETSU,weapons.RCLAYMO,weapons.SCLAYMO,weapons.RIBBON,
			weapons.S_GAUNT,weapons.CLAWS,weapons.TCLAYMO,weapons.ACLAYMO,weapons.WHIP,weapons.PWHIP,weapons.FRTAXE
		];
		private var soulEquipShelfThird:Vector.<ItemType> = new <ItemType>[consumables.W_STICK,consumables.BANGB_M];
		private function weaponMenu(backFunc:Function,items:Vector.<ItemType>):void{
			var buttons:ButtonDataList = new ButtonDataList();
			for each(var item:ItemType in items){
				buttons.add(item.shortName,curry(weaponBuy,item),item.description,item.longName);
			}
			buttons.submenu(backFunc,0,false);
		}

		private function weaponBuy(itype:ItemType):void {
			clearOutput();
			outputText("\"<i>That'll be " + itype.value * 2 + " gems.</i>\"");
			if(player.gems < itype.value * 2) {
				outputText("\n\nYou count out your gems and realize it's beyond your price range.");
				//Goto shop main menu
				doNext(soulequipmentmerchant);
				return;
			}
			else outputText("\n\nDo you buy it?\n\n");
			//Go to debit/update function or back to shop window
			doYesNo(curry(debitWeapon,itype), soulequipmentmerchant);
		}
		private function debitWeapon(itype:ItemType):void {
			player.gems -= itype.value * 2;
			statScreenRefresh();
			inventory.takeItem(itype, soulequipmentmerchant);
		}

	}
}
