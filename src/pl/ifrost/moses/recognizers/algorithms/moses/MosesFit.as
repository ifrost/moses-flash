/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.recognizers.algorithms.moses 
{
	/**
	 * Reduces two arrays to same length
	 * @see moseFit
	 * @author ifrost
	 */
	public class MosesFit 
	{
		private var _reducedPatternData:Array;
		private var _reducedSamplingData:Array;
		
		public function MosesFit(listA:Array, listB:Array) 
		{
			mosesFit(listA, listB);
		}
		
		/**
		 * Run a moses fit on two arrays:
		 * - First and last element of each array remain unchanged
		 * - Longer array will be reduced to length of shorter array by removing points evenly along list		 
		 * Example
		 * array1 = [a,b,c,d,e,f,g]; array2 = [a,b,c,d]
		 * Result after applying moses fit:
		 * array1 = [a,c,e,g]; array2 = [a,b,c,d]
		 */
		protected function mosesFit(patternData:Array, samplingData:Array):void {			
			var offset:Number;
			var longer:Array;
			var shorter:Array;
			
			// reduce listA
			if (patternData.length >= samplingData.length) {				
				offset = (patternData.length - 1) / (samplingData.length - 1);
				_reducedPatternData = reduceList(patternData, offset == Infinity ? offset = samplingData.length : offset);
				_reducedSamplingData = samplingData;
			}
			// reduce listB
			else {
				offset = (samplingData.length - 1) / (patternData.length - 1);
				_reducedPatternData = patternData;
				_reducedSamplingData = reduceList(samplingData, offset == Infinity ? offset = patternData.length : offset);
			}			
		}			
		
		/**
		 * Reduces list by jumping over items by offset (first and last item remain unchaged)
		 * @param	list
		 * @param	offset
		 * @return
		 */
		private  function reduceList(list:Array, offset:Number):Array {
			var jumped:Array = [];
			var current:Number = 0;
			var currentPosition:int = int(current);
			
			while (currentPosition < list.length - 1) {
				jumped.push(list[currentPosition]);
				
				current += offset;
				currentPosition = Math.round(current);
			}
			
			jumped.push(list[list.length - 1]);
			
			return jumped;
		}				
		
		public function get reducedPatternData():Array {
			return _reducedPatternData;
		}
		
		public function get reducedSamplingData():Array {
			return _reducedSamplingData;
		}
		
	}

}