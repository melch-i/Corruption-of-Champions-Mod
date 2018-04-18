package classes
{
	import classes.GlobalFlags.kFLAGS;
	import coc.view.MainView;
	import flash.net.SharedObject;

	/**
	 * class to relocate ControlBindings-code into single method-calls
	 * @author Stadler76
	 */
	public class Bindings
	{
		public static function get game():CoC { return CoC.instance; }
		public static function get flags():DefaultDict { return game.flags; }

		public function Bindings() {}

		public static function execQuickSave(slot:int):void
		{
			if (game.mainView.menuButtonIsVisible(MainView.MENU_DATA) && game.player.str > 0) {
				var slotX:String = Saves.sharedDir + "CoC_" + slot;
				if (flags[kFLAGS.HARDCORE_MODE] > 0) slotX = flags[kFLAGS.HARDCORE_SLOT];
				var doQuickSave:Function = function():void {
					game.mainView.nameBox.text = "";
					game.saves.saveGame(slotX);
					EngineCore.clearOutput();
					EngineCore.outputText("Game saved to " + slotX + "!");
					EngineCore.doNext(EventParser.playerMenu);
				};
				if (flags[kFLAGS.DISABLE_QUICKSAVE_CONFIRM] !== 0) {
					doQuickSave();
					return;
				}
				EngineCore.clearOutput();
				EngineCore.outputText("You are about to quicksave the current game to <b>" + slotX + "</b>\n\nAre you sure?");
				EngineCore.menu();
				EngineCore.addButton(0, "No", EventParser.playerMenu);
				EngineCore.addButton(1, "Yes", doQuickSave);
			}
		}

		public static function execQuickLoad(slot:uint):void
		{
			if (game.mainView.menuButtonIsVisible(MainView.MENU_DATA)) {
				var saveFile:SharedObject = SharedObject.getLocal(Saves.sharedDir + "CoC_" + slot, "/");
				var doQuickLoad:Function = function():void {
					if (game.saves.loadGame(Saves.sharedDir + "CoC_" + slot)) {
						EngineCore.showStats();
						EngineCore.statScreenRefresh();
						EngineCore.clearOutput();
						EngineCore.outputText("Slot " + slot + " Loaded!");
						EngineCore.doNext(EventParser.playerMenu);
					}
				};
				if (saveFile.data.exists) {
					if (game.player.str === 0 || flags[kFLAGS.DISABLE_QUICKLOAD_CONFIRM] !== 0) {
						doQuickLoad();
						return;
					}
					EngineCore.clearOutput();
					EngineCore.outputText("You are about to quickload the current game from slot <b>" + slot + "</b>\n\nAre you sure?");
					EngineCore.menu();
					EngineCore.addButton(0, "No", EventParser.playerMenu);
					EngineCore.addButton(1, "Yes", doQuickLoad);
				}
			}
		}
	}
}
