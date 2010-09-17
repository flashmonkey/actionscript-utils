package org.flashmonkey.utils
{
	import flash.utils.Dictionary;
	
	public class DictionaryUtils
	{
		 public static function getValues(d:Dictionary):Array
		 {
			 var a:Array = new Array();
		 
			 for each (var value:Object in d)
			 {
			 	a.push(value);
			 }
		 
			 return a;
		 }
		 
		 public static function getKeys(d:Dictionary):Array
		 {
			 var a:Array = new Array();
		 
			 for (var key:Object in d)
			 {
				  a.push(key);
			 }
		 
			 return a;
		 }
		 
		 public static function containsKey(d:Dictionary, key:Object):Boolean
		 {
		 	 var keys:Array = getKeys(d);
		 	 
		 	 for each (var i:Object in keys)
		 	 {
		 	 	if (i == key)
		 	 	{
		 	 		return true;
		 	 	}
		 	 }
		 	 
		 	 return false;
		 }
			
		public static function concat(a:Dictionary, b:Dictionary, weakKeys:Boolean = false):Dictionary
		{
			var d:Dictionary = new Dictionary(weakKeys);
			
			var i:Object;
			
			for (i in a)
			{
				d[i] = a[i];
			}
			
			for (i in b)
			{
				d[i] = b[i];
			}
			
			return d;
		}
	}
}