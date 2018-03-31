package classes{
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.SceneLib;

import coc.view.MainView;

import flash.net.SharedObject;
import flash.ui.Keyboard;

internal class ControlBindings {
    public function ControlBindings() {

    }
    public function executeButtonClick(button:int = 0):void {
        mainView.clickButton( button );
    }
    private function get mainView():MainView {
        return CoC.instance.mainView;
    }
    internal function run(inputManager:InputManager):void {
		inputManager.AddBindableControl(
                "Show Stats",
                "Show the stats pane when available",
                function ():void {
                    if (mainView.menuButtonIsVisible(MainView.MENU_STATS) && CoC.instance.player.str > 0) {
                        CoC.instance.playerInfo.displayStats();
                    }
                },
                mainView.statsButton
        );

        inputManager.AddBindableControl(
                "Level Up",
                "Show the level up page when available",
                function ():void {
                    if (mainView.menuButtonIsVisible(MainView.MENU_LEVEL) && CoC.instance.player.str > 0) {
                        CoC.instance.playerInfo.levelUpGo();
                    }
                },
                mainView.levelButton);

	    inputManager.AddBindableControl("Quicksave 1", "Quicksave the current game to slot 1", function():void { Bindings.execQuickSave(1); });
	    inputManager.AddBindableControl("Quicksave 2", "Quicksave the current game to slot 2", function():void { Bindings.execQuickSave(2); });
	    inputManager.AddBindableControl("Quicksave 3", "Quicksave the current game to slot 3", function():void { Bindings.execQuickSave(3); });
	    inputManager.AddBindableControl("Quicksave 4", "Quicksave the current game to slot 4", function():void { Bindings.execQuickSave(4); });
	    inputManager.AddBindableControl("Quicksave 5", "Quicksave the current game to slot 5", function():void { Bindings.execQuickSave(5); });

	    inputManager.AddBindableControl("Quickload 1", "Quickload the current game from slot 1", function():void { Bindings.execQuickLoad(1); });
	    inputManager.AddBindableControl("Quickload 2", "Quickload the current game from slot 2", function():void { Bindings.execQuickLoad(2); });
	    inputManager.AddBindableControl("Quickload 3", "Quickload the current game from slot 3", function():void { Bindings.execQuickLoad(3); });
	    inputManager.AddBindableControl("Quickload 4", "Quickload the current game from slot 4", function():void { Bindings.execQuickLoad(4); });
	    inputManager.AddBindableControl("Quickload 5", "Quickload the current game from slot 5", function():void { Bindings.execQuickLoad(5); });

            inputManager.AddBindableControl(
                    "Show Menu",
                    "Show the main menu",
                    function ():void {
                        if (mainView.menuButtonIsVisible(MainView.MENU_NEW_MAIN) && mainView.menuButtonHasLabel(MainView.MENU_NEW_MAIN, "Main Menu")) {
                            CoC.instance.mainMenu.mainMenu();
                        }
                    });

            inputManager.AddBindableControl(
                    "Data Menu",
                    "Show the save/load menu",
                    function ():void {
                        if (mainView.menuButtonIsVisible(MainView.MENU_DATA)) {
                            CoC.instance.saves.saveLoad(undefined);
                        }
                    },
                    mainView.dataButton
            );

            inputManager.AddBindableControl(
                    "Appearance Page",
                    "Show the appearance page",
                    function ():void {
                        if (mainView.menuButtonIsVisible(MainView.MENU_APPEARANCE)) {
                            CoC.instance.playerAppearance.appearance();
                        }
                    },
                    mainView.appearanceButton
            );

            inputManager.AddBindableControl(
                    "No",
                    "Respond no to any available prompt",
                    function ():void {
                        if (mainView.getButtonText(1) == "No" && mainView.buttonIsVisible(1)) {
                            executeButtonClick(1);
                        }
                    });

            inputManager.AddBindableControl(
                    "Yes",
                    "Respond yes to any available prompt",
                    function ():void {
                        if (mainView.getButtonText(0) == "Yes" && mainView.buttonIsVisible(0)) {
                            executeButtonClick(0);
                        }
                    });

            inputManager.AddBindableControl(
                    "Show Perks",
                    "Show the perks page",
                    function ():void {
                        if (mainView.menuButtonIsVisible(MainView.MENU_PERKS)) {
                            CoC.instance.perkMenu.displayPerks(null);
                        }
                    },
                    mainView.perksButton
            );

            inputManager.AddBindableControl(
                    "Continue",
                    "Respond to continue",
                    function ():void {
                        // Button 9
                        if (mainView.buttonIsVisible(9) && mainView.buttonTextIsOneOf(9, ["Nevermind", "Abandon", "Next", "Return", "Back", "Leave", "Resume"])) {
                            //trace( "keyboard(): processing space bar for button 9",
                            //	mainView.buttonIsVisible( 9 ) ? "(visible)" : "(hidden)",
                            //	mainView.getButtonText( 9 ) );
                            mainView.toolTipView.hide();
                            executeButtonClick(9);
                            return;
                        }
                        // Button 14
                        if (EngineCore.buttonIsVisible(14) && EngineCore.buttonTextIsOneOf(14, ["Nevermind", "Abandon", "Next", "Return", "Back", "Leave", "Resume"])) {
                            //trace( "keyboard(): processing space bar for button 9",
                            //	mainView.buttonIsVisible( 9 ) ? "(visible)" : "(hidden)",
                            //	mainView.getButtonText( 9 ) );
                            mainView.toolTipView.hide();
                            executeButtonClick(14);
                            return;
                        }
                        // Button 0
                        if (mainView.buttonIsVisible(0) && mainView.buttonTextIsOneOf(0, ["Next", "Return", "Back"])) {
                            //trace( "keyboard(): processing space bar for button 0",
                            //	mainView.buttonIsVisible( 0 ) ? "(visible)" : "(hidden)",
                            //	mainView.getButtonText( 0 ) );
                            mainView.toolTipView.hide();
                            executeButtonClick(0);
                            return;
                        }

                        // Button 4
                        if (mainView.buttonIsVisible(4) && mainView.buttonTextIsOneOf(4, ["Nevermind", "Next", "Return", "Back", "Leave"])) {
                            //trace( "keyboard(): processing space bar for button 4",
                            //	mainView.buttonIsVisible( 4 ) ? "(visible)" : "(hidden)",
                            //	mainView.getButtonText( 4 ) );
                            mainView.toolTipView.hide();
                            executeButtonClick(4);
                            return;
                        }

                        // Button 5
                        if (mainView.buttonIsVisible(5) && mainView.buttonTextIsOneOf(5, ["Next", "Return", "Back"])) {
                            //trace( "keyboard(): processing space bar for button 5",
                            //	mainView.buttonIsVisible( 5 ) ? "(visible)" : "(hidden)",
                            //	mainView.getButtonText( 5 ) );
                            mainView.toolTipView.hide();
                            executeButtonClick(5);
                            //return;
                        }
                    });

            inputManager.AddBindableControl(
                    "Cycle Background",
                    "Cycle the background fill of the text display area",
                    function ():void {
                        if (!mainView.textBGWhite.visible) {
                            mainView.textBGWhite.visible = true;
                        }
                        else if (!mainView.textBGTan.visible) {
                            mainView.textBGTan.visible = true;
                        }
                        else {
                            mainView.textBGWhite.visible = false;
                            mainView.textBGTan.visible = false;
                        }

                    });

        for (var i:int=0; i< 15; i++) {
			inputManager.AddBindableControl(
					"Button "+(i+1),
					"Activate button "+(i+1),
					function ():void {
						if (mainView.buttonIsVisible(i)) {
							mainView.toolTipView.hide();
							executeButtonClick(i);
						}
					},
					mainView.bottomButtons[i]
			);
		}
            inputManager.AddBindableControl(
                    "History",
                    "Show text history",
                    function ():void {
                        trace(CoC.instance.mainViewManager.traceSelf());
                        CoC.instance.outputHistory();
                    }
            );
            inputManager.AddBindableControl(
                    "Cheat! Give Hummus",
                    "Cheat code to get free hummus",
                    function (keyCode:int):void {
                        if (CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER] == 0) {
                            if (keyCode == 38) {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER]++;
                            }
                            else {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER] = 0;
                            }
                        }
                        else if (CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER] == 1) {
                            if (keyCode == 40) {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER]++;
                            }
                            else {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER] = 0;
                            }
                        }
                        else if (CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER] == 2) {
                            if (keyCode == 37) {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER]++;
                            }
                            else {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER] = 0;
                            }
                        }
                        else if (CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER] == 3) {
                            if (keyCode == 39) {
                                if (CoC.instance.player.str > 0 && mainView.getButtonText(0).indexOf("Game Over") == -1) {
                                    SceneLib.inventory.giveHumanizer();
                                }
                            }
                            else {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER] = 0;
                            }
                        }
                    },
                    null,InputManager.CHEATCONTROL);

            inputManager.AddBindableControl(
                    "Cheat! Access debug menu",
                    "Cheat code to access debug menu and spawn ANY items or change stats.",
                    function (keyCode:int):void {
                        if (CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 0) {
                            if (keyCode == 68) {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2]++;
                            }
                            else {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
                            }
                        }
                        else if (CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 1) {
                            if (keyCode == 69) {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2]++;
                            }
                            else {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
                            }
                        }
                        else if (CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 2) {
                            if (keyCode == 66) {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2]++;
                            }
                            else {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
                            }
                        }
                        else if (CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 3) {
                            if (keyCode == 85) {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2]++;
                            }
                            else {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
                            }
                        }
                        else if (CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 4) {
                            if (keyCode == 71) {
                                if (CoC.instance.player && CoC.instance.player.str > 0 && mainView.getButtonText(0).indexOf("Game Over") == -1 && (CoC.instance.debug && CoC.instance.flags[kFLAGS.HARDCORE_MODE] <= 0 || CoC_Settings.debugBuild)) {
                                    SceneLib.debugMenu.accessDebugMenu();
                                }
                            }
                            else {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
                            }
                        }
                    },
                    null,InputManager.CHEATCONTROL);


