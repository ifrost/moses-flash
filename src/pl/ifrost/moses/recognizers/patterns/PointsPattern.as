/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.recognizers.patterns 
{
	import pl.ifrost.moses.recognizers.algorithms.Algorithm;
	
	/**
	 * Pattern that is representend by points array
	 * @author ifrost
	 */
	public class PointsPattern implements Pattern 
	{
		private var _name:String;		
		private var _data:Array;		
		private var _algorithm:Algorithm;
		
		public function PointsPattern(name:String, points:Array, algorithm:Algorithm) 
		{
			_name = name;
			_data = points;
			_algorithm = algorithm;			
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get data():* 
		{
			return _data;
		}
		
		public function get algorithm():Algorithm 
		{
			return _algorithm;
		}
		
	}

}