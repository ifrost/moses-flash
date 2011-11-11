/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.recognizers.algorithms.moses 
{
	import pl.ifrost.moses.recognizers.patterns.Pattern;
	import pl.ifrost.moses.recognizers.algorithms.moses.DefaultMosesAlgorithm;
	import pl.ifrost.moses.recognizers.Matching;
	
	/**
	 * Variation of moses algorithm which perform matching on data from pattern and 
	 * reversed data in pattern and choose better one
	 * @author ifrost
	 */
	public class ReversedMosesAlgorithm extends DefaultMosesAlgorithm 
	{
		
		public function ReversedMosesAlgorithm(threshold:Number=0.5, minSamplerPoints:int=5) 
		{
			super(threshold, minSamplerPoints);			
		}
		
		override protected function matchingValue(patternData:Array, samplingData:Array):Number 
		{
			var reversed:Array = patternData.slice();
			reversed.reverse();
			
			var straightValue:Number = super.matchingValue(patternData, samplingData);
			var reversedValue:Number = super.matchingValue(reversed, samplingData);
			
			return straightValue > reversedValue ? straightValue : reversedValue;
			
		}
		
	}

}