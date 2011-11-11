/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.recognizers 
{
	import pl.ifrost.moses.recognizers.patterns.Pattern;

	/**
	 * Matching data for some pattern. It says how much sampled data is similar to pattern.
	 * Recognizers should return a list of such Matching objects
	 * 
	 * @see Recognizer
	 * @see RecognitionData
	 * @author ifrost
	 */
	public class Matching 
	{
		private var _value:Number;
		private var _pattern:Pattern;
		private var _recognized:Boolean;
		
		/**
		 * Create new matching data
		 * @param	pattern
		 * @param	value how much pattern matches sampler data
		 * @param	recognized if false than value is too small to say that pattern has been recognized
		 */
		public function Matching(pattern:Pattern, value:Number, recognized:Boolean) 
		{
			this.recognized = recognized;
			this.pattern = pattern;
			this.value = value;			
		}
		
		public function get value():Number 
		{
			return _value;
		}
		
		public function set value(value:Number):void 
		{
			_value = value;
		}
		
		public function get pattern():Pattern 
		{
			return _pattern;
		}
		
		public function set pattern(value:Pattern):void 
		{
			_pattern = value;
		}
		
		public function get recognized():Boolean 
		{
			return _recognized;
		}
		
		public function set recognized(value:Boolean):void 
		{
			_recognized = value;
		}
		
	}

}