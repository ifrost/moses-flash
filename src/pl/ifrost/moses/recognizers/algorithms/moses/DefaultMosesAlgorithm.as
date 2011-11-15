/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.recognizers.algorithms.moses 
{
	import flash.geom.Point;
	import pl.ifrost.moses.recognizers.algorithms.Algorithm;
	import pl.ifrost.moses.recognizers.Matching;
	import pl.ifrost.moses.recognizers.patterns.Pattern;
	import pl.ifrost.moses.recognizers.patterns.PointsPattern;
	
	/**
	 * Default Moses Algorithm
	 * @author ifrost
	 */
	public class DefaultMosesAlgorithm implements Algorithm 
	{
		private var _minSamplerPoints:int;
		private var _threshold:Number;
		
		public function DefaultMosesAlgorithm(threshold:Number = 0.5, minSamplerPoints:int = 5) 
		{
			_threshold = threshold;
			_minSamplerPoints = minSamplerPoints;			
		}
		
		public function match(pattern:Pattern, samplingData:Array):Matching
		{
			var value:Number = matchingValue(pattern.data, samplingData);
			
			// was pattern recognized?
			var recognized:Boolean = value >= _threshold && samplingData.length >= _minSamplerPoints;		
			
			return new Matching(pattern, value,  recognized);							
		}
		
		protected function matchingValue(patternData:Array, samplingData:Array):Number {
			var mosesFit:MosesFit = new MosesFit(patternData.slice(), samplingData.slice());
			var reducedPatternData:Array = preparePatternData(mosesFit.reducedPatternData);
			var reducedSamplingData:Array = prepareSamplingData(mosesFit.reducedSamplingData);
			
			// pattern directions
			var patternDirections:Array = pointsToDirections(reducedPatternData);
			
			// sampling directions
			var samplingDirections:Array = pointsToDirections(reducedSamplingData);
			
			// match value
			return calculateMosesSimilarity(patternDirections, samplingDirections);
		}			
		
		protected function preparePatternData(data:Array):Array {
			return data;
		}
		
		protected function prepareSamplingData(data:Array):Array {
			return data;
		}

		/**
		 * Chceck similarity of two lists
		 * 1 point for each same direction
		 * 0.5 for directions that differ in one step
		 */
		public static function calculateMosesSimilarity(listA:Array, listB:Array):Number {
			var max:int = listA.length; // A and B has same length
			var points:Number = 0;
			for (var i:int = 0; i < max; i++) {
				var a:int = listA[i];
				var b:int = listB[i];				
				
				if (a == b) {
					points++;
				}
				else {
					var diff:int = Math.abs(a - b)
					points += (diff == 7 || diff == 1) ? 0.5 : 0;					
				}
			}
			return points / max;
		}		
		
		/**
		 * Convert list of points to list of directions		
		 */
		public function pointsToDirections(points:Array):Array {
			var directions:Array = [];
			for (var baseIndex:int = 0; baseIndex < points.length - 1; baseIndex++) {
				directions.push(simplifyDirection(points[baseIndex], points[baseIndex + 1]));
			}
			return directions;
		}				
		
		/**
		 * Convert two points to direction 
		 * 1 - up
		 * 2 - right-up
		 * 3 - right
		 * 4 - right-down
		 * 5 - down
		 * 6 - left-down
		 * 7 - left
		 * 8 - left-up
		 * 0 - no move
		 * 
		 * scheme:
		 *  812
		 *  703
		 *  654
		 * 
		 * @param	p1
		 * @param	p2
		 * @return
		 */
		private function simplifyDirection(p1:Point, p2:Point):Number {
			var direction:Point = p2.subtract(p1);
			if (direction.length == 0) {
				return 0; // no move
			}
			
			var base:Point = new Point(0, 1);
			var dotProduct:Number  = direction.x * base.x + direction.y * base.y			
			var cos:Number = dotProduct / (direction.length * base.length)
			
			var result:Number
			if (direction.x < 0) {
				result = (2 * Math.PI - Math.acos(cos)) / (Math.PI / 4) + 1.5
				if (result >= 9) {
					result -= 9;
				}
			}
			else {
				result = (Math.acos(cos)) / (Math.PI / 4) + 1.5
			}		
			
			return Math.floor(result);
		}
		
	}

}