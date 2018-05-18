package classes
{
	public class KeyItemClass extends Object
	{
		//constructor
		public function KeyItemClass(name:String = "", v1:Number = 0, v2:Number=0, v3:Number=0, v4:Number=0)
		{
			keyName = name;
			value1 = v1;
			value2 = v2;
			value3 = v3;
			value4 = v4;
		}
		
		//data
		public var keyName:String;
		//v1-v4 for storing extra stuff.
		public var value1:Number;
		public var value2:Number;
		public var value3:Number;
		public var value4:Number;
	}
}