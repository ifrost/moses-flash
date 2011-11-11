/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.recognizers.patterns 
{
	import pl.ifrost.moses.recognizers.algorithms.Algorithm;
	import pl.ifrost.moses.recognizers.algorithms.MultiplePatternAlgorithm;

	/**
	 * Pattern that covers more than one simple pattern
	 * @author ifrost
	 */
	public class MultiplePattern implements Pattern 
	{
		private var _name:String;
		private var _patterns:Array;
		private var _algorithm:Algorithm;
		
		public function MultiplePattern(name:String, ...patterns) 
		{			
			_name = name;
			_patterns = patterns;
			_algorithm = new MultiplePatternAlgorithm();
		}
		
		/* INTERFACE pl.ifrost.moses.recognizers.patterns.Pattern */
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get data():* 
		{
			return (_patterns[0] as Pattern).data;
		}
		
		public function get algorithm():Algorithm 
		{
			return _algorithm;
		}
		
		public function get patterns():Array 
		{
			return _patterns;
		}
		
	}

}