/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.recognizers.algorithms.moses 
{
	import flash.geom.Point;
	
	/**
	 * Variation of moses algorithm which before matching shifts data that it look like it
	 * is started from upper left corner (uses in cirlce pattern to handle drawing from different
	 * starting points
	 * 
	 * @author ifrost
	 */
	public class ShiftedPointsMosesAlgorithm extends DefaultMosesAlgorithm 
	{
		
		public function ShiftedPointsMosesAlgorithm(threshold:Number=0.5, minSamplerPoints:int=5) 
		{
			super(threshold, minSamplerPoints);			
		}
		
		override protected function preparePatternData(data:Array):Array 
		{
			return shiftData(data);
		}
		
		override protected function prepareSamplingData(data:Array):Array 
		{
			return shiftData(data);
		}
		
		/**
		 * Find index of most upper left point in array
		 * @param	data
		 * @return
		 */
		protected function upperLeftPointIndex(data:Array):int {
			var x:Number = Number.POSITIVE_INFINITY;
			var y:Number = Number.POSITIVE_INFINITY;
			var index:int = -1;
			
			for (var i:int = 0; i < data.length; i++ ) {
				var point:Point = data[i];
				if (point.y < y || (point.y == y && point.x < x)) {
					x = point.x;
					y = point.y;
					index = i;
				}
			}
			
			return index;
		}
		
		/**
		 * Shift items in array
		 * @param	data
		 * @param	shifts
		 */
		protected function shiftRight(data:Array, shifts:int):void {
			for (var i:int = 0; i < shifts; i++) {
				var point:Point = data.shift();
				data.push(point);
			}
		}

		protected function shiftData(data:Array):Array {
			shiftRight(data, upperLeftPointIndex(data));	
			return data;
		}		
				
		
	}

}