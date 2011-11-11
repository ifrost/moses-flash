/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.samplers 
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import pl.ifrost.moses.events.SamplerEvent;
	
	/**
	 * Base sampler that handles mouse events dispatched by provided display object
	 * @author ifrost
	 */
	public class BaseSampler extends EventDispatcher implements Sampler 
	{
		/**
		 * On this object sampler will listen for mouse events
		 */
		protected var _displayObject:DisplayObject;
		
		/**
		 * True if sample collecting data
		 */
		protected var _isScreeningAcitive:Boolean;
		
		/**
		 * Sampled data container
		 */
		protected var _samplingData:Array;
		
		public function BaseSampler(displayObject:DisplayObject) 
		{
			_samplingData = [];
			_displayObject = displayObject;
			_isScreeningAcitive = false;	
		}
				
		public function getSamplingData():Array 
		{
			return _samplingData;
		}
		
		
		/**
		 * Activate samplers
		 */
		public function activate():void 
		{
			_displayObject.addEventListener(MouseEvent.MOUSE_DOWN, screeningStart);
			dispatchEvent(new SamplerEvent(SamplerEvent.ACTIVATED, _samplingData));
		}
		
		/**
		 * Deactivate sampler
		 */
		public function deactivate():void {
			_displayObject.removeEventListener(MouseEvent.MOUSE_DOWN, screeningStart);
			dispatchEvent(new SamplerEvent(SamplerEvent.DEACTIVATED, _samplingData));
		}
		
		/**
		 * Extract mouse position from mouse event
		 * @param	e
		 * @return
		 */
		protected function mousePosition(e:MouseEvent):Point {
			return new Point(e.localX, e.localY);
		}
		
		/**
		 * Append new mouse position
		 * @param	e
		 */
		protected function pushMousePosition(e:MouseEvent):void {
			_samplingData.push(mousePosition(e));
		}
		
		/**
		 * Collect mouse position after mouse move
		 * 
		 * @see DistanceSampler
		 * @param	e
		 */
		protected function screeningContinue(e:MouseEvent):void 
		{
			pushMousePosition(e);
			dispatchEvent(new SamplerEvent(SamplerEvent.SAMPLED, _samplingData));
		}
		
		/**
		 * Last sampled point
		 * @return
		 */
		protected function getLastPosition():Point {
			if (_samplingData.length > 0) {
				return _samplingData[_samplingData.length-1];
			}
			else {
				return null;
			}
		}
		
		/**
		 * Start collecting data after mouse down
		 * @param	e
		 */
		protected function screeningStart(e:MouseEvent):void 
		{
			// starting point
			_samplingData = [new Point(e.localX, e.localY)]
			
			_isScreeningAcitive = true;
			_displayObject.addEventListener(MouseEvent.MOUSE_MOVE, screeningContinue);
			_displayObject.addEventListener(MouseEvent.MOUSE_UP, screeningEnd);			
			
			dispatchEvent(new SamplerEvent(SamplerEvent.STARTED, _samplingData));
		}		
		
		protected function deactivateScreening():void {
			_isScreeningAcitive = false;
			
			// remove listeners
			_displayObject.removeEventListener(MouseEvent.MOUSE_MOVE, screeningContinue);
			_displayObject.removeEventListener(MouseEvent.MOUSE_UP, screeningEnd);			
		}
		
		/**
		 * Finish collecting data
		 * @param	e
		 */
		protected function screeningEnd(e:MouseEvent):void 
		{
			deactivateScreening();
			dispatchEvent(new SamplerEvent(SamplerEvent.FINISHED, _samplingData));
		}
		
		
	}

}