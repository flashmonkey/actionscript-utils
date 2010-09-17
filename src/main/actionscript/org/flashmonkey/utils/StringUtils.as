package org.flashmonkey.utils
{
	public class StringUtils
	{
		public static function isValidUrl( url:String ):Boolean
		{
			if( url == "" || url == null ) return false;
			
			var regex:RegExp = /.*(\.[Jj][Pp][Gg]|\.[Jj][Pp][Ee][Gg]|\.[Pp][Nn][Gg])/;
			var match:Array = url.match( regex );
			return ( match != null && match.length > 0 );
		}
	}
}