// Insert the default bindings
            inputManager.BindKeyToControl(83, "Show Stats");
            inputManager.BindKeyToControl(76, "Level Up");
            inputManager.BindKeyToControl(112, "Quicksave 1");
            inputManager.BindKeyToControl(113, "Quicksave 2");
            inputManager.BindKeyToControl(114, "Quicksave 3");
            inputManager.BindKeyToControl(115, "Quicksave 4");
            inputManager.BindKeyToControl(116, "Quicksave 5");
            inputManager.BindKeyToControl(117, "Quickload 1");
            inputManager.BindKeyToControl(118, "Quickload 2");
            inputManager.BindKeyToControl(119, "Quickload 3");
            inputManager.BindKeyToControl(120, "Quickload 4");
            inputManager.BindKeyToControl(121, "Quickload 5");
            inputManager.BindKeyToControl(8, "Show Menu");
            inputManager.BindKeyToControl(68, "Data Menu");
            inputManager.BindKeyToControl(65, "Appearance Page");
            inputManager.BindKeyToControl(78, "No");
            inputManager.BindKeyToControl(89, "Yes");
            inputManager.BindKeyToControl(80, "Show Perks");
            inputManager.BindKeyToControl(13, "Continue");
            inputManager.BindKeyToControl(32, "Continue", InputManager.SECONDARYKEY);
            inputManager.BindKeyToControl(36, "Cycle Background");
            inputManager.BindKeyToControl(49, "Button 1");
            inputManager.BindKeyToControl(50, "Button 2");
            inputManager.BindKeyToControl(51, "Button 3");
            inputManager.BindKeyToControl(52, "Button 4");
            inputManager.BindKeyToControl(53, "Button 5");
            inputManager.BindKeyToControl(54, "Button 6");
            inputManager.BindKeyToControl(55, "Button 7");
            inputManager.BindKeyToControl(56, "Button 8");
            inputManager.BindKeyToControl(57, "Button 9");
            inputManager.BindKeyToControl(48, "Button 10");
            inputManager.BindKeyToControl(Keyboard.Q, "Button 6", InputManager.SECONDARYKEY);
            inputManager.BindKeyToControl(Keyboard.W, "Button 7", InputManager.SECONDARYKEY);
            inputManager.BindKeyToControl(Keyboard.E, "Button 8", InputManager.SECONDARYKEY);
            inputManager.BindKeyToControl(Keyboard.R, "Button 9", InputManager.SECONDARYKEY);
            inputManager.BindKeyToControl(Keyboard.T, "Button 10", InputManager.SECONDARYKEY);
            inputManager.BindKeyToControl(Keyboard.A, "Button 11", InputManager.SECONDARYKEY);
            inputManager.BindKeyToControl(Keyboard.S, "Button 12", InputManager.SECONDARYKEY);
            inputManager.BindKeyToControl(Keyboard.D, "Button 13", InputManager.SECONDARYKEY);
            inputManager.BindKeyToControl(Keyboard.F, "Button 14", InputManager.SECONDARYKEY);
            inputManager.BindKeyToControl(Keyboard.G, "Button 15", InputManager.SECONDARYKEY);
            inputManager.BindKeyToControl(Keyboard.H, "History");

            inputManager.RegisterDefaults();


    }
}
}