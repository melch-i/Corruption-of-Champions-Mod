/**
 * Coded by aimozg on 24.11.2017.
 */
package coc.view {
import classes.CoC;
import classes.Monster;
import classes.PerkLib;
import classes.Player;
import classes.internals.Utils;

import flash.text.TextField;
import flash.text.TextFormat;

public class MonsterStatsView extends Block {
	
	private var sideBarBG:BitmapDataSprite;
	private var nameText:TextField;
	private var levelBar:StatBar;
	private var hpBar:StatBar;
	private var lustBar:StatBar;
	private var fatigueBar:StatBar;
	private var manaBar:StatBar;
	private var kiBar:StatBar;
	private var wrathBar:StatBar;
	private var corBar:StatBar;
	private var generalTypeLabel:TextField;
	private var generalTypeValue:TextField;
	private var elementalTypeLabel:TextField;
	private var elementalTypeValue:TextField;
	
	public function MonsterStatsView(mainView:MainView) {
		super({
			x           : MainView.MONSTER_X,
			y           : MainView.MONSTER_Y,
			width       : MainView.MONSTER_W,
			height      : MainView.MONSTER_H,
			layoutConfig: {
				padding     : MainView.GAP,
				type        : 'flow',
				direction   : 'column',
				ignoreHidden: true,
				gap         : 1
			}
		});
		StatBar.setDefaultOptions({
			barColor: '#600000',
			width   : innerWidth
		});
		sideBarBG = addBitmapDataSprite({
			width  : MainView.MONSTER_W,
			height : MainView.MONSTER_H,
			stretch: true
		}, {ignore: true});
		nameText  = addTextField({
			defaultTextFormat: StatsView.LABEL_FORMAT
		});
		addElement(levelBar = new StatBar({
			statName: "Level:",
			hasBar  : false
		}));
		addElement(hpBar = new StatBar({
			statName: "HP:",
			barColor: '#008000',
			bgColor : '#ff0000',
			showMax : true
		}));
		addElement(lustBar = new StatBar({
			statName   : "Lust:",
			//	barColor   : '#ff1493',
			minBarColor: '#ff0000',
			hasMinBar  : true,
			showMax    : true
		}));
		addElement(fatigueBar = new StatBar({
			statName: "Fatigue:",
			showMax : true
		}));
		addElement(kiBar = new StatBar({
			statName: "Ki:",
			//	barColor: '#ffd700',
			showMax : true
		}));
		addElement(manaBar = new StatBar({
			statName: "Mana:",
			//	barColor: '#0000ff',
			showMax : true
		}));
		addElement(wrathBar = new StatBar({
			statName: "Wrath:",
			showMax : true
		}));
		addElement(corBar = new StatBar({
			statName: "Corruption:",
			showMax : false,
			maxValue: 100
		}));
		generalTypeLabel = addTextField({
			defaultTextFormat: StatsView.LABEL_FORMAT,
			text:"General Type"
		});
		generalTypeValue = addTextField({
			defaultTextFormat: StatsView.TEXT_FORMAT
		});
		elementalTypeLabel = addTextField({
			defaultTextFormat: StatsView.LABEL_FORMAT,
			text:"Elemental Type"
		});
		elementalTypeValue = addTextField({
			defaultTextFormat: StatsView.TEXT_FORMAT
		});
	}
	
	public function show():void {
		this.visible = true;
	}
	
	public function hide():void {
		this.visible = false;
	}
	
	public function refreshStats(game:CoC):void {
		var player:Player     = game.player;
		var monster:Monster   = game.monster;
		nameText.text         = Utils.capitalizeFirstLetter(monster.short);
		levelBar.value        = monster.level;
		hpBar.maxValue        = monster.maxHP();
		hpBar.value           = monster.HP;
		lustBar.maxValue      = monster.maxLust();
		lustBar.minValue      = monster.minLust();
		lustBar.value         = monster.lust;
		fatigueBar.value      = monster.fatigue;
		fatigueBar.maxValue   = monster.maxFatigue();
		kiBar.value    = monster.ki;
		kiBar.maxValue = monster.maxKi();
		manaBar.value         = monster.mana;
		manaBar.maxValue      = monster.maxMana();
		manaBar.visible       = player.hasPerk(PerkLib.JobSorcerer);
		wrathBar.value        = monster.wrath;
		wrathBar.maxValue     = monster.maxWrath();
		corBar.value          = monster.cor;
		
		invalidateLayout();
	}
	public function setMonsterTypes(generalTypes:/*String*/Array, elementalTypes:/*String*/Array):void {
		generalTypeLabel.visible = generalTypes.length > 0;
		generalTypeValue.visible = generalTypes.length > 0;
		generalTypeValue.text = generalTypes.join("\n");
		elementalTypeLabel.visible = elementalTypes.length > 0;
		elementalTypeValue.visible = elementalTypes.length > 0;
		elementalTypeValue.text = elementalTypes.join("\n");
		invalidateLayout();
	}
	public function setBackground(bitmapClass:Class):void {
		sideBarBG.bitmapClass = bitmapClass;
	}
	public function setTheme(font:String,
							 textColor:uint,
							 barAlpha:Number):void {
		var dtf:TextFormat;
		for (var ci:int = 0, cn:int = this.numElements; ci < cn; ci++) {
			var e:StatBar = this.getElementAt(ci) as StatBar;
			if (!e) continue;
			dtf = e.valueLabel.defaultTextFormat;
			dtf.color = textColor;
			dtf.font = font;
			e.valueLabel.defaultTextFormat = dtf;
			e.valueLabel.setTextFormat(dtf);
			e.nameColor = textColor;
			if (e.bar) e.bar.alpha    = barAlpha;
			if (e.minBar) e.minBar.alpha = (1 - (1 - barAlpha) / 2); // 2 times less transparent than bar
		}
		for each(var tf:TextField in [nameText]) {
			dtf = tf.defaultTextFormat;
			dtf.color = textColor;
			tf.defaultTextFormat = dtf;
			tf.setTextFormat(dtf);
		}
	}
}
}
