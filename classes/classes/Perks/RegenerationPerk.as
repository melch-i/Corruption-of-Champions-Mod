package classes.Perks 
{
import classes.CoC;
import classes.PerkClass;
	import classes.PerkType;
	import classes.GlobalFlags.*;

	public class RegenerationPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			if (CoC.instance.flags[kFLAGS.HUNGER_ENABLED] > 0 && CoC.instance.player.hunger < 25) return "<b>DISABLED</b> - You are too hungry!";
			else return super.desc(params);
		}
		
		public function RegenerationPerk(level:int)
		{
			var num:String = "Regeneration ";
			switch(level){
				case 1: num += "I"; break;
				case 2: num += "II"; break;
				case 3: num += "III"; break;
				case 4: num += "IV"; break;
				case 5: num += "V"; break;
				case 6:
				default:
					num += "VI";
			}
			super(
					num, num, "Regenerates 1% of max HP/hour and 0,5% of max HP/round.",
					"You choose the '"+num+"' perk, allowing you to heal 0,5% of max HP every round of combat and 1% of max HP every hour!"
			);

		}
		
	}

}
