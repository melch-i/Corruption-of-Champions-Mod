/**
 * ...
 * @author Ormael / Liadri
 */
package classes.Scenes.Camp {

	import classes.*;
	import classes.GlobalFlags.kFLAGS;

	import coc.view.ButtonDataList;

	public class CampMakeWinions extends BaseContent {

		public static var summon_statuses: Array = [
			StatusEffects.SummonedElementalsAir,
			StatusEffects.SummonedElementalsEarth,
			StatusEffects.SummonedElementalsFire,
			StatusEffects.SummonedElementalsWater,
			StatusEffects.SummonedElementalsEther,
			StatusEffects.SummonedElementalsWood,
			StatusEffects.SummonedElementalsMetal,
			StatusEffects.SummonedElementalsIce,
			StatusEffects.SummonedElementalsLightning,
			StatusEffects.SummonedElementalsDarkness
		];

		public function CampMakeWinions() {}

		public function maxSizeOfElementalsArmy(): int {
			if (!player.hasPerk(PerkLib.JobElementalConjurer)) {
				return 0;
			}
			var max: int = 1;
			var perks: Array = [
				[PerkLib.ElementalContractRank1, 1],
				[PerkLib.ElementalContractRank2, 1],
				[PerkLib.ElementalContractRank3, 1],
				[PerkLib.ElementalContractRank4, 1],
				[PerkLib.ElementalContractRank5, 1],
				[PerkLib.ElementalContractRank6, 1],
				[PerkLib.ElementalContractRank7, 1],
				[PerkLib.ElementalContractRank8, 2],
				[PerkLib.ElementalContractRank9, 2],
				[PerkLib.ElementalContractRank10, 2],
				[PerkLib.ElementalContractRank11, 2],
				[PerkLib.ElementsOfTheOrtodoxPath, 1],
				[PerkLib.ElementsOfMarethBasics, 1]
			];
			for each(var pk: Array in perks) {
				if (player.hasPerk(pk[0])) {
					max += pk[1];
				}
			}
			return max;
		}

		public function accessSummonElementalsMainMenu(): void {
			clearOutput();
			menu();
			var text: String = "Which one elemental would you like to summon or promote to higher rank?\n\n";
			text += ("Which one elemental would you like to summon or promote to higher rank?\n\n");
			if (player.hasPerk(PerkLib.JobElementalConjurer)) {
				text += ("Current limit for elemental summons: " + maxSizeOfElementalsArmy() + " different types of elementals\n\n");
			}
			text += ("[b: Currently summoned elementals:][i: ");
			for each (var summon: StatusEffectType in summon_statuses) {
				if (player.hasStatusEffect(summon)) {
					text += "\n" + elementName(summon) + " (Rank " + (player.statusEffectv2(summon) - 1) + ")";
				}
			}
			text += "]";
			outputText(text);
			var buttons: ButtonDataList = new ButtonDataList();
			buttons.add("Summon", summoningSubmenu)
				.disableIf(player.statusEffectv1(StatusEffects.SummonedElementals) >= maxSizeOfElementalsArmy(), "You have too many elementals summoned!")
				.disableIf(!player.hasPerk(PerkLib.JobElementalConjurer), "You're not quite sure how to summon anything yet.");
			buttons.add("Rank Up", rankUpSubmenu)
				.disableIf(!player.hasPerk(PerkLib.ElementalContractRank1));
			buttons.submenu(playerMenu, 0, false);
		}

		private function elementName(status: StatusEffectType): String {
			return status.id.replace("Summoned Elementals ", "");
		}

		private function summoningSubmenu(): void {
			outputText("\n\nIf you not have enough mana and fatigue it will be impossible to summon any elementals.\n\n");
			menu();
			var buttons: ButtonDataList = new ButtonDataList();
			var reg: Array = [StatusEffects.SummonedElementalsAir, StatusEffects.SummonedElementalsEarth, StatusEffects.SummonedElementalsFire, StatusEffects.SummonedElementalsWater];
			var ort: Array = [StatusEffects.SummonedElementalsEther, StatusEffects.SummonedElementalsWood, StatusEffects.SummonedElementalsMetal];
			var bas: Array = [StatusEffects.SummonedElementalsIce, StatusEffects.SummonedElementalsLightning, StatusEffects.SummonedElementalsDarkness];

			addButtons(reg);
			if (player.hasPerk(PerkLib.ElementsOfTheOrtodoxPath)) {
				addButtons(ort);
			}
			if (player.hasPerk(PerkLib.ElementsOfMarethBasics)) {
				addButtons(bas);
			}

			function addButtons(statuses: Array): void {
				for each (var status: StatusEffectType in statuses) {
					newButton(status);
				}
			}

			function newButton(status: StatusEffectType): void {
				buttons.add(elementName(status), curry(summonElemental, status))
					.disableIf(player.statusEffectv1(status) >= 1, "You already have this elemental summoned")
					.requireMana(100)
					.requireFatigue(50);
			}
			buttons.submenu(accessSummonElementalsMainMenu);
		}


		private function summonElemental(elemental: StatusEffectType): void {
			var name: String = elementName(elemental).toLowerCase();
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning an " + name + " elemental, you begin the ritual by drawing a small circle of runes inside the larger arcane circle you have already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The " + name + " elemental appears within the circle, at first huge and terrifying, it fights against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again.");
			outputText("\n\n[b: The ritual is finally complete congratulation is in order as you bound your very own " + name + " elemental!]");
			player.createOrFindStatusEffect(StatusEffects.SummonedElementals).value1 += 1;
			player.createStatusEffect(elemental, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1 / 2);
		}

		private function rankUpSubmenu(): void {
			var buttons: ButtonDataList = new ButtonDataList();
			var circleLevel: int = flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE];
			for each(var summon: StatusEffectType in summon_statuses) {
				var level: int = player.statusEffectv2(summon);
				var reqMana: int = 100 * level;
				var reqFatigue: int = 50 * level;
				var needUpgrade: Boolean = (level >= 8 && circleLevel < 3) || (level >= 4 && circleLevel < 2);
				buttons.add(elementName(summon), curry(rankUpElemental, summon, level, reqMana, reqFatigue))
					.disableIf(level <= 0, "You don't have any elementals of this type summoned.")
					.disableIf(level > 11, "This elemental can't be leveled further.")
					.disableIf(needUpgrade, "You need a better arcane circle to upgrade this elemental.")
					.disableIf(!player.hasPerk(PerkLib["ElementalContractRank" + level]), "You need to advance your elemental contract to rank up this elemental further.")
					.requireFatigue(reqFatigue)
					.requireMana(reqMana);
			}
			buttons.submenu(accessSummonElementalsMainMenu);
		}

		private function rankUpElemental(elemental: StatusEffectType, level: int, manaCost: int, fatigueCost: int): void {
			clearOutput();
			useMana(manaCost);
			fatigue(fatigueCost);
			statScreenRefresh();
			showRankUpIntroText();
			var summmast: Number = 0;
			if (player.wis > level * 25) {
				summmast += 25;
			} else {
				summmast += player.wis / level;
			}
			if (rand(summmast) > 5) {
				outputText("\n\nThe outraged elemental starts struggling but as it is unable to defeat its binding it lets go and stands still awaiting your commands. Their duty fulfilled, the binding runes fade, disappearing into the elemental until you call upon them again.");
				outputText("\n\n[b: The ritual is complete and your elemental empowered as such!]");
				player.addStatusValue(elemental, 2, 1);
			}
			else {
				failToRankUpElemental();
			}
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1 / 2);
		}

		private function showRankUpIntroText(): void {
			outputText("It has been a while and your mastery of summoning has increased as a consequence. Now confident that you can contain it you head to the arcane circle and set up the ritual to release some of your servant restraints. You order your pet to stand still as you release the binding rune containing it. ");
			outputText("At first it trashes in its prison with the clear intention to break free, kill and consume you but the ward holds. You write an additional arcane circle ");
			if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 2) {
				outputText("around the first ");
			}
			if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 3) {
				outputText("around the previous one ");
			}
			outputText("and add new directive and containment runes to the formula. Satisfied with the result you incant a final word of power.");
		}

		private function failToRankUpElemental(): void {
			outputText("\n\nThe enraged elemental struggles against its containment and to your horror finds a breach, beginning to grow to its full power and striking you in the process with a powerful barrage of energy!");
			outputText("\n\n[say: You pitiful mortal... you thought you could contain me forever! I'm going to make you regret ever summoning me...]");
			outputText("\n\nThe elemental screams in dismay as your larger arcane circle unleashes the full might of its last resort rune. A powerful discharge of energy strikes the wayward servant buying you enough time to rewrite its seal and force it back into servitude.");
			outputText("\n\n[say: Someday you will attempt this ritual again and when you do I will..]");
			outputText("\n\nIts final curse is silenced as its power are sealed again reducing it back to its former size.\n\n [b: This ritual was a failure you will have to try again when you have achieved better control.]");
			HPChange(-(Math.round(player.HP * 0.5)), true);
		}
	}

}