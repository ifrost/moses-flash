/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.demo 
{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import pl.ifrost.moses.recognizers.patterns.Pattern;
	import pl.ifrost.moses.views.SimplePointsVisualizer;
	
	/**
	 * View for moses pattern. Will show how pattern should look like
	 * @author ifrost
	 */
	public class PatternView extends Sprite
	{
		/**
		 * Configuration
		 */
		public static const SIZE:Number = 100;
		public static const BACKGROUND:uint = 0x0CFBE3;
		public static const BORDER:uint = 0x1693A5;
		public static const HIGHLIGHT:uint = 0x03FF68;
		public static const MARKER:uint = 0x1693A5;
		public static const PATH:uint = 0x1693A5;
		public static const BORDER_SIZE:uint = 5;
		
		protected var _backgroundSprite:Sprite;
		protected var _patternBackground:Sprite;
				
		protected var visualizer:SimplePointsVisualizer;
		
		/**
		 * Pattern which will be shown
		 */
		protected var _pattern:Pattern;
		
		public function PatternView(pattern:Pattern) 
		{
			super();			
			
			// draw backgrounds
			draw();
			
			// draw pattern
			_pattern = pattern;
			showPattern();
		}
		
		/**
		 * Draw basic view
		 */
		private function draw():void {						
			// create background
			_backgroundSprite = new Sprite();
			
			// create pattern background
			_patternBackground = new Sprite();
			
			// draw background without highlight
			highlight(false);
			
			// put background on view
			addChild(_backgroundSprite);
			
			// put pattern backgorund on view
			addChild(_patternBackground);			
		}
		
		/**
		 * Recreates background with selected color
		 * @param	color - background color
		 */
		protected function colorizeBackground(color:uint, color2:uint = 0xFFFFFF):void {
			_backgroundSprite.graphics.lineStyle(BORDER_SIZE, BORDER);
			
			var matrix:Matrix = new Matrix();			
			matrix.createGradientBox(SIZE, SIZE)
			matrix.rotate(Math.PI / 2);
			_backgroundSprite.graphics.beginGradientFill(GradientType.LINEAR, [color, color2], [1, 1],
				[100, 255], matrix);
			
			_backgroundSprite.graphics.drawRoundRect(0, 0, SIZE, SIZE, 50, 50);
			_backgroundSprite.graphics.endFill();			
		}
		
		/**
		 * Draw and start animating pattern
		 */
		private function showPattern():void {
			visualizer = new SimplePointsVisualizer(_patternBackground);
			visualizer
				.setPathColor(PATH)
				.setNofMarkers(5)
				.setShowPath(true)
				.setMarkerRadius(3)
				.setMarkerColor(MARKER)
				.setReleaseDelay(100)
				.setPathThickness(2)
				.setStepDelay(100)
				.setWidth(SIZE / 2)
				.setHeight(SIZE / 2)
				.setOffsetX(25)
				.setOffsetY(25);			
		}
		
		/**
		 * Simulate pattern move
		 */
		public function animate():void {
			visualizer.play(_pattern.data);
		}
		
		/**
		 * Active or deactive background highlight
		 */
		public function highlight(show:Boolean):void {
			colorizeBackground(show ? HIGHLIGHT : BACKGROUND);
		}
		
		public function get pattern():Pattern {
			return _pattern;
		}
		
	}

}