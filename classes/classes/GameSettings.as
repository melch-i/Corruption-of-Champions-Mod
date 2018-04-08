package classes {
import classes.GlobalFlags.*;
	import classes.display.SettingPane;

	import coc.view.MainView;
import coc.view.StatsView;

import flash.display.StageQuality;
	import flash.text.TextField;
	import flash.text.TextFormat;

/**
 * ...
 * @author ...
 */
public class GameSettings extends BaseContent {
	private var lastDisplayedPane:SettingPane;
	private var initializedPanes:Boolean = false;

	private var panes:Array = [];

	private static const PANES_CONFIG:Array = [
		["settingPaneGameplay", "Gameplay Settings", "You can adjust gameplay experience such as game difficulty and NPC standards."],
		["settingPaneInterface", "Interface Settings", "You can customize aspects of the interface to your liking."],
		["settingPaneFetish", "Fetish Settings", "You can turn on or off weird and extreme fetishes."]
	];

	public function GameSettings() {}

	public function configurePanes():void {
		//Gameplay Settings
		for (var i:int = 0; i < PANES_CONFIG.length; i++) {
			var pane:SettingPane = new SettingPane(CoC.instance.mainView.mainText.x, CoC.instance.mainView.mainText.y, CoC.instance.mainView.mainText.width + 16, CoC.instance.mainView.mainText.height);
			pane.name = PANES_CONFIG[i][0];
			var hl:TextField = pane.addHelpLabel();
			hl.htmlText = formatHeader(PANES_CONFIG[i][1]) + PANES_CONFIG[i][2] + "\n\n";
			setOrUpdateSettings(pane);
			panes.push(pane);
		}
		//All done!
		initializedPanes = true;
	}

	private function formatHeader(headLine:String):String
	{
		return "<font size=\"36\" face=\"Georgia\"><u>" + headLine + "</u></font>\n";
	}

	private function setOrUpdateSettings(pane:SettingPane):void {
		if (pane.name == PANES_CONFIG[0][0]) { //Gameplay
			pane.addOrUpdateToggleSettings("Game Difficulty", [
				["Choose", difficultySelectionMenu, getDifficultyText(), false],
				"overridesLabel"
			]);
			pane.addOrUpdateToggleSettings("Debug Mode", [
				["ON", curry(toggleDebug, true), "Items will not be consumed by use, fleeing always succeeds, and bad-ends can be ignored.", debug == true],
				["OFF", curry(toggleDebug, false), "Items consumption will occur as normal.", debug == false]
			]);
			pane.addOrUpdateToggleSettings("Silly Mode", [
				["ON", curry(toggleSetting, kFLAGS.SILLY_MODE_ENABLE_FLAG, true), "Crazy, nonsensical, and possibly hilarious things may occur.", flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] == true],
				["OFF", curry(toggleSetting, kFLAGS.SILLY_MODE_ENABLE_FLAG, false), "You're an incorrigible stick-in-the-mud with no sense of humor.", flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] == false]
			]);
			pane.addOrUpdateToggleSettings("Low Standards", [
				["ON", curry(toggleSetting, kFLAGS.LOW_STANDARDS_FOR_ALL, true), "NPCs ignore body type preferences. Not gender preferences though; you still need the right hole.", flags[kFLAGS.LOW_STANDARDS_FOR_ALL] == true],
				["OFF", curry(toggleSetting, kFLAGS.LOW_STANDARDS_FOR_ALL, false), "NPCs have body-type preferences.", flags[kFLAGS.LOW_STANDARDS_FOR_ALL] == false]
			]);
			pane.addOrUpdateToggleSettings("Hyper Happy", [
				["ON", curry(toggleSetting, kFLAGS.HYPER_HAPPY, true), "Only reducto and humus shrink endowments. Incubus draft doesn't affect breasts, and succubi milk doesn't affect cocks.", flags[kFLAGS.HYPER_HAPPY] == true],
				["OFF", curry(toggleSetting, kFLAGS.HYPER_HAPPY, false), "Male enhancement potions shrink female endowments, and vice versa.", flags[kFLAGS.HYPER_HAPPY] == false]
			]);
			pane.addOrUpdateToggleSettings("Automatic Leveling", [
				["ON", curry(toggleSetting, kFLAGS.AUTO_LEVEL, true), "Leveling up is done automatically once you accumulate enough experience.", flags[kFLAGS.AUTO_LEVEL] == true],
				["OFF", curry(toggleSetting, kFLAGS.AUTO_LEVEL, false), "Leveling up is done manually by pressing 'Level Up' button.", flags[kFLAGS.AUTO_LEVEL] == false]
			]);
			pane.addOrUpdateToggleSettings("SFW Mode", [
				["ON", curry(toggleSetting, kFLAGS.SFW_MODE, true), "SFW mode is enabled. You won't see sex scenes nor will you get raped.", flags[kFLAGS.SFW_MODE] == true],
				["OFF", curry(toggleSetting, kFLAGS.SFW_MODE, false), "SFW mode is disabled. You'll see sex scenes.", flags[kFLAGS.SFW_MODE] == false]
			]);
//			pane.addOrUpdateToggleSettings("Prison", [
//				["ON", curry(toggleSetting, kFLAGS.PRISON_ENABLED, true), "The prison can be accessed.\nWARNING: The prison is very buggy and may break your game. Enter it at your own risk!", flags[kFLAGS.PRISON_ENABLED] == true],
//				["OFF", curry(toggleSetting, kFLAGS.PRISON_ENABLED, false), "The prison cannot be accessed.", flags[kFLAGS.PRISON_ENABLED] == false]
//			]);
			pane.addOrUpdateToggleSettings("Enable Survival", [
				["Enable", enableSurvivalPrompt, "Survival mode is already enabled.", flags[kFLAGS.HUNGER_ENABLED] >= 0.5]
			]);
			pane.addOrUpdateToggleSettings("Enable Realistic", [
				["Enable", enableRealisticPrompt, "Realistic mode is already enabled.", flags[kFLAGS.HUNGER_ENABLED] >= 1]
			]);
			pane.update();
		}
		else if (pane.name == PANES_CONFIG[1][0]) { //Interface
			pane.addOrUpdateToggleSettings("Main Background", [
				["Choose", menuMainBackground, "", false]
			]);
			pane.addOrUpdateToggleSettings("Text Background", [
				["Choose", menuTextBackground, "", false]
			]);
			pane.addOrUpdateToggleSettings("Font Size", [
				["Adjust", fontSettingsMenu, "<b>Font Size: " + (flags[kFLAGS.CUSTOM_FONT_SIZE] || 20) + "</b>", false],
				"overridesLabel"
			]);
			pane.addOrUpdateToggleSettings("Sidebar Font", [
				["New", curry(toggleSetting, kFLAGS.USE_OLD_FONT, false), "Palatino Linotype will be used. This is the current font.", flags[kFLAGS.USE_OLD_FONT] == false],
				["Old", curry(toggleSetting, kFLAGS.USE_OLD_FONT, true), "Lucida Sans Typewriter will be used. This is the old font.", flags[kFLAGS.USE_OLD_FONT] == true]
			]);
			pane.addOrUpdateToggleSettings("Sprites", [
				["Off", curry(toggleSetting, kFLAGS.SHOW_SPRITES_FLAG, 0), "There are only words. Nothing else.", flags[kFLAGS.SHOW_SPRITES_FLAG] == 0],
				["Old", curry(toggleSetting, kFLAGS.SHOW_SPRITES_FLAG, 1), "You like to look at pretty pictures. Old, 8-bit sprites will be shown.", flags[kFLAGS.SHOW_SPRITES_FLAG] == 1],
				["New", curry(toggleSetting, kFLAGS.SHOW_SPRITES_FLAG, 2), "You like to look at pretty pictures. New, 16-bit sprites will be shown.", flags[kFLAGS.SHOW_SPRITES_FLAG] == 2]
			]);
			pane.addOrUpdateToggleSettings("Image Pack", [
				["ON", curry(toggleSetting, kFLAGS.IMAGEPACK_OFF, false), "Image pack is currently enabled.", flags[kFLAGS.IMAGEPACK_OFF] == false],
				["OFF", curry(toggleSetting, kFLAGS.IMAGEPACK_OFF, true), "Images from image pack won't be shown.", flags[kFLAGS.IMAGEPACK_OFF] == true]
			]);
			pane.addOrUpdateToggleSettings("CharView",[
				["ON",toggleCharViewer,"Player visualiser is enabled",flags[kFLAGS.CHARVIEWER_ENABLED] == 1],
				["OFF",toggleCharViewer,"Player visualiser is disabled",flags[kFLAGS.CHARVIEWER_ENABLED] == 0]
			]);
			pane.addOrUpdateToggleSettings("CharView Style",[
				["New",curry(flagToggle, curry(setOrUpdateSettings,pane), kFLAGS.CHARVIEW_STYLE),"Character Viewer is inline with text",flags[kFLAGS.CHARVIEW_STYLE] == 0],
				["Old",curry(flagToggle, curry(setOrUpdateSettings,pane), kFLAGS.CHARVIEW_STYLE),"Character Viewer is separate from text",flags[kFLAGS.CHARVIEW_STYLE] == 1]
			]);
//			pane.addOrUpdateToggleSettings("Animate Stats Bars", [
//				["ON", curry(toggleSetting, kFLAGS.ANIMATE_STATS_BARS, true), "The stats bars and numbers will be animated if changed.", flags[kFLAGS.ANIMATE_STATS_BARS] == true],
//				["OFF", curry(toggleSetting, kFLAGS.ANIMATE_STATS_BARS, false), "The stats will not animate. Basically classic.", flags[kFLAGS.ANIMATE_STATS_BARS] == false]
//			]);
//			pane.addOrUpdateToggleSettings("Show Enemy Stats Bars", [
//				["ON", curry(toggleSetting, kFLAGS.ENEMY_STATS_BARS_ENABLED, true), "Opponent's stat bars will be displayed in combat.", flags[kFLAGS.ENEMY_STATS_BARS_ENABLED] == true],
//				["OFF", curry(toggleSetting, kFLAGS.ENEMY_STATS_BARS_ENABLED, false), "Opponent's stat bars will not be displayed in combat, and classic enemy info display will be used.", flags[kFLAGS.ENEMY_STATS_BARS_ENABLED] == false]
//			]);
			pane.addOrUpdateToggleSettings("Time Format", [
				["12-hour", curry(toggleSetting, kFLAGS.USE_12_HOURS, true), "Time will be shown in 12-hour format. (AM/PM)", flags[kFLAGS.USE_12_HOURS] == true],
				["24-hour", curry(toggleSetting, kFLAGS.USE_12_HOURS, false), "Time will be shown in 24-hour format.", flags[kFLAGS.USE_12_HOURS] == false]
			]);
			pane.addOrUpdateToggleSettings("Measurements", [
				["Metric", curry(settingToggle,curry(setOrUpdateSettings,pane),Measurements,"useMetrics"), "Various measurements will be shown in metrics. (Centimeters, meters)", Measurements.useMetrics == true],
				["Imperial", curry(settingToggle,curry(setOrUpdateSettings,pane),Measurements,"useMetrics"), "Various measurements will be shown in imperial units. (Inches, feet)", Measurements.useMetrics == false]
			]);
			pane.addOrUpdateToggleSettings("Quicksave Confirmation", [
				["ON", curry(toggleSetting, kFLAGS.DISABLE_QUICKSAVE_CONFIRM, false), "Quicksave confirmation dialog is enabled.", flags[kFLAGS.DISABLE_QUICKSAVE_CONFIRM] == false],
				["OFF", curry(toggleSetting, kFLAGS.DISABLE_QUICKSAVE_CONFIRM, true), "Quicksave confirmation dialog is disabled.", flags[kFLAGS.DISABLE_QUICKSAVE_CONFIRM] == true]
			]);
			pane.addOrUpdateToggleSettings("Quickload Confirmation", [
				["ON", curry(toggleSetting, kFLAGS.DISABLE_QUICKLOAD_CONFIRM, false), "Quickload confirmation dialog is enabled.", flags[kFLAGS.DISABLE_QUICKLOAD_CONFIRM] == false],
				["OFF", curry(toggleSetting, kFLAGS.DISABLE_QUICKLOAD_CONFIRM, true), "Quickload confirmation dialog is disabled.", flags[kFLAGS.DISABLE_QUICKLOAD_CONFIRM] == true]
			]);
			pane.addOrUpdateToggleSettings("Hotkey Visibility", [
				["ON", curry(settingToggle,curry(setOrUpdateSettings,pane),CoC.instance.inputManager,"showHotkeys"), "Hotkeys are displayed", CoC.instance.inputManager.showHotkeys == true],
				["OFF", curry(settingToggle,curry(setOrUpdateSettings,pane),CoC.instance.inputManager,"showHotkeys"), "Hotkeys are disabled", CoC.instance.inputManager.showHotkeys == false]
			]);
			pane.update();
		}
		else if (pane.name == PANES_CONFIG[2][0]) { //Fetishes
			pane.addOrUpdateToggleSettings("Watersports (Urine)", [
				["ON", curry(toggleSetting, kFLAGS.WATERSPORTS_ENABLED, true), "Watersports are enabled. You kinky person.", flags[kFLAGS.WATERSPORTS_ENABLED] == true],
				["OFF", curry(toggleSetting, kFLAGS.WATERSPORTS_ENABLED, false), "You won't see watersports scenes.", flags[kFLAGS.WATERSPORTS_ENABLED] == false]
			]);
			if(player){
				pane.addOrUpdateToggleSettings("Worms", [
					["ON", curry(setWorms, true, false), "You have chosen to encounter worms as you find the mountains.", player.hasStatusEffect(StatusEffects.WormsOn) && !player.hasStatusEffect(StatusEffects.WormsHalf)],
					["ON (Half)", curry(setWorms, true, true), "You have chosen to encounter worms as you find the mountains, albeit at reduced rate.", player.hasStatusEffect(StatusEffects.WormsHalf)],
					["OFF", curry(setWorms, false, false), "You have chosen not to encounter worms.", player.hasStatusEffect(StatusEffects.WormsOff)],
				]);
			}
			pane.update();
		}
	}

	public function enterSettings():void {
		CoC.instance.saves.savePermObject(false);
		CoC.instance.mainMenu.hideMainMenu();
		hideMenus();
		if (!initializedPanes) configurePanes();
		clearOutput();
		disableHardcoreCheatSettings();
		displaySettingPane(panes[0]);
		setButtons();
	}
	public function exitSettings():void {
		CoC.instance.saves.savePermObject(false);
		hideSettingPane();
		CoC.instance.mainMenu.mainMenu();
	}

	private function setButtons():void {
		menu();
		addButton(0, "Gameplay", displaySettingPane, panes[0]);
		addButton(1, "Interface", displaySettingPane, panes[1]);
		addButton(2, "Fetishes", displaySettingPane, panes[2]);
		addButton(4, "Controls", displayControls);
		addButton(10, "Debug Info", enterDebugPane);
		addButton(14, "Back", exitSettings);
		for (var i:int = 0; i < panes.length; i++) {
			if (lastDisplayedPane == panes[i]) {
				addButtonDisabled(i, mainView.bottomButtons[i].labelText);
			}
		}
	}

	private function displaySettingPane(pane:SettingPane):void {
		hideSettingPane();
		lastDisplayedPane = pane;
		mainView.mainText.visible = false;
		mainView.addChild(pane);
		pane.update();
		setButtons();
	}
	private function hideSettingPane():void {
		mainView.mainText.visible = true;
		if (lastDisplayedPane != null && lastDisplayedPane.parent != null) lastDisplayedPane.parent.removeChild(lastDisplayedPane);
	}
	private function enterDebugPane():void {
		hideSettingPane();
		CoC.instance.debugInfoMenu.debugPane();
	}

	private function getDifficultyText():String {
		var text:String = "<b>Difficulty: ";
		switch(flags[kFLAGS.GAME_DIFFICULTY]) {
			case 0:
				if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG]) text += "<font color=\"#008000\">Easy</font></b>\n<font size=\"14\">Combat is easier and bad-ends can be ignored.</font>";
				else text += "<font color=\"#808000\">Normal</font></b>\n<font size=\"14\">No opponent stats modifiers. You can resume from bad-ends with penalties.</font>";
				break;
			case 1:
				text += "<font color=\"#800000\">Hard</font></b>\n<font size=\"14\">Opponent has 25% more HP and does 15% more damage. Bad-ends can ruin your game.</font>";
				break;
			case 2:
				text += "<font color=\"#C00000\">Nightmare</font></b>\n<font size=\"14\">Opponent has 50% more HP and does 30% more damage.</font>";
				break;
			case 3:
				text += "<font color=\"#FF0000\">Extreme</font></b>\n<font size=\"14\">Opponent has 100% more HP and does more 50% damage.</font>";
				break;
			default:
				text += "Something derped with the coding!";
		}
		return text;
	}
	public function disableHardcoreCheatSettings():void {
		if (flags[kFLAGS.HARDCORE_MODE] > 0) {
			outputText("<font color=\"#ff0000\">Hardcore mode is enabled. Cheats are disabled.</font>\n\n");
			debug = false;
			flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 0;
			flags[kFLAGS.HYPER_HAPPY] = 0;
			flags[kFLAGS.LOW_STANDARDS_FOR_ALL] = 0;
		}
//		if (flags[kFLAGS.GRIMDARK_MODE] > 0) {
//			debug = false;
//			flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 0;
//			flags[kFLAGS.GAME_DIFFICULTY] = 3;
//		}
	}

	public function get charviewEnabled():Boolean {
		return flags[kFLAGS.CHARVIEWER_ENABLED];
	}

	private function difficultySelectionMenu():void {
		hideSettingPane();
		clearOutput();
		outputText("You can choose a difficulty to set how hard battles will be.\n");
		outputText("\n<b>Easy:</b> -50% damage, can ignore bad-ends.");
		outputText("\n<b>Normal:</b> No stats changes.");
		outputText("\n<b>Hard:</b> +25% HP, +15% damage.");
		outputText("\n<b>Nightmare:</b> +50% HP, +30% damage.");
		outputText("\n<b>Extreme:</b> +100% HP, +50% damage.");
		menu();
		addButton(0, "Easy", chooseDifficulty, -1);
		addButton(1, "Normal", chooseDifficulty, 0);
		addButton(2, "Hard", chooseDifficulty, 1);
		addButton(3, "Nightmare", chooseDifficulty, 2);
		addButton(4, "EXTREME", chooseDifficulty, 3);
		addButton(14, "Back", displaySettingPane, lastDisplayedPane);
	}
	private function chooseDifficulty(difficulty:int = 0):void {
		if (difficulty < 0) {
			flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = -difficulty;
			flags[kFLAGS.GAME_DIFFICULTY] = 0;
		}
		else {
			flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 0;
			flags[kFLAGS.GAME_DIFFICULTY] = difficulty;
		}
		setOrUpdateSettings(lastDisplayedPane);
		displaySettingPane(lastDisplayedPane);
	}

	private function setWorms(enabled:Boolean, half:Boolean):void {
		//Clear status effects
		if (player.hasStatusEffect(StatusEffects.WormsOn)) player.removeStatusEffect(StatusEffects.WormsOn);
		if (player.hasStatusEffect(StatusEffects.WormsHalf)) player.removeStatusEffect(StatusEffects.WormsHalf);
		if (player.hasStatusEffect(StatusEffects.WormsOff)) player.removeStatusEffect(StatusEffects.WormsOff);
		//Set status effects
		if (enabled) {
			player.createStatusEffect(StatusEffects.WormsOn, 0, 0, 0, 0);
			if (half) player.createStatusEffect(StatusEffects.WormsHalf, 0, 0, 0, 0);
		}
		else {
			player.createStatusEffect(StatusEffects.WormsOff, 0, 0, 0, 0);
		}
		setOrUpdateSettings(lastDisplayedPane);
	}

	//Survival Mode
	public function enableSurvivalPrompt():void {
		hideSettingPane();
		clearOutput();
		outputText("Are you sure you want to enable Survival Mode?\n\n");
		outputText("You will NOT be able to turn it off! (Unless you reload immediately.)");
		doYesNo(enableSurvivalForReal, createCallBackFunction(displaySettingPane, lastDisplayedPane));
	}
	public function enableSurvivalForReal():void {
		clearOutput();
		outputText("Survival mode is now enabled.");
		player.hunger = 80;
		flags[kFLAGS.HUNGER_ENABLED] = 0.5;
		doNext(createCallBackFunction(displaySettingPane, lastDisplayedPane));
	}

	//Realistic Mode
	public function enableRealisticPrompt():void {
		hideSettingPane();
		clearOutput();
		outputText("Are you sure you want to enable Realistic Mode?\n\n");
		outputText("You will NOT be able to turn it off! (Unless you reload immediately.)");
		doYesNo(enableRealisticForReal, createCallBackFunction(displaySettingPane, lastDisplayedPane));
	}
	public function enableRealisticForReal():void {
		clearOutput();
		outputText("Realistic mode is now enabled.")
		flags[kFLAGS.HUNGER_ENABLED] = 1;
		doNext(createCallBackFunction(displaySettingPane, lastDisplayedPane));
	}

	public function menuMainBackground():void {
		menu();
		addButton(0, "Default", setMainBackground, 0);
		addButton(1, "Map", setMainBackground, 1);
		addButton(2, "Parchment", setMainBackground, 2);
		addButton(3, "Marble", setMainBackground, 3);
		addButton(4, "Obsidian", setMainBackground, 4);
		addButton(5, "Black", setMainBackground, 5);

		addButton(14, "Back", displaySettingPane, lastDisplayedPane);
	}

	public function menuTextBackground():void {
		menu();
		addButton(0, "Normal", setTextBackground, 0);
		addButton(1, "White", setTextBackground, 1);
		addButton(2, "Tan", setTextBackground, 2);
		addButton(3, "Clear", setTextBackground, -1);
		addButton(14, "Back", displaySettingPane, lastDisplayedPane);
	}

	private function flagToggle(returnTo:Function, flag:int):void
	{
		flags[flag] ^= 1; // Bitwise XOR. Neat trick to toggle between 0 and 1
		returnTo();
	}
	private function settingToggle(returnTo:Function, obj:Object, setting:String):void
	{
		obj[setting] = !obj[setting];
		returnTo();
	}

	public function toggleSetting(flag:int, selection:int):void {
		flags[flag] = selection;
		setOrUpdateSettings(lastDisplayedPane);
	}
	public function toggleDebug(selection:Boolean):void {
		debug = selection;
		setOrUpdateSettings(lastDisplayedPane);
	}

	public function toggleCharViewer(flag:int = kFLAGS.CHARVIEWER_ENABLED):void {
		if (flags[flag] < 1) {
			flags[flag] = 1;
			mainView.charView.reload();
		} else {
			flags[flag] = 0;
		}
		setOrUpdateSettings(lastDisplayedPane);
	}

		public function setMainBackground(type:int):void {
			flags[kFLAGS.BACKGROUND_STYLE]           = type;
			mainView.background.bitmapClass          = MainView.Backgrounds[flags[kFLAGS.BACKGROUND_STYLE]];
			mainView.statsView.setBackground(StatsView.SidebarBackgrounds[flags[kFLAGS.BACKGROUND_STYLE]]);
			mainView.monsterStatsView.setBackground(StatsView.SidebarBackgrounds[flags[kFLAGS.BACKGROUND_STYLE]]);
			menuMainBackground();
		}

	public function setTextBackground(type:int):void {
		flags[kFLAGS.TEXT_BACKGROUND_STYLE] = type;
		mainView.setTextBackground(type);
	}

	//Needed for keys
	public function cycleBackground():void {
		flags[kFLAGS.TEXT_BACKGROUND_STYLE]++;
		if (flags[kFLAGS.TEXT_BACKGROUND_STYLE] > 2) {
			flags[kFLAGS.TEXT_BACKGROUND_STYLE] = 0;
		}
		mainView.setTextBackground(flags[kFLAGS.TEXT_BACKGROUND_STYLE]);
	}

	public function cycleQuality():void {
		if (mainView.stage.quality == StageQuality.LOW) mainView.stage.quality = StageQuality.MEDIUM;
		else if (mainView.stage.quality == StageQuality.MEDIUM) mainView.stage.quality = StageQuality.HIGH;
		else if (mainView.stage.quality == StageQuality.HIGH) mainView.stage.quality = StageQuality.LOW;
	}

	//------------
	// FONT SIZE
	//------------
	public function fontSettingsMenu():void {
		hideSettingPane();
		clearOutput();
		outputText("Font size is currently set at " + (flags[kFLAGS.CUSTOM_FONT_SIZE] > 0 ? flags[kFLAGS.CUSTOM_FONT_SIZE] : 20) +  ".\n\n");
		outputText("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae turpis nec ipsum fermentum pellentesque. Nam consectetur euismod diam. Proin vitae neque in massa tempor suscipit eget at mi. In hac habitasse platea dictumst. Morbi laoreet erat et sem hendrerit mattis. Cras in mauris vestibulum nunc fringilla condimentum. Nam sed arcu non ipsum luctus dignissim a eget ante. Curabitur dapibus neque at elit iaculis, ac aliquam libero dapibus. Sed non lorem diam. In pretium vehicula facilisis. In euismod imperdiet felis, vitae ultrices magna cursus at. Vivamus orci urna, fringilla ac elementum eu, accumsan vel nunc. Donec faucibus dictum erat convallis efficitur. Maecenas cursus suscipit magna, id dapibus augue posuere ut.\n\n");
		menu();
		addButton(0, "Smaller Font", adjustFontSize, -1);
		addButton(1, "Larger Font", adjustFontSize, 1);
		addButton(2, "Reset Size", adjustFontSize, 0);
		addButton(4, "Back", displaySettingPane, lastDisplayedPane);
	}
	public function adjustFontSize(change:int):void {
		var fmt:TextFormat = mainView.mainText.getTextFormat();
		if (fmt.size == null) fmt.size = 20;
		fmt.size = (fmt.size as Number) + change;
		if (change == 0) fmt.size = 20;
		if ((fmt.size as Number) < 14) fmt.size = 14;
		if ((fmt.size as Number) > 32) fmt.size = 32;
		mainView.mainText.setTextFormat(fmt);
		flags[kFLAGS.CUSTOM_FONT_SIZE] = fmt.size;
		setOrUpdateSettings(lastDisplayedPane);
		fontSettingsMenu();
	}

    private function displayControls():void
    {
	    hideSettingPane();
        mainView.hideAllMenuButtons();
        CoC.instance.inputManager.DisplayBindingPane();
        EngineCore.menu();
        EngineCore.addButton(0, "Reset Ctrls", resetControls);
        EngineCore.addButton(1, "Clear Ctrls", clearControls);
        EngineCore.addButton(4, "Back", hideControls);
    }

    private function hideControls():void
    {
        CoC.instance.inputManager.HideBindingPane();
	    displaySettingPane(lastDisplayedPane);
    }

    private function resetControls():void
    {
        CoC.instance.inputManager.HideBindingPane();
        EngineCore.clearOutput();
        EngineCore.outputText("Are you sure you want to reset all of the currently bound controls to their defaults?");

        EngineCore.doYesNo(resetControlsYes, displayControls);
    }

    private function resetControlsYes():void
    {
        CoC.instance.inputManager.ResetToDefaults();
        EngineCore.clearOutput();
        EngineCore.outputText("Controls have been reset to defaults!\n\n");

        EngineCore.doNext(displayControls);
    }

    private function clearControls():void
    {
        CoC.instance.inputManager.HideBindingPane();
        EngineCore.clearOutput();
        EngineCore.outputText("Are you sure you want to clear all of the currently bound controls?");

        EngineCore.doYesNo(clearControlsYes, displayControls);
    }

    private function clearControlsYes():void
    {
        CoC.instance.inputManager.ClearAllBinds();
        EngineCore.clearOutput();
        EngineCore.outputText("Controls have been cleared!");

        EngineCore.doNext(displayControls);
    }
}

}
