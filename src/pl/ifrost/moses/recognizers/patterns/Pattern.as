/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.recognizers.patterns 
{
	import pl.ifrost.moses.recognizers.algorithms.Algorithm;
	
	/**
	 * Interface for any pattern
	 * @author ifrost
	 */
	public interface Pattern 
	{
		function get name():String;
		
		/**
		 * Getter for pattern data.
		 */
		function get data():*;
		
		/**
		 * Algorithm for this pattern
		 */
		function get algorithm():Algorithm;
	}
	
}