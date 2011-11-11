/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.recognizers 
{
	/**
	 * Information about proceeded recognition
	 * 
	 * @author ifrost
	 */
	public class RecognitionData 
	{
		private var _allMatchings:Array;
		private var _bestMatching:Matching;
		
		public function RecognitionData(matchings:Array) 
		{			
			this.allMatchings = matchings;			
			// find best matching			
			this.bestMatching = null;
			for each (var matching:Matching in matchings) {
				if (bestMatching != null) {
					bestMatching = matching.value > bestMatching.value ? matching : bestMatching;
				}
				else {
					bestMatching = matching;
				}
			}
		}
		
		public function get allMatchings():Array 
		{
			return _allMatchings;
		}
		
		public function set allMatchings(value:Array):void 
		{
			_allMatchings = value;
		}
		
		public function get bestMatching():Matching 
		{
			return _bestMatching;
		}
		
		public function set bestMatching(value:Matching):void 
		{
			_bestMatching = value;
		}
		
	}

}