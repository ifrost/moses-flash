/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.recognizers.algorithms 
{
	import pl.ifrost.moses.recognizers.Matching;
	import pl.ifrost.moses.recognizers.patterns.MultiplePattern;
	import pl.ifrost.moses.recognizers.patterns.Pattern;
	
	/**
	 * Algorithm for MultiplePattern. It will examine all patterns in multiple
	 * pattern, choose the best one and treat it as single pattern matching
	 * @author ifrost
	 */
	public class MultiplePatternAlgorithm implements Algorithm {
			
		public function match(p:Pattern, samplingData:Array):Matching 
		{
			if (!(p is MultiplePattern)) {
				throw new Error("You can use multiple pattern algorithm only with MultiplePattern instance");
			}
			
			// cast
			var complexPattern:MultiplePattern = p as MultiplePattern;
			
			var bestMatching:Matching;
			var currentMatching:Matching;
			
			// find best matching
			for each (var pattern:Pattern in complexPattern.patterns) {
				currentMatching = pattern.algorithm.match(pattern, samplingData);
				if (bestMatching != null) {
					bestMatching = currentMatching.value > bestMatching.value ? currentMatching : bestMatching;
				}
				else {
					bestMatching = currentMatching;
				}
			}
			
			// treat subpattern matching as complex pattern matching
			return new Matching(complexPattern, bestMatching.value, bestMatching.recognized);
		}
		
		
	}

}