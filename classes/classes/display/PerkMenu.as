/**
 * Created by aimozg on 22.05.2017.
 */
package classes.display {
import classes.BaseContent;
import classes.BodyParts.Face;
import classes.BodyParts.Tail;
import classes.CoC;
import classes.EngineCore;
import classes.GlobalFlags.kFLAGS;
import classes.PerkClass;
import classes.PerkLib;
import classes.PerkTree;
import classes.PerkType;
import classes.Scenes.SceneLib;
import classes.StatusEffects;

import flash.events.MouseEvent;

public class PerkMenu extends BaseContent {
	public function PerkMenu() {
	}
	public function displayPerks(e:MouseEvent = null):void {
		var temp:int = 0;
		clearOutput();
		displayHeader("Perks");
		while(temp < player.perks.length) {
			outputText("<b>" + player.perk(temp).perkName + "</b> - " + player.perk(temp).perkDesc + "\n");
			temp++;
		}
		menu();
		var button:int = 0;
		addButton(button++, "Next", playerMenu);
		if (player.perkPoints > 0) {
			outputText("\n<b>You have " + num2Text(player.perkPoints) + " perk point");
			if(player.perkPoints > 1) outputText("s");
			outputText(" to spend.</b>");
			addButton(button++, "Perk Up", CoC.instance.playerInfo.perkBuyMenu);
		}
		addButton(4, "Database", perkDatabase);
		if (player.hasPerk(PerkLib.Spellsword) || player.hasPerk(PerkLib.Spellarmor) || player.hasPerk(PerkLib.Battleflash) || player.hasPerk(PerkLib.Battlemage)) {
			outputText("\n<b>You can adjust your spell autocast settings.</b>");
			addButton(7, "Spells Opt",spellautocastOptions);
		}
		if (player.statusEffectv1(StatusEffects.SummonedElementals) >= 1) {
			outputText("\n<b>You can adjust your elemental summons behaviour during combat.</b>");
			addButton(8, "Elementals",summonsbehaviourOptions);
		}
		addButton(10, "Number of", EngineCore.doNothing);
		addButton(11, "perks: " + player.perks.length, EngineCore.doNothing);
	}

	public function spellautocastOptions():void {
		clearOutput();
		menu();
		var toggleflag:Function = curry(toggleFlag,spellautocastOptions);
		outputText("You can choose to autocast or not specific buff spells at the start of each combat.\n");
		if (player.hasPerk(PerkLib.Spellsword)) {
			outputText("\n<b>Charge Weapon:</b> ");
			if (flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] == 1) outputText("Manual");
			else outputText("Autocast");
		}
		if (player.hasPerk(PerkLib.Spellarmor)) {
			outputText("\n<b>Charge Armor:</b> ");
			if (flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] == 1) outputText("Manual");
			else outputText("Autocast");
		}
		if (player.hasPerk(PerkLib.Battlemage)) {
			outputText("\n<b>Might:</b> ");
			if (flags[kFLAGS.AUTO_CAST_MIGHT] == 1) outputText("Manual");
			else outputText("Autocast");
		}
		if (player.hasPerk(PerkLib.Battleflash)) {
			outputText("\n<b>Blink:</b> ");
			if (flags[kFLAGS.AUTO_CAST_BLINK] == 1) outputText("Manual");
			else outputText("Autocast");
		}
		if (flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] != 0) addButton(0, "Autocast", toggleflag,kFLAGS.AUTO_CAST_CHARGE_WEAPON,false);
		if (player.hasPerk(PerkLib.Spellsword) && flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] != 1) addButton(5, "Manual", toggleflag,kFLAGS.AUTO_CAST_CHARGE_WEAPON,true);
		if (flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] != 0) addButton(1, "Autocast", toggleflag,kFLAGS.AUTO_CAST_CHARGE_ARMOR,false);
		if (player.hasPerk(PerkLib.Spellarmor) && flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] != 1) addButton(6, "Manual", toggleflag,kFLAGS.AUTO_CAST_CHARGE_ARMOR,true);
		if (flags[kFLAGS.AUTO_CAST_MIGHT] != 0) addButton(2, "Autocast", toggleflag,kFLAGS.AUTO_CAST_MIGHT,false);
		if (player.hasPerk(PerkLib.Battlemage) && flags[kFLAGS.AUTO_CAST_MIGHT] != 1) addButton(7, "Manual", toggleflag,kFLAGS.AUTO_CAST_MIGHT,true);
		if (flags[kFLAGS.AUTO_CAST_BLINK] != 0) addButton(3, "Autocast", toggleflag,kFLAGS.AUTO_CAST_BLINK,false);
		if (player.hasPerk(PerkLib.Battleflash) && flags[kFLAGS.AUTO_CAST_BLINK] != 1) addButton(8, "Manual", toggleflag,kFLAGS.AUTO_CAST_BLINK,false);
		if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) addButton(13, "FoI Off", toggleFortressOfIntelect,false);

		var e:MouseEvent;
		addButton(14, "Back", displayPerks);

		function toggleFortressOfIntelect(on:Boolean):void{
			if(on){player.createStatusEffect(StatusEffects.FortressOfIntellect,0,0,0,0);}
			else{player.removeStatusEffect(StatusEffects.FortressOfIntellect);}
			spellautocastOptions();
		}
	}

	
	public function summonsbehaviourOptions():void {
        var attackingElementalTypeFlag:int = flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE];
        var elementalConjuerSummons:int = flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS];
        var setflag:Function = curry(setFlag,summonsbehaviourOptions);
        var attackingElementalType:Function = curry(setflag,kFLAGS.ATTACKING_ELEMENTAL_TYPE);
		clearOutput();
		menu();
		outputText("You can choose how your summoned elementals will behave during each fight.\n\n");
		outputText("\n<b>Elementals behavious:</b>\n");

        if (elementalConjuerSummons == 3) outputText("Elemental will attack enemy on it own alongside PC.");
		if (elementalConjuerSummons == 2) outputText("Attacking instead of PC each time melee attack command is chosen.");
		if (elementalConjuerSummons < 2) outputText("Not participating");
		outputText("\n\n<b>Elemental, which would attack in case option to them helping in attacks is enabled:</b>\n");
        switch(attackingElementalTypeFlag){
			case 1: outputText("Air"); break;
            case 2: outputText("Earth"); break;
            case 3: outputText("Fire"); break;
            case 4: outputText("Water"); break;
            case 10: outputText("Ether"); break;
            case 8: outputText("Wood"); break;
            case 9: outputText("Metal"); break;
            case 5: outputText("Ice"); break;
            case 6: outputText("Lightning"); break;
            case 7: outputText("Darkness"); break;
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsAir) && attackingElementalTypeFlag != 1) addButton(0, "Air", attackingElementalType,1);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarth) && attackingElementalTypeFlag != 2) addButton(1, "Earth", attackingElementalType,2);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsFire) && attackingElementalTypeFlag != 3) addButton(2, "Fire", attackingElementalType,3);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsWater) && attackingElementalTypeFlag != 4) addButton(3, "Water", attackingElementalType,4);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsEther) && attackingElementalTypeFlag != 10) addButton(4, "Ether", attackingElementalType,10);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsWood) && attackingElementalTypeFlag != 8) addButton(5, "Wood", attackingElementalType,8);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsMetal) && attackingElementalTypeFlag != 9) addButton(6, "Metal", attackingElementalType,9);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsIce) && attackingElementalTypeFlag != 5) addButton(7, "Ice", attackingElementalType,5);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsLightning) && attackingElementalTypeFlag != 6) addButton(8, "Lightning", attackingElementalType,6);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsDarkness) && attackingElementalTypeFlag != 7) addButton(9, "Darkness", attackingElementalType,7);
		if (elementalConjuerSummons > 1) addButton(10, "NotHelping", setflag,kFLAGS.ELEMENTAL_CONJUER_SUMMONS,1);
		if (elementalConjuerSummons != 2 && player.hasStatusEffect(StatusEffects.SummonedElementals)) addButton(11, "MeleeAtk", elementalAttackReplacingPCmeleeAttack);
		if (elementalConjuerSummons != 3 && player.hasStatusEffect(StatusEffects.SummonedElementals) && player.hasPerk(PerkLib.FirstAttackElementals)) addButton(12, "Helping", setflag,kFLAGS.ELEMENTAL_CONJUER_SUMMONS,3);

        if (CoC.instance.inCombat) addButton(14, "Back", combat.combatMenu);
        else addButton(14, "Back", displayPerks);
        function elementalAttackReplacingPCmeleeAttack():void {
            flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] = 2;
            if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 0) {
                menu();
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsAir)) addButton(0, "Air", attackingElementalType,1);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarth)) addButton(1, "Earth", attackingElementalType,2);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsFire)) addButton(2, "Fire", attackingElementalType,3);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsWater)) addButton(3, "Water", attackingElementalType,4);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsEther)) addButton(4, "Ether", attackingElementalType,10);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsWood)) addButton(5, "Wood", attackingElementalType,8);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsMetal)) addButton(6, "Metal", attackingElementalType,9);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsIce)) addButton(7, "Ice", attackingElementalType,5);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsLightning)) addButton(8, "Lightning", attackingElementalType,6);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsDarkness)) addButton(9, "Darkness", attackingElementalType,7);
            }
        }
	}

	public function perkDatabase(page:int=0, count:int=20):void {
		var allPerks:Array = PerkTree.obtainablePerks();
		var pages:int = Math.ceil(allPerks.length/count);
		clearOutput();
		var perks:Array = allPerks.slice(page*count,(page+1)*count);
		displayHeader("All Perks ("+(1+page*count)+"-"+(page*count+perks.length)+
					  "/"+allPerks.length+")");
		for each (var ptype:PerkType in perks) {
			var pclass:PerkClass = player.getPerk(ptype);

			var color:String;
			if (pclass) color=(darkTheme()?'#ffffff':'#000000'); // has perk
			else if (ptype.available(player)) color=darkTheme()?'#44cc44':'#228822'; // can take on next lvl
			else color=darkTheme()?'#ffcc44':'#aa8822'; // requirements not met

			outputText("<font color='" +color +"'><b>"+ptype.name+"</b></font>: ");
			outputText(pclass?ptype.desc(pclass):ptype.longDesc);
			if (!pclass && ptype.requirements.length>0) {
				var reqs:Array = [];
				for each (var cond:Object in ptype.requirements) {
					if (cond.fn(player)) color=(darkTheme()?'#ffffff':'#000000');
					else color=darkTheme()?'#ff4444':'#aa2222';
					reqs.push("<font color='"+color+"'>"+cond.text+"</font>");
				}
				outputText("<ul><li><b>Requires:</b> " + reqs.join(", ")+".</li></ul>");
			} else {
				outputText("\n");
			}
		}
		if (page>0) addButton(0,"Prev",perkDatabase,page-1);
		else addButtonDisabled(0,"Prev");
		if (page+1 < pages) addButton(1,"Next",perkDatabase,page+1);
		else addButtonDisabled(1,"Next");
		addButton(9, "Back", playerMenu);
	}
    private function toggleFlag(returnTo:Function,flag:int,on:Boolean):void{
        setFlag(returnTo,flag,((on)?1:0));
    }
	private function setFlag(returnTo:Function,flag:int,val:int):void{
		flags[flag] =  val;
		returnTo();
	}
	/* [INTERMOD: revamp]
	 public function ascToleranceOption():void{
	 clearOutput();
	 menu();
	 if (player.perkv2(PerkLib.AscensionTolerance) == 0){
	 outputText("Corruption Tolerance is under effect, giving you " + player.corruptionTolerance() + " tolerance on most corruption events." +
	 "\n\nYou can disable this perk's effects at any time.<b>Some camp followers may leave you immediately after doing this. Save beforehand!</b>");
	 addButton(0, "Disable", disableTolerance);
	 }else addButtonDisabled(0, "Disable", "The perk is already disabled.");
	 if (player.perkv2(PerkLib.AscensionTolerance) == 1){
	 outputText("Ascension Tolerance is not under effect. You may enable it at any time.");
	 addButton(1, "Enable", enableTolerance);
	 }else addButtonDisabled(1, "Enable", "The perk is already enabled.");
	 addButton(4, "Back", displayPerks);
	 }

	 public function disableTolerance():void{
	 player.setPerkValue(PerkLib.AscensionTolerance, 2, 1);
	 ascToleranceOption();
	 }
	 public function enableTolerance():void{
	 player.setPerkValue(PerkLib.AscensionTolerance, 2, 0);
	 ascToleranceOption();
	 }
	 */

}
}
