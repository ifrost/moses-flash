/**
 * Copyright (c) 2011 Piotr Jamróz
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
package pl.ifrost.moses.events 
{
	import flash.events.Event;
	import pl.ifrost.moses.recognizers.RecognitionData;
	
	/**
	 * Event dispatched by recognizer. It holds any registered pattern with matching value in
	 * RecognitionData object
	 * 
	 * @see RecognitionData
	 * @author ifrost
	 */
	public class RecognizerEvent extends Event 
	{
		public static const RECOGNITION_PROCEEDED:String = "recognitionProceeded";
		
		public var recognitionData:RecognitionData;
		
		public function RecognizerEvent(type:String, recognitionData:RecognitionData, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.recognitionData = recognitionData;
		}

		/**
		 * True if any pattern has been marked as recognized
		 */
		public function get recognized():Boolean {
			return recognitionData.bestMatching != null && recognitionData.bestMatching.recognized;
		}
		
	}

}