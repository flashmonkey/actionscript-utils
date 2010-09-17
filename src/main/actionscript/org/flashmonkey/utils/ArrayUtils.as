package org.flashmonkey.utils
{
	public class ArrayUtils
	{
		public static function contains(array:Array, value:Object):Boolean
		{
			for each (var v:Object in array)
			{
				if (v == value)
				{
					return true;
				}
			}
			
			return false;
		}

	}
}