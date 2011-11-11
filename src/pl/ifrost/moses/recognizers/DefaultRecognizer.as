/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.recognizers 
{
	import pl.ifrost.moses.recognizers.patterns.Pattern;
	
	/**
	 * Default recognizer that just examine all patterns for matchings
	 * @author ifrost
	 */
	public class DefaultRecognizer extends AbstractRecognizer 
	{
		
		public function DefaultRecognizer() 
		{
			super();			
		}
		
		override protected function recognize(samplingData:Array):RecognitionData 
		{
			var matchings:Array = [];
			
			// examine all registered patterns
			for each (var pattern:Pattern in _patterns) {								
				matchings.push(pattern.algorithm.match(pattern, samplingData));
			}
			
			return new RecognitionData(matchings);
		}		
		
	}

}