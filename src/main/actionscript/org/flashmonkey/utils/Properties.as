package org.flashmonkey.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import mx.logging.ILogger;

	/**
	 * Simulates the Java Properties class behaviour.
	 * Files containing key/value pairs of properties can be loaded by this class.
	 * Property values can be retrieved by their key as raw objects or as specific types.
	 * This class is a 'Singleton'.
	 */
	public class Properties extends EventDispatcher
	{		
		CONFIG::debug 
		{
			/**
			 * Logger instance.
			 */
			private static const log:ILogger = Logger.getLogger(Properties);
		}
		
		/**
		 * Singleton instance of this class.
		 */
		private static var _instance:Properties;
		
		/**
		 * Returns the Singleton instance of this class.
		 * Creates it if it doesn't already exist.
		 */
		public static function get instance():Properties
		{
			return _instance = (_instance == null) ? new Properties() : _instance;
		}

		/**
		 * Dictionary object containing the key/value properties loaded from
		 * files or registered directly.
		 */
		private var _properties:Dictionary = new Dictionary(true);
		
		/**
		 * Seperator character used to split the key/value properties.
		 */
		private var _seperator:String;
		
		/**
		 * The list of properties files to be loaded and parsed.
		 */
		private var _files:Array = [];
		
		/**
		 * Counter used to track how many properties files have been loaded and parsed during the 'load' operation.
		 */
		private var _loadCount:int;
		
		/**
		 * Constructor.
		 * Optionally provide a seperator character that will be used to 
		 * split the key/value pairs in the properties files.
		 * Default is a newline '\n' chararacter.
		 */
		public function Properties(seperator:String = "\n")
		{
			_seperator = seperator;
		}
		
		/**
		 * Add a file url to the list of properties files to be loaded.
		 */
		public function addFile(url:String):void 
		{
			_files.push(url);
		}
		
		/**
		 * Add an array of files to the list of properties files to be loaded.
		 */
		public function addFiles(files:Array):void 
		{
			_files = _files.concat(files);
		}
		
		/**
		 * Load the registered files.
		 * If there are no files to load dispatches 'complete' event immediately.
		 */
		public function load():void 
		{
			_loadCount = _files.length;
			
			CONFIG::debug 
			{
				log.info("loading " + _loadCount + " property files");
			}
			
			if (_loadCount > 0)
			{			
				for each (var url:String in _files)
				{
					var loader:URLLoader = new URLLoader();
					loader.addEventListener(Event.COMPLETE, onLoadComplete);
					loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
					
					CONFIG::debug 
					{
						log.info("Loading Property File :: " + url);
					}
					
					loader.load(new URLRequest(url + "?" + RandomUtils.randomString(10)));
				}
			}
			else
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		/**
		 * When properties file load has completed the file is parsed and the properties registered.
		 * Check to see if all files have loaded, if they have then dispatch 'complete' event.
		 */
		private function onLoadComplete(e:Event):void 
		{
			var loader:URLLoader = URLLoader(e.target);
			var properties:String = loader.data as String;
			
			parseProperties(properties);
			
			_loadCount--;
			
			if (_loadCount == 0)
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function onLoadError(e:IOErrorEvent):void 
		{
			
		}
		
		/**
		 * Parse the properties file, if the line isn't empty and isn't a comment
		 * (comment lines begin with a '#') then the line is split on the '='
		 * symbol and the resulting key/value pair is registered with the properties Dictionary.
		 */
		public function parseProperties(properties:String):void 
		{
			var keyValueArray:Array = properties.split(_seperator);

			for each (var keyValue:String in keyValueArray)
			{
				if (keyValue && keyValue.length > 0 && 
					keyValue.charAt(0) != "#" &&
					keyValue.charAt(0) != "")
				{
					var split:Array = keyValue.split("=");
					trace(split[0] + " = " + split[1]);
					setProperty(split[0], split[1]);
				}
			}
		}
		
		/**
		 * Register a key/value property value pair.
		 */
		public function setProperty(key:*, value:*):void 
		{
			_properties[key] = value;
		}
		
		/**
		 * Retrieve the raw value of the property key.
		 */
		public function getProperty(key:*):*
		{
			return _properties[key];
		}
		
		/**
		 * Retrieve a property value as a Number.
		 */
		public function getNumberProperty(key:*):Number 
		{
			return Number(_properties[key]);
		}
		
		/**
		 * Retrieve a property value as a String.
		 */
		public function getStringProperty(key:*):String 
		{
			return String(_properties[key]);
		}
	}
}