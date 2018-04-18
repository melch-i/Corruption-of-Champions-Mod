package classes.lists {
import classes.internals.EnumValue;

public class Gender {
	public static const Values:/*EnumValue*/Array = [];
	
	public static const GENDER_NONE:int   = EnumValue.add(Values,0,"GENDER_NONE",{name:"genderless"});
	public static const GENDER_MALE:int   = EnumValue.add(Values,1,"GENDER_MALE",{name:"male"});
	public static const GENDER_FEMALE:int = EnumValue.add(Values,2,"GENDER_FEMALE",{name:"female"});
	public static const GENDER_HERM:int   = EnumValue.add(Values,3,"GENDER_HERM",{name:"hermaphrodite"});
}
}
