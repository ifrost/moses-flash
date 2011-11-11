/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.recognizers.patterns 
{
	import flash.geom.Point;
	import pl.ifrost.moses.recognizers.algorithms.Algorithm;
	
	/**
	 * Special use of PointsPattern when array of points are provided as flat 
	 * array of numbers
	 * @author ifrost
	 */
	public class FlatPointsPattern extends PointsPattern implements Pattern 
	{
		
		public function FlatPointsPattern(name:String, flatPoints:Array, algorithm:Algorithm) 
		{
			super(name, toPointsArray(flatPoints), algorithm);
		}
		
		/**
		 * Converts flat array to array of points
		 * @param	points
		 * @return
		 */
		private function toPointsArray(points:Array):Array {
			if (points.length % 2 != 0) {
				throw Error("You must provide even number of coordinates!");
			}
			
			var pointsArray:Array = [];
			
			for (var index:int = 0; index < points.length; index += 2) {
				pointsArray.push(new Point(points[index], points[index + 1]));
			}
			
			return pointsArray;
		}		
	
	}

}