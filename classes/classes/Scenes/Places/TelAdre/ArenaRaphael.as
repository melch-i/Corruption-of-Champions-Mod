package classes.Scenes.Places.TelAdre
{
	import classes.BodyParts.Arms;
	import classes.BodyParts.Face;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.Tail;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kFLAGS;
	import classes.Monster;
import classes.Scenes.Combat.Combat;
import classes.Scenes.SceneLib;
	import classes.StatusEffects;
	import classes.internals.WeightedDrop;

	public class ArenaRaphael extends Monster
	{
		public function ArenaRaphael()
		{
			var met:Boolean = flags[kFLAGS.RAPHAEL_MET] == 1;

			this.a = "";
			this.short = met? "Raphael" : "The Red Avenger";
			this.long = "Your opponent is "+(met?"Raphael":"a fox morph")+". He wears a black mask on his face, hiding his features. He wears a red cape and casual clothes as if he didn't actually need armor to begin, with which might prove true. He circles you, his rapier at the ready and analysing your movement as only a master fencer can.";
			this.level = 20;
			this.armorDef = 0;
			this.armorName = "jacket";

			this.weaponName = "rapier";
			this.weaponVerb = "lunge";
			this.weaponAttack = 75;

			this.special1 = disarm;
			this.special2 = riposte;

			initStrTouSpeInte(20, 50, 100, 45);
			initWisLibSensCor(20, 40, 30, 20);

			this.drop = new WeightedDrop(null);

			createBreastRow(0);
			this.createCock(7,2,CockTypesEnum.FOX);
			this.tallness = 70;

			this.tailType = Tail.FOX;
			this.faceType = Face.FOX;
			this.lowerBody = LowerBody.FOX;
			this.arms.type = Arms.FOX;

			this.skin.growFur({color:"vibrant crimson"});
			this.skinDesc = "sleek fur";
			this.hairColor = "vibrant crimson";

			checkMonster();
		}

		private function disarm():void
		{
			outputText("With a twist of the wrist, the fox morph strikes at your hands. The injury is small but it's painful enough that it will leave you unable to attack for a while.");
			player.createStatusEffect(StatusEffects.Sealed, 4, 11, 0, 0);
		}

		private var riposteWait:Boolean = false;
		private function riposte():void
		{
			if(riposteWait){
				if(flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1){
					outputText("You wait for your opponent's next move. The fox does nothing for a moment then changes back to his original stance again.");
				} else {
					outputText("The fox, having spent time to wait for an opening in your guard, rushes for the counterattack, his rapier piercing through you from side to side. You scream in pain as he slowly removes it.");
					player.takePhysDamage(player.level * 10);
				}
			} else {
				outputText("The wily fox changes his stance. You have no idea what he is up to.");
			}
			riposteWait = !riposteWait;
		}

		private function spellbreaker():void
		{
			outputText("You try to use magic, but the fox responds by ramming his foot into your stomach, cutting your air off before you can do anything. You won’t be able to use magic for a moment.");
			player.createStatusEffect(StatusEffects.Sealed, 2, 6, 0, 0);
		}

		override protected function performCombatAction():void
		{
			if(riposteWait) {
				riposte();
			} else if(!flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG]==1 && SceneLib.combat.lastAttack == Combat.HPSPELL){
				spellbreaker();
			} else {
				super.performCombatAction();
			}
		}
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.telAdre.arena.gaunletchallange2postfight();
		}
	}
}
