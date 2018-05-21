package classes.Scenes.Monsters {
	import classes.Monster;
	import classes.PerkLib;
	import classes.Scenes.Combat.Combat;
	import classes.Scenes.SceneLib;

	public class PackMonster extends Monster{
		public function packAttack():void {
			//Determine if dodged!
			if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				outputText("You duck, weave, and dodge.  Despite their best efforts, the throng of demons only hit the air and each other.");
			}
			//Determine if evaded
			else if ((player.hasPerk(PerkLib.Evade) && rand(100) < 10) || (player.hasPerk(PerkLib.JunglesWanderer) && rand(100) < 35)) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep [monster a] [monster name]' attacks.");
			}
			//("Misdirection"
			else if (player.hasPerk(PerkLib.Misdirection) && rand(100) < 15 && player.armorName == "red, high-society bodysuit") {
				outputText("Using Raphael's teachings, you anticipate and sidestep [monster a] [monster name]' attacks.");
			}
			//Determine if cat'ed
			else if (player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
				outputText("With your incredible flexibility, you squeeze out of the way of [monster a] [monster name]' attacks.");
			}
			else {
				var damage:int = int((str + weaponAttack) * (player.damagePercent() / 100)); //Determine damage - str modified by enemy toughness!
				if (damage <= 0) {
					if (!plural)
						outputText("You deflect and block every " + weaponVerb + " [monster a] [monster name] throw at you.");
					else outputText("You deflect [monster a] [monster name] " + weaponVerb + ".");
				}
				else {
					if (damage <= 5)
						outputText("You are struck a glancing blow by [monster a] [monster name]! ");
					else if (damage <= 10)
						outputText("[monster A][monster name] wound you! ");
					else if (damage <= 20)
						outputText("[monster A][monster name] stagger you with the force of [monster his] " + weaponVerb + "s! ");
					else outputText("[monster A][monster name] <b>mutilates</b> you with powerful fists and " + weaponVerb + "s! ");
					player.takePhysDamage(damage, true);
				}
				statScreenRefresh();
				outputText("\n");
			}
		}

		public function lustAttack():void {
			SceneLib.combat.lastAttack = Combat.LUSTSPELL;
			if (player.lust < (player.maxLust() * 0.35)) {
				outputText("The [monster name] press in close against you and although they fail to hit you with an attack, the sensation of their skin rubbing against yours feels highly erotic.");
			}
			else if (player.lust < (player.maxLust() * 0.65)) {
				outputText("The push of the [monster name]' sweaty, seductive bodies sliding over yours is deliciously arousing and you feel your ");
				if (player.cocks.length > 0)
					outputText(player.multiCockDescriptLight() + " hardening ");
				else if (player.vaginas.length > 0) outputText(vaginaDescript(0) + " get wetter ");
				outputText("in response to all the friction.");
			}
			else {
				outputText("As the [monster name] mill around you, their bodies rub constantly over yours, and it becomes harder and harder to keep your thoughts on the fight or resist reaching out to touch a well lubricated cock or pussy as it slips past.  You keep subconsciously moving your ");
				if (player.gender == 1) outputText(player.multiCockDescriptLight() + " towards the nearest inviting hole.");
				if (player.gender == 2) outputText(vaginaDescript(0) + " towards the nearest swinging cock.");
				if (player.gender == 3) outputText("aching cock and thirsty pussy towards the nearest thing willing to fuck it.");
				if (player.gender == 0) outputText("groin, before remember there is nothing there to caress.");
			}
			dynStats("lus", 10 + player.sens / 10);
		}
	}
}
