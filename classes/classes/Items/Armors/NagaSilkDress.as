//idea from liadri, added to by others
package classes.Items.Armors {
import classes.Items.Armor;
import classes.TimeAwareInterface;
import classes.EventParser;
import classes.Player;
import classes.CoC;

public class NagaSilkDress extends Armor implements TimeAwareInterface {
    private var _name:String;
	private function get player():Player{ //need the instance of player
			return CoC.instance.player;
	}
    public function NagaSilkDress() {
        super("NagaDress","Naga Dress","","a desert naga silk dress",0,0,
                "",
        "",false,false);
        setColor();
		EventParser.timeAwareClassAdd(this);
    }
    public function setColor(color:String="purple"):void
    {
        _name = "desert naga "+color+" and black silk dress";
        _longName = "a "+color+" desert naga silk dress";
        _description = "A very seductive dress made for naga or females without a human set of legs. It has a black collar, bikini top, sleeves with golden bangles and a waistcloth, all decorated with a golden trim. The bottom has a "+color+" silk veil that runs down to what would be the human knee while the center of the bikini is also covered by a small strand of silk. It helps accentuate your curves and increase your natural charm. The dress obviously is so minimalist that you could as well say you are naked yet it looks quite classy on a tauric or naga body giving you the air of a master seducer.";
    }
    public override function get name():String{return _name;}


	public function timeChangeLarge():Boolean {	return false;	}
		
	public function timeChange():Boolean {
		if (player.armor is NagaSilkDress && CoC.instance.model.time.hours == 5) { //only call function once per day as time change is called every hour
			Progression(); 
			return true;
		}
		return false; //stop if not wearing
		}
	public function Progression():void {
		var verb:String; 
		var text:String;
		var x :int;
		var tfChoice :Array = []; 
		var dreams:Array = [	
		
		];
	}
}}