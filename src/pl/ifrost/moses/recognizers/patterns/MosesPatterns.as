/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.recognizers.patterns 
{
	import pl.ifrost.moses.recognizers.algorithms.moses.DefaultMosesAlgorithm;
	import pl.ifrost.moses.recognizers.algorithms.moses.ReversedMosesAlgorithm;
	import pl.ifrost.moses.recognizers.algorithms.moses.ShiftedPointsMosesAlgorithm;

	/**
	 * Set of patterns used by moses algorithms
	 * 
	 * @author ifrost
	 */
	public class MosesPatterns 
	{				
		// CIRCLES
		
		public static var CIRCLE_CLOCKWISE:FlatPointsPattern = new FlatPointsPattern(
			"Circle (clockwise)",
			[0, -100, 17, -98.5, 34, -94, 50, -86.6, 64.2, -76.6,76.6, -64.2,86.6, -50,94, -34,98.5, -17.7,			
			100, 0,	98.5, 17.7,94,34,86.6,50,76.6, 64.2,64.2, 76.6,50, 86.6,34, 94,17, 98.5,0, 100,			
			-17, 98.5,-34, 94,-50, 86.6,-64.2, 76.6,-76.6, 64.2,-86.6, 50,-94, 34,-98.5, 17.7,-100, 0,
			-98.5, -17.7, -94, -34, -86.6, -50, -76.6, -64.2, -64.2, -76.6, -50, -86.6, -34, -94, -17, -98.5, 0, -100],
			new ShiftedPointsMosesAlgorithm(0.6, 10)
		);

		public static var CIRCLE_COUNTER_CLOCKWISE:FlatPointsPattern = new FlatPointsPattern(
			"Circle (counter clockwise)",
			[0, -100,-17, -98.5,-34, -94,-50, -86.6,-64.2, -76.6,-76.6, -64.2,-86.6,-50,-94,-34,-98.5, -17.7,
			-100, 0,-98.5, 17.7,-94, 34,-86.6, 50,-76.6, 64.2,-64.2, 76.6,-50, 86.6,-34, 94,-17, 98.5,0, 100,
			17, 98.5, 34, 94, 50, 86.6, 64.2, 76.6, 76.6, 64.2, 86.6, 50, 94, 34, 98.5, 17.7, 100, 0, 98.5,
			-17.7,94, -34,86.6, -50,76.6, -64.2,64.2, -76.6,50, -86.6, 34, -94,17, -98.5, 0, -100],
			new ShiftedPointsMosesAlgorithm(0.6, 10)
		);		
		
		public static var CIRCLE:MultiplePattern = new MultiplePattern(
			"Circle",
			CIRCLE_CLOCKWISE,
			CIRCLE_COUNTER_CLOCKWISE
		);
		
		// SQUARES
		
		public static var LEFT_TOP_SQUARE:FlatPointsPattern = new FlatPointsPattern(
			"Square (from left top corner)",
			[0, 0, 10, 0, 20, 0, 30, 0, 40, 0, 50, 0, 60, 0, 70, 0, 80, 0, 90, 0, 
			90, 10, 90, 20, 90, 30, 90, 40, 90, 50, 90, 60, 90, 70, 90, 80, 90, 90,
			80, 90, 70, 90, 60, 90, 50, 90, 40, 90, 30, 90, 20, 90, 10, 90, 0, 90,
			0, 80, 0, 70, 0, 60, 0, 50, 0, 40, 0, 30, 0, 20, 0, 10, 0, 0],
			new ReversedMosesAlgorithm(0.7, 4)
		);
		
		public static var RIGHT_TOP_SQUARE:FlatPointsPattern = new FlatPointsPattern(
			"Square (from right top corner)",
			[90, 0, 90, 10, 90, 20, 90, 30, 90, 40, 90, 50, 90, 60, 90, 70, 90, 80, 
			90, 90, 80, 90, 70, 90, 60, 90, 50, 90, 40, 90, 30, 90, 20, 90, 10, 90,
			0, 90, 0, 80, 0, 70, 0, 60, 0, 50, 0, 40, 0, 30, 0, 20, 0, 10, 0, 0, 
			10, 0, 20, 0, 30, 0, 40, 0, 50, 0, 60, 0, 70, 0, 80, 0, 90, 0],
			new ReversedMosesAlgorithm(0.7, 4)
		);

		public static var LEFT_BOTTOM_SQUARE:FlatPointsPattern = new FlatPointsPattern(
			"Square (from left bottom corner)",
			[0, 90, 0, 80, 0, 70, 0, 60, 0, 50, 0, 40, 0, 30, 0, 20, 0, 10,
			0, 0, 10, 0, 20, 0, 30, 0, 40, 0, 50, 0, 60, 0, 70, 0, 80, 0, 90, 0, 
			90, 10, 90, 20, 90, 30, 90, 40, 90, 50, 90, 60, 90, 70, 90, 80, 90, 90,
			80, 90, 70, 90, 60, 90, 50, 90, 40, 90, 30, 90, 20, 90, 10, 90, 0, 90],
			new ReversedMosesAlgorithm(0.7, 4)
		);
		
		public static var RIGHT_BOTTOM_SQUARE:FlatPointsPattern = new FlatPointsPattern(
			"Square (from right bottom corner)",
			[90, 90, 80, 90, 70, 90, 60, 90, 50, 90, 40, 90, 30, 90, 20, 90, 10, 90, 0, 90,
			0, 80, 0, 70, 0, 60, 0, 50, 0, 40, 0, 30, 0, 20, 0, 10, 0, 0,
			10, 0, 20, 0, 30, 0, 40, 0, 50, 0, 60, 0, 70, 0, 80, 0, 90, 0, 
			90, 10, 90, 20, 90, 30, 90, 40, 90, 50, 90, 60, 90, 70, 90, 80, 90, 90],
			new ReversedMosesAlgorithm(0.7, 4)
		);		
		
		public static var SQUARE:MultiplePattern = new MultiplePattern(
			"Square",
			LEFT_TOP_SQUARE,
			LEFT_BOTTOM_SQUARE,
			RIGHT_TOP_SQUARE,
			RIGHT_BOTTOM_SQUARE
		);
		
		// OTHERS
		
		public static var DASH:FlatPointsPattern = new FlatPointsPattern(
			"Dash Normal",
			[ -50, 100,-45, 90,-40, 80,-35, 70,-30, 60,-25, 50,-20, 40,-15, 30,-10, 20,-5, 10, 0, 0,
			5, 10, 10, 20, 15, 30, 20, 40, 25, 50, 30, 60, 35, 70, 40, 80, 45, 90, 50, 100],
			new DefaultMosesAlgorithm(0.6, 4)
		);
		
		public static var V:FlatPointsPattern = new FlatPointsPattern(
			"V",
			[ -50, -100, -45, -90, -40, -80, -35, -70, -30, -60, -25, -50, -20, -40, -15, -30, - 10, -20, -5, -10, 0, 0,
			5, -10, 10, -20, 15, -30, 20, -40, 25, -50, 30, -60, 35, -70, 40, -80, 45, -90, 50, -100],
			new DefaultMosesAlgorithm(0.6, 4)
		);
		
		public static var SEVEN:FlatPointsPattern = new FlatPointsPattern(
			"Seven", 
			[0, 0, 10, 0, 20, 0, 30, 0, 40, 0, 50, 0, 60, 0, 70, 0, 80, 0, 90, 0, 100, 0,
			90, 10, 80, 20, 70, 30, 60, 40, 50, 50, 40, 60, 30, 70, 20, 80, 10, 90, 0, 100], 
			new DefaultMosesAlgorithm(0.7, 2)
		);			
		
		public static var Z:FlatPointsPattern = new FlatPointsPattern(
			"Z", 
			[0, 0, 10, 0, 20, 0, 30, 0, 40, 0, 50, 0, 60, 0, 70, 0, 80, 0, 90, 0, 100, 0,
			90, 10, 80, 20, 70, 30, 60, 40, 50, 50, 40, 60, 30, 70, 20, 80, 10, 90, 0, 100,
			10, 100, 20, 100, 30, 100, 40, 100, 50, 100, 60, 100, 70, 100, 80, 100, 90, 100], 
			new DefaultMosesAlgorithm(0.65, 4)
		);				
		
		// LINES
		
		public static var LINE_UP_DOWN:FlatPointsPattern = new FlatPointsPattern(
			"Up-down",
			[0, 0, 0, 10, 0, 20, 0, 30, 0, 40, 0, 50, 0, 60, 0, 70, 0, 80, 0, 90, 0, 100],
			new DefaultMosesAlgorithm(0.7, 2)
		);
		
		public static var LINE_DOWN_UP:FlatPointsPattern = new FlatPointsPattern(
			"Down-up",
			[0, 0, 0, -10, 0, -20, 0, -30, 0, -40, 0, -50, 0, -60, 0, -70, 0, -80, 0, -90, 0, -100],
			new DefaultMosesAlgorithm(0.7, 2)
		);		
		
		public static var LINE_LEFT_RIGHT:FlatPointsPattern = new FlatPointsPattern(
			"Left-right",
			[0, 0, 10, 0, 20, 0, 30, 0, 40, 0, 50, 0, 60, 0, 70, 0, 80, 0, 90, 0, 100, 0],
			new DefaultMosesAlgorithm(0.7, 2)
		);
		
		public static var LINE_RIGHT_LEFT:FlatPointsPattern = new FlatPointsPattern(
			"Right-left",
			[0, 0, -10, 0, -20, 0, -30, 0, -40, 0, -50, 0, -60, 0, -70, 0, -80, 0, -90, 0, -100, 0],
			new DefaultMosesAlgorithm(0.7, 2)
		);				
		
		// SAMPLES
		
		public static var EXAMPLE:FlatPointsPattern = new FlatPointsPattern(
			"Example", 
			[0, 0, 10, 0, 20, 0, 30, 0, 40, 0, 50, 0, 60, 0, 70, 0, 80, 0, 90, 0, 
			90, 10, 90, 20, 90, 30, 90, 40, 90, 50, 90, 60, 90, 70, 90, 80, 90, 90],
			new DefaultMosesAlgorithm(0.7, 4)
		);
		
	}

}