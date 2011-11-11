/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.recognizers.algorithms 
{
	import pl.ifrost.moses.recognizers.Matching;
	import pl.ifrost.moses.recognizers.patterns.Pattern;
	
	/**
	 * Algorithm for calculating matching value of some pattern and sampling data
	 * @author ifrost
	 */
	public interface Algorithm 
	{
		function match(pattern:Pattern, samplingData:Array):Matching;
	}
	
}