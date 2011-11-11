/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.demo 
{
	import com.greensock.TweenLite;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.greensock.*;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * View for drawing patterns
	 * @author ifrost
	 */
	public class PatternSamplerView extends Sprite 
	{
		/**
		 * Sprite used for showing warning
		 */
		private var warnSprite:Sprite;
		
		/**
		 * Configuration
		 */
		public static const SIZE:uint = 300;
		public static const BACKGROUND:uint = 0x0CFBE3;
		public static const WARN:uint = 0xE73525;
		public static const BORDER:uint = 0x1693A5;	
		public static const PATH:uint = 0x1693A5;	
		public static const TEXT:uint = 0x1693A5;			
		public static const BORDER_SIZE:uint = 5;
		
		/**
		 * True if drawing is active (path will be drawn)
		 */
		protected var drawingActive:Boolean;
		
		public function PatternSamplerView() 
		{
			super();
			drawingActive = false; // default
			
			// initialize handlers
			addEventListener(MouseEvent.MOUSE_DOWN, activateDrawing);
			addEventListener(MouseEvent.MOUSE_UP, deactivateDrawing);
			addEventListener(MouseEvent.MOUSE_MOVE, drawLine);			
			
			redraw();
		
			addHelpLabel();
						
			// add invisible warn sprite
			addWarnSprite();			
		}
		
		/**
		 * Create little label at the bottom of view
		 */
		private function addHelpLabel():void 
		{
			var label:TextField = new TextField();
			label.defaultTextFormat = new TextFormat("Verdana", 10, TEXT, true);			
			label.autoSize = "left";
			label.selectable = false;
			label.text = "draw here";
			label.x = SIZE / 2 - label.textWidth / 2;
			label.y = height - label.textHeight * 2;
			
			addChild(label);
		}
		
		/**
		 * Draw line to mouse position if drawing is active
		 * @param	e
		 */
		private function drawLine(e:MouseEvent):void 
		{
			if (drawingActive) {
				graphics.lineTo(e.localX, e.localY);
			}
		}
		
		/**
		 * Deactivate drawning
		 * @param	e
		 */
		private function deactivateDrawing(e:MouseEvent):void 
		{
			drawingActive = false;
		}
		
		/**
		 * Set drawing active and clear current drawnings
		 * @param	e
		 */
		private function activateDrawing(e:MouseEvent):void 
		{
			drawingActive = true;
			redraw(); // clear all
			graphics.moveTo(e.localX, e.localY);
		}
		
		/**
		 * Redraw sampler area
		 */
		public function redraw():void {
			graphics.lineStyle(BORDER_SIZE, BORDER);
			
			var matrix:Matrix = new Matrix();			
			matrix.createGradientBox(SIZE, SIZE)
			matrix.rotate(Math.PI / 2);
			graphics.beginGradientFill(GradientType.LINEAR, [BACKGROUND, 0xFFFFFF], [1, 1],
				[0, 255], matrix);			
			
			graphics.drawRoundRect(0, 0, SIZE, SIZE, 50, 50);
			graphics.endFill();
			graphics.lineStyle(3, PATH);
		}
		
		/**
		 * Create sprite that cover whole view filled with WARN color
		 */
		protected function addWarnSprite():void {
			warnSprite = new Sprite();
			warnSprite.alpha = 0;
			warnSprite.graphics.beginFill(WARN);
			warnSprite.graphics.drawRoundRect(0, 0, SIZE, SIZE, 50, 50);
			warnSprite.graphics.endFill();
			addChild(warnSprite);
		}
		
		/**
		 * Show warn by fading warn sprite
		 */
		public function warn():void {
			TweenLite.to(warnSprite, 0.4, { alpha: 0.6, onComplete: onWarnComplete } );
		}
		
		/**
		 * Back to normal state
		 */
		private function onWarnComplete():void {
			TweenLite.to(warnSprite, 0.4, { alpha: 0.0 } );
		}
		
	}

}