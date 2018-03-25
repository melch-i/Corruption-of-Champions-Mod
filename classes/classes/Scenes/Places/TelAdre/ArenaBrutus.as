package classes.Scenes.Places.TelAdre
{
	import classes.AssClass;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Face;
	import classes.BodyParts.Hips;
	import classes.BodyParts.LowerBody;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kFLAGS;
	import classes.Monster;
	import classes.Scenes.SceneLib;
	import classes.StatusEffects;
	import classes.internals.WeightedDrop;

	public class ArenaBrutus extends Monster
	{
		public function ArenaBrutus()
		{
			this.a = "";
			this.short = "Brutus";
			this.long = "Your opponent is a minotaur sized dog morph with the face of a pitbull. His overly muscular body suggests he spent maybe a few too many hours at the city gym, although considering how dumb and feral he look it’s also possible that he overfed himself on medicinal drugs. His chest and epic abs are not covered with any armor, perhaps for the sake of the show or because he doesn’t care about it. He carries with him a massive steel spiked ball, linked with a four feet long chain.";
			this.level = 12;
			this.weaponName = "spiked ball and chain";
			this.weaponVerb = "smash";
			this.weaponAttack = 50;
			this.faceType = Face.DOG;

			this.createCock(rand(13)+ 24,2 + rand(3),CockTypesEnum.HORSE);
			this.balls = 2;
			this.ballSize = 2 + rand(13);
			this.cumMultiplier = 1.5;
			this.hoursSinceCum = this.ballSize * 10;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = rand(37) + 84;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE;
			this.lowerBody = LowerBody.HOOFED;
			this.skin.growFur({color:"brown"});
			this.skinDesc = "shaggy fur";
			this.hairColor = "brown";
			this.hairLength = 3;
			initStrTouSpeInte(100, 70, 35, 20);
			initWisLibSensCor(20, 40 + this.ballSize * 2, 15 + this.ballSize * 2, 35);
			this.armorName = "thick fur";
			this.armorDef = 12;
			this.bonusHP = 20 + rand(this.ballSize*2);
			this.bonusLust = 30 + rand(this.ballSize*3);
			this.lust = this.ballSize * 3;
			this.lustVuln = 0.84;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.special1 = smash;
			this.drop = new WeightedDrop(null);
			checkMonster();
		}
		private var smashCounter:int = 0;

		override protected function performCombatAction():void
		{
			if(smashCounter > 0){
				smash();
			} else {
				super.performCombatAction();
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.telAdre.arena.gaunletchallange1fight2();
		}

		private function smash():void
		{
			switch(smashCounter){
				case 0:
					outputText("Brutus begins whirling his ball and chain.");
					break;
				case 1:
					outputText("The dog morph continues whirling his ball and chain, he's about to attack!");
					break;
				case 2:
					if(flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1){
						outputText("Brutus slams the spiked ball in an attempt to crush you, but you saw it coming all along. You sidestep out of the ball’s reach as it crashes into the arena sand leaving a massive hole where you used to stand.");
					} else {
						outputText("Brutus slams the spiked ball in an attempt to crush you. Having not prepared for this attack, you are squarely stamped in the arena sand for <b><font color=\"#800000\">5000</font></b> damage!");
						player.HP -= 5000;
						game.mainView.statsView.showStatDown('hp');
						dynStats("lus", 0); //Force display arrow.
					}
					break;
			}
			smashCounter = (smashCounter+1)%3;
		}
	}
}
