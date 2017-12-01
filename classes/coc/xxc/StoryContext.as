/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc {
import classes.Appearance;
import classes.BodyParts.Skin;
import classes.CoC;
import classes.CockTypesEnum;
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
import classes.Scenes.SceneLib;

import coc.xlogic.ExecContext;

public class StoryContext extends ExecContext{
	public var game:CoC;
	public function StoryContext(game:CoC) {
		super([
			game,
			CoC,
			{
				Appearance:Appearance,
				CockTypesEnum:CockTypesEnum,
				kFLAGS:kFLAGS,
				kGAMECLASS:kGAMECLASS,
				Math:Math,
				SceneLib:SceneLib,
				Skin:Skin
			}
		]);
		this.game = game;
	}
}
}
