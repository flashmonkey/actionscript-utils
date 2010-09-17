package org.flashmonkey.utils
{
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import org.as3commons.lang.ClassUtils;

	public class Logger
	{
		public static function getLogger(clazz:Class):ILogger
		{
			return Log.getLogger(ClassUtils.getFullyQualifiedName(clazz, true));
		}
	}
}