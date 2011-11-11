/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.recognizers 
{
	import flash.events.IEventDispatcher;
	import pl.ifrost.moses.events.RecognizerEvent;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import pl.ifrost.moses.events.SamplerEvent;
	import pl.ifrost.moses.recognizers.patterns.Pattern;
	import pl.ifrost.moses.samplers.Sampler;
	
	/**
	 * Abstract recognizer that handle communication with sampler and register patterns
	 * Only recognize method must be provided by sub class
	 * 
	 * @author ifrost
	 */	
	public class AbstractRecognizer implements Recognizer
	{
		/**
		 * Container for registered patterns
		 */
		protected var _patterns:Dictionary;
		
		protected var _sampler:Sampler;		
				
		protected var _eventDispatcher:IEventDispatcher;
		
		public function AbstractRecognizer() 
		{
			_eventDispatcher = new EventDispatcher();
			clear(); // clear patterns
		}
		
		public function addEventListener(type:String, handler:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			_eventDispatcher.addEventListener(type, handler, useCapture, priority, useWeakReference);
		}

		/**
		 * Register new pattern
		 * @param	pattern
		 */
		public function register(pattern:Pattern):void
		{
			_patterns[pattern.name] = pattern;
		}
		
		/**
		 * Clear registered patterns
		 */
		public function clear():void {
			_patterns = new Dictionary();
		}
		
		public function set sampler(value:Sampler):void 
		{
			// clear handlers when sampler is overriden
			if (_sampler != null) {
				removeSampler();
			}
			_sampler = value;
			
			// add event handlers
			initSampler();			
		}
		
		/**
		 * Initizliaze sampler by addeing listener after successul samling
		 */
		private function initSampler():void {
			_sampler.addEventListener(SamplerEvent.FINISHED, onSamplingFinished);
		}
		
		/**
		 * Create matching data for any pattern
		 * @param	event
		 */
		protected function onSamplingFinished(event:SamplerEvent):void {
			_eventDispatcher.dispatchEvent(new RecognizerEvent(RecognizerEvent.RECOGNITION_PROCEEDED, recognize(event.data)));
		}
		
		/**
		 * This function should be overriden in subclass and return Recognition Data object
		 * @param	samplingData
		 * @return
		 */
		[Abstract]
		protected function recognize(samplingData:Array):RecognitionData {
			return null; // must be overriden
		}
		
		/**
		 * Clear sampler listerners
		 */
		public function removeSampler():void {
			_sampler.addEventListener(SamplerEvent.FINISHED, onSamplingFinished);
			_sampler = null;
		}
	}

}